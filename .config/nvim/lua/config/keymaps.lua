vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
	desc = "Roslyn Quick Actions",
})

vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {
	desc = "Rename",
})

vim.keymap.set("n", "<leader>cR", function()
	Snacks.picker.lsp_references()
end, {
	desc = "References",
})

vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "Goto Definition" })
vim.keymap.set("n", "<leader>ci", vim.diagnostic.open_float)
