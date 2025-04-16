-- Define lazy.nvim plugin specs for importing
-- This file returns the plugin specs for lazy.nvim

return {
    -- Plugin manager
    { "folke/lazy.nvim", version = "*" },
    
    -- Load plugin configurations
    { import = "andy4747.plugins.editor" },
    { import = "andy4747.plugins.ui" },
    { import = "andy4747.plugins.lsp" },
    { import = "andy4747.plugins.tools" },
}