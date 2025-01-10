return {
	{
		"nvim-telescope/telescope.nvim",
		version = false, -- Always use the latest version
		dependencies = {
			{ "nvim-lua/plenary.nvim" }, -- Required dependency
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Fuzzy search speedup
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			telescope.setup({
				defaults = {
					prompt_prefix = "🔍 ",
					selection_caret = "➤ ",
					file_ignore_patterns = { "^.git/" }, -- Ignore .git directory
					layout_config = {
						horizontal = { preview_width = 0.6 },
						vertical = { preview_height = 0.6 },
					},
					mappings = {
						i = { -- Insert mode
							["<C-j>"] = actions.move_selection_next, -- Move to next item
							["<C-k>"] = actions.move_selection_previous, -- Move to previous item
							["<C-c>"] = actions.close, -- Close Telescope
						},
						n = { -- Normal mode
							["q"] = actions.close, -- Close Telescope
						},
					},
				},
				pickers = {
					find_files = {
						hidden = true, -- Show hidden files
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- Fuzzy matching
						override_generic_sorter = true, -- Override the generic sorter
						override_file_sorter = true, -- Override the file sorter
						case_mode = "smart_case", -- "smart_case" | "ignore_case" | "respect_case"
					},
				},
			})
			-- Load extensions
			telescope.load_extension("fzf")
		end,
	},
}
