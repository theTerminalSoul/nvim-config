return {
  "rebelot/kanagawa.nvim",
  lazy = false,    -- Load this during startup so you don't see a flash of the default theme
  priority = 1000, -- Ensure it loads before other plugins
  config = function()
    require("kanagawa").setup({
      compile = true,             -- High performance mode
      undercurl = true,           -- For better-looking diagnostics/errors
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true,         -- <-- CHANGED TO TRUE: Makes main editor transparent
      dimInactive = false,        -- Dims the background of non-active windows
      terminalColors = true,      -- Use the Kanagawa palette in :terminal
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none", -- Makes the line number column look cleaner
            }
          }
        }
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- CHANGED: Clear out background colors to make floats fully transparent
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none", fg = theme.ui.nontext },
          FloatTitle  = { bg = "none", fg = theme.ui.fg_dim, bold = true },

          -- Also clear Telescope float backgrounds if you use it
          TelescopeNormal = { bg = "none" },
          TelescopeBorder = { bg = "none", fg = theme.ui.nontext },

          -- Save a bit of "pop" for the statusline
          StatusLine = { fg = theme.ui.fg_dim, bg = "none", blend = 0 },
        }
      end,
      theme = "dragon", -- Options: "wave", "dragon", "lotus"
    })

    -- Finally, load the colorscheme
    vim.cmd("colorscheme kanagawa")
  end,
}
