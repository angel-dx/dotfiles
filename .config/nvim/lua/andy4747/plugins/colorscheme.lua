-- return {
-- 	"sainnhe/sonokai",
-- 	priority = 1000,
-- 	config = function()
-- 		-- Choose a style (optional — defaults to 'default' if unset)
-- 		vim.g.sonokai_style = "shusia" -- or 'andromeda', 'shusia', 'espresso' etc.
--
-- 		-- (Optional) Improve performance on some terminals
-- 		vim.g.sonokai_enable_italic = 1
-- 		vim.g.sonokai_disable_italic_comment = 0
--
-- 		-- Set colorscheme
-- 		vim.cmd.colorscheme("sonokai")
-- 	end,
-- }
-- return {
-- 	"zenbones-theme/zenbones.nvim",
-- 	-- Optionally install Lush. Allows for more configuration or extending the colorscheme
-- 	-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
-- 	-- In Vim, compat mode is turned on as Lush only works in Neovim.
-- 	dependencies = "rktjmp/lush.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	-- you can set set configuration options here
-- 	config = function()
-- 		vim.g.zenbones_darken_comments = 45
-- 		vim.cmd.colorscheme("kanagawabones")
-- 	end,
-- }
-- return {
-- 	"armannikoyan/rusty",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {
-- 		transparent = true,
-- 		italic_comments = true,
-- 		underline_current_line = true,
-- 		colors = {
-- 			foreground = "#c5c8c6",
-- 			background = "#1d1f21",
-- 			selection = "#373b41",
-- 			line = "#282a2e",
-- 			comment = "#969896",
-- 			red = "#cc6666",
-- 			orange = "#de935f",
-- 			yellow = "#f0c674",
-- 			green = "#b5bd68",
-- 			aqua = "#8abeb7",
-- 			blue = "#81a2be",
-- 			purple = "#b294bb",
-- 			window = "#4d5057",
-- 		},
-- 	},
-- 	config = function(_, opts)
-- 		require("rusty").setup(opts)
-- 		vim.cmd("colorscheme rusty")
-- 	end,
-- }

