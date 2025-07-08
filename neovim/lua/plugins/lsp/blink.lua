return {
    "saghen/blink.cmp",
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "uga-rosa/cmp-skkeleton",
        "onsails/lspkind-nvim",
    },
    config = function ()
        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = {
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-e>'] = cmp.mapping.close(),
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
                { name = "skkeleton" },
            },
            formatting = {
                fields = { "menu", "abbr", "kind" },
                format = function(entry, vim_item)
                    local menu_icon = {
                        nvim_lsp = "lsp",
                        luasnip = "snip",
                        buffer = "buf",
                        path = "path",
                        skkeleton = "skk",
                    }
                    vim_item.menu = menu_icon[entry.source.name] or "?"
                    return vim_item
                end,
            },
            experimental = {
                ghost_text = {
                    hl_group = "LspCodeLens",
                },
            },
        })
    end,
}
