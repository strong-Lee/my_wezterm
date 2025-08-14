-- ~/.config/wezterm/wezterm.lua

local wezterm = require('wezterm')
local Config = require('config')

require('utils.backdrops')
   -- :set_focus('#000000')
   -- :set_images_dir(require('wezterm').home_dir .. '/Pictures/Wallpapers/')
   :set_images()
   :random()

require('events.left-status').setup()
require('events.right-status').setup({ date_format = '%a %b %d, %H:%M:%S' }) -- 建议用更详细的日期格式
require('events.tab-title').setup({ hide_active_tab_unseen = false, unseen_icon = '󰧞' }) -- '' (circle) -> '󰧞' (bell.badge) a more semantic icon
require('events.new-tab-button').setup()

-- 主配置加载流程
local config = Config:init()
   :append(require('config.appearance'))
   :append(require('config.general'))
   :append(require('config.fonts'))
   :append(require('config.bindings'))
   :append(require('config.domains'))
   :append(require('config.launch'))
   :append({
      color_scheme = 'custom',
      colors = require('colors.custom'),
   }).options

-- 2. 然后，用已经构建好的配置去设置事件监听器
-- 这样，事件相关的模块就能安全地访问到 config 里的所有信息了
wezterm.on('update-right-status', function(window, pane)
   require('events.right-status').setup(window, pane)
end)

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
   return require('events.tab-title').setup(tab)
end)

-- 保持其他事件的设置方式，如果它们不依赖config，可以照旧
-- 如果依赖，也应改为 wezterm.on 的形式
require('utils.backdrops'):set_images():random()

require('events.left-status').setup()
require('events.new-tab-button').setup()

-- 3. 最后返回配置对象
return config