-- Rose Pine Colorscheme Configuration with Enhanced Syntax Highlighting
-- A sophisticated theme with added color variance for code
-- return {}
-- return {
--   "rose-pine/neovim",
--   name = "rose-pine",
--   priority = 1000, -- Load this before other plugins
--   config = function()
--     require('rose-pine').setup({
--       --- @usage 'auto'|'main'|'moon'|'dawn'
--       variant = 'auto',
--       --- @usage 'main'|'moon'|'dawn'
--       dark_variant = 'main',
--       bold_vert_split = false,
--       dim_nc_background = false,
--       disable_background = false,
--       disable_float_background = false,
--       disable_italics = false,

--       --- @usage string hex value or named color from rosepinetheme.com/palette
--       groups = {
--         background = 'base',
--         background_nc = '_experimental_nc',
--         panel = 'surface',
--         panel_nc = 'base',
--         border = 'highlight_med',
--         comment = 'muted',
--         link = 'iris',
--         punctuation = 'subtle',

--         error = 'love',
--         hint = 'iris',
--         info = 'foam',
--         warn = 'gold',

--         headings = {
--           h1 = 'iris',
--           h2 = 'foam',
--           h3 = 'rose',
--           h4 = 'gold',
--           h5 = 'pine',
--           h6 = 'foam',
--         }
--       },

--       -- Enhanced syntax highlighting with more color variance
--       highlight_groups = {
--         -- Blend colours against the "base" background
--         CursorLine = { bg = 'foam', blend = 10 },
--         StatusLine = { fg = 'love', bg = 'love', blend = 10 },

--         -- Telescope customization
--         TelescopeNormal = { bg = 'base' },
--         TelescopeBorder = { fg = 'subtle', bg = 'base' },
--         TelescopePromptNormal = { bg = 'surface' },
--         TelescopePromptBorder = { fg = 'subtle', bg = 'surface' },
--         TelescopePromptTitle = { fg = 'base', bg = 'rose' },
--         TelescopePreviewTitle = { fg = 'base', bg = 'foam' },
--         TelescopeResultsTitle = { fg = 'base', bg = 'gold' },

--         -- Diagnostics
--         DiagnosticError = { fg = 'love' },
--         DiagnosticWarn = { fg = 'gold' },
--         DiagnosticInfo = { fg = 'foam' },
--         DiagnosticHint = { fg = 'iris' },

--         -- NvimTree
--         NvimTreeNormal = { bg = 'base' },
--         NvimTreeWinSeparator = { fg = 'subtle' },

--         -- Indent lines
--         IndentBlanklineChar = { fg = 'subtle', bg = 'none' },

--         -- Floating windows
--         FloatBorder = { fg = 'subtle' },
--         FloatTitle = { fg = 'subtle' },

--         -- LSP
--         LspReferenceText = { bg = 'highlight_med' },
--         LspReferenceRead = { bg = 'highlight_med' },
--         LspReferenceWrite = { bg = 'highlight_med' },

--         -- ============= ENHANCED SYNTAX HIGHLIGHTING =============
--         -- Basic syntax
--         Comment = { fg = 'muted', italic = true },
--         String = { fg = '#d7c897' }, -- Warmer gold for strings
--         Character = { fg = '#f0b4a7' }, -- Soft coral for characters
--         Number = { fg = '#c4a7f0' }, -- Light purple for numbers
--         Boolean = { fg = '#f0a7c4' }, -- Pink for booleans
--         Float = { fg = '#c4a7f0', italic = true }, -- Purple italic for floats

--         -- Keywords and structure
--         Identifier = { fg = '#a3cdf5' }, -- Soft blue for identifiers
--         Function = { fg = '#f0a7b4', italic = true }, -- Rose with italic for functions
--         Statement = { fg = '#a7e9df' }, -- Minty teal for statements
--         Conditional = { fg = '#a7c9e9', italic = true }, -- Blue for conditionals
--         Repeat = { fg = '#ddb0f0', italic = true }, -- Light purple for loops
--         Label = { fg = '#f0cfa7' }, -- Light orange for labels
--         Operator = { fg = '#e9dba7' }, -- Light gold for operators
--         Keyword = { fg = '#a7c9e9', bold = true }, -- Bold blue for keywords
--         Exception = { fg = '#f0a7a7', italic = true }, -- Red for exceptions

--         -- Preprocessor
--         PreProc = { fg = '#c9a7e9' }, -- Light purple for preprocessor
--         Include = { fg = '#a7e9c9', italic = true }, -- Green for includes
--         Define = { fg = '#e9a7c9' }, -- Pink for defines
--         Macro = { fg = '#e9a7c9', italic = true }, -- Pink italic for macros
--         PreCondit = { fg = '#a7e9c9', italic = true }, -- Green italic for conditionals

--         -- Types
--         Type = { fg = '#a7e9e9', bold = true }, -- Cyan for types
--         StorageClass = { fg = '#e9c9a7', italic = true }, -- Tan for storage classes
--         Structure = { fg = '#a7e9c9', bold = true }, -- Bold green for structures
--         Typedef = { fg = '#a7e9e9', italic = true }, -- Italic cyan for typedefs

--         -- Special
--         Special = { fg = '#f0c4a7' }, -- Peach for special
--         SpecialChar = { fg = '#f0b4a7', italic = true }, -- Coral for special chars
--         Tag = { fg = '#a7e9c9' }, -- Green for tags
--         Delimiter = { fg = '#c9c9d9' }, -- Light gray for delimiters
--         SpecialComment = { fg = '#b0b0c0', italic = true }, -- Gray italic for special comments
--         Debug = { fg = '#f0a7a7' }, -- Red for debug

--         -- Other
--         Underlined = { underline = true },
--         Ignore = { fg = 'muted' },
--         Error = { fg = 'love', underline = true },
--         Todo = { fg = 'base', bg = 'gold', bold = true },

--         -- Treesitter specific enhancements
--         ["@function"] = { fg = '#f0a7b4', italic = true },
--         ["@method"] = { fg = '#f5c4a7', italic = true },
--         ["@constructor"] = { fg = '#a7c9e9', bold = true },
--         ["@parameter"] = { fg = '#ddc4f0' },
--         ["@keyword.function"] = { fg = '#a7e9c9', italic = true },
--         ["@property"] = { fg = '#c4f0a7' },
--         ["@field"] = { fg = '#b4f0a7' },
--         ["@variable"] = { fg = '#a7d9f0' },
--         ["@namespace"] = { fg = '#f0d9a7', italic = true },
--         ["@constant"] = { fg = '#e9a7d9', bold = true },
--         ["@annotation"] = { fg = '#f0cfa7', italic = true },
--         ["@attribute"] = { fg = '#cfa7f0', italic = true },
--         ["@string.escape"] = { fg = '#f0b4a7', bold = true },
--         ["@string.special"] = { fg = '#f0cda7' },
--         ["@tag"] = { fg = '#a7e9d9' },
--         ["@tag.attribute"] = { fg = '#c4f0a7', italic = true },

--         -- Misc
--         Search = { bg = 'gold', fg = 'base' },
--         IncSearch = { bg = 'love', fg = 'base' },
--         CursorLineNr = { fg = 'iris', bold = true },
--         Visual = { bg = 'highlight_med' },
--       },
--     })

--     -- Load colorscheme with some additional options
--     vim.cmd('colorscheme rose-pine')

--     -- Additional configuration to enhance UI
--     vim.opt.termguicolors = true
--     vim.opt.cursorline = true

--     -- Custom commands to switch variants
--     vim.api.nvim_create_user_command('RosePineMain', function()
--       vim.g.rose_pine_variant = 'main'
--       vim.cmd('colorscheme rose-pine')
--     end, {})

--     vim.api.nvim_create_user_command('RosePineMoon', function()
--       vim.g.rose_pine_variant = 'moon'
--       vim.cmd('colorscheme rose-pine')
--     end, {})

--     vim.api.nvim_create_user_command('RosePineDawn', function()
--       vim.g.rose_pine_variant = 'dawn'
--       vim.cmd('colorscheme rose-pine')
--     end, {})

--     -- Keymaps for quick variant switching
--     vim.keymap.set('n', '<leader>cm', '<cmd>RosePineMain<CR>', { desc = "Rose Pine Main Theme" })
--     vim.keymap.set('n', '<leader>cn', '<cmd>RosePineMoon<CR>', { desc = "Rose Pine Moon Theme" })
--     vim.keymap.set('n', '<leader>cd', '<cmd>RosePineDawn<CR>', { desc = "Rose Pine Dawn Theme" })
--   end,
-- }

