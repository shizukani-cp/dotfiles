local function config()
    local output = vim.fs.joinpath(require("plugins.treesitter.install_path"), "parser", "norg.so")
    vim.system({ "tree-sitter", "build", "--output", output },
        { cwd = require("manager.core.path").plugin_path("tree-sitter-norg") }, function() end)
end

return function(manager)
    manager.add({
        id = "tree-sitter-norg",
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        config = config,
    })
end
