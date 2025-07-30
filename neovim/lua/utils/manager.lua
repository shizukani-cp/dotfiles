local fn = vim.fn
local cmd = vim.cmd
local notify = vim.notify

local M = {}

local install_base_path = fn.stdpath('data') .. '/site/pack/manager/opt'

M.plugins = {}
local loaded_plugins = {}

local function do_load(id)
  if loaded_plugins[id] then return end
  local plugin = M.plugins[id]
  cmd('packadd ' .. plugin.spec.id)
  if type(plugin.spec.config) == 'function' then
    plugin.spec.config()
  end
  loaded_plugins[id] = true
end

function M.add(spec)
  if not spec.id or not spec.url then
    error("プラグインには 'id' と 'url' が必須やで！ spec: " .. vim.inspect(spec))
  end
  if M.plugins[spec.id] then return end
  local install_path = fn.stdpath('data') .. '/site/pack/manager/opt/' .. spec.id
  local is_installed = fn.isdirectory(install_path) == 1
  M.plugins[spec.id] = {
    spec = spec,
    status = is_installed and 'installed' or 'new',
    on_installed_callbacks = {},
  }
  if not is_installed then
    local plugin = M.plugins[spec.id]
    plugin.status = 'installing'
    fn.jobstart('git clone --depth 1 ' .. spec.url .. ' ' .. install_path, {
      on_exit = function(_, code)
        vim.schedule(function()
          if code == 0 then
            plugin.status = 'installed'
            cmd('packloadall!')
            for _, callback in ipairs(plugin.on_installed_callbacks) do
              callback()
            end
            plugin.on_installed_callbacks = {}
          else
            plugin.status = 'failed'
            notify("'" .. spec.id .. "' のインストール、失敗したみたいや…😢", vim.log.levels.ERROR)
          end
        end)
      end,
    })
  end
end

function M.load(id)
  if loaded_plugins[id] then return end
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
    table.insert(plugin.on_installed_callbacks, function() do_load(id) end)
  else
    notify("'"..id.."' をロードできへんかった。ステータスがおかしいで: " .. plugin.status, vim.log.levels.ERROR)
  end
end

local function process_update_queue(queue)
  if #queue == 0 then
    notify('プラグインの更新、全部終わったで！👍', vim.log.levels.INFO)
    return
  end
  local id = table.remove(queue, 1)
  local plugin = M.plugins[id]
  local install_path = install_base_path .. '/' .. id
  if plugin.status ~= 'installed' then
    notify("'" .. id .. "' はまだインストールされてへんからスキップや。", vim.log.levels.WARN)
    process_update_queue(queue)
    return
  end
  notify("'" .. id .. "' を更新中…")
  fn.jobstart({ 'git', '-C', install_path, 'pull' }, {
    on_exit = function(_, code)
      vim.schedule(function()
        if code == 0 then
          notify("'" .. id .. "' の更新完了！")
        else
          notify("'" .. id .. "' の更新に失敗したみたいや…", vim.log.levels.ERROR)
        end
        process_update_queue(queue)
      end)
    end,
  })
end

-- @param target_id (string | nil) 更新したいプラグインのID。nilなら全部。
function M.update(target_id)
  local queue = {}

  if target_id then
    if M.plugins[target_id] then
      table.insert(queue, target_id)
      notify("プラグイン '" .. target_id .. "' の更新を始めるで！", vim.log.levels.INFO)
    else
      notify("プラグイン '" .. target_id .. "' は登録されてへんで。", vim.log.levels.ERROR)
      return
    end
  else
    for id, _ in pairs(M.plugins) do
      table.insert(queue, id)
    end

    if #queue == 0 then
      notify('アップデートするプラグインが一つも登録されてへんで。', vim.log.levels.WARN)
      return
    end
    notify('プラグインの更新を始めるで！', vim.log.levels.INFO)
  end

  process_update_queue(queue)
end

return M
