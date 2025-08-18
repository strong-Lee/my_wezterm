-- ~/.config/wezterm/config/general.lua

return {
   -- behaviours
   automatically_reload_config = true,
   check_for_updates = false, -- 关闭自动更新检测配置
   -- if the shell program exited with a successful status
   exit_behavior = 'CloseOnCleanExit',
   exit_behavior_messaging = 'Verbose',
   status_update_interval = 1000,

   scrollback_lines = 20000,

   -- 启用智能拆分，新建窗格继承当前目录
   default_cwd = 'CurrentPaneDomain',

   -- 超链接规则
   hyperlink_rules = {
      -- 匹配URL
      {
         regex = '\\b\\w+://[\\w.-]+(?:/\\S*)?',
         format = '$0',
      },
      -- 匹配邮箱
      {
         regex = [[\b\w\S*@\w\S*\.\w\S*\b]],
         format = 'mailto:$0',
      },
      -- 匹配文件路径，如 `file.lua:10:2`
      {
         regex = [[\b(/[^:\s]+):(\d+):(\d+)\b]],
         format = 'file:$1#L$2C$3',
      },
      -- 匹配IP地址
      {
         regex = [[\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b]],
         format = '$0',
      },
   },

   -- 为快速选择器添加要匹配的规则
   quick_select_patterns = {
      '\\b\\w+://[\\w.-]+(?:/\\S*)?',
      [[\b\w\S*@\w\S*\.\w\S*\b]],
      [[\b(/[^:\s]+):(\d+):(\d+)\b]],
      [[\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b]],
   },
}
