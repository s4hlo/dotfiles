-- Palettes used by lualine, indentline, cmp, notify, nest...
-- The active one follows lua/user/theme.lua
local palettes = {}

-- VS Code Dark+ (same as the Windows Terminal "Dark+" scheme)
palettes.vscode = function()
	return {
		white = "#d4d4d4",
		black = "#000000",
		gray = "#808080",
		light_gray = "#9d9d9d",
		background = "#1e1e1e",
		red = "#f44747",
		green = "#6a9955",
		blue = "#569cd6",
		orange = "#ce9178",
		yellow = "#dcdcaa",
		purple = "#c586c0",
		pink = "#d670d6",
		cyan = "#4ec9b0",
		sky_blue = "#9cdcfe",
		sapphire = "#4fc1ff",
		lavender = "#b4b4ff",
		rosewater = "#d7ba7d",
		flamingo = "#f14c4c",
		maroon = "#d16969",
		surface = "#252526",
		surface1 = "#373737",
		surface2 = "#3c3c3c",
		mantle = "#181818",
		subtext = "#bbbbbb",
		subtext1 = "#cccccc",
		pure_white = "#ffffff",
		pure_black = "#000000",
	}
end

-- Catppuccin Mocha
palettes.catppuccin = function()
	return {
		white = "#cdd6f5",
		black = "#11111c",
		gray = "#6c7087",
		light_gray = "#7f849d",
		background = "#1e1e2f",
		red = "#f38ba9",
		green = "#a6e3a2",
		blue = "#89b4fb",
		orange = "#fab388",
		yellow = "#f9e2b0",
		purple = "#cba6f8",
		pink = "#f5c2e8",
		cyan = "#94e2d6",
		sky_blue = "#89dcec",
		sapphire = "#74c7ed",
		lavender = "#b4beff",
		rosewater = "#f5e0dd",
		flamingo = "#f2cdce",
		maroon = "#eba0ad",
		surface = "#313245",
		surface1 = "#45475b",
		surface2 = "#585b71",
		mantle = "#181826",
		subtext = "#a6adc9",
		subtext1 = "#bac2df",
		theme = require("catppuccin.palettes").get_palette("mocha"), -- full palette if needed
		pure_white = "#ffffff",
		pure_black = "#000000",
	}
end

return palettes[require("user.theme")]()
