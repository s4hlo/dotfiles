#!/bin/bash

# Colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
BOLD="\e[1m"
NC="\e[0m"

clean_field() {
    echo "$1" | sed 's/,//g' | xargs
}

int_part() {
    echo "${1%.*}"
}

is_int() {
    [[ "$1" =~ ^[0-9]+$ ]]
}

echo -e "${BOLD}=== GPU INFO ===${NC}"

# Read one GPU line
IFS=',' read -r PSTATE UTIL CLOCK MEM_USED MEM_TOTAL TEMP POWER FAN <<< \
"$(nvidia-smi --query-gpu=pstate,utilization.gpu,clocks.gr,memory.used,memory.total,temperature.gpu,power.draw,fan.speed --format=csv,noheader,nounits | head -n1)"

# Clean values
PSTATE=$(clean_field "$PSTATE")
UTIL=$(clean_field "$UTIL")
CLOCK=$(clean_field "$CLOCK")
MEM_USED=$(clean_field "$MEM_USED")
MEM_TOTAL=$(clean_field "$MEM_TOTAL")
TEMP=$(clean_field "$TEMP")
POWER=$(clean_field "$POWER")
FAN=$(clean_field "$FAN")

# Convert power to integer for arithmetic checks
POWER_INT=$(int_part "$POWER")

# Handle [N/A] fan speed
if ! is_int "$FAN"; then
    FAN_DISPLAY="N/A"
else
    FAN_DISPLAY="${FAN}%"
fi

# Safe defaults if something comes back weird
is_int "$UTIL" || UTIL=0
is_int "$CLOCK" || CLOCK=0
is_int "$MEM_USED" || MEM_USED=0
is_int "$MEM_TOTAL" || MEM_TOTAL=0
is_int "$TEMP" || TEMP=0
is_int "$POWER_INT" || POWER_INT=0

# Color logic
if (( UTIL > 90 )); then
    UTIL_COLOR=$RED
elif (( UTIL > 60 )); then
    UTIL_COLOR=$YELLOW
else
    UTIL_COLOR=$GREEN
fi

if (( TEMP > 80 )); then
    TEMP_COLOR=$RED
elif (( TEMP > 65 )); then
    TEMP_COLOR=$YELLOW
else
    TEMP_COLOR=$GREEN
fi

if (( MEM_TOTAL > 0 && MEM_USED > MEM_TOTAL * 90 / 100 )); then
    MEM_COLOR=$RED
elif (( MEM_TOTAL > 0 && MEM_USED > MEM_TOTAL * 60 / 100 )); then
    MEM_COLOR=$YELLOW
else
    MEM_COLOR=$GREEN
fi

echo -e "State: ${CYAN}${PSTATE}${NC}"
echo -e "Usage: ${UTIL_COLOR}${UTIL}%${NC}"
echo -e "Clock: ${BLUE}${CLOCK} MHz${NC}"
echo -e "Temperature: ${TEMP_COLOR}${TEMP}°C${NC}"
echo -e "Power: ${YELLOW}${POWER} W${NC}"
echo -e "Fan: ${CYAN}${FAN_DISPLAY}${NC}"
echo -e "VRAM: ${MEM_COLOR}${MEM_USED}/${MEM_TOTAL} MB${NC}"

echo ""

# Driver mode
MODE=$(nvidia-settings -q GPUPowerMizerMode -t 2>/dev/null | xargs)

case "$MODE" in
    1) echo -e "🚀 ${GREEN}Driver Mode: Prefer Maximum Performance${NC}" ;;
    2) echo -e "⚖️ ${YELLOW}Driver Mode: Adaptive${NC}" ;;
    0) echo -e "🌿 ${GREEN}Driver Mode: Auto${NC}" ;;
    *) echo -e "❓ ${RED}Driver Mode: Unknown/Unavailable${NC}" ;;
esac

echo ""

# Performance state
if [[ "$PSTATE" == "P0" ]]; then
    echo -e "🔥 ${GREEN}GPU is at MAXIMUM PERFORMANCE${NC}"
else
    echo -e "💤 ${YELLOW}GPU is NOT at maximum performance (${PSTATE})${NC}"
fi

echo ""
echo -e "${BOLD}=== ALERTS ===${NC}"

HAS_ALERTS=0

if (( TEMP > 80 )); then
    echo -e "${RED}⚠️ High temperature!${NC}"
    HAS_ALERTS=1
fi

if (( UTIL > 90 )); then
    echo -e "${YELLOW}⚡ Heavy GPU load${NC}"
    HAS_ALERTS=1
fi

if (( MEM_TOTAL > 0 && MEM_USED > MEM_TOTAL * 90 / 100 )); then
    echo -e "${RED}🧠 VRAM almost full!${NC}"
    HAS_ALERTS=1
fi

if (( POWER_INT < 50 && UTIL > 80 )); then
    echo -e "${RED}🚫 Possible power limit or throttling${NC}"
    HAS_ALERTS=1
fi

if (( HAS_ALERTS == 0 )); then
    echo -e "${GREEN}No critical alerts${NC}"
fi

echo ""
echo -e "${BOLD}=== TOP GPU PROCESSES ===${NC}"
nvidia-smi --query-compute-apps=pid,process_name,used_memory \
--format=csv,noheader 2>/dev/null | sort -t, -k3 -nr | head
