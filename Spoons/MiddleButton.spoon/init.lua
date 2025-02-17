local obj = {}
obj.__index = obj

-- Metadata
obj.name = "MiddleButton"
obj.version = "1.0"
obj.author = "Mario Studio<gcyyq@hotmail.com>"
obj.homepage = "https://github.com/KingMario/spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Track if middle button down was triggered by this spoon
local middleButtonDownTriggered = false

-- Function to start the spoon
function obj:start()
    self.eventtap = hs.eventtap.new(
        {hs.eventtap.event.types.leftMouseDown, hs.eventtap.event.types.leftMouseUp},
        function(event)
            local flags = event:getFlags()
            local button = event:getProperty(hs.eventtap.event.properties.mouseEventButtonNumber)
            local mousePosition = hs.mouse.absolutePosition()
            local currentEvent = event:getType()
            local middleButtonEventType

            if flags.fn and button == 0 and currentEvent == hs.eventtap.event.types.leftMouseDown then
                middleButtonEventType = hs.eventtap.event.types.otherMouseDown
            elseif middleButtonDownTriggered and button == 0 and currentEvent == hs.eventtap.event.types.leftMouseUp then
                middleButtonEventType = hs.eventtap.event.types.otherMouseUp
            end

            if middleButtonEventType and mousePosition then
                -- Create a new mouse event with button number 2
                local middleButtonEvent = hs.eventtap.event.newMouseEvent(middleButtonEventType, mousePosition)
                middleButtonEvent:setProperty(hs.eventtap.event.properties.mouseEventButtonNumber, 2)
                middleButtonDownTriggered = middleButtonEventType == hs.eventtap.event.types.otherMouseDown
                middleButtonEvent:post()

                return true -- Consume the event
            end

            return false -- Do not consume the event
        end
    )
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
