require("terminalsoul.core.keymaps")
require("terminalsoul.core.options")
require("terminalsoul.core.transpernt")
require("terminalsoul.core.lazy")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 300,
		})
	end,
})
