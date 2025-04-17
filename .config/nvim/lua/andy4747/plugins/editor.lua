-- File: ~/.config/nvim/lua/andy4747/plugins/editor.lua
-- Lazy.nvim configuration for neo-tree.nvim

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Optional but recommended
    "MunifTanjim/nui.nvim"
  },
  cmd = "Neotree",
  keys = {
    {"<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree"},
    {"<leader>o", "<cmd>Neotree focus<cr>", desc = "Focus Neo-tree"},
    {"<leader>gs", "<cmd>Neotree git_status<cr>", desc = "Git Status (Neo-tree)"},
    {"<leader>bf", "<cmd>Neotree buffers<cr>", desc = "Buffers (Neo-tree)"}
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = true,
    use_default_mappings = true,
    source_selector = {
      winbar = true,
      statusline = false,
      sources = {
        {source = "filesystem", display_name = " 󰉓 Files"},
        {source = "buffers", display_name = " 󰈙 Buffers"},
        {source = "git_status", display_name = " 󰊢 Git"}
      }
    },
    default_component_configs = {
      container = {
        enable_character_fade = true
      },
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander"
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
        default = "",
        highlight = "NeoTreeFileIcon"
      },
      modified = {
        symbol = "[+]",
        highlight = "NeoTreeModified"
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName"
      },
      git_status = {
        symbols = {
          -- Change type
          added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = "✖", -- this can only be used in the git_status source
          renamed = "󰁕", -- this can only be used in the git_status source
          -- Status type
          untracked = "",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = ""
        }
      }
    },
    window = {
      position = "left",
      width = 35,
      mapping_options = {
        noremap = true,
        nowait = true
      },
      mappings = {
        ["<space>"] = {
          "toggle_node",
          nowait = false -- disable `nowait` if you have existing combos starting with this char that you want to use
        },
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["<esc>"] = "cancel", -- close preview or floating neo-tree window
        ["P"] = {"toggle_preview", config = {use_float = true}},
        ["l"] = "focus_preview",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["t"] = "open_tabnew",
        ["w"] = "open_with_window_picker",
        ["C"] = "close_node",
        ["z"] = "close_all_nodes",
        ["Z"] = "expand_all_nodes",
        ["R"] = "refresh",
        ["a"] = "add",
        ["A"] = "add_directory",
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy", -- takes text input for destination
        ["m"] = "move", -- takes text input for destination
        ["q"] = "close_window",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source"
      }
    },
    filesystem = {
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = true, -- only works on Windows for hidden files/directories
        hide_by_name = {
          "node_modules",
          ".git",
          ".DS_Store"
        },
        hide_by_pattern = {},
        always_show = {},
        never_show = {},
        never_show_by_pattern = {}
      },
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        leave_dirs_open = false -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      group_empty_dirs = false, -- when true, empty folders will be grouped together
      hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree in whatever position is specified
      use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
      window = {
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
          ["o"] = "system_open"
        },
        fuzzy_finder_mappings = {
          -- define keymaps for filter popup window in fuzzy_finder_mode
          ["<C-j>"] = "move_cursor_down",
          ["<C-k>"] = "move_cursor_up"
        }
      },
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          -- Cross-platform open command
          local cmd
          if vim.fn.has("mac") == 1 then
            cmd = "open"
          elseif vim.fn.has("unix") == 1 then
            cmd = "xdg-open"
          elseif vim.fn.has("win32") == 1 then
            cmd = "start"
          end
          if cmd then
            vim.api.nvim_command("silent !" .. cmd .. " " .. vim.fn.shellescape(path))
          end
        end
      }
    },
    buffers = {
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        leave_dirs_open = false -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      group_empty_dirs = true, -- when true, empty folders will be grouped together
      show_unloaded = true,
      window = {
        mappings = {
          ["bd"] = "buffer_delete",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root"
        }
      }
    },
    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"] = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push"
        }
      }
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          -- Auto close neo-tree after selecting a file
          require("neo-tree").close_all()
        end
      },
      {
        event = "neo_tree_buffer_enter",
        handler = function()
          vim.opt_local.signcolumn = "auto"
        end
      }
    }
  }
}
