local lazyload = require("manager.lazyload")

return function(manager)
    manager.add({
        id = "vim-tmux-navigator",
        url = "https://github.com/christoomey/vim-tmux-navigator",
        config = config,
    })
    lazyload.key("n", "<C-h>", "<Cmd><C-U>TmuxNavigateLeft<Cr>",
        "vim-tmux-navigator", { noremap = true, silent = true })
    lazyload.key("n", "<C-j>", "<Cmd><C-U>TmuxNavigateDown<Cr>",
        "vim-tmux-navigator", { noremap = true, silent = true })
    lazyload.key("n", "<C-k>", "<Cmd><C-U>TmuxNavigateUp<Cr>",
        "vim-tmux-navigator", { noremap = true, silent = true })
    lazyload.key("n", "<C-l>", "<Cmd><C-U>TmuxNavigateRight<Cr>",
        "vim-tmux-navigator", { noremap = true, silent = true })
    lazyload.key("n", "<C-\\>", "<Cmd><C-U>TmuxNavigatePrevious<Cr>",
        "vim-tmux-navigator", { noremap = true, silent = true })
end
