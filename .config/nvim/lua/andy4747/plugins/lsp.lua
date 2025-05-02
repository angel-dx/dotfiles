return {
  --mason config for installing lsp server, dap, linters
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_lspconfig.setup({
        ensure_installed = {
          -- Go
          "gopls",
          "golangci_lint_ls",
          -- JavaScript/TypeScript/React
          "ts_ls",
          "eslint",
          "html",
          "cssls",
          "tailwindcss",
          -- Zig
          "zls",
          -- Lua (for Neovim)
          "lua_ls",
          -- DevOps
          "dockerls",
          "docker_compose_language_service",
          "yamlls",
          "jsonls",
          "terraformls",
          "bashls",

          -- Python
          "pyright",
          -- Shell
          "bashls",
          -- Markdown (for documentation and README editing)
          "marksman",
          -- SQL
          "sqlls",
          -- TOML (for config files, eg. cargo, pyproject)
          "taplo",
          -- XML
          "lemminx",
          -- YAML schema support
          "yamlls",
          -- CI/CD tools (optional)
          "ansiblels",     -- For Ansible playbooks
          "helm_ls",       -- Helm chart files
          "powershell_es", -- Windows scripting
        },
        automatic_installation = true,
      })
    end,
  },
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
      {
        "hrsh7th/cmp-nvim-lsp",
      },
      "b0o/schemastore.nvim",
    },
    config = function()
      require("neodev").setup()
      local lspconfig = require("lspconfig")
      -- LSP on_attach function to set keybindings when an LSP connects to a buffer
      local on_attach = function(client, bufnr)
        -- Initialize which-key
        local wk = require("which-key")

        -- Define keymap groups using wk.add
        wk.add({
          -- Leader-based keymaps
          {
            "<leader>D",
            vim.lsp.buf.type_definition,
            desc = "Type Definition",
            buffer = bufnr,
          },
          { "<leader>c", group = "Code",     buffer = bufnr },
          {
            "<leader>ca",
            vim.lsp.buf.code_action,
            desc = "Code Action",
            buffer = bufnr,
          },
          {
            "<leader>cr",
            vim.lsp.buf.rename,
            desc = "Rename",
            buffer = bufnr,
          },
          {
            "<leader>cli",
            "<cmd>LspInfo<cr>",
            desc = "LSP Info",
            buffer = bufnr,
          },
          {
            "<leader>clr",
            "<cmd>LspRestart<CR>",
            desc = "Restart LSP",
            buffer = bufnr,
          },
          { "<leader>d", group = "Document", buffer = bufnr },
          {
            "<leader>ds",
            require("telescope.builtin").lsp_document_symbols,
            desc = "Document Symbols",
            buffer = bufnr,
          },
          {
            "<leader>dws",
            require("telescope.builtin").lsp_dynamic_workspace_symbols,
            desc = "Workspace Symbols",
            buffer = bufnr,
          },
          -- Non-leader keymaps
          { "g", group = "Go", buffer = bufnr },
          {
            "gd",
            vim.lsp.buf.definition,
            desc = "Go to Definition",
            buffer = bufnr,
          },
          {
            "gr",
            require("telescope.builtin").lsp_references,
            desc = "Find References",
            buffer = bufnr,
          },
          {
            "gI",
            vim.lsp.buf.implementation,
            desc = "Go to Implementation",
            buffer = bufnr,
          },
          {
            "gt",
            vim.lsp.buf.type_definition,
            desc = "Go to Type Definition",
            buffer = bufnr,
          },
          {
            "K",
            vim.lsp.buf.hover,
            desc = "Hover Documentation",
            buffer = bufnr,
          },
          {
            "<C-s>",
            vim.lsp.buf.signature_help,
            desc = "Signature Help",
            buffer = bufnr,
          },
          {
            "[d",
            vim.diagnostic.goto_prev,
            desc = "Prev Diagnostic",
            buffer = bufnr,
          },
          {
            "]d",
            vim.diagnostic.goto_next,
            desc = "Next Diagnostic",
            buffer = bufnr,
          },
          {
            "D",
            vim.diagnostic.open_float,
            desc = "Show Diagnostics",
            buffer = bufnr,
          },
        }, { mode = "n" })
      end
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- enable files watching
      capabilities.workspace.didChangeWatchedFiles = {
        dynamicRegistration = true,
      }
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        -- define diagnostic sign for neovim <= 0.10
        -- vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        -- define diagnostic sign for neovim >= 0.11
        vim.diagnostic.config({
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.INFO] = "󰠠 ",
              [vim.diagnostic.severity.HINT] = " ",
            },
          },
        })
      end
      -- gopls setup
      lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
              nilness = true,
              unusedwrite = true,
              useany = true,
            },
            completeUnimported = true,
            gofumpt = true,
            staticcheck = true,
            semanticTokens = true,
            usePlaceholders = true,
            hints = {
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

      -- Lua
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
              checkThirdParty = false,
            },
            telemetry = { enable = false },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })

      -- Golangci-lint
      lspconfig.golangci_lint_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        -- Set up proper filetypes for Go files
        filetypes = { "go", "gomod", "gosum", "gowork" },
      })

      --zig
      lspconfig.zls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })


      --CSS
      lspconfig.cssls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- HTML
      lspconfig.html.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Docker
      lspconfig.dockerls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Docker Compose
      lspconfig.docker_compose_language_service.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- YAML (for Kubernetes, GitHub Actions, etc.)
      lspconfig.yamlls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] =
              "/*.k8s.yaml",
            },
            format = { enable = true },
            validate = true,
          },
        },
      })

      -- JSON
      lspconfig.jsonls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      -- Terraform
      lspconfig.terraformls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Bash
      lspconfig.bashls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- JavaScript/TypeScript
      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          -- Disable formatting from tsserver when using prettier
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
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
  -- Go specific plugins
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        -- Go linting configuration
        lsp_cfg = false, -- We'll use our own LSP setup
        lsp_gofumpt = true,
        dap_debug = true,
        dap_debug_gui = true,
        -- Run gofmt + goimports on save
        lsp_document_formatting = true,
        -- Add tags and struct field completion
        tag_transform = "snakecase",
        -- Organize imports on save
        lsp_inlay_hints = {
          enable = true,
          parameter_hints = true,
          type_hints = true,
          other_hints = {
            variable_type = true,
          },
        },
        -- Set up test flags
        test_runner = "go",
        run_in_floaterm = true,
        trouble = true,
      })

      -- Format on save
      -- local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      -- vim.api.nvim_create_autocmd(
      --   "BufWritePre",
      --   {
      --     pattern = "*.go",
      --     callback = function()
      --       require("go.format").goimport()
      --     end,
      --     group = format_sync_grp
      --   }
      -- )

      -- Setup keymaps for Go
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          -- Go specific keymaps
          local map = function(mode, lhs, rhs, desc)
            local opts = { buffer = true, desc = desc }
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          map("n", "<leader>gc", "<cmd>GoCmt<CR>", "Add/Fix Go Comment")
          map("n", "<leader>gfs", "<cmd>GoFillStruct<CR>", "Fill Struct")
          map("n", "<leader>gim", "<cmd>GoImpl<CR>", "Implement Interface")
          map("n", "<leader>gta", "<cmd>GoAddTag json<CR>", "Add tag json")
          map("n", "<leader>gtr", "<cmd>GoRmTag<CR>", "Remove Tags")
          map("n", "<leader>gtt", "<cmd>GoTest<CR>", "Run Test")
          map("n", "<leader>gtf", "<cmd>GoTestFunc<CR>", "Run Test Function")
          map("n", "<leader>gie", "<cmd>GoIfErr<CR>", "Add if err")
          map("n", "<leader>gl", "<cmd>GoLint<CR>", "Run Linter")
          map("n", "<leader>gmd", "<cmd>GoModTidy<CR>", "Go Mod Tidy")
        end,
      })
    end,
    ft = { "go", "gomod", "gosum", "gowork" },
    build = ':lua require("go.install").update_all_sync()',
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
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim", -- Nice icons in completion menu
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Add Go, React, TS/JS snippets
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/go" } })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/typescript-react" } })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/docker" } })

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
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
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              path = "[Path]",
            },
          }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip",  priority = 750 },
          { name = "buffer",   priority = 500 },
          { name = "path",     priority = 250 },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        experimental = {
          ghost_text = true,
        },
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore)
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore)
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
      })
    end,
  },
}
