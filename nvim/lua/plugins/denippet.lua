local function config(manager)
    local dir = vim.fn.stdpath("config") .. "/snippets/"

    for _, file in ipairs(vim.fn.glob(dir .. "*.*", true, true)) do
        vim.fn["denippet#load"](file)
    end

    local root = vim.fs.joinpath(manager:plugin_path("friendly-snippets"), "snippets")

    for name, type in vim.fs.dir(root) do
        if type == "file" then
            vim.fn["denippet#load"](vim.fs.joinpath(root, name))
        elseif type == "directory" then
            local dirname = name
            for name2, type2 in vim.fs.dir(vim.fs.joinpath(root, dirname)) do
                if type2 == "file" then
                    vim.fn["denippet#load"](vim.fs.joinpath(root, dirname, name2))
                end
            end
        end
    end

    vim.keymap.set("i", "<C-l>", "<Plug>(denippet-expand)")

    vim.keymap.set({ "i", "s" }, "<Tab>", function()
        return vim.fn["denippet#jumpable"]() and "<Plug>(denippet-jump-next)" or "<Tab>"
    end, { expr = true })

    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        return vim.fn["denippet#jumpable"](-1) and "<Plug>(denippet-jump-prev)" or "<S-Tab>"
    end, { expr = true })
end

return function(manager)
    manager:add({
        id = "denippet.vim",
        url = "https://github.com/uga-rosa/denippet.vim",
        dependencies = {
            "denops.vim",
            "friendly-snippets",
        },
        config = config,
    })
    manager:lazyload_event("InsertEnter", "denippet.vim")
end
