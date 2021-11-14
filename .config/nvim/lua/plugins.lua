-- This file can be loaded by calling `lua require("plugins")` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function()
  -- Let Packer manage itself
  use "wbthomason/packer.nvim"
  -- Speedup lua module loading
  use "lewis6991/impatient.nvim"
  -- filetypes
  use "nathom/filetype.nvim"
  -- Dashboard
  use "glepnir/dashboard-nvim"
  -- Key helper
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  }
  -- Project
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  -- Preview Markdown in a browser
  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    ft = {"markdown"}
  }
  use "tpope/vim-commentary"
  -- Statusbar
  use {
    "nvim-lualine/lualine.nvim",
    requires = {"kyazdani42/nvim-web-devicons", opt = true},
    config = function()
      local gps = require("nvim-gps")
      require("lualine").setup {
        options = {
          theme = "tokyonight",
        },
        sections = {
          lualine_c = {
            "filename", { gps.get_location, cond = gps.is_available },
          },
        },
      }
    end
  }
  -- lsp
  use {
    "neovim/nvim-lspconfig",
    config = function()
      local shared_capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lsp = require("lspconfig")
      lsp.gopls.setup {}
      lsp.jsonls.setup {
        commands = {
          Format = {
            function()
              vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
            end
          }
        }
      }
      lsp.pylsp.setup {
        settings = {
          pylsp = {
            -- configurationSources = {"flake8", "mypy", "isort"},
            configurationSources = {"flake8"},
            plugins = {
              pyls_mypy = {
                enabled = true,
              },
              pyls_black = {
                enabled = true,
              },
              pyls_isort = {
                enabled = true,
              },
            },
          },
        },
        capabilities = shared_capabilities,
      }
    end,
    requires = {"hrsh7th/cmp-nvim-lsp"}
  }
  use {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require"cmp"
      cmp.setup{
        mapping = {
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
        }, {
          { name = "buffer" },
        }),
        -- Don't show the text like "Function" after the symbol
        -- src: https://github.com/hrsh7th/nvim-cmp#how-to-show-name-of-item-kind-and-source-like-compe
        formatting = {
          format = require("lspkind").cmp_format({
            with_text = false,
          }),
        },
      }
    end,
    requires = {"onsails/lspkind-nvim"},
  }
  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    branch = "0.5-compat",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup{
        ensure_installed = "maintained",
        highlight = { enable = true },
        indent = { enable = true },
        rainbow = {
          enable = true,
          extended_mode = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        -- tree-sitter objects for code navigation
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim 
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      }
    end
  }
  use {
    "romgrk/nvim-treesitter-context",
    requires = {
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require"treesitter-context".setup{}
    end
  }
  use {
    "SmiteshP/nvim-gps",
    requires = {
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require("nvim-gps").setup{}
    end
  }
  use {
    "p00f/nvim-ts-rainbow",
    requires = {
      "nvim-treesitter/nvim-treesitter"
    },
  }
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {}
    end
  }
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
          "function",
          "method",
        },
      }
    end
  }
  -- easymotion for neovim
  use {
    "phaazon/hop.nvim",
    branch = "v1", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require"hop".setup { keys = "etovxqpdygfblzhckisuran" }
    end
  }
  -- Git gutter
  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim"
    },
    event = {"BufNewFile", "BufRead"},
    tag = "release",
    config = function()
      require("gitsigns").setup {
        signcolumn = true,
        numhl = true,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text_pos = "right_align"
        }
      }
    end
  }
  -- Buffers as tabs
  use {
    "noib3/cokeline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
        local get_hex = require("cokeline/utils").get_hex
        require("cokeline").setup {
            default_hl = {
                focused = {
                  fg = get_hex("Normal", "fg"),
                  bg = get_hex("ColorColumn", "bg"),
                },
                unfocused = {
                  fg = get_hex("Comment", "fg"),
                  bg = get_hex("ColorColumn", "bg"),
                },
            },
            components = {
                {
                    text = "｜",
                    hl = {
                        fg = function(buffer)
                            return
                                buffer.is_modified
                                and vim.g.terminal_color_3 -- yellow
                                or vim.g.terminal_color_2 -- green
                        end
                    },
                },
                {
                  text = function(buffer) return buffer.devicon.icon .. " " end,
                  hl = {
                    fg = function(buffer) return buffer.devicon.color end,
                  },
                },
                {
                  text = function(buffer) return buffer.unique_prefix end,
                  hl = {
                    fg = get_hex("Comment", "fg"),
                    style = "italic",
                  },
                },
                {
                  text = function(buffer) return buffer.filename .. " " end,
                  hl = {
                    style = function(buffer) return buffer.is_focused and "bold" or nil end,
                  },
                },
            },
        }
    end
  }
  -- use {
  --   "akinsho/bufferline.nvim",
  --   requires = "kyazdani42/nvim-web-devicons",
  --   config = function()
  --     require("bufferline").setup{
  --       highlights = {
  --         buffer_selected = {
  --           gui = "bold",
  --         },
  --       },
  --     }
  --   end,
  -- }
  -- File closer helper
  use {"famiu/bufdelete.nvim"}
  -- Themes
  use {"Mofiqul/dracula.nvim"} 
  use {"folke/tokyonight.nvim"}
  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
      {"nvim-telescope/telescope-github.nvim"},
      {"xiyaowong/telescope-emoji.nvim"},
    },
    config = function()
      local tele = require("telescope")
      local actions = require("telescope.actions")
      tele.setup {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close
            },
          },
        }
      }
    end,
  }
  use {
    "mrjones2014/dash.nvim",
    run = "make install",
  }
  -- Terminal
  use {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup{}
    end,
  }
end)
