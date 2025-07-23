-- File: ~/.config/nvim/lua/andy4747/plugins/editor.lua
-- Lazy.nvim configuration for neo-tree.nvim, telescope

return {
  -- markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = ":call mkdp#util#install()",
    config = function()
      -- Configure markdown preview settings
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ''
      vim.g.mkdp_browser = 'zen-browser' -- Use zen-browser
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ''
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {}
      }
      vim.g.mkdp_markdown_css = ''
      vim.g.mkdp_highlight_css = ''
      vim.g.mkdp_port = '4000'
      vim.g.mkdp_page_title = '「${name}」'
      vim.g.mkdp_filetypes = { 'markdown' }

      local wk = require("which-key")
      wk.add({
        { "<leader>d",  group = "Document",               mode = "n" },
        { "<leader>dp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Preview Markdown " },
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("render-markdown").setup({})
    end,
  },
  -- Indent Guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },
  -- Plugin specification for lazy.nvim or packer

  -- Adding a filename to the Top Right
  {
    "b0o/incline.nvim",
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local devicons = require("nvim-web-devicons")

      require("incline").setup({
        hide = {
          only_win = false,
        },
        render = function(props)
          local bufname = vim.api.nvim_buf_get_name(props.buf)
          local filename = vim.fn.fnamemodify(bufname, ":t")
          if filename == "" then
            filename = "[No Name]"
          end

          local ext = vim.fn.fnamemodify(bufname, ":e")
          local icon, icon_color = devicons.get_icon(filename, ext, { default = true })

          local modified = vim.bo[props.buf].modified

          return {
            { " ",      icon,                               " ", guifg = icon_color },
            { filename, gui = modified and "bold" or "none" },
            modified and { " [+]", guifg = "#ff9e64" } or "",
            " ",
          }
        end,
      })
    end,
  },
}
