return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd[[colorscheme tokyonight]]
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        lazy = false,
	dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
	config = function()
	    require("neo-tree").setup({
		window = {
		    position = "float",
		    width = 40,
		    height = 30,
	        },
            })
        end,
    },
    {
        "airblade/vim-gitgutter",
        lazy = true,
        config = function()
	    require('vim-gitgutter').setup()
        end,
    },
    {
        "j-morano/buffer_manager.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require('buffer_manager').setup()
        end,
    },
}

