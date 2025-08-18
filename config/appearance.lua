-- ~/.config/wezterm/config/appearance.lua

-- #1a1b26 是 Tokyo Night 的深蓝背景，相比纯黑更有层次感
local background_color = 'rgba(26, 27, 38, 0.75)'

return {
   -- 配合无边框，启用macOS原生毛玻璃背景
   macos_window_background_blur = 100, -- 数值越高越模糊
   -- 我们将使用 Catppuccin 的 mantle 色作为基础，并增加 alpha 通道
   background = {
      {
         source = { Color = background_color },
         height = '100%',
         width = '100%',
      },
   },
   window_decorations = 'RESIZE', -- 仅保留窗口大小调整功能
   -- 在窗口顶部增加内边距，为自定义的 "标题栏" 留出空间
   -- 同时也让整体布局更有呼吸感
   window_padding = {
      left = 15,
      right = 15,
      top = 25,
      bottom = 10,
   },
   -- 在左上角添加macOS风格的红绿灯按钮
   --window_buttons = {
   --   -- 你可以调整X, Y坐标来微调按钮位置
   --   position = 'TopLeft',
   --   style = 'macOS',
   --},

   -- 优化非激活窗格的视觉区分，使其变暗但不过于饱和
   -- 1.0 的 brightness 意味着没有变化，这不实用
   inactive_pane_hsb = {
      saturation = 0.8,
      brightness = 0.6,
   },
   -- 其他实用配置
   adjust_window_size_when_changing_font_size = false,
   window_close_confirmation = 'NeverPrompt',
   enable_tab_bar = true, -- 确保标签栏是开启的
}
