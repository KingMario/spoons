local obj = {}
obj.__index = obj

local presets = {
  left = {x = 0.00, y = 0.00, w = 0.50, h = 1.00},
  right = {x = 0.50, y = 0.00, w = 0.50, h = 1.00},
  up = {x = 0.00, y = 0.00, w = 1.00, h = 0.50},
  down = {x = 0.00, y = 0.50, w = 1.00, h = 0.50},
  
  topLeft = {x = 0.00, y = 0.00, w = 0.50, h = 0.50},
  topRight = {x = 0.50, y = 0.00, w = 0.50, h = 0.50},
  bottomLeft = {x = 0.00, y = 0.50, w = 0.50, h = 0.50},
  bottomRight = {x = 0.50, y = 0.50, w = 0.50, h = 0.50},
  
  topLeft2 = {x = 0.00, y = 0.00, w = 0.67, h = 0.50},
  topRight1 = {x = 0.67, y = 0.00, w = 0.33, h = 0.50},
  left2 = {x = 0.00, y = 0.00, w = 0.67, h = 1.00},
  right1 = {x = 0.67, y = 0.00, w = 0.33, h = 1.00},
  bottomLeft2 = {x = 0.00, y = 0.50, w = 0.67, h = 0.50},
  bottomRight1 = {x = 0.67, y = 0.50, w = 0.33, h = 0.50},
  
  maximum = {x = 0.00, y = 0.00, w = 1.00, h = 1.00}
}

local mash = {'shift', 'option'}

local move = function (preset) hs.window.focusedWindow():move(presets[preset], nil, true) end

local resize = function (enlarge)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  local stepX = max.w / 20
  local stepY = max.h / 20

  if enlarge then
    f.x = f.x - stepX
    f.x = f.x < max.x and max.x or f.x
    f.y = f.y - stepY
    f.w = f.w + stepX * 2
    f.h = f.h + stepY * 2
  else
  	f.x = f.x + stepX
  	f.y = f.y + stepY
    f.w = f.w - stepX * 2
    f.h = f.h - stepY * 2
  end

  win:setFrame(f)
end

local shiftScreen = function (next)
  local win = hs.window.focusedWindow()
  local screenToMove = next and win:screen():next() or win:screen():previous()
  win:moveToScreen(screenToMove)

  local mode = screenToMove:currentMode()
  local screenCenter = {x = 0.50 * mode.w, y = 0.50 * mode.h}

  hs.mouse.setRelativePosition(screenCenter, screenToMove)
end

local toggleFullScreen = function()
  local win = hs.window.focusedWindow()
  local currentState = win:isFullScreen()
  win:setFullScreen(not currentState)
end

local centerOnScreen = function () hs.window.focusedWindow():centerOnScreen() end

hs.hotkey.bind(mash, 'LEFT', function() move('left') end)
hs.hotkey.bind(mash, 'RIGHT', function() move('right') end)
hs.hotkey.bind(mash, 'UP', function() move('up') end)
hs.hotkey.bind(mash, 'DOWN', function() move('down') end)

hs.hotkey.bind(mash, 'a', function() move('topLeft') end)
hs.hotkey.bind(mash, 's', function() move('topRight') end)
hs.hotkey.bind(mash, 'z', function() move('bottomLeft') end)
hs.hotkey.bind(mash, 'x', function() move('bottomRight') end)

hs.hotkey.bind(mash, 'h', function() move('topLeft') shiftScreen(true) end)
hs.hotkey.bind(mash, 'j', function() move('topRight') shiftScreen(true) end)
hs.hotkey.bind(mash, 'n', function() move('bottomLeft') shiftScreen(true) end)
hs.hotkey.bind(mash, 'm', function() move('bottomRight') shiftScreen(true) end)

hs.hotkey.bind(mash, '[', function() move('topLeft2') end)
hs.hotkey.bind(mash, ']', function() move('topRight1') end)
hs.hotkey.bind(mash, ';', function() move('left2') end)
hs.hotkey.bind(mash, '\'', function() move('right1') end)
hs.hotkey.bind(mash, '.', function() move('bottomLeft2') end)
hs.hotkey.bind(mash, '/', function() move('bottomRight1') end)

hs.hotkey.bind(mash, 'q', function() move('maximum') end)

hs.hotkey.bind(mash, 'y', function() move('maximum')  shiftScreen(true) end)

hs.hotkey.bind({'option'}, 'TAB', function () shiftScreen(true) end)
hs.hotkey.bind(mash, 'TAB', function () shiftScreen(false) end)

hs.hotkey.bind(mash, 'w', function () toggleFullScreen() end)
hs.hotkey.bind(mash, 'd', function () resize(true) end)
hs.hotkey.bind(mash, 'e', function () resize(false) end)
hs.hotkey.bind(mash, 'c', function () centerOnScreen() end)

hs.hotkey.bind(mash, ',', function () centerOnScreen() shiftScreen(true) end)

return obj
