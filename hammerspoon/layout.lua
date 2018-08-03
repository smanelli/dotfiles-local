local u = hs.geometry.unitrect

layoutLabEmacs = {
  {'Things', nil, LAB_LEFT_MONITOR, u(0, 0, 1/2, 1/4), nil, nil, visible=true},
  {'Calendar', nil, LAB_LEFT_MONITOR, u(1/2, 0, 1/2, 1/4), nil, nil, visible=true},
  {'Google Chrome', nil, LAB_LEFT_MONITOR, u(0, 1/4, 1, 1/2), nil, nil, visible=true},
  {'Mail', nil, LAB_LEFT_MONITOR, u(0, 3/4, 1, 1/4), nil, nil, visible=true},

  {'Emacs', nil, LAB_RIGHT_MONITOR, u(0, 0, 3/5, 1), nil, nil, visible=true},
  {'iTerm2', nil, LAB_RIGHT_MONITOR, u(3/5, 0, 2/5, 1), nil, nil, visible=true},

  {'Slack', nil, MACBOOK_MONITOR, u(0, 0, 1/2, 1/2), nil, nil, visible=true},
  {'Zulip', nil, MACBOOK_MONITOR, u(0, 1/2, 1/2, 1/2), nil, nil, visible=true},
  {'Spotify', nil, MACBOOK_MONITOR, u(1/2, 0, 1/2, 1), nil, nil, visible=true}
}

layoutLabEmacsFocus = {
  {'Google Chrome', nil, LAB_LEFT_MONITOR, u(0, 0, 1, 1/2), nil, nil, visible=true},
  {'iTerm2', nil, LAB_LEFT_MONITOR, u(0, 1/2, 1, 1/2), nil, nil, visible=true},

  {'Emacs', nil, LAB_RIGHT_MONITOR, u(0, 0, 1, 1), nil, nil, visible=true},

  {'Things', nil, MACBOOK_MONITOR, u(0, 0, 1/2, 1), nil, nil, visible=true},
  {'Calendar', nil, MACBOOK_MONITOR, u(1/2, 0, 1/2, 1), nil, nil, visible=true},

  {'Slack', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
  {'Zulip', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
  {'Spotify', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
  {'Mail', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
}

layoutDormTerminal = {
  {'Google Chrome', nil, DORM_LEFT_MONITOR, u(0, 0, 1, 1), nil, nil, visible=true},

  {'iTerm2', nil, DORM_RIGHT_MONITOR, u(0, 0, 1, 1), nil, nil, visible=true},

  {'Slack', nil, MACBOOK_MONITOR, u(0, 0, 1/2, 1/2), nil, nil, visible=true},
  {'Things', nil, MACBOOK_MONITOR, u(0, 1/2, 1/2, 1/2), nil, nil, visible=true},
  {'Zulip', nil, MACBOOK_MONITOR, u(1/2, 0, 1/2, 1/2), nil, nil, visible=true},
  {'Mail', nil, MACBOOK_MONITOR, u(1/2, 1/2, 1/2, 1/2), nil, nil, visible=true},

  {'Spotify', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
  {'Calendar', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
  {'Emacs', nil, DORM_RIGHT_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false}
}

layoutLaptop = {
  {'Calendar', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
  {'Emacs', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
  {'Google Chrome', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
  {'Mail', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
  {'Slack', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
  {'Spotify', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
  {'Things', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
  {'Zulip', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
  {'iTerm2', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=true},
}


tableToSet = function(table)
  local s = {}
  if not table then
    return s
  end
  for _, v in ipairs(table) do s[v] = true end
  return s
end

applyLayout = function(name, layout)
  for _, entry in ipairs(layout) do
    local name = entry[1]
    local show = entry['visible']
    local app = hs.application.get(name)
    if app then
      if show then
        app:unhide()
      else
        app:hide()
      end
    end
  end
  hs.layout.apply(layout)
  hs.notify.new({title='Layout', informativeText='Applied layout: ' .. name}):send()
end

rescue = function()
  local screen = hs.screen.mainScreen()
  local screenFrame = screen:fullFrame()
  local wins = hs.window.visibleWindows()
  for _, win in ipairs(wins) do
    local frame = win:frame()
    if not frame:inside(screenFrame) then
      win:moveToScreen(screen, true, true)
    end
  end
end
