local obj = {}
obj.__index = obj

-- Metadata
obj.name = "MetaZoom"
obj.version = "1.0"
obj.author = "Mario Studio<gcyyq@hotmail.com>"
obj.homepage = "https://github.com/KingMario/spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Function to start the spoon
function obj:start()
    self.eventtap = hs.eventtap.new({hs.eventtap.event.types.scrollWheel}, function(event)
        local flags = event:getFlags()
        if flags.cmd then
            local scrollDirection = event:getProperty(hs.eventtap.event.properties.scrollWheelEventDeltaAxis1)

            -- Dispatch a click event
            local clickEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown,
                hs.mouse.getAbsolutePosition())
            clickEvent:post()
            hs.timer.usleep(1000) -- Small delay to ensure the click is registered
            hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, hs.mouse.getAbsolutePosition()):post()

            if scrollDirection < 0 then
                -- Scroll up, send cmd + =
                hs.eventtap.keyStroke({"cmd"}, "=")
            elseif scrollDirection > 0 then
                -- Scroll down, send cmd + -
                hs.eventtap.keyStroke({"cmd"}, "-")
            end
            return true -- Consume the event
        end
        return false -- Do not consume the event
    end)
    self.eventtap:start()
end

-- Function to stop the spoon
function obj:stop()
    if self.eventtap then
        self.eventtap:stop()
        self.eventtap = nil
    end
end

return obj
