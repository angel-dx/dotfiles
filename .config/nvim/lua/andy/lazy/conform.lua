return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
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

		-- Add explicit auto-command for formatting on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				conform.format({
					lsp_fallback = true,
				})
			end,
		})
	end,
}
