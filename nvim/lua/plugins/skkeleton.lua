local lazyload = require("manager.lazyload")

local function config()
    vim.fn["skkeleton#config"]({
        globalDictionaries = {
            '~/.local/share/skk/SKK-JISYO.L',
        },
        eggLikeNewline = true,
        markerHenkan = "¦",
        markerHenkanSelect = "|",
    })
    vim.keymap.set({ "i", "c" }, "<Esc>", "<Plug>(skkeleton-toggle)",
        { noremap = true, silent = true, desc = "Skkeleton enable/disable" })
end

return function(manager)
    manager.add({
        id = "skkeleton",
        url = "https://github.com/vim-skk/skkeleton",
        dependencies = {
            "denops.vim"
        },
        config = config
    })
    lazyload.event("InsertEnter", "skkeleton")
    vim.api.nvim_create_autocmd("BufRead", {
        pattern = "/tmp/input.md",
        callback = function()
            vim.cmd("normal! ggdG")
            vim.api.nvim_create_autocmd("VimLeavePre", {
                buffer = 0,
                callback = function()
                    vim.cmd("silent %y+")
                    os.execute("sleep 0.1 && wl-copy < /tmp/input.md && wtype -M ctrl v -m ctrl")
                end
            })
        end
    })
    vim.keymap.set({ "i", "c" }, "<Esc>", "<Nop>")
end
