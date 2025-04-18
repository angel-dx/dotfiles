return {
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        priority = 1000, -- Make sure this loads very early
        config = function()
            -- Disable netrw at the very start
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            vim.g.loaded_netrwSettings = 1
            vim.g.loaded_netrwFileHandlers = 1

            local dashboard = require("alpha.themes.dashboard")

            -- Set header
            dashboard.section.header.val = {
                "                                                     ",
                "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
                "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
                "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
                "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
                "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
                "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
                "                                            andy4747"
            }

            -- Set menu
            dashboard.section.buttons.val = {
                dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
                dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
                dashboard.button("s", "  Settings", ":e $MYVIMRC <CR>"),
                dashboard.button("q", "  Quit NVIM", ":qa<CR>")
            }

            -- Set footer
            local fortune = require("alpha.fortune")
            dashboard.section.footer.val = fortune()

            -- Send config to alpha
            require("alpha").setup(dashboard.opts)

            -- Ensure alpha opens on startup
            vim.api.nvim_create_autocmd(
                "VimEnter",
                {
                    desc = "Start Alpha when vim is opened with no arguments",
                    callback = function()
                        local should_skip = false
                        -- If a file or directory is specified on the command line
                        if vim.fn.argc() > 0 or vim.fn.line2byte("$") ~= -1 or not vim.o.modifiable then
                            should_skip = true
                        else
                            -- Skip special buffers
                            for _, arg in pairs(vim.v.argv) do
                                if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
                                    should_skip = true
                                    break
                                end
                            end
                        end

                        if not should_skip then
                            require("alpha").start(true)
                        end
                    end,
                    group = vim.api.nvim_create_augroup("alpha_autostart", { clear = true })
                }
            )
        end
    }
}
