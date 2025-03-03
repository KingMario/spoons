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
            local mousePosition = hs.mouse.getAbsolutePosition()

            local windows = hs.window.orderedWindows()

            local windowUnderPointer = nil
            for _, window in ipairs(windows) do
                local frame = window:frame()
                if hs.geometry(mousePosition):inside(frame) then
                    windowUnderPointer = window
                    break
                end
            end

            local focusedWindow = hs.window.focusedWindow()

            if windowUnderPointer and windowUnderPointer ~= focusedWindow then
                windowUnderPointer:focus()
            end

            local scrollDirection = event:getProperty(hs.eventtap.event.properties.scrollWheelEventDeltaAxis1)

            if scrollDirection < 0 then
                hs.eventtap.keyStroke({"cmd"}, "=")
            elseif scrollDirection > 0 then
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
