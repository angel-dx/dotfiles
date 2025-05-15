return {
	{
		"stevearc/oil.nvim",
		enabled = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				default_file_explorer = true, -- start up nvim with oil instead of netrw
				columns = {},
				keymaps = {
					["<C-h>"] = false,
					["<C-c>"] = false, -- prevent from closing Oil as <C-c> is esc key
					["<M-h>"] = "actions.select_split",
					["q"] = "actions.close",
				},
				delete_to_trash = true,
				view_options = {
					show_hidden = true,
				},
				skip_confirm_for_simple_edits = true,
			})

			-- opens parent dir over current active window
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
			-- open parent dir in float window
			vim.keymap.set("n", "<leader>-", require("oil").toggle_float)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "oil", -- Adjust if Oil uses a specific file type identifier
				callback = function()
					vim.opt_local.cursorline = true
				end,
			})
		end,
	},
	{
		"echasnovski/mini.files",
		enabled = false,
		config = function()
			local MiniFiles = require("mini.files")
			MiniFiles.setup({
				mappings = {
					go_in = "<CR>", -- Map both Enter and L to enter directories or open files
					go_in_plus = "L",
					go_out = "<C-h>",
					go_out_plus = "H",
				},
			})
			vim.keymap.set("n", "<leader>ee", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" }) -- toggle file explorer
			vim.keymap.set("n", "<leader>ef", function()
				MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
				MiniFiles.reveal_cwd()
			end, { desc = "Toggle into currently opened file" })
		end,
	},
}
