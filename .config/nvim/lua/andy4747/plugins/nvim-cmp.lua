return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim", -- Nice icons in completion menu
		"roobert/tailwindcss-colorizer-cmp.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		local colorizer = require("tailwindcss-colorizer-cmp").formatter

		local lsp_kinds = {
			Class = " ",
			Color = " ",
			Constant = " ",
			Constructor = " ",
			Enum = " ",
			EnumMember = " ",
			Event = " ",
			Field = " ",
			File = " ",
			Folder = " ",
			Function = " ",
			Interface = " ",
			Keyword = " ",
			Method = " ",
			Module = " ",
			Operator = " ",
			Property = " ",
			Reference = " ",
			Snippet = " ",
			Struct = " ",
			Text = " ",
			TypeParameter = " ",
			Unit = " ",
			Value = " ",
			Variable = " ",
		}

		-- Load friendly-snippets
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Add Go, React, TS/JS snippets
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/go" } })
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/typescript-react" } })
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/docker" } })

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				-- ["<Tab>"] = cmp.mapping(function(fallback)
				--   if cmp.visible() then
				--     cmp.select_next_item()
				--   elseif luasnip.expand_or_jumpable() then
				--     luasnip.expand_or_jump()
				--   else
				--     fallback()
				--   end
				-- end, { "i", "s" }),
				-- ["<S-Tab>"] = cmp.mapping(function(fallback)
				-- 	if cmp.visible() then
				-- 		cmp.select_prev_item()
				-- 	elseif luasnip.jumpable(-1) then
				-- 		luasnip.jump(-1)
				-- 	else
				-- 		fallback()
				-- 	end
				-- end, { "i", "s" }),
			}),
			formatting = {

				format = function(entry, vim_item)
					vim_item.kind = string.format("%s %s", lsp_kinds[vim_item.kind] or "", vim_item.kind)
					-- add menu tags (e.g., [Buffer], [LSP])
					vim_item.menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						latex_symbols = "[LaTeX]",
					})[entry.source.name]
					-- use lsplkind
					vim_item = lspkind.cmp_format({
						maxwidth = 50,
						ellipsis_char = "...",
					})(entry, vim_item)
					-- use tailwindcss-colorizer-cmp for color formatting
					if entry.source.name == "nvim_lsp" then
						vim_item = colorizer(entry, vim_item)
					end
					return vim_item
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 1000 }, -- most relevant: LSP suggestions
				{ name = "luasnip", priority = 900 }, -- snippet completions
				{ name = "nvim_lua", priority = 800 }, -- Lua API if you're writing Neovim config/plugins
				{ name = "buffer", priority = 700 }, -- local buffer words
				{ name = "path", priority = 600 }, -- file system paths
				{ name = "tailwindcss-colorizer-cmp", priority = 500 }, -- color support, if using Tailwind
			}),
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			experimental = {
				ghost_text = true,
			},
		})

		-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore)
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore)
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "cmdline" },
			}),
		})
	end,
}
