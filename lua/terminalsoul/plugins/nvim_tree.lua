return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- Initialize nvim-tree with basic styling
		require("nvim-tree").setup({
			view = {
				width = 30,
				side = "left",
			},
			renderer = {
				group_empty = true,
				highlight_git = true,
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
				},
			},
			filters = {
				dotfiles = false, -- Set to true if you want to hide hidden files by default
			},
		})

		-- Set up your custom keymap for <leader>ee to toggle the tree
		vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", {
			desc = "Toggle NvimTree",
			silent = true,
			noremap = true,
		})
	end,
}
