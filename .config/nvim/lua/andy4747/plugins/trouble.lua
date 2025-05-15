return {
    {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	opts = {
		focus = true,
	},
	cmd = "Trouble",
	keys = {
		{ "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
		{
			"<leader>xd",
			"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
			desc = "Open trouble document diagnostics",
		},
		{ "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
		{ "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
	},
},
  -- {
  --   "folke/trouble.nvim",
  --   branch = "main", -- Ensures v3.x
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   cmd = { "Trouble" },
  --   keys = {
  --     { "<leader>xx", "<cmd>Trouble document_diagnostics<cr>",            desc = "Document Diagnostics (Trouble)" },
  --     { "<leader>xX", "<cmd>Trouble workspace_diagnostics<cr>",           desc = "Workspace Diagnostics (Trouble)" },
  --     { "<leader>xL", "<cmd>Trouble loclist<cr>",                         desc = "Location List (Trouble)" },
  --     { "<leader>xQ", "<cmd>Trouble quickfix<cr>",                        desc = "Quickfix List (Trouble)" },
  --     { "<leader>xt", "<cmd>Trouble todo<cr>",                            desc = "Todo (Trouble)" },
  --     { "<leader>xr", "<cmd>Trouble lsp_references<cr>",                  desc = "LSP References (Trouble)" },
  --     { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Toggle Buffer Diagnostics" },
  --     { "<leader>xi", "<cmd>Trouble lsp_implementations<cr>",             desc = "LSP Implementations (Trouble)" },
  --     { "<leader>xs", "<cmd>Trouble symbols<cr>",                         desc = "Document Symbols (Trouble)" },
  --   },
  --   opts = {
  --     position = "bottom",
  --     height = 10,
  --     icons = true,
  --     mode = "workspace_diagnostics",
  --     severity = nil,
  --     group = true,
  --     padding = true,
  --     cycle_results = true,
  --     auto_close = false,
  --     auto_preview = true,
  --     auto_fold = false,
  --     auto_jump = { "lsp_definitions", "lsp_implementations" },
  --     indent_lines = true,
  --     win_config = { border = "rounded" },
  --     use_diagnostic_signs = true,
  --     signs = {
  --       error = "",
  --       warning = "",
  --       hint = "",
  --       information = "",
  --       other = "",
  --     },
  --     action_keys = {
  --       close = "q",
  --       cancel = "<esc>",
  --       refresh = "r",
  --       jump = { "<cr>", "<tab>" },
  --       open_split = { "<c-x>" },
  --       open_vsplit = { "<c-v>" },
  --       open_tab = { "<c-t>" },
  --       jump_close = { "o" },
  --       toggle_mode = "m",
  --       toggle_preview = "P",
  --       hover = "K",
  --       preview = "p",
  --       close_folds = { "zM", "zm" },
  --       open_folds = { "zR", "zr" },
  --       toggle_fold = { "zA", "za" },
  --       previous = "k",
  --       next = "j",
  --     },
  --     -- Custom mode for filtering diagnostics by severity
  --     modes = {
  --       errors = {
  --         mode = "diagnostics",
  --         filter = { severity = vim.diagnostic.severity.ERROR },
  --         auto_open = false,
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     require("trouble").setup(opts)
  --     local wk = require("which-key")
  --     wk.add({
  --       { "<leader>x",  group = "Trouble",                        mode = "n" },
  --       { "<leader>xx", "<cmd>Trouble document_diagnostics<cr>",  desc = "Document Diagnostics" },
  --       { "<leader>xX", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
  --       { "<leader>xL", "<cmd>Trouble loclist<cr>",               desc = "Location List" },
  --       { "<leader>xQ", "<cmd>Trouble quickfix<cr>",              desc = "Quickfix List" },
  --       { "<leader>xt", "<cmd>Trouble todo<cr>",                  desc = "Todo List" },
  --       { "<leader>xr", "<cmd>Trouble lsp_references<cr>",        desc = "LSP References" },
  --       {
  --         "<leader>xd",
  --         "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  --         desc = "Toggle Buffer Diagnostics",
  --       },
  --       { "<leader>xi", "<cmd>Trouble lsp_implementations<cr>", desc = "LSP Implementations" },
  --       { "<leader>xs", "<cmd>Trouble symbols<cr>",             desc = "Document Symbols" },
  --       { "<leader>xe", "<cmd>Trouble errors<cr>",              desc = "Errors Only" },
  --     })
  --   end,
  -- },
}
