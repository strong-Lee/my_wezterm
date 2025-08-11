-- ~/.config/wezterm/config/init.lua
-- 配置构造器
-- 这是一个自定义的 Lua "类"，用来安全地合并多个配置模块。
-- 它的主要功能是防止不同的配置文件定义了相同的配置项（键冲突），并在发生冲突时发出警告。
-- 对于大型配置，这是一个很好的实践

local wezterm = require('wezterm')

---@class Config
---@field options table
local Config = {}
Config.__index = Config

-- 初始化函数，创建一个包含 options 表的 Config 对象
---@return Config
function Config:init()
   local config = setmetatable({ options = {} }, self)
   return config
end

-- 合并函数，将新的配置表 (new_options) 合并到 self.options 中
---@param new_options table new options to append
---@return Config
function Config:append(new_options)
   for k, v in pairs(new_options) do
      -- 检查是否已存在相同的配置键
      if self.options[k] ~= nil then
         wezterm.log_warn(
            'Duplicate config option detected: ',
            { old = self.options[k], new = new_options[k] }
         )
         goto continue
      end
      -- 如果不存在，则添加新的配置项
      self.options[k] = v
      ::continue::
   end
   return self
end

return Config
