return {
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Load early so it takes over diagnostics quickly
		priority = 1000, -- Ensure it loads ahead of other UI elements
		config = function()
			-- 1. Turn OFF Neovim's default messy virtual text
			vim.diagnostic.config({ virtual_text = false })

			-- 2. Configure the beautiful inline diagnostic blocks
			require("tiny-inline-diagnostic").setup({
				preset = "modern", -- Other options: "classic", "minimal"
				hi = {
					background = "DiagnosticVirtualTextBackground", -- Automatically grabs your theme colors
				},
				options = {
					-- Show the diagnostic only on the line where your cursor is resting
					show_on_cursor = true,

					-- Put a subtle border around the warning box
					show_source = true, -- Shows where the error came from (e.g., lua_ls)

					-- Better handling for long error messages
					softwrap = 60,
				},
			})
		end,
	},
}
