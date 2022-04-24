local awful = require('awful')
local gears = require('gears')
local client_keys = require('configuration.client.keys')
local client_buttons = require('configuration.client.buttons')

-- Rules
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      keys = client_keys,
      buttons = client_buttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_offscreen,
      floating = false,
      maximized = false,
      above = false,
      below = false,
      ontop = false,
      sticky = false,
      maximized_horizontal = false,
      maximized_vertical = false
    }
  },
  {
    rule_any = {name = {'QuakeTerminal'}},
    properties = {skip_decoration = true}
  },
  -- Titlebars
  {
    rule_any = {type = {'dialog'}, class = {'Wicd-client.py', 'calendar.google.com'}},
    properties = {
      placement = awful.placement.centered,
      ontop = true,
      floating = true,
      drawBackdrop = true,
      shape = function()
        return function(cr, w, h)
          gears.shape.rounded_rect(cr, w, h, 8)
        end
      end,
      skip_decoration = true
    }
  },
  {
    rule_any = {name = {'YouTube'}},
    -- type = { "normal", "dialog" },
    properties = { 
    placement = awful.placement.bottom_right,
    -- focus = awful.client.focus.filter,
    -- screen = awful.screen.preferred,
    width = awful.screen.focused().workarea.width * 0.4,
    height = awful.screen.focused().workarea.height * 0.4,
    ontop = true,
    floating = true,
    drawBackdrop = true,
    -- shape = function()
    --   return function(cr, w, h)
    --     gears.shape.rounded_rect(cr, w, h, 8)
    --   end
    -- end,
    skip_decoration = true,
    titlebars_enabled = false
    -- switchtotag = true
  }}
  
}