-- Catppuccin Colorscheme Configuration
-- A soothing pastel theme for Neovim

-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   priority = 1000, -- Load this before other plugins
--   config = function()
--     require("catppuccin").setup(
--       {
--         -- Main configuration
--         flavour = "mocha", -- latte, frappe, macchiato, mocha
--         background = {
--           -- :h background
--           light = "latte",
--           dark = "mocha"
--         },
--         transparent_background = false, -- Disables setting the background color
--         show_end_of_buffer = false, -- Shows the '~' characters after the end of buffers
--         term_colors = true, -- Sets terminal colors (e.g. `g:terminal_color_0`)
--         dim_inactive = {
--           enabled = false, -- dims the background color of inactive window
--           shade = "dark",
--           percentage = 0.15 -- percentage of the shade to apply to the inactive window
--         },
--         no_italic = false, -- Force no italic
--         no_bold = false, -- Force no bold
--         no_underline = false, -- Force no underline
--         styles = {
--           -- Handles the styles of general hi groups
--           comments = {"italic"},
--           conditionals = {"italic"},
--           loops = {},
--           functions = {},
--           keywords = {"italic"},
--           strings = {},
--           variables = {},
--           numbers = {},
--           booleans = {},
--           properties = {},
--           types = {},
--           operators = {}
--         },
--         color_overrides = {},
--         custom_highlights = {
--           -- Telescope customization
--           TelescopeNormal = {link = "NormalFloat"},
--           TelescopeBorder = {link = "FloatBorder"},
--           TelescopePromptPrefix = {fg = "#cba6f7"}, -- Changed from "@text.todo" to "#cba6f7"
--           TelescopePromptTitle = {fg = "#1e1e2e", bg = "#f5c2e7"},
--           TelescopePreviewTitle = {fg = "#1e1e2e", bg = "#89dceb"},
--           TelescopeResultsTitle = {fg = "#1e1e2e", bg = "#f9e2af"},
--           -- LSP
--           LspReferenceText = {bg = "#45475a"},
--           LspReferenceRead = {bg = "#45475a"},
--           LspReferenceWrite = {bg = "#45475a"},
--           -- Cursor line and column
--           CursorLine = {bg = "#313244"},
--           CursorLineNr = {fg = "#cba6f7", bold = true},
--           -- Indent lines
--           IndentBlanklineChar = {fg = "#45475a"},
--           -- NvimTree
--           NvimTreeNormal = {link = "Normal"},
--           NvimTreeWinSeparator = {fg = "#45475a"},
--           -- Diagnostics
--           DiagnosticUnderlineError = {undercurl = true, sp = "#f38ba8"},
--           DiagnosticUnderlineWarn = {undercurl = true, sp = "#f9e2af"},
--           DiagnosticUnderlineInfo = {undercurl = true, sp = "#89dceb"},
--           DiagnosticUnderlineHint = {undercurl = true, sp = "#cba6f7"}
--         },
--         -- Integrations (enable specific integrations)
--         integrations = {
--           cmp = true,
--           gitsigns = true,
--           nvimtree = true,
--           treesitter = true,
--           telescope = {
--             enabled = true
--           },
--           which_key = true,
--           indent_blankline = {
--             enabled = true,
--             colored_indent_levels = false
--           },
--           native_lsp = {
--             enabled = true,
--             virtual_text = {
--               errors = {"italic"},
--               hints = {"italic"},
--               warnings = {"italic"},
--               information = {"italic"}
--             },
--             underlines = {
--               errors = {"underline"},
--               hints = {"underline"},
--               warnings = {"underline"},
--               information = {"underline"}
--             }
--           },
--           -- For more plugins integrations please see https://github.com/catppuccin/nvim#integrations
--           aerial = false,
--           alpha = true,
--           barbar = false,
--           beacon = false,
--           bufferline = true,
--           dashboard = true,
--           fidget = true,
--           gitgutter = false,
--           hop = false,
--           illuminate = true,
--           leap = false,
--           lightspeed = false,
--           lsp_saga = true,
--           lsp_trouble = true,
--           markdown = true,
--           mason = true,
--           neogit = false,
--           neotest = false,
--           neotree = false,
--           noice = false,
--           notify = true,
--           semantic_tokens = true,
--           symbols_outline = false,
--           telekasten = false,
--           ts_rainbow = false,
--           ts_rainbow2 = false,
--           vimwiki = false,
--           headlines = false
--         }
--       }
--     )

