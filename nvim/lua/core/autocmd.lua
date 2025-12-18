local term_grp = vim.api.nvim_create_augroup("NeovimTerminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
    group = term_grp,
    pattern = "*",
    callback = function()
        vim.opt_local.number = false
        vim.cmd("startinsert")
    end,
})

local format_on_save_grp = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = format_on_save_grp,
    pattern = "*",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

local clean_history_grp = vim.api.nvim_create_augroup("CleanHistory", { clear = true })
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "c:*",
    group = clean_history_grp,
    callback = function()
        local cmd = vim.fn.histget(":", -1)
        if cmd == "x" or cmd == "xa" or cmd:match("^w?q?a?!?$") then
            vim.fn.histdel(":", -1)
        end
    end,
})
