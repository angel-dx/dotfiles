return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x", -- Use stable v3.x branch
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- For file icons
    "MunifTanjim/nui.nvim",
    -- Optional: "3rd/image.nvim", -- Uncomment for image preview support
  },
  cmd = { "Neotree" }, -- Lazy-load on :Neotree command
  keys = {
    -- Lazy-loading keymaps
    { "<leader>e",  "<cmd>Neotree toggle left<cr>",      desc = "Toggle File Explorer" },
    { "<leader>eg", "<cmd>Neotree git_status float<cr>", desc = "Git Status" },
    { "<leader>eb", "<cmd>Neotree buffers float<cr>",    desc = "Buffer List" },
  },
  init = function()
    -- Automatically open Neo-tree on Neovim startup (optional, customizable)
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- Delay opening to avoid startup slowdown
        vim.defer_fn(function()
          -- Skip for certain filetypes or conditions
          if vim.bo.filetype == "" and vim.fn.argc() == 0 then
            vim.cmd("Neotree left")
          end
        end, 100)
      end,
    })
  end,
  config = function()
    -- Setup Neo-tree with comprehensive configuration
    require("neo-tree").setup({
      -- General options
      close_if_last_window = true,    -- Close Neo-tree if it's the last window
      popup_border_style = "rounded", -- Match your which-key popup style
      enable_git_status = true,       -- Enable git integration
      enable_diagnostics = true,      -- Show LSP diagnostics
      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          with_expanders = true, -- Show expand/collapse arrows
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰜌",
          default = "*",
          folder_empty_open = "󰷏",
        },
        modified = { symbol = "✶" },
        git_status = {
          symbols = {
            added = "✚",
            modified = "✹",
            deleted = "✖",
            renamed = "➜",
            untracked = "★",
            ignored = "◌",
            unstaged = "✗",
            staged = "✓",
            conflict = "",
          },
        },
      },
      -- Window options
      window = {
        position = "left", -- Default sidebar position
        width = 40,        -- Wide enough for readability
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          -- Basic navigation
          ["<CR>"] = "open",                                      -- Open file/folder
          ["<C-t>"] = "open_tabnew",                              -- Open in new tab
          ["<C-v>"] = "open_vsplit",                              -- Open in vertical split
          ["<C-x>"] = "open_split",                               -- Open in horizontal split
          -- File operations
          ["a"] = { "add", config = { show_path = "relative" } }, -- Create file
          ["A"] = "add_directory",                                -- Create directory
          ["d"] = "delete",                                       -- Delete file/folder
          ["r"] = "rename",                                       -- Rename file/folder
          ["y"] = "copy_to_clipboard",                            -- Copy file path
          ["x"] = "cut_to_clipboard",                             -- Cut file
          ["p"] = "paste_from_clipboard",                         -- Paste file
          -- Git actions
          ["S"] = "git_add_all",                                  -- Stage all changes
          ["gu"] = "git_unstage_file",                            -- Unstage file
          ["ga"] = "git_add_file",                                -- Stage file
          -- Misc
          ["q"] = "close_window",                                 -- Close Neo-tree
          ["?"] = "show_help",                                    -- Show help
          ["<"] = "prev_source",                                  -- Switch to previous source
          [">"] = "next_source",                                  -- Switch to next source
        },
      },
      -- Filesystem source
      filesystem = {
        filtered_items = {
          visible = false, -- Hide hidden files by default
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = { ".git", "node_modules", "__pycache__" },
          never_show = { ".DS_Store" },
        },
        follow_current_file = {
          enabled = true,              -- Auto-reveal current file
          leave_dirs_open = false,     -- Close parent dirs when switching
        },
        use_libuv_file_watcher = true, -- Auto-refresh on file changes
        bind_to_cwd = true,            -- Sync Neo-tree with Neovim's CWD
      },
      -- Buffers source
      buffers = {
        follow_current_file = {
          enabled = true, -- Highlight current buffer
          leave_dirs_open = false,
        },
        group_empty_dirs = true, -- Group empty directories
      },
      -- Git status source
      git_status = {
        window = {
          position = "float", -- Floating window for git status
          mappings = {
            ["A"] = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
          },
        },
      },
      -- Event handlers for integration with other plugins
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            -- Auto-close Neo-tree after opening a file
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    })

    -- Register keymaps with which-key
    local wk = require("which-key")
    wk.add({
      { "<leader>e",  group = "Explorer",                  mode = "n" },
      { "<leader>er", "<cmd>Neotree reveal current<cr>",   desc = "Reveal Current File", mode = "n" },
      { "<leader>eg", "<cmd>Neotree git_status float<cr>", desc = "Git Status",          mode = "n" },
      { "<leader>eb", "<cmd>Neotree buffers float<cr>",    desc = "Buffer List",         mode = "n" },
    })
  end,
}
