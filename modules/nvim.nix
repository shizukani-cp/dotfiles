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
      formatonsave = true;
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
    plugins = {
      # Auto input pair
      nvim-autopairs = {
        enable = true;
        lazyLoad.settings.event = "InsertEnter";
      };
      # Bufferline
      bufferline = {
        enable = true;
        lazyLoad.settings.event = "BufWinEnter";
      };
      # Formatter to LSP
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            nix = [ "nixfmt" ];
            rust = [ "rustfmt" ];
          };
        };
      };
      # Neovim develop
      lazydev = {
        enable = true;
      };
      lsp = {
        enable = true;
        servers = {
          cssls = {
            enable = true;
            settings = {
              css = {
                lint = {
                  unknownAtRules = "ignore";
                };
              };
            };
          };
          denols = {
            enable = true;
            settings = {
              lint = true;
              unstable = true;
              suggest = {
                imports = {
                  hosts = {
                    "https://crux.land" = true;
                    "https://deno.land" = true;
                    "https://x.nest.land" = true;
                  };
                };
              };
            };
            # root_dir = function(fname)
            #     local util = require("lspconfig.util")
            #     return util.root_pattern(".git", "deno.json", "deno.jsonc")(fname)
            # end,
          };
          html = {
            enable = true;
          };
          jsonls = {
            enable = true;
          };
          lua_ls = {
            enable = true;
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT";
                };
                diagnostics = {
                  globals = [ "vim" ];
                };
                workspace = {
                  # library = vim.list_extend(vim.api.nvim_get_runtime_file("lua", true), {
                  #     "${3rd}/luv/library",
                  #     "${3rd}/busted/library",
                  #     "${3rd}/luassert/library",
                  # }),
                  checkThirdParty = "Disable";
                };
              };
            };
          };
          nil_ls = {
            enable = true;
          };
          pylsp = {
            enable = true;
            cmd = [ "pylsp" ];
            settings = {
              pylsp = {
                plugins = {
                  pyflakes = {
                    enabled = true;
                  };
                  pylint = {
                    enabled = true;
                  };
                };
              };
            };
          };
          rust_analyzer = {
            enable = true;
          };
          tailwindcss = {
            enable = true;
          };
          ts_ls = {
            enable = true;
            # cmd = function(dispatchers, _)
            #     return vim.lsp.rpc.start({ "typescript-language-server", "--stdio" }, dispatchers)
            # end,
            # root_dir = function(fname)
            #     local util = require("lspconfig.util")
            #     return util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
            # end,
          };
        };
      };
      # Lazy loading
      lz-n.enable = true;
    };
  };
}
