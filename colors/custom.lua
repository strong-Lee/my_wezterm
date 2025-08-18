-- ~/.config/wezterm/colors/custom.lua

local theme = {
   fg = '#c0caf5',
   bg = '#1a1b26',
   bright_cyan = '#7dcfff', -- 高亮青色
   bright_blue = '#7aa2f7', -- 高亮蓝色，用于leader指示器
   dark_grey = '#414868', -- 暗灰色
   light_grey = '#565f89', -- 亮灰色
   red = '#f7768e', -- 红色

   cursor_bg = '#7dcfff',
   cursor_fg = '#1a1b26',
   cursor_border = '#7dcfff',
   selection_bg = '#2e3c6c',
   selection_fg = '#c0caf5',
   ansi = { '#15161e', '#f7768e', '#9ece6a', '#e0af68', '#7aa2f7', '#bb9af7', '#7dcfff', '#a9b1d6' },
   brights = {
      '#414868',
      '#f7768e',
      '#9ece6a',
      '#e0af68',
      '#7aa2f7',
      '#bb9af7',
      '#7dcfff',
      '#c0caf5',
   },
   split = '#414868',
   scrollbar_thumb = '#414868',
}

-- 这是最终返回给 Wezterm 的配置表
return {
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

   -- 2. Tab栏颜色，更适合无边框设计 (Wezterm UI 元素)
   tab_bar = {
      background = 'rgba(26, 27, 38, 0.5)',

      -- 核心改变在这里：
      -- 我们不再尝试画任何不存在的边框或下划线。
      -- 我们直接把激活标签的文字颜色变成最醒目的高亮青色。
      -- 这才是正确且符合设计理念的做法。
      active_tab = {
         bg_color = 'rgba(122, 162, 247, 0.2)', -- 保留淡淡的背景光晕
         fg_color = theme.bright_cyan, -- **使用高亮青色作为文字颜色**
         intensity = 'Bold', -- 并且加粗
      },

      inactive_tab = {
         bg_color = 'none',
         fg_color = theme.light_grey,
      },
      inactive_tab_hover = {
         bg_color = 'none',
         fg_color = theme.fg,
         italic = true,
      },
      new_tab = {
         bg_color = 'none',
         fg_color = theme.light_grey,
      },
      new_tab_hover = {
         bg_color = 'rgba(42, 44, 55, 0.7)',
         fg_color = theme.fg,
         italic = true,
      },
   },

   -- 3. 搜索高亮颜色 (CORRECTED: 这是一个独立的顶级配置项)
   -- search_match_colors = {
   --    background = 'rgba(255, 165, 0, 0.5)',
   --    foreground = theme.bg,
   -- },
}
