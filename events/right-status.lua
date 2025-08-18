-- ~/.config/wezterm/events/right-status.lua

local wezterm = require('wezterm')
local nf = wezterm.nerdfonts
local M = {}

local colors = {
   cpu_fg = '#a3be8c',
   mem_fg = '#d08770',
   net_fg = '#88c0d0',
   battery_fg = '#ebcb8b',
   date_fg = '#d8dee9',
   separator_fg = '#4c566a',
}

-- CPU & 内存
local function cpu_mem_info()
   local cpu = io.popen("top -l 1 | grep 'CPU usage' | awk '{print $3}'"):read('*a')
   local mem = io.popen("vm_stat | grep 'Pages free' | awk '{print $3}'"):read('*a')
   cpu = cpu:gsub('\n', '')
   mem = mem:gsub('\n', '')
   return string.format('%s %s%%  %s %s', nf.md_cpu_64_bit, cpu or '?', nf.md_memory, mem or '?')
end

-- 网络（WiFi 名称 + IP）
local function net_info()
   local wifi =
      io.popen("networksetup -getairportnetwork en0 2>/dev/null | awk -F': ' '{print $2}'")
         :read('*a')
   local ip = io.popen('ipconfig getifaddr en0 2>/dev/null'):read('*a')
   wifi = wifi:gsub('\n', '')
   ip = ip:gsub('\n', '')
   if wifi ~= '' and ip ~= '' then
      return string.format('%s %s (%s)', nf.md_wifi, wifi, ip)
   end
   return ''
end

-- 电池
local function battery_info()
   for _, b in ipairs(wezterm.battery_info()) do
      local icon = nf.md_battery
      local charge = math.floor(b.state_of_charge * 100)
      if b.state == 'Charging' then
         icon = nf.md_battery_charging
      elseif charge < 20 then
         icon = nf.md_battery_20
      elseif charge < 50 then
         icon = nf.md_battery_50
      elseif charge < 80 then
         icon = nf.md_battery_80
      end
      return string.format('%s %d%%', icon, charge)
   end
   return ''
end

M.setup = function()
   wezterm.on('update-right-status', function(window, _)
      --local cpu_mem = cpu_mem_info()
      local net = net_info()
      local battery = battery_info()
      local date = wezterm.strftime('%Y-%m-%d %H:%M:%S')

      local right = wezterm.format({
         --{ Foreground = { Color = colors.cpu_fg } },
         --{ Text = cpu_mem },
         --{ Foreground = { Color = colors.separator_fg } },
         --{ Text = ' │ ' },
         { Foreground = { Color = colors.net_fg } },
         { Text = net },
         { Foreground = { Color = colors.separator_fg } },
         { Text = ' │ ' },
         { Foreground = { Color = colors.battery_fg } },
         { Text = battery },
         { Foreground = { Color = colors.separator_fg } },
         { Text = ' │ ' },
         { Foreground = { Color = colors.date_fg } },
         { Text = ' ' .. date .. ' ' }, -- 两边加空格
      })

      window:set_right_status(right)
   end)
end

return M
