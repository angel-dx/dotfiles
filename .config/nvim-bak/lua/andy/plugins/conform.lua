return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Format in visual mode using space+fm
			"<space>fm",
			function()
				local start_row = vim.fn.line("'<")
				local end_row = vim.fn.line("'>")
				require("conform").format({
					range = {
						start = { start_row, 0 },
						["end"] = { end_row, 999999 },
					},
				})
			end,
			mode = { "x" },
			desc = "Format selection",
		},
		{
			-- Format in visual mode using gq
			"gq",
			function()
				local start_row = vim.fn.line("'<")
				local end_row = vim.fn.line("'>")
				require("conform").format({
					range = {
						start = { start_row, 0 },
						["end"] = { end_row, 999999 },
					},
				})
			end,
			mode = { "x" },
			desc = "Format selection (gq)",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "gofmt", "goimports" },
			javascript = { "prettierd", "eslint" },
			typescript = { "prettierd", "eslint" },
			typescriptreact = { "prettierd", "eslint" },
			javascriptreact = { "prettierd", "eslint" },
			jsx = { "prettierd", "eslint" },
			tsx = { "prettierd", "eslint" },
			elixir = { "elixirls" },
			svelte = { "prettierd", "eslint" },
			yaml = { "yamlfmt" },
			toml = { "taplo" },
			bash = { "beautysh" },
			markdown = { "prettierd" },
			json = { "prettierd" },
			html = { "prettierd" },
			css = { "prettierd" },
			scss = { "prettierd" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = {
			timeout_ms = 500,
		},
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				conform.format({
					lsp_fallback = true,
				})
			end,
		})
	end,
}
