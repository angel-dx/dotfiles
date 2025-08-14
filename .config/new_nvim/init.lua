require("options")
require("map")
require("lsp")
-- -- Simple snippet functionality using native features
-- local function expand_snippet(snippet)
--   local cursor_pos = vim.api.nvim_win_get_cursor(0)
--   local line = vim.api.nvim_get_current_line()
--   local before_cursor = line:sub(1, cursor_pos[2])
--   local after_cursor = line:sub(cursor_pos[2] + 1)
--
--   local new_line = before_cursor .. snippet .. after_cursor
--   vim.api.nvim_set_current_line(new_line)
--   vim.api.nvim_win_set_cursor(0, {cursor_pos[1], cursor_pos[2] + #snippet})
-- end
--
-- -- Simple snippets
-- keymap('i', '<C-s>f', function() expand_snippet('function() {\n  \n}') end)
-- keymap('i', '<C-s>i', function() expand_snippet('if () {\n  \n}') end)
-- keymap('i', '<C-s>l', function() expand_snippet('for (let i = 0; i < ; i++) {\n  \n}') end)

-- Treesitter configuration (if available)
if pcall(require, 'nvim-treesitter.configs') then
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'lua', 'vim', 'vimdoc', 'query',
      'javascript', 'typescript', 'html', 'css',
      'python', 'rust', 'go', 'c', 'cpp'
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
  })
end

-- Color scheme (using built-in themes)
vim.cmd.colorscheme('habamax') -- or 'default', 'blue', 'darkblue', etc.

-- Create undo directory if it doesn't exist
vim.fn.mkdir(vim.fn.expand('~/.config/nvim/undo'), 'p')

print("configuration loaded!")
