return {
	"kyazdani42/nvim-web-devicons",
	config = function()
		local colors = require("user.colors")
		require("nvim-web-devicons").setup({
			override = {
				["service.ts"] = {
					icon = "",
					color = colors.yellow,
					name = "ServiceTS",
				},
				["controller.ts"] = {
					icon = "",
					color = colors.blue,
					name = "ControllerTS",
				},
				["module.ts"] = {
					icon = "",
					color = colors.red,
					name = "ModuleTS",
				},
			},
			default = true,
		})
	end,
}
