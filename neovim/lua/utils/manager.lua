-- lua/utils/manager.lua

local fn = vim.fn
local cmd = vim.cmd
local notify = vim.notify

local M = {}

local install_base_path = fn.stdpath('data') .. '/site/pack/manager/opt'

M.plugins = {}
local loaded_plugins = {}

--- 実際のロード処理を行う内部関数や
local function do_load(id)
  if loaded_plugins[id] then
    return
  end

  local plugin = M.plugins[id]
  -- ★ notify("ロード中…") を削除

  cmd('packadd ' .. plugin.spec.id)

  if type(plugin.spec.config) == 'function' then
    plugin.spec.config()
  end

  loaded_plugins[id] = true
  -- ★ notify("ロード完了") を削除
end

--- プラグインを登録して、必要ならインストールする関数や
function M.add(spec)
  if not spec.id or not spec.url then
    error("プラグインには 'id' と 'url' が必須やで！ spec: " .. vim.inspect(spec))
  end

  if M.plugins[spec.id] then
    return
  end

  local install_path = install_base_path .. '/' .. spec.id
  local is_installed = fn.isdirectory(install_path) == 1

  M.plugins[spec.id] = {
    spec = spec,
    status = is_installed and 'installed' or 'new',
    on_installed_callbacks = {},
  }

  if not is_installed then
    local plugin = M.plugins[spec.id]
    plugin.status = 'installing'

    -- ★ notify("インストール中…") を削除
    fn.jobstart('git clone --depth 1 ' .. spec.url .. ' ' .. install_path, {
      on_exit = function(_, code)
        vim.schedule(function()
          if code == 0 then
            plugin.status = 'installed'
            -- ★ notify("インストール完了") を削除
            cmd('packloadall!')

            for _, callback in ipairs(plugin.on_installed_callbacks) do
              callback()
            end
            plugin.on_installed_callbacks = {}
          else
            plugin.status = 'failed'
            -- ★ エラーの通知は、問題解決のために残しとくで！
            notify("'" .. spec.id .. "' のインストール、失敗したみたいや…😢", vim.log.levels.ERROR)
          end
        end)
      end,
    })
  end
end

--- IDを指定してプラグインをロードする関数や
function M.load(id)
  if loaded_plugins[id] then
    return
  end

  local plugin = M.plugins[id]
  if not plugin then
    error("プラグイン '" .. id .. "' は見つからへんで。add()したか確認しとき！")
  end

  if plugin.spec.dependencies then
    for _, dep_id in ipairs(plugin.spec.dependencies) do
      M.load(dep_id)
    end
  end

  if plugin.status == 'installed' then
    do_load(id)
  elseif plugin.status == 'installing' then
    -- ★ notify("待機中…") を削除
    table.insert(plugin.on_installed_callbacks, function()
      do_load(id)
    end)
  else
    -- ★ こっちのエラーも、いざという時のために残しとく
    notify("'"..id.."' をロードできへんかった。ステータスがおかしいで: " .. plugin.status, vim.log.levels.ERROR)
  end
end

return M
