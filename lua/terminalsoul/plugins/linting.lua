return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local lint = require("lint")

    -- Linters for each filetype
    lint.linters_by_ft = {
      -- JavaScript / TypeScript
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },

      -- C / C++
      c = { "cppcheck" },
      cpp = { "cppcheck" },

      -- Python
      python = { "ruff" },
    }

    -- Automatically run linting
    local lint_augroup = vim.api.nvim_create_augroup(
      "TerminalSoulLint",
      { clear = true }
    )

    vim.api.nvim_create_autocmd({
      "BufEnter",
      "BufWritePost",
      "InsertLeave",
    }, {
      group = lint_augroup,

      callback = function()
        lint.try_lint()
      end,
    })

    -- Manual linting
    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, {
      desc = "Trigger linting for current file",
    })
  end,
}
