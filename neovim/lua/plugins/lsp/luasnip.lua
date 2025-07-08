return {
	"L3MON4D3/LuaSnip",
	version = "v2.3.0",
	build = "make install_jsregexp",
    event = "InsertEnter",
    config = function ()
        require("luasnip").setup({})
        require("luasnip.loaders.from_vscode").load({})
    end,
}
