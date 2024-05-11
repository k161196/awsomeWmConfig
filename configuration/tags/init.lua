local awful = require('awful')
local gears = require('gears')
local icons = require('theme.icons')
local apps = require('configuration.apps')

local tags = {
  {
    icon = icons.brain,
    type = 'brain',
    defaultApp = apps.default.logseq,
    screen = 1
  },
  {
    icon = icons.code,
    type = 'code',
    defaultApp = apps.default.editor,
    screen = 1
  },
  {
    icon = icons.terminal,
    type = 'terminal',
    defaultApp = apps.default.terminal,
    screen = 1
  },
  {
    icon = icons.social,
    type = 'slack',
    defaultApp = apps.default.slack,
    screen = 1
  },

  -- {
  --   icon = icons.api,
  --   type = 'postman',
  --   defaultApp = apps.default.postman,
  --   screen = 1
  -- },
  -- {
  --   icon = icons.chrome,
  --   type = 'chrome',
  --   defaultApp = apps.default.chrome,
  --   screen = 1
  -- },
  {
    icon = icons.api,
    type = 'postman',
    defaultApp = apps.default.postman,
    screen = 1
  },
  
  {
    icon = icons.chrome,
    type = 'chrome',
    defaultApp = apps.default.browser,
    screen = 1
  },

 

 
  
  


  
  {
    icon = icons.notion,
    type = 'notion',
    defaultApp = apps.default.notion,
    icon = icons.notion,
    type = 'notion',
    defaultApp = apps.default.notion,
    screen = 1
  },
  {
    icon = icons.terminal,
    type = 'terminal',
    defaultApp = apps.default.notion,
    screen = 1
  }
}

awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max,
  awful.layout.suit.floating
}

awful.screen.connect_for_each_screen(
  function(s)
    for i, tag in pairs(tags) do
      awful.tag.add(
        i,
        {
          icon = tag.icon,
          icon_only = true,
          layout = awful.layout.suit.tile,
          gap_single_client = false,
          gap = 2,
          screen = s,
          defaultApp = tag.defaultApp,
          selected = i == 1
        }
      )
    end
  end
)

_G.tag.connect_signal(
  'property::layout',
  function(t)
    local currentLayout = awful.tag.getproperty(t, 'layout')
    if (currentLayout == awful.layout.suit.max) then
      t.gap = 0
    else
      t.gap = 2
    end
  end
)
