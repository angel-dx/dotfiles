return {
	"vim-scripts/twilight256.vim",
	name = "twilight256",
	priority = 1000, -- Load this early
	lazy = false, -- Don't lazy load colorschemes
	config = function()
		vim.opt.background = "dark"
		vim.opt.termguicolors = true
		vim.cmd("colorscheme twilight256")
	end,
}
