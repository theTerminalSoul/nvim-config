return {
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      "j-hui/fidget.nvim",
    },

    config = function()
      local capabilities =
        require("cmp_nvim_lsp").default_capabilities()

      --------------------------------------------------
      -- FIDGET
      --------------------------------------------------
      require("fidget").setup({})

      --------------------------------------------------
      -- LSP ATTACH KEYMAPS
      --------------------------------------------------
      local group = vim.api.nvim_create_augroup(
        "TerminalSoulLsp",
        { clear = true }
      )

      vim.api.nvim_create_autocmd("LspAttach", {
        group = group,

        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }

          -- Navigation
          vim.keymap.set("n", "gd", vim.lsp.buf.definition,
            vim.tbl_extend("force", opts, {
              desc = "Go to definition",
            })
          )

          vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
            vim.tbl_extend("force", opts, {
              desc = "Go to declaration",
            })
          )

          vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
            vim.tbl_extend("force", opts, {
              desc = "Go to implementation",
            })
          )

          vim.keymap.set("n", "gr", vim.lsp.buf.references,
            vim.tbl_extend("force", opts, {
              desc = "Show references",
            })
          )

          vim.keymap.set("n", "gt", vim.lsp.buf.type_definition,
            vim.tbl_extend("force", opts, {
              desc = "Go to type definition",
            })
          )

          -- Documentation
          vim.keymap.set("n", "K", vim.lsp.buf.hover,
            vim.tbl_extend("force", opts, {
              desc = "Hover documentation",
            })
          )

          -- Code actions
          vim.keymap.set({ "n", "v" }, "<leader>ca",
            vim.lsp.buf.code_action,
            vim.tbl_extend("force", opts, {
              desc = "Code actions",
            })
          )

          -- Rename
          vim.keymap.set("n", "<leader>rn",
            vim.lsp.buf.rename,
            vim.tbl_extend("force", opts, {
              desc = "Rename symbol",
            })
          )

          -- Diagnostics
          vim.keymap.set("n", "<leader>d",
            vim.diagnostic.open_float,
            vim.tbl_extend("force", opts, {
              desc = "Line diagnostics",
            })
          )

          vim.keymap.set("n", "[d",
            vim.diagnostic.goto_prev,
            vim.tbl_extend("force", opts, {
              desc = "Previous diagnostic",
            })
          )

          vim.keymap.set("n", "]d",
            vim.diagnostic.goto_next,
            vim.tbl_extend("force", opts, {
              desc = "Next diagnostic",
            })
          )

          vim.keymap.set("n", "<leader>D",
            vim.diagnostic.setloclist,
            vim.tbl_extend("force", opts, {
              desc = "Diagnostic location list",
            })
          )
        end,
      })

      --------------------------------------------------
      -- DIAGNOSTICS
      --------------------------------------------------
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,

        float = {
          border = "rounded",
          source = "if_many",
        },
      })

      --------------------------------------------------
      -- DEFAULT LSP CAPABILITIES
      --------------------------------------------------
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      --------------------------------------------------
      -- C / C++ : CLANGD
      --------------------------------------------------
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
        },

        filetypes = {
          "c",
          "cpp",
          "objc",
          "objcpp",
        },

        root_markers = {
          "compile_commands.json",
          "compile_flags.txt",
          ".clangd",
          ".git",
        },
      })

      --------------------------------------------------
      -- PYTHON : PYRIGHT
      --------------------------------------------------
      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
              typeCheckingMode = "basic",
            },
          },
        },
      })

      --------------------------------------------------
      -- LUA : LUA_LS
      --------------------------------------------------
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },

            diagnostics = {
              globals = {
                "vim",
              },
            },

            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },

            telemetry = {
              enable = false,
            },
          },
        },
      })

      --------------------------------------------------
      -- MASON LSP CONFIG
      --------------------------------------------------
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "pyright",
          "lua_ls",
        },

        automatic_enable = true,
      })
    end,
  },
}
