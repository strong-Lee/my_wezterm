-- ~/.config/wezterm/events/left-status.lua

local wezterm = require('wezterm')
local nf = wezterm.nerdfonts
local M = {}

-- 颜色方案
local colors = {
   fg = '#d8dee9', -- 主文字颜色
   icon_fg = '#88c0d0', -- 图标颜色
   process_fg = '#a3be8c', -- 进程颜色
   ssh_fg = '#ebcb8b', -- SSH 信息颜色
}

-- 缩短路径函数 (适用于本地和远程路径)
local function shorten_path(path)
   -- 优先替换 home 目录
   local home = os.getenv('HOME')
   if home and path:find(home, 1, true) == 1 then
      path = path:gsub(home, '~')
   end
   -- 如果远程路径是 ~ 开头，也进行缩略处理
   if path:find('~/', 1, true) == 1 then
      -- 路径已经是 ~ 开头，我们处理后面的部分
   end

   local parts = {}
   for part in string.gmatch(path, '[^/]+') do
      table.insert(parts, part)
   end

   if #parts > 4 then
      -- 保留'~' (如果存在) 或第一部分，然后是 '...'，最后是倒数两个部分
      local first = path:find('~') == 1 and '~' or parts[1]
      return table.concat({ first, '...', parts[#parts - 1], parts[#parts] }, '/')
   end
   return path
end

-- 检测是否为 SSH 会话
local function get_ssh_info(pane)
   local title = pane:get_title() or ''
   local proc = pane:get_foreground_process_name() or ''
   -- 检查标题或进程名是否表明这是一个SSH会话
   if proc:match('ssh$') or title:match('@[%w._-]+') then
      -- 尝试从标题中提取 user@host 信息，如果失败则返回 'SSH'
      return title:match('([%w._-]+@[%w._-]+)') or 'SSH'
   end
   return nil
end

M.setup = function()
   wezterm.on('update-right-status', function(window, pane)
      -- 首先，判断是否为 SSH 会话
      local ssh_info = get_ssh_info(pane)

      -- 获取当前前台进程名
      local process_name = pane:get_foreground_process_name() or ''
      process_name = process_name:match('([^/]+)$') or ''

      -- `context_elements` 将根据会话类型填充
      local context_elements = {}

      if ssh_info then
         -- 状态一：SSH 会话
         local title = pane:get_title() or ''
         local remote_path_match = title:match(':(.*)$')
         local remote_path_text = ''
         if remote_path_match and remote_path_match ~= '' then
            local shortened_remote_path = shorten_path(remote_path_match)
            remote_path_text = ' ' .. nf.fa_folder_open .. ' ' .. shortened_remote_path
         end

         context_elements = {
            { Foreground = { Color = colors.ssh_fg } },
            { Text = nf.md_ssh .. ' ' .. ssh_info },
            { Foreground = { Color = colors.fg } },
            { Text = remote_path_text },
         }
      else
         -- 状态二：本地会话
         local cwd = ''
         local cwd_uri = pane:get_current_working_dir()
         if cwd_uri and cwd_uri.file_path then
            cwd = shorten_path(cwd_uri.file_path)
         end

         context_elements = {
            { Foreground = { Color = colors.icon_fg } },
            { Text = nf.fa_folder_open .. ' ' },
            { Foreground = { Color = colors.fg } },
            { Text = cwd },
         }
      end

      -- 无论哪种状态，都在末尾附加当前进程信息
      local process_elements = {
         { Foreground = { Color = colors.icon_fg } },
         { Text = nf.md_console_line .. ' ' },
         { Foreground = { Color = colors.process_fg } },
         { Text = process_name },
      }

      -- 组合所有元素
      local final_elements = context_elements

      -- *** 新增部分：在这里插入分隔符 ***
      -- 这会在上下文信息（路径/SSH）和进程信息之间添加两个空格
      table.insert(final_elements, { Text = '  ' })

      -- 将 process_elements 的所有内容追加到 final_elements 的末尾
      table.move(process_elements, 1, #process_elements, #final_elements + 1, final_elements)

      -- 格式化并设置状态栏
      local left = wezterm.format(final_elements)
      window:set_left_status(left)
   end)
end

return M