--     -- Load the colorscheme
--     vim.cmd.colorscheme "catppuccin"

--     -- Additional configuration
--     vim.opt.termguicolors = true
--     vim.opt.cursorline = true

--     -- Create commands to switch between flavors
--     vim.api.nvim_create_user_command(
--       "CatppuccinLatte",
--       function()
--         vim.g.catppuccin_flavour = "latte"
--         vim.cmd.colorscheme "catppuccin"
--       end,
--       {}
--     )

--     vim.api.nvim_create_user_command(
--       "CatppuccinFrappe",
--       function()
--         vim.g.catppuccin_flavour = "frappe"
--         vim.cmd.colorscheme "catppuccin"
--       end,
--       {}
--     )

--     vim.api.nvim_create_user_command(
--       "CatppuccinMacchiato",
--       function()
--         vim.g.catppuccin_flavour = "macchiato"
--         vim.cmd.colorscheme "catppuccin"
--       end,
--       {}
--     )

--     vim.api.nvim_create_user_command(
--       "CatppuccinMocha",
--       function()
--         vim.g.catppuccin_flavour = "mocha"
--         vim.cmd.colorscheme "catppuccin"
--       end,
--       {}
--     )

--     -- Keymaps for quick flavor switching
--     vim.keymap.set("n", "<leader>c1", "<cmd>CatppuccinLatte<CR>", {desc = "Catppuccin Latte (Light)"})
--     vim.keymap.set("n", "<leader>c2", "<cmd>CatppuccinFrappe<CR>", {desc = "Catppuccin Frappe"})
--     vim.keymap.set("n", "<leader>c3", "<cmd>CatppuccinMacchiato<CR>", {desc = "Catppuccin Macchiato"})
--     vim.keymap.set("n", "<leader>c4", "<cmd>CatppuccinMocha<CR>", {desc = "Catppuccin Mocha (Dark)"})
--   end
-- }

