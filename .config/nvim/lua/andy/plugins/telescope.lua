return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next,     -- move to next result
                    },
                },
                find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
                file_ignore_patterns = {}, -- Ensure no patterns are excluding files
                no_ignore = true,          -- Disable ignoring files specified in .gitignore or other ignore files
                follow = true,             -- Follow symlinks
            },
        })

        telescope.load_extension("fzf")

        -- set keymaps
        local keymap = vim.keymap

        keymap.set("n", "<leader>ff", function()
            require("telescope.builtin").find_files({
                hidden = true,
                no_ignore = true,
                file_ignore_patterns = { ".git/" }, -- Exclude the .git directory
            })
        end, { desc = "Fuzzy find files in cwd" })
    end,
}
