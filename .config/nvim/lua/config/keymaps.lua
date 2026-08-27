vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
	desc = "Roslyn Quick Actions",
})

vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "Goto Definition" })
vim.keymap.set("n", "<leader>ci", vim.diagnostic.open_float, { desc = "Diagnostic" })