return {
  "rebelot/kanagawa.nvim",
  priority = 1000, -- Load this before other plugins
  config = function()
    require("kanagawa").setup({
      -- Main configuration
      background = "dark",
      compile = false,  -- Enable compiling the colorscheme
      undercurl = true, -- Enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = {},
      typeStyle = {},
      transparent = false,   -- Do not set background color
      dimInactive = false,   -- Dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- Define vim.g.terminal_color_{0,17}
      -- Palette overrides for different variants
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
              bg = "#000000",    -- Darker background color
              bg_m1 = "#0d0e12", -- Even darker for some elements
              bg_m2 = "#090a0d", -- Darkest background variant
              bg_p1 = "#1a1b20", -- Slightly lighter for highlights
              bg_p2 = "#21232a", -- Even lighter for more prominent elements
            },
          },
        },
      },
      -- Theme variants: "wave", "dragon", "lotus"
      theme = "dragon", -- Default theme
      -- Override highlights
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Normal background override
          Normal = { bg = theme.ui.bg },
          NormalFloat = { bg = theme.ui.bg_m1 },
          FloatBorder = { bg = theme.ui.bg_m1 },

          -- Telescope customization
          TelescopeNormal = { link = "NormalFloat" },
          TelescopeBorder = { link = "FloatBorder" },
          TelescopePromptPrefix = { fg = theme.syn.keyword },
          TelescopePromptTitle = { fg = theme.ui.bg, bg = theme.syn.fun },
          TelescopePreviewTitle = { fg = theme.ui.bg, bg = theme.syn.type },
          TelescopeResultsTitle = { fg = theme.ui.bg, bg = theme.syn.constant },
          -- LSP
          LspReferenceText = { bg = theme.ui.bg_p2 },
          LspReferenceRead = { bg = theme.ui.bg_p2 },
          LspReferenceWrite = { bg = theme.ui.bg_p2 },
          -- Cursor line and column
          CursorLine = { bg = theme.ui.bg_p1 },
          CursorLineNr = { fg = theme.syn.fun, bold = true },
          -- Indent lines
          IndentBlanklineChar = { fg = theme.ui.nontext },
          -- NvimTree
          NvimTreeNormal = { link = "Normal" },
          NvimTreeWinSeparator = { fg = theme.ui.nontext },
          -- Diagnostics
          DiagnosticUnderlineError = { undercurl = true, sp = theme.diag.error },
          DiagnosticUnderlineWarn = { undercurl = true, sp = theme.diag.warning },
          DiagnosticUnderlineInfo = { undercurl = true, sp = theme.diag.info },
          DiagnosticUnderlineHint = { undercurl = true, sp = theme.diag.hint },
        }
      end,
    })
    -- Load the colorscheme
    vim.cmd.colorscheme("kanagawa-dragon")
    -- Additional configuration
    vim.opt.termguicolors = true
    vim.opt.cursorline = true
  end,
}

-- return {
--   "mellow-theme/mellow.nvim",
--   priority = 1000, -- Load this before other plugins
--   config = function()
--     -- Set the colorscheme directly without a setup function
--     vim.cmd.colorscheme "mellow"

--     -- Light cyan for functions
--     vim.api.nvim_set_hl(0, "Function", {fg = "#B2FFFF"})
--     -- Light cyan + bold for structures
--     vim.api.nvim_set_hl(0, "Structure", {fg = "#B2FFFF", bold = true})
--     vim.api.nvim_set_hl(0, "String", {fg = "#FFFACD"}) -- lemon chiffon
--   end
-- }

-- return {
--   "Mofiqul/dracula.nvim",
--   priority = 1000,
--   config = function()
--     -- Load the default Dracula colorscheme
--     vim.cmd.colorscheme "dracula"
--   end,
-- }

-- return {
--   "Mofiqul/vscode.nvim",
--   priority = 1000,
--   config = function()
--     require("vscode").setup(
--       {
--         -- Enable italic comments
--         italic_comments = true,
--         -- Remove background from nvim-tree (if you use it)
--         disable_nvimtree_bg = true,
--         -- Disable transparency (i.e., solid background)
--         transparent = false
--       }
--     )
--     vim.o.background = "dark" -- or "light" for vscode-light

--     -- Load the colorscheme
--     vim.cmd.colorscheme "vscode"
--   end
-- }
