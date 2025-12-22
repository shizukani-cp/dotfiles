local lazyload = require("manager.lazyload")

return function(manager)
    manager.add({
        id = "cellular-automaton.nvim",
        url = "https://github.com/Eandrju/cellular-automaton.nvim",
    })
    lazyload.key('n', '<Leader>ec', "<Cmd>CellularAutomaton game_of_life<Cr>", "cellular-automaton.nvim",
        { noremap = true, silent = true, desc = "Game of life" })
end
