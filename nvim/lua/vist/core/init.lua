---@class Vist.Item
---@field id any
---@field display? string
---@field data? any

---@class Vist.Action<T>
---@field kind `T`
---@field data? any

---@class Vist.Adapter
---@field list fun(): Vist.Item[]
---@field parse? fun(lines: string[]): Vist.Action<any>[]
---@field do_action? fun(action: Vist.Action<any>)
