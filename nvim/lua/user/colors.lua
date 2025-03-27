local mocha = require("catppuccin.palettes").get_palette("mocha")

local colors = {
	white = mocha.text or "#cdd6f5",
	black = mocha.crust or "#11111c",
	gray = mocha.overlay0 or "#6c7087",
	light_gray = mocha.overlay1 or "#7f849d",
	background = mocha.base or "#1e1e2f",

	red = mocha.red or "#f38ba9",
	green = mocha.green or "#a6e3a2",
	blue = mocha.blue or "#89b4fb",
	orange = mocha.peach or "#fab388",
	yellow = mocha.yellow or "#f9e2b0",
	purple = mocha.mauve or "#cba6f8",
	pink = mocha.pink or "#f5c2e8",

	cyan = mocha.teal or "#94e2d6",
	sky_blue = mocha.sky or "#89dcec",
	sapphire = mocha.sapphire or "#74c7ed",
	lavender = mocha.lavender or "#b4beff",
	rosewater = mocha.rosewater or "#f5e0dd",
	flamingo = mocha.flamingo or "#f2cdce",
	maroon = mocha.maroon or "#eba0ad",

	surface = mocha.surface0 or "#313245",
	surface1 = mocha.surface1 or "#45475b",
	surface2 = mocha.surface2 or "#585b71",
	mantle = mocha.mantle or "#181826",
	subtext = mocha.subtext0 or "#a6adc9",
	subtext1 = mocha.subtext1 or "#bac2df",

	theme = mocha, -- full palette if needed
  
  pure_white = "#ffffff",
  pure_black = "#000000",
}

return colors
