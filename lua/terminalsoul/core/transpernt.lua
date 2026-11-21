local M = {}

M.setup = function()
  -- Create an autocmd group so highlight rules don't duplicate when re-sourcing config
  local transparent_group = vim.api.nvim_create_augroup("TransparentBg", { clear = true })

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = transparent_group,
    pattern = "*",
    callback = function()
      -- 1. Main editor background transparency groups
      local base_groups = {
        "Normal",
        "NormalNC",    -- Inactive windows background
        "LineNr",      -- Line numbers column
        "SignColumn",  -- Column where git signs/diagnostics appear
        "StatusLine",  -- Main statusline background
        "StatusLineNC",-- Inactive statuslines
        "EndOfBuffer", -- The '~' characters at the bottom of empty space
      }

      for _, group in ipairs(base_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
      end

      -- 2. Floating windows and Telescope popup transparency groups
      local float_groups = {
        "NormalFloat",
        "FloatBorder",
        "FloatTitle",
        "TelescopeNormal",
        "TelescopeBorder",
        "TelescopePromptNormal",
        "TelescopePromptBorder",
      }

      for _, group in ipairs(float_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
      end
    end,
  })
end

-- Execute the setup immediately upon loading this file
M.setup()

return M
