-- ~/.config/wezterm/wezterm.lua

local wezterm = require('wezterm')
local Config = require('config')

-- 1. 构建基础配置对象
-- 这是一个清晰的链式调用，将所有模块化配置组合在一起
local config = Config:init()
   :append(require('config.appearance'))
   :append(require('config.general'))
   :append(require('config.fonts'))
   :append(require('config.bindings'))
   :append(require('config.domains'))
   :append(require('config.launch'))
   :append({
      -- 直接在这里整合颜色配置
      color_scheme = 'custom',
      colors = require('colors.custom'),
   }).options

-- 动态全屏功能实现
-- 这个函数将窗口大小设置为屏幕的可用区域
local function set_window_size(window)
   local screen = window:current_screen()
   if not screen then
      wezterm.log_error('Could not get current screen for window')
      return
   end

   -- screen.usable_area 是关键，它会自动排除 macOS 的 Dock 和菜单栏
   local geometry = screen.usable_area
   wezterm.log_info(
      'Setting window geometry to: x='
         .. geometry.x
         .. ', y='
         .. geometry.y
         .. ', width='
         .. geometry.width
         .. ', height='
         .. geometry.height
   )

   -- 设置窗口位置和大小
   window:set_position(geometry.x, geometry.y)
   window:set_inner_size(geometry.width, geometry.height)
end

-- 2. 设置事件监听器
-- 使用 `wezterm.on` 来处理动态事件，这是Wezterm推荐的最佳实践
-- 当Wezterm GUI启动或配置重载时，应用动态全屏
wezterm.on('window-spawned', function(window, _)
   -- pane 和 window 参数由 Wezterm 自动传入
   wezterm.time.call_after(0.05, function()
      set_window_size(window)
   end)
end)

-- 使用 _pane 明确表示 pane 参数在此处未使用
wezterm.on('window-config-reloaded', function(window, _)
   wezterm.time.call_after(0.05, function()
      set_window_size(window)
   end)
end)

wezterm.on('gui-startup', function(cmd)
   local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
   window:gui_window():toggle_fullscreen()
end)

-- 背景图片设置 (保持您的随机背景功能)
-- require('utils.backdrops'):set_images():random()

-- 左侧状态栏 (无需改动)
require('events.left-status').setup()

-- 右侧状态栏
-- 这会注册'update-right-status'事件，逻辑在模块内部处理
require('events.right-status').setup()

-- 标签页标题
wezterm.on('format-tab-title', function(tab, _, _, _, _, _)
   return require('events.tab-title').setup(tab)
end)

-- 新建标签页按钮 (无需改动)
require('events.new-tab-button').setup()

-- 3. 返回最终的配置对象
return config
