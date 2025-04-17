return {
     -- LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("lazyvim.util").has("nvim-cmp")
        end,
      },
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = true,
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      codelens = {
        enabled = true,
      },
      capabilities = {},
      autoformat = true,
      format_notify = false,
      format = {
        formatting_options = nil,
        timeout_ms = 3000,
      },
      servers = {
        -- Configured individually in setup function
      },
      setup = {
        -- Custom server setup handlers can be added here
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      
      -- Configure diagnostic display
      vim.diagnostic.config(opts.diagnostics)

      -- Set up inlay hints
      if opts.inlay_hints.enabled then
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.supports_method("textDocument/inlayHint") then
              vim.lsp.inlay_hint.enable(args.buf, true)
            end
          end,
        })
      end

      -- LSP key mappings
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local nmap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
          end

          nmap("gd", vim.lsp.buf.definition, "Go to Definition")
          nmap("gr", "<cmd>Telescope lsp_references<cr>", "Go to References")
          nmap("gI", vim.lsp.buf.implementation, "Go to Implementation")
          nmap("gt", vim.lsp.buf.type_definition, "Go to Type Definition")
          nmap("K", vim.lsp.buf.hover, "Hover Documentation")
          nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
          nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          nmap("<leader>cr", vim.lsp.buf.rename, "Rename")
          nmap("<leader>cf", vim.lsp.buf.format, "Format Document")
          nmap("<leader>cl", "<cmd>LspInfo<cr>", "LSP Info")
          nmap("<leader>cd", "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics")
          nmap("<leader>cD", "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics")
          nmap("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
          nmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
        end,
      })

      -- Setup LSP servers
      -- Setup Go
      lspconfig.gopls.setup({
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
              nilness = true,
              unusedwrite = true,
              useany = true,
            },
            experimentalPostfixCompletions = true,
            gofumpt = true,
            staticcheck = true,
            usePlaceholders = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })

      -- Setup TypeScript/JavaScript
      lspconfig.tsserver.setup({
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
      })
    end,
  },

  -- Installer for LSP servers, DAP servers, linters, formatters
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    opts = {
      ensure_installed = {
        -- LSP
        "gopls",
        "typescript-language-server",
        "lua-language-server",
        "json-lsp",
        "yaml-language-server",
        
        -- Formatters
        "gofumpt",
        "goimports",
        "prettier",
        "stylua",
        
        -- Linters
        "golangci-lint",
        "eslint_d",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "tsserver",
        "lua_ls",
        "jsonls",
      },
      automatic_installation = true,
    },
  },

  -- Auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        build = (not jit.os:find("Windows"))
            and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
          or nil,
        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
        opts = {
          history = true,
          delete_check_events = "TextChanged",
        },
      },
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(_, item)
            local icons = {
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "󰜢",
              Variable = "󰀫",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "",
            }
            if icons[item.kind] then
              item.kind = icons[item.kind] .. " " .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }
    end,
  },

  -- Show function signature as you type
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      doc_lines = 0,
      handler_opts = {
        border = "rounded",
      },
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },

  -- Go development
  {
    "ray-x/go.nvim",
    dependencies = { 
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      goimport = "gopls",
      gofmt = "gopls",
      max_line_len = 120,
      tag_transform = false,
      test_dir = "",
      comment_placeholder = "",
      lsp_cfg = false, -- we use our own gopls setup
      lsp_gofumpt = true,
      lsp_on_attach = nil,
      dap_debug = true,
    },
    ft = {"go", "gomod"},
    build = ':lua require("go.install").update_all_sync()',
    keys = {
      { "<leader>gtj", "<cmd>GoTagAdd json<cr>", desc = "Add JSON tags" },
      { "<leader>gty", "<cmd>GoTagAdd yaml<cr>", desc = "Add YAML tags" },
      { "<leader>gtx", "<cmd>GoTagRm<cr>", desc = "Remove tags" },
      { "<leader>gie", "<cmd>GoIfErr<cr>", desc = "Add if err" },
      { "<leader>gll", "<cmd>GoLint<cr>", desc = "Run linter" },
      { "<leader>gtf", "<cmd>GoTestFunc<cr>", desc = "Test function" },
      { "<leader>gtc", "<cmd>GoCoverage<cr>", desc = "Test coverage" },
    },
  },
  -- TypeScript/JavaScript tools
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        tsserver_file_preferences = {
          importModuleSpecifierPreference = "non-relative",
        },
      },
    },
    ft = {
      "typescript",
      "javascript",
      "typescriptreact",
      "javascriptreact",
    },
  },
}