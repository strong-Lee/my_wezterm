-- ~/.config/wezterm/config/bindings.lua

local wezterm = require('wezterm')
local act = wezterm.action

return {
   -- 启用 Leader Key，这是高效操作的基石 (类似 tmux 或 vim)
   -- Ctrl+A 是一个常见的选择，因为默认它只用于行首跳转
   leader = { key = 'a', mods = 'CTRL', timemout_miliseconds = 1000 },
   keys = {
      -- 使用macOS习惯的快捷键
      -- Cmd+C 复制, Cmd+V 粘贴
      { key = 'c', mods = 'CMD', action = act.CopyTo('ClipboardAndPrimarySelection') },
      { key = 'v', mods = 'CMD', action = act.PasteFrom('Clipboard') },

      -- Cmd+F 搜索
      { key = 'f', mods = 'CMD', action = act.Search('CurrentSelectionOrEmptyString') },

      -- Cmd+T 新建标签页 Cmd+W 关闭标签页/窗格 Cmd+N 新建窗口 Cmd + 数字切换标签页
      { key = 't', mods = 'CMD', action = act.SpawnTab('CurrentPaneDomain') },
      { key = 'w', mods = 'CMD', action = act.CloseCurrentPane({ confirm = false }) },
      { key = 'n', mods = 'CMD', action = act.SpawnWindow },
      { key = '1', mods = 'CMD', action = act.ActivateTab(0) },
      { key = '2', mods = 'CMD', action = act.ActivateTab(1) },
      { key = '3', mods = 'CMD', action = act.ActivateTab(2) },
      { key = '4', mods = 'CMD', action = act.ActivateTab(3) },
      { key = '5', mods = 'CMD', action = act.ActivateTab(4) },
      { key = '6', mods = 'CMD', action = act.ActivateTab(5) },
      { key = '7', mods = 'CMD', action = act.ActivateTab(6) },
      { key = '8', mods = 'CMD', action = act.ActivateTab(7) },
      -- Cmd+9 切换到最后一个标签页
      { key = '9', mods = 'CMD', action = act.ActivateTab(-1) },

      -- 左右切换Tab
      { key = '[', mods = 'CMD', action = act.ActivateTabRelative(-1) },
      { key = ']', mods = 'CMD', action = act.ActivateTabRelative(1) },

      -- *** Leader Key 绑定 ***
      -- Leader -> c: 新建标签页
      { key = 'c', mods = 'LEADER', action = act.SpawnTab('CurrentPaneDomain') },
      -- Leader -> x: 关闭当前窗格
      { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane({ confirm = false }) },
      -- Leader -> %: 水平分割 (Shift+5)
      {
         key = '%',
         mods = 'LEADER',
         action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
      },
      -- Leader -> ": 垂直分割 (Shift+')
      { key = '"', mods = 'LEADER', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
      -- Leader -> h,j,k,l: 在窗格间移动
      { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection('Left') },
      { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection('Down') },
      { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection('Up') },
      { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection('Right') },
      -- Leader -> H,J,K,L: 调整窗格大小
      { key = 'H', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize({ 'Left', 5 }) },
      { key = 'J', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize({ 'Down', 5 }) },
      { key = 'K', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize({ 'Up', 5 }) },
      { key = 'L', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize({ 'Right', 5 }) },
   },
}
