if true then
  return {}
end
return {
  -- Colorscheme
  { "ellisonleao/gruvbox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- Go Development
  { import = "lazyvim.plugins.extras.lang.go" },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    config = function()
      require("go").setup({
        goimport = "gopls", -- goimport command
        gofmt = "gopls", -- gofmt command
        max_line_len = 120, -- max line length in goline format
        tag_transform = false, -- tag_transform
        test_dir = "", -- default directory name for test files
        comment_placeholder = "", -- comment placeholder
        lsp_cfg = true, -- configure gopls through go.nvim
        lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
        lsp_on_attach = true, -- use on_attach from go.nvim
        dap_debug = true, -- set to true to enable dap
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- React support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { buffer = buffer, desc = "Rename File" })
        end)
      end,
    },
    opts = {
      servers = {
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
      },
      setup = {
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  },
  -- JSON enhancements (treesitter + schemas)
  { import = "lazyvim.plugins.extras.lang.json" },
  -- UI starter replacement
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- TailwindCSS support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "svelte", "vue" },
          init_options = {
            userLanguages = {
              ["javascript"] = "javascript",
              ["javascriptreact"] = "javascriptreact",
              ["typescript"] = "typescript",
              ["typescriptreact"] = "typescriptreact",
              ["svelte"] = "html",
              ["vue"] = "html",
            },
          },
        },
      },
    },
  },

  -- Tailwind CSS color highlight and autocomplete
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end,
  },

  -- Mason tools
  {
    "williamboman/mason.nvim",
    opts = {
      ensureinstalled = {
        -- Golang tools
        "gopls",
        "golangci-lint",
        "gofumpt",
        "goimports",
        "delve",
        -- TS/JS Tolls
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
        "tailwindcss-language-server",
        -- Linting/Formatting
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
  -- Treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "html",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "lua",
        "markdown",
        "markdowninline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "css",
        "scss",
      })
    end,
  },
  -- Completion sources
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
  -- Telescope tweaks
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep({
            type_filter = "go",
            additional_args = { "--glob", "*.go" },
          })
        end,
        desc = "Search in Go Files",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sortingstrategy = "ascending",
        winblend = 0,
      },
    },
  },
  -- Lualine config
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },
}
