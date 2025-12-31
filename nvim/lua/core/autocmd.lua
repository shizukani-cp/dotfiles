vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("NeovimTerminal", { clear = true }),
    pattern = "*",
    callback = function()
        vim.opt_local.number = false
        vim.cmd("startinsert")
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
    pattern = "*",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "c:*",
    group = vim.api.nvim_create_augroup("CleanHistory", { clear = true }),
    callback = function()
        local cmd = vim.fn.histget(":", -1)
        if cmd == "x" or cmd == "xa" or cmd:match("^w?q?a?!?$") then
            vim.fn.histdel(":", -1)
        end
    end,
})
