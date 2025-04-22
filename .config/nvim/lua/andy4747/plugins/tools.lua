return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
		},
	},
	{
		"echasnovski/mini.splitjoin",
		config = function()
			local mini_split_join = require("mini.splitjoin")
			mini_split_join.setup({ mappings = { toggle = "" } })
			vim.keymap.set({ "n", "x" }, "sj", function()
				mini_split_join.join()
			end, { desc = "join arguments" })
			vim.keymap.set({ "n", "x" }, "sk", function()
				mini_split_join.split()
			end, { desc = "split arguments" })
		end,
	},
	-- Todo comments
	{
		"folke/todo-comments.nvim",
		cmd = {
			"TodoTrouble",
			"TodoTelescope",
		},
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {}, -- Replaces config = true for better lazy.nvim integration
		-- keys = {
		--   -- Define keys for lazy-loading (minimal commands to trigger plugin)
		--   { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
		--   { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
		--   { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
		--   { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
		--   { "<leader>ft", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
		--   { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
		-- },
		config = function()
			-- Setup todo-comments.nvim
			require("todo-comments").setup()

			-- Register keymaps with which-key
			local wk = require("which-key")
			wk.add({
				-- Todo navigation (no prefix, motion-like)
				{
					"]t",
					function()
						require("todo-comments").jump_next()
					end,
					desc = "Next Todo Comment",
				},
				{
					"[t",
					function()
						require("todo-comments").jump_prev()
					end,
					desc = "Previous Todo Comment",
				},
				-- Trouble-related keymaps under <leader>x
				{ "<leader>x", group = "Trouble", mode = "n" },
				{
					"<leader>xt",
					"<cmd>TodoTrouble<cr>",
					desc = "Todo List",
					mode = "n",
				},
				{
					"<leader>xT",
					"<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",
					desc = "Todo/Fix/Fixme List",
					mode = "n",
				},
				-- Telescope-related keymaps under <leader>f
				{ "<leader>f", group = "Find", mode = "n" },
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
	--comment context
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
				config = {
					-- Default comment styles for various languages
					javascript = {
						__default = "// %s",
						jsx_element = "{/* %s */}",
						jsx_fragment = "{/* %s */}",
						jsx_attribute = "// %s",
						comment = "// %s",
					},
					typescript = {
						__default = "// %s",
						tsx_element = "{/* %s */}",
						tsx_fragment = "{/* %s */}",
						tsx_attribute = "// %s",
						comment = "// %s",
					},
					go = "// %s",
					python = "# %s",
					lua = "-- %s",
					html = "<!-- %s -->",
					css = "/* %s */",
					json = "// %s",
					yaml = "# %s",
					toml = "# %s",
					markdown = "<!-- %s -->",
					bash = "# %s",
					fish = "# %s",
					dockerfile = "# %s",
					rust = "// %s",
					c = "/* %s */",
					cpp = "// %s",
				},
			})
		end,
	},
	-- Comment lines/blocks
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			require("Comment").setup({
				-- Required fields to resolve the diagnostic
				padding = true, -- Add space after comment marker (e.g., "// " instead of "//")
				sticky = true, -- Keep cursor in place after commenting
				ignore = "^$", -- No patterns to ignore (can be a regex like "^$" to ignore empty lines)
				extra = {
					above = "gcO", -- Add comment on the line above
					below = "gco", -- Add comment on the line below
					eol = "gcA", -- Add comment at end of line
				},
				post_hook = function() end,

				-- Existing configuration for keymaps
				toggler = {
					line = "gcc", -- Line-comment toggle
					block = "gbc", -- Block-comment toggle
				},
				opleader = {
					line = "gc", -- Line-comment operator
					block = "gb", -- Block-comment operator
				},
				mappings = {
					basic = true, -- Enable basic mappings (gcc, gbc)
					extra = true, -- Enable extra mappings (gcO, gco, gcA)
				},

				-- Integration with nvim-ts-context-commentstring for JSX and language-specific commenting
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})

			-- Register keymaps with which-key for consistency
			local wk = require("which-key")
			wk.add({
				{ "<leader>c", group = "Code", mode = { "n", "v" } },
				{ "<leader>cc", "gcc", desc = "Toggle Line Comment", mode = "n", remap = true },
				{ "<leader>cb", "gbc", desc = "Toggle Block Comment", mode = "n", remap = true },
				{ "<leader>cc", "gc", desc = "Toggle Line Comment", mode = "v", remap = true },
				{ "<leader>cb", "gb", desc = "Toggle Block Comment", mode = "v", remap = true },
			})
		end,
	},
}
