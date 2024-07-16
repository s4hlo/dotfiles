return {
  {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },
  {

    "mistweaverco/kulala.nvim",
    config = function()
      vim.filetype.add {
        extension = {
          ["http"] = "http",
        },
      }
      -- Setup is required, even if you don't pass any options
      require("kulala").setup()
    end,
  },
}
