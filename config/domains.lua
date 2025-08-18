-- ~/.config/wezterm/config/domains.lua

return {
   ssh_domains = {
      -- 您原有的配置
      {
         name = 'wsl.ssh',
         remote_address = 'localhost',
         multiplexing = 'None',
         default_prog = { 'fish', '-l' },
         assume_shell = 'Posix',
      },
      -- 为生产服务器添加的SSH域
      {
         -- 当你运行 `wezterm ssh prod-server` 时会激活此配置
         name = 'prod-server',

         -- Wezterm 实际连接的地址。可以是 'user@hostname' 或 'user@ip.address'
         remote_address = 'your_user@your_server_ip_or_hostname',

         -- 例如，给生产服务器一个警告性的红色Tab
         -- colors = {
         --    tab_bar = {
         --       active_tab = {
         --          bg_color = '#ff5555', -- 醒目的红色
         --          fg_color = '#1a1b26', -- 深色文字
         --          intensity = 'Bold',
         --       },
         --    },
         -- },
         -- 你甚至可以改变字体大小或任何其他wezterm配置
         -- font_size = 18,
      },
   },

   -- 您原有的其他 domains (保持不变)
   unix_domains = {},
   wsl_domains = {
      {
         name = 'WSL:Ubuntu',
         distribution = 'Ubuntu',
         username = 'kevin',
         default_cwd = '/home/kevin',
         default_prog = { 'fish', '-l' },
      },
   },
}
