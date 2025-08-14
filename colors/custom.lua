-- ~/.config/wezterm/colors/custom.lua

local theme = {
   fg = '#c0caf5',
   bg = '#1a1b26',
   -- 我们想要的那个高亮青色，将作为激活标签的文字颜色
   bright_cyan = '#7dcfff',

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

   -- =============================================================
   -- [[ THE FINAL AND CORRECT TAB BAR CONFIGURATION ]]
   -- =============================================================
   tab_bar = {
      background = 'none', -- 背景与主窗口融合

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
         fg_color = '#565f89',
      },
      inactive_tab_hover = {
         bg_color = 'none',
         fg_color = '#c0caf5',
      },
      new_tab = {
         bg_color = 'none',
         fg_color = '#565f89',
      },
      new_tab_hover = {
         bg_color = 'rgba(42, 44, 55, 0.7)',
         fg_color = '#c0caf5',
         italic = true,
      },
   },
}
