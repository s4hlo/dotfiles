return {
  "kyazdani42/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup {
      override = {
        ["service.ts"] = {
          icon = "",
          color = "#FFD700", 
          name = "ServiceTS",
        },
        ["controller.ts"] = {
          icon = "",
          color = "#1E90FF", 
          name = "ControllerTS",
        },
        ["module.ts"] = {
          icon = "", 
          color = "#FF4500", 
          name = "ModuleTS",
        },
      },
      default = true,
    }
  end,
}
