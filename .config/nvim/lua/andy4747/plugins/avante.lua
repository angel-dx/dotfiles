return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		enabled = false,
		build = "make",
		opts = {
			provider = "gemini",
			behaviour = {
				auto_suggestions = false, -- Experimental stage
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = false,
				support_paste_from_clipboard = false,
			},
			gemini = {
				-- @see https://ai.google.dev/gemini-api/docs/models/gemini
				api_key_name = "GEMINI_API_KEY",
				model = "gemini-1.5-pro",
				max_tokens = 4096,
				temperature = 0,
			},
		},
		dependencies = {
			"MeanderingProgrammer/render-markdown.nvim",
			ft = { "markdown", "norg", "rmd", "org", "Avante" },
		},
	},
}
