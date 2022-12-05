return {
  ["folke/which-key.nvim"] = {
    disable = false,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls").setup()
    end,
  },
  ["weilbith/nvim-code-action-menu"] = {},
  ["kosayoda/nvim-lightbulb"] = {
    config = function()
      require("custom.plugins.nvim-lightbulb").setup()
    end,
    requires = "antoinemadec/FixCursorHold.nvim",
  },
  ["folke/trouble.nvim"] = {
    config = function()
      require("custom.plugins.trouble").setup()
    end,
    requires = "kyazdani42/nvim-web-devicons",
  },
  ["rcarriga/nvim-dap-ui"] = {
    config = function()
      require("custom.plugins.dap").setup()
    end,
    requires = {"mfussenegger/nvim-dap-python", "mfussenegger/nvim-dap"},
  },
  ["theHamsta/nvim-dap-virtual-text"] = {
    config = function()
      require("custom.plugins.nvim-dap-virtual-text").setup()
    end,
  },
  ["hrsh7th/nvim-cmp"] = {
    config = function()
      require("custom.plugins.cmp").setup()
    end,
  },
  ["danymat/neogen"] = {
    config = function()
        require('neogen').setup {}
    end,
  }
}
