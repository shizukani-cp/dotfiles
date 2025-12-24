local parsers = {
    "bash",
    "diff",
    "html",
    "javascript",
    "json",
    "jsx",
    "lua",
    "markdown",
    "markdown",
    "markdown_inline",
    "python",
    "regex",
    "rust",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
}

local function config()
    require("nvim-treesitter").setup({
        install_dir = require("plugins.treesitter.install_path"),
    })
    require("nvim-treesitter").install(parsers, {
        force = false,
        generate = true,
        max_jobs = 4,
        summary = false,
    })
    vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = parsers,
        callback = function()
            vim.treesitter.start()
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
    })
end

return function(manager)
    manager.add({
        id = "nvim-treesitter",
        url = "https://github.com/nvim-treesitter/nvim-treesitter",
        config = config,
    })
    manager.load("nvim-treesitter")
end
