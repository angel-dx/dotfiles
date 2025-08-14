-- LSP Configuration (Native LSP)
local lsp_servers = {
  'lua_ls',
  'py_ls',
  'ts_ls',
  'gopls',
  'clangd',
}

for _, server in ipairs(lsp_servers) do
    vim.lsp.enable(server)
end

-- LSP keymaps (set when LSP attaches)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local opts = { buffer = event.buf }

    keymap('n', 'gd', vim.lsp.buf.definition, opts)
    keymap('n', 'gD', vim.lsp.buf.declaration, opts)
    keymap('n', 'gr', vim.lsp.buf.references, opts)
    keymap('n', 'gi', vim.lsp.buf.implementation, opts)
    keymap('n', 'K', vim.lsp.buf.hover, opts)
    keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
    keymap({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, opts)
    keymap('n', '<leader>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    keymap('n', '[d', vim.diagnostic.goto_prev, opts)
    keymap('n', ']d', vim.diagnostic.goto_next, opts)
    keymap('n', '<leader>d', vim.diagnostic.open_float, opts)
    keymap('n', '<leader>dl', vim.diagnostic.setloclist, opts)
  end,
})

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

-- Diagnostic signs
local signs = {
  Error = ' ',
  Warn = ' ',
  Hint = ' ',
  Info = ' '
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end


