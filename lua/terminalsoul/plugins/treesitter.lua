
return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    init = function()
      local parsers = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "json",
        "gitignore",
        "go",
      }

      local group = vim.api.nvim_create_augroup(
        "TerminalSoulTreesitter",
        { clear = true }
      )

      -- Enable Treesitter for supported filetypes
      vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
        group = group,
        callback = function()
          if vim.bo.buftype ~= "" then
            return
          end

          pcall(vim.treesitter.start, 0)
        end,
      })

      -- Install parsers after startup
      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "VeryLazy",
        once = true,
        callback = function()
          require("nvim-treesitter").install(parsers)
        end,
      })
    end,
  },

  -- Treesitter Textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },

    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,

          selection_modes = {
            ["@function.outer"] = "V",
            ["@class.outer"] = "V",
          },
        },
      })

      local select = require("nvim-treesitter-textobjects.select")

      -- Functions
      vim.keymap.set({ "x", "o" }, "af", function()
        select.select_textobject("@function.outer", "textobjects")
      end, { desc = "Select around function" })

      vim.keymap.set({ "x", "o" }, "if", function()
        select.select_textobject("@function.inner", "textobjects")
      end, { desc = "Select inside function" })

      -- Classes
      vim.keymap.set({ "x", "o" }, "ac", function()
        select.select_textobject("@class.outer", "textobjects")
      end, { desc = "Select around class" })

      vim.keymap.set({ "x", "o" }, "ic", function()
        select.select_textobject("@class.inner", "textobjects")
      end, { desc = "Select inside class" })

      -- Parameters
      vim.keymap.set({ "x", "o" }, "aa", function()
        select.select_textobject("@parameter.outer", "textobjects")
      end, { desc = "Select around parameter" })

      vim.keymap.set({ "x", "o" }, "ia", function()
        select.select_textobject("@parameter.inner", "textobjects")
      end, { desc = "Select inside parameter" })

      -- Conditionals
      vim.keymap.set({ "x", "o" }, "ai", function()
        select.select_textobject("@conditional.outer", "textobjects")
      end, { desc = "Select around conditional" })

      vim.keymap.set({ "x", "o" }, "ii", function()
        select.select_textobject("@conditional.inner", "textobjects")
      end, { desc = "Select inside conditional" })
    end,
  },
}
