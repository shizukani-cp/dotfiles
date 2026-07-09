local managerpath = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "pack", "manager", "start", "manager.nvim")
if not (vim.uv or vim.loop).fs_stat(managerpath) then
    local managerrepo = "https://github.com/shizukani-cp/manager.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=main", managerrepo, managerpath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone manager.nvim:\n", "ErrorMsg" },
        }, true, {})
    end
end
local manager_dev = false
if not manager_dev then
    vim.opt.runtimepath:prepend(managerpath)
else
    vim.opt.runtimepath:prepend(require("utils.local_plugin_path")("manager.nvim"))
end

local manager = require("manager.core").new()

_G.manager = manager

local _ = manager.logger:on(function(e)
    if e.level >= 3 then
        vim.notify(e.msg, e.level)
    end
end)

local flags = {
    vime = (vim.env.VIME ~= nil),
    ddu = (vim.env.DDU ~= nil),
}

local function plugin(mod, opt)
    if not opt then
        return require("plugins." .. mod)(manager)
    end

    for fn, fv in pairs(flags) do
        if opt[fn] ~= nil then
            if opt[fn] == true then
                return require("plugins." .. mod)(manager)
            end

            if opt[fn] == false then
                if fv == true then
                    return require("plugins." .. mod)(manager)
                else
                    return
                end
            end
        end
    end
end

plugin("manager.manager-lock", { vime = true })
plugin("manager.manager-lazyload", { vime = true })

manager:lock()
plugin("Comment") -- Comment
plugin("bufferline") -- bufferline
plugin("capture") -- コマンドの結果をバッファに出す
plugin("dashboard") -- dashboard
plugin("ddc.ddc") -- ddc.vim
plugin("ddc.ddc-source-lsp-setup") -- ddc.vimのLSP連携
plugin("ddu.ddu", { ddu = false }) -- ddu.vim
plugin("ddu.ddu-plugins", { ddu = false }) -- ddu.vimの取り巻き
plugin("ddu.ddu-source-manager", { ddu = false }) -- ddu.vimのmanager.nvim連携
plugin("denippet") -- snippet
plugin("deps.denops", { vime = true }) -- from ddc.vim,ddu.vim,denippet,skkeleton
plugin("deps.nui") -- from noice.nvim
plugin("deps.nvim-web-devicons") -- from many plugins
plugin("deps.plenary")
plugin("dial") -- Ctrl+a,Ctrl+x
plugin("dropbar") -- パンくずリスト
plugin("fidget") -- LSPがロードしてるのをカッコ良く表示してくれる
plugin("friendly-snippets") -- スニペット集
plugin("gitsigns", { vime = true }) -- gitの差分表示
plugin("hlargs") -- 引数強調
plugin("hlchunk") -- インデント系util
plugin("indent-blankline") -- ブロックの頭の行を出してくれる
plugin("jumpcursor") -- カーソルをいろんなところにジャンプできる
plugin("lazygit") -- lazygit
plugin("lsp.conform") -- formatter to LSP
plugin("lsp.lazydev") -- Neovim develop
plugin("lsp.nvim-lspconfig") -- LSP Configs
plugin("lsp.renamer") -- rename var
plugin("manager.manager-command") -- manager.nvim commands
plugin("manager.manager-remove") -- manager.nvim remove,clean()
plugin("manager.manager-update") -- manager.nvim update()
plugin("markview", { vime = true }) -- markdown view
plugin("neoscroll", { vime = true }) -- スクロールを滑らかにしてくれる
plugin("noice") -- UIをいい感じにしてくれる
plugin("nvim-autopairs", { vime = true }) -- ペアを自動で入力してくれる
plugin("nvim-surround") -- 囲み文字系のtextobject
plugin("nvim-various-textobjs") -- Add textobjects
plugin("nvimdoc-ja") -- Neovim document Japanese
plugin("oklch-color-picker") -- color highlight
plugin("satellite") -- Decorate scrollbar
plugin("skkeleton", { vime = true }) -- IME
plugin("smear-cursor", { vime = true }) -- カーソルを滑らかにしてくれる
plugin("sort") -- `:Sort`コマンド
plugin("status.status", { vime = true }) -- status bar
plugin("status.status-git", { vime = true }) -- status bar git
plugin("status.status-lsp", { vime = true }) -- status bar lsp
plugin("status.status-std", { vime = true }) -- status bar std
plugin("tabset") -- 言語ごとにインデントの深さを設定してくれる
plugin("tiny-inline-diagnostic") -- インラインで警告表示
plugin("tobira") -- 怒らないで Vim を教えてくれる
plugin("todo-comments") -- TODO: とかを強調してくれる
plugin("toggleterm") -- トグルできるターミナル
plugin("tokyonight", { vime = true }) -- colorscheme
plugin("treesitter.nvim-treesitter", { vime = true }) -- treesitter
plugin("treesitter.nvim-treesitter-textobjects") -- textobjects from treesitter
plugin("treesitter.nvim-ts-autotag", { vime = true }) -- XML系のタグを自動で閉じてくれるやつ
plugin("trouble") -- diagnostics
plugin("undotree", { vime = true }) -- undo tree
plugin("vim-better-whitespace") -- highlight end of line spaces
plugin("vim-illuminate") -- 同じ変数をハイライトしてくれる
plugin("vimdoc-ja") -- Vim document Japanese
plugin("vist.vist") -- vist.nvim
plugin("vist.vist-file") -- file like oil.nvim
plugin("visual-whitespace") -- 空白文字をvisualで選択したときに記号を出してくれる
plugin("which-key", { vime = true }) -- key helps

vim.wait(30000, function()
    for _, p in pairs(_G.manager.plugins) do
        if p.status == "installing" then
            return false
        end
    end
    return true
end, 100)
manager:unlock()
plugin("lsp.config")
