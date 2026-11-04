{ pkgs, pkgs-unstable, ... }: {
  programs.nixvim = {
    enable = true;
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        transparent = true;
        styles = {
          sidebars = "transparent";
          floats = "transparent";
        };
      };
    };
    globals = {
      mapleader = "k";
    };
    keymaps = [
      {
        mode = "x";
        key = "<Leader>y";
        action = "\"+y";
        options = {
          noremap = true;
          silent = true;
          desc = "Yank to clipboard";
        };
      }
      {
        mode = "n";
        key = "<Leader>P";
        action = "\"+P";
        options = {
          noremap = true;
          silent = true;
          desc = "Paste from clipboard";
        };
      }
      {
        mode = "n";
        key = "<Leader>eo";
        action = "<Cmd>noh<Cr>";
        options = {
          desc = ":noh";
        };
      }
      {
        mode = "n";
        key = "<Leader>em";
        action = "<Cmd>messages<Cr>";
        options = {
          desc = "Messages";
        };
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "gg";
        action = "gg^";
        options = {
          noremap = true;
          silent = true;
          desc = "Go to the top of the file";
        };
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "G";
        action = "G$";
        options = {
          noremap = true;
          silent = true;
          desc = "Go to the end of the file";
        };
      }
      {
        mode = "n";
        key = "L";
        action = "<Cmd>bnext<Cr>";
        options = {
          noremap = true;
          silent = true;
          desc = "Next buffer";
        };
      }
      {
        mode = "n";
        key = "H";
        action = "<Cmd>bprevious<Cr>";
        options = {
          noremap = true;
          silent = true;
          desc = "Previous buffer";
        };
      }
      {
        mode = "i";
        key = "<F27>";
        action = "<Esc><Cmd>w<Cr>";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<F27>";
        action = "<Esc><Cmd>xa!<Cr>";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "t";
        key = "<F27>";
        action = "<C-\\><C-n>";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "i";
        key = "<C-F3>";
        action = "<Esc><Cmd>w<Cr>";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-F3>";
        action = "<Esc><Cmd>xa!<Cr>";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "t";
        key = "<C-F3>";
        action = "<C-\\><C-n>";
        options = {
          noremap = true;
          silent = true;
        };
      }
    ];
    opts = {
      encoding = "utf-8";
      expandtab = true;
      fileencoding = "utf-8";
      fileencodings = "utf-8,cp932,euc-jp,sjis";
      foldcolumn = "1";
      foldenable = true;
      foldlevel = 99;
      foldlevelstart = 99;
      helplang = "ja,en";
      iskeyword = "@,48-57,192-255";
      laststatus = 3;
      mouse = "";
      number = true;
      relativenumber = true;
      scrolloff = 4;
      shiftwidth = 4;
      tabstop = 4;
      termguicolors = true;
      updatetime = 1000;
      whichwrap = "b,s,h,l,<,>";
    };
  };
}
