return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",

    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },

    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          -- C / C++
          "clang-format",

          -- Python
          "ruff",
          "black",

          -- Lua
          "stylua",
        },

        auto_update = false,
        run_on_start = true,
      })
    end,
  },
}

