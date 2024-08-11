local awful = require 'awful'
local beautiful = require 'beautiful'
local wibox = require 'wibox'
local TaskList = require 'widget.task-list'
local TagList = require 'widget.tag-list'
local gears = require 'gears'
local clickable_container = require 'widget.material.clickable-container'
local mat_icon_button = require 'widget.material.icon-button'
local mat_icon = require 'widget.material.icon'
local dpi = require('beautiful').xresources.apply_dpi
local icons = require 'theme.icons'
local battery_widget = require 'battery-widget'
local cpu_meter = require 'widget.cpu.cpu-meter'

local total_prev = 0
local idle_prev = 0
local max_temp = 85

local BAT0 = battery_widget {
  ac = 'ACAD',
  adapter = 'BAT1',
  ac_prefix = '🔌',
  battery_prefix = '',
  percent_colors = {
    { 25, 'red' },
    { 50, 'orange' },
    { 999, 'green' },
  },
  listen = true,
  timeout = 10,
  widget_text = '${AC_BAT}${color_on}${percent}%${color_off}',
  widget_font = 'Deja Vu Sans Mono 12',
  tooltip_text = 'Battery ${state}${time_est}\nCapacity: ${capacity_percent}%',
  alert_threshold = 5,
  alert_timeout = 0,
  alert_title = 'Low battery !',
  alert_text = '${AC_BAT}${time_est}',
}
-- Titus - Horizontal Tray
local systray = wibox.widget.systray()
systray:set_horizontal(true)
systray:set_base_size(20)
systray.forced_height = 20

-- Clock / Calendar 24h format
-- local textclock = wibox.widget.textclock('<span font="Roboto Mono bold 9">%d.%m.%Y\n     %H:%M</span>')
-- Clock / Calendar 12AM/PM fornat
local textclock = wibox.widget.textclock '<span font="Roboto Mono 12">%I:%M %p</span>'
-- textclock.forced_height = 36

-- Add a calendar (credits to kylekewley for the original code)
local month_calendar = awful.widget.calendar_popup.month {
  screen = s,
  start_sunday = false,
  week_numbers = true,
}

month_calendar:attach(textclock)

local clock_widget = wibox.container.margin(textclock, dpi(13), dpi(13), dpi(9), dpi(8))

local add_button = mat_icon_button(mat_icon(icons.plus, dpi(24)))

add_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
  awful.spawn(awful.screen.focused().selected_tag.defaultApp, {
    tag = _G.mouse.screen.selected_tag,
    placement = awful.placement.bottom_right,
  })
end)))

-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
local LayoutBox = function(s)
  local layoutBox = clickable_container(awful.widget.layoutbox(s))
  layoutBox:buttons(awful.util.table.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))
  return layoutBox
end

local TopPanel = function(s)
  local panel = wibox {
    ontop = true,
    screen = s,
    height = dpi(31),
    width = s.geometry.width,
    x = s.geometry.x,
    y = s.geometry.y,
    stretch = false,
    bg = beautiful.background.hue_800,
    -- bg = '#00000066',
    -- fg='#FF0000',
    fg = beautiful.fg_normal,
    struts = {
      top = dpi(32),
    },
  }
  --   panel.border_width  = dpi(10)
  -- panel.border_color = "#ffffff00"
  panel:struts {
    top = dpi(32),
  }

  panel:setup {
    layout = wibox.layout.align.horizontal,
    expand = 'none',
    {
      layout = wibox.layout.fixed.horizontal,
      -- Create a taglist widget
      TagList(s),
      TaskList(s),
      -- add_button,
    },
    -- nil,
    wibox.container.place(clock_widget, 'center', 'center'),
    -- TagList(s),
    {
      layout = wibox.layout.fixed.horizontal,
      -- Layout box
      --
      --watch('bash -c "free | grep -z Mem.*Swap.*"', 1, function(_, stdout)
      --   local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
      --     stdout:match '(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)'
      --   slider:set_value(used / total * 100)
      --   collectgarbage 'collect'
      -- end)
      awful.widget.watch([[bash -c "cat /proc/stat | grep '^cpu '"]], 10, function(widget, stdout)
        local user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice =
          stdout:match '(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s'

        local total = user + nice + system + idle + iowait + irq + softirq + steal

        local diff_idle = idle - idle_prev
        local diff_total = total - total_prev
        local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

        widget:set_text(string.format('| %.2f%% c | ', diff_usage))
        -- widget:set_text(diff_usage)
        total_prev = total
        idle_prev = idle
        collectgarbage 'collect'
      end),

      awful.widget.watch('bash -c "free | grep -z Mem.*Swap.*"', 10, function(widget, s)
        local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
          s:match '(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)'

        widget:set_text(string.format('%.2f%% r | ', used / total * 100))

        collectgarbage 'collect'
      end),
      awful.widget.watch('bash -c "cat /sys/class/thermal/thermal_zone0/temp"', 10, function(widget, stdout)
        local temp = stdout:match '(%d+)'

        widget:set_text(string.format('%.2f%% t | ', (temp / 1000) / max_temp * 100))
        -- widget:set_text((temp / 1000) / max_temp * 100)
        collectgarbage 'collect'
      end),
      wibox.container.margin(systray, dpi(3), dpi(3), dpi(6), dpi(3)),
      BAT0,
      LayoutBox(s),
      -- Clock
      -- clock_widget,
    },
  }

  return panel
end

return TopPanel
