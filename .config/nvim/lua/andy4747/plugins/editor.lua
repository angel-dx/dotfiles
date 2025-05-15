-- File: ~/.config/nvim/lua/andy4747/plugins/editor.lua
-- Lazy.nvim configuration for neo-tree.nvim, telescope

return {
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
		config = function()
			require("render-markdown").setup({})
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

	-- Adding a filename to the Top Right
	{
		"b0o/incline.nvim",
		enabled = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local devicons = require("nvim-web-devicons")

			require("incline").setup({
				hide = {
					only_win = false,
				},
				render = function(props)
					local bufname = vim.api.nvim_buf_get_name(props.buf)
					local filename = vim.fn.fnamemodify(bufname, ":t")
					if filename == "" then
						filename = "[No Name]"
					end

					local ext = vim.fn.fnamemodify(bufname, ":e")
					local icon, icon_color = devicons.get_icon(filename, ext, { default = true })

					local modified = vim.bo[props.buf].modified

					return {
						{ " ", icon, " ", guifg = icon_color },
						{ filename, gui = modified and "bold" or "none" },
						modified and { " [+]", guifg = "#ff9e64" } or "",
						" ",
					}
				end,
			})
		end,
	},
}
