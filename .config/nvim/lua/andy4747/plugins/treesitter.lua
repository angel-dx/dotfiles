return {
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        modules = {},
        -- A list of parser names, or "all" (parsers with maintainers)
        ensure_installed = {
          -- Programming languages
          "go",
          "gomod",
          "gosum",
          "gowork", -- Go ecosystem
          "zig",
          "javascript",
          "typescript",
          "tsx", -- JS/TS ecosystem
          "html",
          "css",
          "json",
          "jsonc",
          "yaml",
          "toml",
          "markdown",
          "markdown_inline", -- Common formats
          -- Config files
          "lua",
          "vim", -- Editor configs
          "dockerfile",
          "bash",
          "fish", -- Shell/container configs
          "diff",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore", -- Git-related
          -- Common additional languages
          "python",
          "rust",
          "c",
          "cpp",
          "make",
          "cmake",
          -- Query language for treesitter itself
          "query",
        },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- Automatically install missing parsers when entering buffer
        auto_install = true,
        -- List of parsers to ignore installing (or "all")
        ignore_install = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = function(lang, buf)
            -- Disable for very large files to maintain performance
            local max_filesize = 500 * 1024 -- 500 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        -- Indentation based on treesitter
        indent = { enable = true },
        -- Incrementally select code blocks
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        -- Auto close and rename HTML/JSX tags
        autotag = { enable = true },
        -- Text objects for selecting syntax tree nodes
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["ai"] = "@conditional.outer",
              ["ii"] = "@conditional.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["as"] = "@statement.outer",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          context_commentstring = {
            enabled = true,
            enable_autocmd = false,
          },
        },
      })

      -- Set compiler options for specific languages
      require("nvim-treesitter.install").compilers = { "gcc", "clang" }

      -- Set folding based on treesitter
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false -- Disable folding at startup
    end,
  },
}
