local obj = {}
obj.__index = obj

local mash = {'shift', 'option'}

local mouseGo = function (next)
  local screen = hs.mouse.getCurrentScreen()
  local screenToMove = next and screen:next() or screen:previous()
  local mode = screenToMove:currentMode()

  local screenCenter = {x = 0.50 * mode.w, y = 0.50 * mode.h}

  hs.mouse.setRelativePosition(screenCenter, screenToMove)
end

hs.hotkey.bind({'option'}, '`', function () mouseGo(true) end)
hs.hotkey.bind(mash, '`', function () mouseGo(false) end)

return obj
