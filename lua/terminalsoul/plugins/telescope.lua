return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },

    config = function()
      local status_ok_t, telescope = pcall(require, "telescope")
      local builtin = require("telescope.builtin")
      local status_ok_a, actions = pcall(require, "telescope.actions")

      if not (status_ok_t and status_ok_a) then
        return
      end

      telescope.setup({
        defaults = {
          path_display = { "smart" },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["jk"] = actions.close, -- consistent with your escape map
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
      })


      -- Set keymaps
      local keymap = vim.keymap
      local opts = { noremap = true, silent = true }

      keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files", unpack(opts) })
      keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files", unpack(opts) })
      keymap.set("n", "<leader>fs", function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end, { desc = "Find string in current file", unpack(opts) })
      keymap.set(
        "n",
        "<leader>fc",
        "<cmd>Telescope grep_string<cr>",
        { desc = "Find string under cursor", unpack(opts) }
      )
      keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Find files in git repo" })
      keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    end,
}
