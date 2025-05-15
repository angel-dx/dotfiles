return {
	--mason config for installing lsp server, dap, linters
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"neovim/nvim-lspconfig",
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
					-- c/cpp
					"clangd",
					-- Go
					"gopls",
					"golangci_lint_ls",
					-- JavaScript/TypeScript/React
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
					-- Markdown (for documentation and README editing)
					"marksman",
					-- SQL
					"sqlls",
					-- TOML (for config files, eg. cargo, pyproject)
					"taplo",
					-- XML
					"lemminx",
					-- CI/CD tools (optional)
					"ansiblels", -- For Ansible playbooks
					"helm_ls", -- Helm chart files
					"powershell_es", -- Windows scripting
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local capabilities = cmp_nvim_lsp.default_capabilities() -- used to enable autocompletion
			local lspconfig = require("lspconfig")

			-- Configure default LSP servers
			local servers = {
				"clangd",
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"gopls",
				"golangci_lint_ls",
				"zls",
				"dockerls",
				"docker_compose_language_service",
				"yamlls",
				"jsonls",
				"terraformls",
				"bashls",
				"pyright",
				"marksman",
				"sqlls",
				"taplo",
				"lemminx",
				"ansiblels",
				"helm_ls",
				"powershell_es",
			}

			-- Set up each LSP with default capabilities
			for _, server in ipairs(servers) do
				if server ~= "lua_ls" then -- we'll configure lua_ls separately
					lspconfig[server].setup({
						capabilities = capabilities,
					})
				end
			end

			-- configuring clangd lsp settings
			-- lspconfig["clangd"].setup({
			-- 	capabilities = capabilities,
			-- 	cmd = { "clangd" },
			-- 	filetypes = { "c", "cpp", "objc", "objcpp" },
			-- 	root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
			-- })

			-- Customize Lua LSP for Neovim development
			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						-- make the language server recognize "vim" global
						diagnostics = {
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},
						workspace = {
							-- make language server aware of run time files
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			})

			-- Configure ESLint explicitly for React/JS/TS projects
			lspconfig.eslint.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					-- Enable autofix on save
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
				settings = {
					eslint = {
						enable = true,
						packageManager = "npm", -- or "yarn", "pnpm" depending on your project
						alwaysShowStatus = true,
						autoFixOnSave = true, -- auto fix on save
						-- Add JSX/TSX specific rules
						validate = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
						},
					},
				},
			})

			-- NOTE: LSP Keybinds
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Buffer local mappings
					-- Check `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf, silent = true }

					-- keymaps
					opts.desc = "Show LSP references"
					vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

					opts.desc = "Go to declaration"
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

					opts.desc = "Show LSP definitions"
					vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

					opts.desc = "Show LSP implementations"
					vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

					opts.desc = "Show LSP type definitions"
					vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

					opts.desc = "See available code actions"
					vim.keymap.set({ "n", "v" }, "<leader>vca", function()
						vim.lsp.buf.code_action()
					end, opts) -- see available code actions, in visual mode will apply to selection

					opts.desc = "Smart rename"
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

					opts.desc = "Show buffer diagnostics"
					vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

					opts.desc = "Show line diagnostics"
					vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

					opts.desc = "Show documentation for what is under cursor"
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

					opts.desc = "Restart LSP"
					vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

					vim.keymap.set("i", "<C-h>", function()
						vim.lsp.buf.signature_help()
					end, opts)
				end,
			})
			-- Define sign icons for each severity
			local signs = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.HINT] = "󰠠 ",
				[vim.diagnostic.severity.INFO] = " ",
			}

			-- Set the diagnostic config with all icons
			vim.diagnostic.config({
				signs = {
					text = signs, -- Enable signs in the gutter
				},
				virtual_text = true, -- Specify Enable virtual text for diagnostics
				underline = true, -- Specify Underline diagnostics
				update_in_insert = false, -- Keep diagnostics active in insert mode
				severity_sort = true, -- Sort by severity - prioritize errors over warnings
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					header = "",
					prefix = "",
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

	-- TypeScript/JavaScript tools - Using typescript-tools instead of ts_ls
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("typescript-tools").setup({
				settings = {
					-- Specify import preferences
					tsserver_file_preferences = {
						importModuleSpecifierPreference = "non-relative",
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
					-- Enhance JSX/TSX support
					tsserver_format_options = {
						allowIncompleteCompletions = false,
						allowRenameOfImportPath = false,
					},
					-- Diagnostics settings
					tsserver_plugins = {
						-- Add plugins if needed
					},
					jsx_close_tag = {
						enable = true,
						filetypes = { "javascriptreact", "typescriptreact" },
					},
				},
				-- Custom handlers for specific actions
				handlers = {
					["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
						if result.diagnostics == nil then
							return
						end

						-- Filter out specific errors or warnings if needed
						local filtered_diagnostics = vim.tbl_filter(function(diagnostic)
							-- Example: filter out specific error codes if they're problematic
							-- return diagnostic.code ~= 80001
							return true -- Keep all diagnostics by default
						end, result.diagnostics)

						result.diagnostics = filtered_diagnostics

						vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
					end,
				},
			})

			-- Add specific keymaps for React/TypeScript files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "typescriptreact", "javascriptreact", "typescript", "javascript" },
				callback = function()
					local map = function(mode, lhs, rhs, desc)
						local opts = { buffer = true, desc = desc }
						vim.keymap.set(mode, lhs, rhs, opts)
					end

					map("n", "<leader>toi", "<cmd>TSToolsOrganizeImports<CR>", "Organize Imports")
					map("n", "<leader>tru", "<cmd>TSToolsRemoveUnused<CR>", "Remove Unused")
					map("n", "<leader>tfa", "<cmd>TSToolsFixAll<CR>", "Fix All")
					map("n", "<leader>trf", "<cmd>TSToolsRenameFile<CR>", "Rename File")
					map("n", "<leader>tai", "<cmd>TSToolsAddMissingImports<CR>", "Add Missing Imports")
					map("n", "<leader>tci", "<cmd>TSToolsGoToSourceDefinition<CR>", "Find Implementation")
				end,
			})
		end,
		ft = {
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
		},
	},
}
