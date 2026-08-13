local function config()
    require("conform").setup({
        formatters_by_ft = {
            lua = { "stylua" },
            nix = { "nixfmt" },
        },
    })

    vim.g.formatonsave = true
    vim.keymap.set({ "n" }, "<Leader>ef", function()
        if vim.g.formatonsave then
            vim.g.formatonsave = false
        else
            vim.g.formatonsave = true
        end
    end, { noremap = true, silent = true, desc = "Toggle fonmat on save" })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
        pattern = "*",
        callback = function(args)
            if vim.g.formatonsave then
                require("conform").format({ bufnr = args.buf })
            end
        end,
    })
end

return function(manager)
    manager:add({
        id = "conform.nvim",
        url = "https://github.com/stevearc/conform.nvim",
        config = config,
    })
end
