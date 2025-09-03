-- ~/.config/wezterm/colors/custom.lua
-- Everforest Dark Soft Palette

local theme = {
   -- Base Palette (from official Everforest palette)
   bg = '#323d43', -- Background (bg_soft)
   fg = '#d3c6aa', -- Foreground
   red = '#e67e80',
   green = '#a7c080',
   yellow = '#dbbc7f',
   blue = '#7fbbb3',
   purple = '#d699b6',
   aqua = '#83c092',
   grey = '#a9b1d6', -- Using a standard grey from your old theme for general purpose
   dark_grey = '#4f585e', -- bg2
   light_grey = '#859289', -- fg_dim

   -- UI Elements
   cursor_bg = '#a7c080', -- Green for good visibility
   cursor_fg = '#323d43',
   cursor_border = '#a7c080',
   selection_bg = '#4f585e', -- bg2, a darker grey for selection
   selection_fg = '#d3c6aa',
   split = '#4f585e',
   scrollbar_thumb = '#4f585e',

   -- ANSI Colors
   ansi = {
      '#414b50', -- Black (bg1)
      '#e67e80', -- Red
      '#a7c080', -- Green
      '#dbbc7f', -- Yellow
      '#7fbbb3', -- Blue
      '#d699b6', -- Purple
      '#83c092', -- Aqua
      '#d3c6aa', -- White (fg)
   },
   -- Bright ANSI Colors
   brights = {
      '#4f585e', -- Bright Black (bg2)
      '#e67e80', -- Bright Red
      '#a7c080', -- Bright Green
      '#dbbc7f', -- Bright Yellow
      '#7fbbb3', -- Bright Blue
      '#d699b6', -- Bright Purple
      '#83c092', -- Bright Aqua
      '#d3c6aa', -- Bright White (fg)
   },
}

-- 这是最终返回给 Wezterm 的配置表
return {
   -- 1. 基本颜色配置
   foreground = theme.fg,
   background = theme.bg,
   cursor_bg = theme.cursor_bg,
   cursor_fg = theme.cursor_fg,
   cursor_border = theme.cursor_border,
   selection_bg = theme.selection_bg,
   selection_fg = theme.selection_fg,
   ansi = theme.ansi,
   brights = theme.brights,
   split = theme.split,
   scrollbar_thumb = theme.scrollbar_thumb,

   -- 2. Tab栏颜色，适配 Everforest 风格
   tab_bar = {
      -- 使用背景色加上一点透明度，与背景融为一体
      background = 'rgba(50, 61, 67, 0.5)', -- rgba version of theme.bg

      -- 激活的标签页
      active_tab = {
         -- 使用一个柔和的背景高亮
         bg_color = 'rgba(127, 187, 179, 0.2)', -- rgba version of theme.blue
         -- 使用醒目的绿色作为文字颜色，这是 Everforest 的标志性颜色之一
         fg_color = theme.green,
         intensity = 'Bold',
      },

      -- 未激活的标签页
      inactive_tab = {
         bg_color = 'none',
         fg_color = theme.light_grey, -- 使用暗一点的前景色
      },
      inactive_tab_hover = {
         bg_color = 'none',
         fg_color = theme.fg,
         italic = true,
      },

      -- 新建标签页按钮
      new_tab = {
         bg_color = 'none',
         fg_color = theme.light_grey,
      },
      new_tab_hover = {
         bg_color = 'rgba(79, 88, 94, 0.7)', -- rgba version of theme.dark_grey
         fg_color = theme.fg,
         italic = true,
      },
   },
}
