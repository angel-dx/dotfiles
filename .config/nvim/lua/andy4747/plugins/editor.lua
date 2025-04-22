-- File: ~/.config/nvim/lua/andy4747/plugins/editor.lua
-- Lazy.nvim configuration for neo-tree.nvim, telescope

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-project.nvim" },
		},
		event = "VeryLazy", -- Load earlier to ensure availability for extensions
		cmd = "Telescope",
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			-- Telescope setup (unchanged)
			telescope.setup({
				defaults = {
					prompt_prefix = "   ",
					selection_caret = " ",
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = { prompt_position = "top", preview_width = 0.55 },
						vertical = { mirror = false },
						width = 0.87,
						height = 0.80,
					},
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<esc>"] = actions.close,
						},
					},
					file_ignore_patterns = {
						"node_modules/",
						"%.git/",
						"%.cache/",
						"__pycache__/",
						"%.class",
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						follow = true,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					project = {
						base_dirs = {
							{ path = "~/Desktop/andy4747", max_depth = 3 },
							-- for zoro macbook
							-- { path = "~/Documents/andy4747", max_depth = 3 },
							{ path = "~/.config", max_depth = 2 },
						},
						hidden_files = true,
					},
				},
			})

			-- Load Telescope extensions
			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
			telescope.load_extension("project")
			pcall(telescope.load_extension, "trouble")

			-- Register keymaps with which-key
			local wk = require("which-key")
			wk.add({
				{ "<leader>f", group = "Find", mode = "n" },
				{
					"<leader>ff",
					"<cmd>Telescope find_files<CR>",
					desc = "Find Files",
					mode = "n",
				},
				{
					"<leader>fg",
					"<cmd>Telescope live_grep<CR>",
					desc = "Live Grep",
					mode = "n",
				},
				{
					"<leader>fb",
					"<cmd>Telescope buffers<CR>",
					desc = "Buffers",
					mode = "n",
				},
				{
					"<leader>fh",
					"<cmd>Telescope help_tags<CR>",
					desc = "Help Tags",
					mode = "n",
				},
				{
					"<leader>fr",
					"<cmd>Telescope oldfiles<CR>",
					desc = "Recent Files",
					mode = "n",
				},
				{
					"<leader>fp",
					"<cmd>Telescope project<CR>",
					desc = "Projects",
					mode = "n",
				},
				{ "<leader>fd", "<cmd>Telescope trouble<CR>", desc = "Find Diagnostics" },
				-- Include todo-comments keymaps under <leader>f for consistency
				{
					"<leader>ft",
					"<cmd>TodoTelescope<cr>",
					desc = "Find Todos",
					mode = "n",
				},
				{
					"<leader>fT",
					"<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",
					desc = "Find Todo/Fix/Fixme",
					mode = "n",
				},
			})
		end,
	},
	-- markdown preview
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = ":call mkdp#util#install()",
		config = function()
			local wk = require("which-key")
			wk.add({
				{ "<leader>d", group = "Document", mode = "n" },
				{ "<leader>dp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Preview Markdown " },
			})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter", -- Load only when needed
		config = function()
			local npairs = require("nvim-autopairs")

			npairs.setup({
				check_ts = true, -- Enable Treesitter integration
				disable_filetype = { "TelescopePrompt", "vim" },
				fast_wrap = {
					map = "<M-e>", -- Alt+e to trigger wrapping
					chars = { "{", "[", "(", '"', "'", "`" },
					pattern = [=[[%'%"%)%>%]%)%}%,]]=],
					offset = 0,
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "PmenuSel",
					highlight_grey = "LineNr",
				},
			})
		end,
	},

	-- Install and configure nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				modules = {},
				-- A list of parser names, or "all" (parsers with maintainers)
				ensure_installed = {
					-- Programming languages
					"go",
					"gomod",
					"gosum",
					"gowork", -- Go ecosystem
					"javascript",
					"typescript",
					"tsx", -- JS/TS ecosystem
					"html",
					"css",
					"json",
					"jsonc",
					"yaml",
					"toml",
					"markdown",
					"markdown_inline", -- Common formats
					-- Config files
					"lua",
					"vim", -- Editor configs
					"dockerfile",
					"bash",
					"fish", -- Shell/container configs
					"diff",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore", -- Git-related
					-- Common additional languages
					"python",
					"rust",
					"c",
					"cpp",
					"make",
					"cmake",
					-- Query language for treesitter itself
					"query",
				},
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				-- Automatically install missing parsers when entering buffer
				auto_install = true,
				-- List of parsers to ignore installing (or "all")
				ignore_install = {},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
					disable = function(lang, buf)
						-- Disable for very large files to maintain performance
						local max_filesize = 500 * 1024 -- 500 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				-- Indentation based on treesitter
				indent = { enable = true },
				-- Incrementally select code blocks
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
				-- Auto close and rename HTML/JSX tags
				autotag = { enable = true },
				-- Text objects for selecting syntax tree nodes
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["ai"] = "@conditional.outer",
							["ii"] = "@conditional.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
							["as"] = "@statement.outer",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					context_commentstring = {
						enabled = true,
						enable_autocmd = false,
					},
				},
			})

			-- Set compiler options for specific languages
			require("nvim-treesitter.install").compilers = { "gcc", "clang" }

			-- Set folding based on treesitter
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldenable = false -- Disable folding at startup
		end,
	},
	-- Better text objects
	{
		"echasnovski/mini.ai",
		version = "*",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			}
		end,
	},
	-- Indent Guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPost",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
	},
	-- Plugin specification for lazy.nvim or packer
	{
		"folke/trouble.nvim",
		branch = "main", -- Ensures v3.x
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope.nvim",
		},
		cmd = { "Trouble" },
		keys = {
			{ "<leader>xx", "<cmd>Trouble document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble loclist<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble quickfix<cr>", desc = "Quickfix List (Trouble)" },
			{ "<leader>xt", "<cmd>Trouble todo<cr>", desc = "Todo (Trouble)" },
			{ "<leader>xr", "<cmd>Trouble lsp_references<cr>", desc = "LSP References (Trouble)" },
			{ "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Toggle Buffer Diagnostics" },
			{ "<leader>xi", "<cmd>Trouble lsp_implementations<cr>", desc = "LSP Implementations (Trouble)" },
			{ "<leader>xs", "<cmd>Trouble symbols<cr>", desc = "Document Symbols (Trouble)" },
		},
		opts = {
			position = "bottom",
			height = 10,
			icons = true,
			mode = "workspace_diagnostics",
			severity = nil,
			group = true,
			padding = true,
			cycle_results = true,
			auto_close = false,
			auto_preview = true,
			auto_fold = false,
			auto_jump = { "lsp_definitions", "lsp_implementations" },
			indent_lines = true,
			win_config = { border = "rounded" },
			use_diagnostic_signs = true,
			signs = {
				error = "",
				warning = "",
				hint = "",
				information = "",
				other = "",
			},
			action_keys = {
				close = "q",
				cancel = "<esc>",
				refresh = "r",
				jump = { "<cr>", "<tab>" },
				open_split = { "<c-x>" },
				open_vsplit = { "<c-v>" },
				open_tab = { "<c-t>" },
				jump_close = { "o" },
				toggle_mode = "m",
				toggle_preview = "P",
				hover = "K",
				preview = "p",
				close_folds = { "zM", "zm" },
				open_folds = { "zR", "zr" },
				toggle_fold = { "zA", "za" },
				previous = "k",
				next = "j",
			},
			-- Custom mode for filtering diagnostics by severity
			modes = {
				errors = {
					mode = "diagnostics",
					filter = { severity = vim.diagnostic.severity.ERROR },
					auto_open = false,
				},
			},
		},
		config = function(_, opts)
			require("trouble").setup(opts)
			local wk = require("which-key")
			wk.add({
				{ "<leader>x", group = "Trouble", mode = "n" },
				{ "<leader>xx", "<cmd>Trouble document_diagnostics<cr>", desc = "Document Diagnostics" },
				{ "<leader>xX", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
				{ "<leader>xL", "<cmd>Trouble loclist<cr>", desc = "Location List" },
				{ "<leader>xQ", "<cmd>Trouble quickfix<cr>", desc = "Quickfix List" },
				{ "<leader>xt", "<cmd>Trouble todo<cr>", desc = "Todo List" },
				{ "<leader>xr", "<cmd>Trouble lsp_references<cr>", desc = "LSP References" },
				{
					"<leader>xd",
					"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
					desc = "Toggle Buffer Diagnostics",
				},
				{ "<leader>xi", "<cmd>Trouble lsp_implementations<cr>", desc = "LSP Implementations" },
				{ "<leader>xs", "<cmd>Trouble symbols<cr>", desc = "Document Symbols" },
				{ "<leader>xe", "<cmd>Trouble errors<cr>", desc = "Errors Only" },
			})
		end,
	},
}
