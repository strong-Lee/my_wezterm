-- ~/.config/wezterm/config/fonts.lua

local wezterm = require('wezterm')
local platform = require('utils.platform')

-- local font = 'Maple Mono SC NF'
local font_family = 'JetBrainsMono Nerd Font'
local font_size = platform.is_mac and 15 or 9

return {
   font = wezterm.font({
      family = font_family,
      weight = 600, -- 公司电脑为SemiBold 家里Medium
   }),
   font_size = font_size,
   line_height = 1, -- 增加行高可以提升长篇文章的可读性

   -- 使用 font_rules 来精确控制粗体和斜体样式
   -- 这告诉 WezTerm, 当需要渲染特定样式的文本时，应该使用哪个字体定义。
   font_rules = {
      -- 当终端需要渲染 "斜体" (italic) 文字时，使用下面定义的字体
      {
         italic = true,
         font = wezterm.font({
            family = font_family,
            style = 'Italic', -- 明确指定使用 Italic 样式
         }),
      },
      -- 当终端需要渲染 "粗体" (bold) 文字时，使用下面定义的字体
      {
         intensity = 'Bold',
         font = wezterm.font({
            family = font_family,
            weight = 'Bold', -- 明确指定使用 Bold 字重
         }),
      },
      -- 当终端需要渲染 "粗斜体" (bold and italic) 文字时
      {
         intensity = 'Bold',
         italic = true,
         font = wezterm.font({
            family = font_family,
            weight = 'Bold',
            style = 'Italic',
         }),
      },
   },

   -- 针对macOS Retina屏幕的字体渲染优化
   freetype_load_target = 'HorizontalLcd',
   freetype_render_target = 'HorizontalLcd',

   -- 保持 harfbuzz_features，这对于连字和图标显示非常重要
   harfbuzz_features = {
      'calt',
      'liga',
      'dlig', -- 'dlig' for discretionary ligatures
      'ss01',
      'ss02',
      'ss03',
      'ss04',
      'ss05',
      'ss06',
      'ss07',
      'ss08',
      'zero', -- 启用带斜线的 '0'
   },
}
