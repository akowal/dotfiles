hs.window.animationDuration = 0

local TRIGGER_RESIZE = {"cmd", "ctrl"}
local TRIGGER_MOVE = {"cmd", "ctrl", "alt"}

hs.hotkey.bind(TRIGGER_RESIZE, "c", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen():frame()

  win:setFullscreen(false)

  f.x = screen.x
  f.y = screen.y
  f.w = screen.w
  f.h = screen.h
  win:setFrame(f)
end)

hs.hotkey.bind(TRIGGER_MOVE, "c", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen():frame()

  win:setFullscreen(false)

  f.x = screen.x + screen.w / 6
  f.y = screen.y + screen.h / 6
  f.w = screen.w - screen.w / 3
  f.h = screen.h - screen.h / 3
  win:setFrame(f)
end)


hs.hotkey.bind(TRIGGER_RESIZE, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen():frame()

  win:setFullscreen(false)

  f.x = screen.x
  f.y = screen.y
  f.w = screen.w / 2
  f.h = screen.h
  win:setFrame(f)
end)

hs.hotkey.bind(TRIGGER_RESIZE, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen():frame()

  win:setFullscreen(false)

  f.x = screen.x + screen.w / 2
  f.y = screen.y
  f.w = screen.w / 2
  f.h = screen.h
  win:setFrame(f)
end)

hs.hotkey.bind(TRIGGER_RESIZE, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen():frame()

  win:setFullscreen(false)

  f.x = screen.x
  f.y = screen.y
  f.w = screen.w
  f.h = screen.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind(TRIGGER_RESIZE, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen():frame()

  win:setFullscreen(false)

  f.x = screen.x
  f.y = screen.y + screen.h / 2
  f.w = screen.w
  f.h = screen.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind(TRIGGER_MOVE, "Left", function()
  local win = hs.window.focusedWindow()
  win:setFullscreen(false)
  win:moveOneScreenWest(false, true)
end)

hs.hotkey.bind(TRIGGER_MOVE, "Right", function()
  local win = hs.window.focusedWindow()
  win:setFullscreen(false)
  win:moveOneScreenEast(false, true)
end)
