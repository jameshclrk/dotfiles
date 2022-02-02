-- This file can be loaded by calling `lua require("plugins")` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

function get_config(name)
  return string.format("require(\"config/%s\")", name)
end

function get_lsp_config(name)
  return string.format("require(\"config/lsp\").%s()", name)
end

pcall(require, "packer_compiled")

return require("packer").startup({function()
  ----- Config-less
  -- Let Packer manage itself
  use "wbthomason/packer.nvim"
  -- Speedup lua module loading
  use "lewis6991/impatient.nvim"
  -- filetypes
  use "nathom/filetype.nvim"
  -- Dashboard
  use "glepnir/dashboard-nvim"
  -- File closer helper
  use "famiu/bufdelete.nvim"
  -- The Pope
  use "tpope/vim-markdown"
  use "tpope/vim-commentary"
  -- Themes
  use "Mofiqul/dracula.nvim"
  use "folke/tokyonight.nvim"
  

  ----- Config
  -- indent lines
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = get_config("indent-blankline"),
  }
  -- LSP Progress
  use {
    "j-hui/fidget.nvim",
    config = get_config("fidget"),
  }

  -- Key helper
  use {
    "folke/which-key.nvim",
    config = get_config("which-key"),
  }
  -- Project
  use {
    "ahmedkhalf/project.nvim",
    config = get_config("project_nvim"),
  }
  -- Minimap
  -- use {
  --   "wfxr/minimap.vim",
  -- }
  -- Statusbar
  use {
    "nvim-lualine/lualine.nvim",
    config = get_config("lualine"),
    requires = {
      {"kyazdani42/nvim-web-devicons", opt = true},
      {"nvim-gps", opt = true},
    }
  }
  -- lsp
  use {
    "neovim/nvim-lspconfig",
    config = get_lsp_config("lspconfig"),
    requires = {"hrsh7th/cmp-nvim-lsp"}
  }
  use {
    "hrsh7th/nvim-cmp",
    config = get_config("cmp"),
    requires = {
      {"hrsh7th/cmp-nvim-lua"},
      {"hrsh7th/cmp-nvim-lsp"},
      {"hrsh7th/cmp-nvim-lsp-document-symbol"},
      {"onsails/lspkind-nvim"},
    },
  }
  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = get_lsp_config("null_ls"),
  }
  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    config = get_config("treesitter"),
    run = ":TSUpdate",
  }
  use {
    "romgrk/nvim-treesitter-context",
    config = get_config("treesitter-context"),
    requires = {"nvim-treesitter/nvim-treesitter"},
  }
  use {
    "SmiteshP/nvim-gps",
    config = get_config("nvim-gps"),
    requires = {"nvim-treesitter/nvim-treesitter"},
  }
  use {
    "p00f/nvim-ts-rainbow",
    requires = {"nvim-treesitter/nvim-treesitter"},
  }
  -- easymotion for neovim
  use {
    "phaazon/hop.nvim",
    config = get_config("hop"),
    branch = "v1", -- optional but strongly recommended
  }
  -- Git gutter
  use {
    "lewis6991/gitsigns.nvim",
    config = get_config("gitsigns"),
    requires = {"nvim-lua/plenary.nvim"},
    event = {"BufNewFile", "BufRead"},
    tag = "release",
  }
  -- Buffers as tabs
  use {
    "noib3/cokeline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = get_config("cokeline"),
  }
  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    config = get_config("telescope"),
    requires = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
      {"xiyaowong/telescope-emoji.nvim"},
    },
    opt = true,
    cmd = {"Telescope"},
  }
  use {
    "pwntester/octo.nvim",
    config = get_config("octo"),
    requires = {
      {"nvim-telescope/telescope.nvim"},
      {"kyazdani42/nvim-web-devicons"},
    },
  }
  use {
    "jubnzv/mdeval.nvim",
    config = get_config("mdeval"),
    opt = true
  }
end,
config = {
  display = {
    open_fn = require('packer.util').float,
  },
  compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
}})
