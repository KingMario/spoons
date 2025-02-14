local obj = {}
obj.__index = obj

-- Metadata
obj.name = "MiddleButton"
obj.version = "1.0"
obj.author = "Mario Studio<gcyyq@hotmail.com>"
obj.homepage = "https://github.com/KingMario/spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Function to start the spoon
function obj:start()
    self.eventtap = hs.eventtap.new({hs.eventtap.event.types.leftMouseDown, hs.eventtap.event.types.leftMouseUp},
        function(event)
            local flags = event:getFlags()
            local button = event:getProperty(hs.eventtap.event.properties.mouseEventButtonNumber)

            if flags.fn and button == 0 then -- Check if fn key is held and left mouse button is involved
                local middleButtonEventType = event:getType() == hs.eventtap.event.types.leftMouseDown and
                                                  hs.eventtap.event.types.otherMouseDown or
                                                  hs.eventtap.event.types.otherMouseUp
                local mousePosition = hs.mouse.absolutePosition()
                -- print("Mouse Position:", mousePosition)

                if middleButtonEventType and mousePosition then
                    -- Create a new mouse event with button number 2
                    local middleButtonEvent = hs.eventtap.event.newMouseEvent(middleButtonEventType, mousePosition)
                    middleButtonEvent:setProperty(hs.eventtap.event.properties.mouseEventButtonNumber, 2)
                    if middleButtonEvent then
                        middleButtonEvent:post()
                        return true -- Consume the event
                    end
                end
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
