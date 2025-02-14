hs.window.animationDuration = 0

local mash = {'⇧', '⌥'}

hs.loadSpoon('ReloadConfiguration')
spoon.ReloadConfiguration:start()

hs.loadSpoon('MouseGo')

hs.loadSpoon('ShiftIt')

hs.loadSpoon('MetaZoom')
local metaZoomEnabled = false
local function toggleMetaZoom()
    if metaZoomEnabled then
        spoon.MetaZoom:stop()
        metaZoomEnabled = false
        hs.alert.show("MetaZoom Stopped")
    else
        spoon.MetaZoom:start()
        metaZoomEnabled = true
        hs.alert.show("MetaZoom Started")
    end
end
hs.hotkey.bind(mash, 'o', toggleMetaZoom)

hs.loadSpoon("MiddleButton")
local middleButtonEnabled = false
local function toggleMiddleButton()
    if middleButtonEnabled then
        spoon.MiddleButton:stop()
        middleButtonEnabled = false
        hs.alert.show("MiddleButton Stopped")
    else
        spoon.MiddleButton:start()
        middleButtonEnabled = true
        hs.alert.show("MiddleButton Started")
    end
end
hs.hotkey.bind(mash, 'p', toggleMiddleButton)

hs.loadSpoon('StageToggler')

hs.loadSpoon('WindowGrid')
hs.grid.setMargins({
    w = 0,
    h = 0
})
hs.grid.HINTS = {{'1', '2', '3', '4', '5', '6', '7', '8', '9'}, {'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O'},
                 {'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'}, {'Z', 'X', 'C', 'V', 'B', 'N', 'M', ',', '.'},
                 {'0', '-', '=', 'P', '[', ']', '\\', ';', '\''}}
spoon.WindowGrid.gridGeometries = {{'9x6'}}
spoon.WindowGrid:start()
spoon.WindowGrid:bindHotkeys({
    show_grid = {mash, 'f'}
})

hs.loadSpoon('KSheet')
spoon.KSheet:bindHotkeys({
    toggle = {{'⌘'}, 'ESCAPE'}
})

function presetWin(hint, position, monitor)
    if not monitor then
        monitor = '8416852B-E884-4B0D-8850-D206C73968D9' -- XiaoMi 1
        -- monitor = '7819D603-EA7E-4AD7-B9D6-5C0E4EF9E46F' -- XiaoMi 2
        -- monitor = '5A271085-C2D1-4FCC-B893-9F255EEAA8A6'
    end

    screenToMove = hs.screen.find(monitor)

    if screenToMove then
        local win = hs.window.find(hint)

        if win then
            if string.match(hint, 'Git -') and string.match(win:title(), 'Google Chrome') then
                return
            end

            win:move(position, screenToMove, true)
        end
    end
end

function presetApplicationWin(application, hint, position, monitor)
    if application then
        local win = application:findWindow(hint)

        if win then
            presetWin(win:id(), position, monitor)
        end
    end
end

function toggleFullScreen(title)
    local win = hs.window.find(title)
    if win then
        win:toggleFullScreen()
    end
end

function loginWechat()
    local weChatApp = hs.application.find("WeChat")
    if not weChatApp then
        print("WeChat application is not running.")
        return
    end

    weChatApp:activate()
    hs.eventtap.keyStroke({}, "return")
end

local excludedTitles = {'Google Chrome', 'DevTools -', 'Commit - ', 'Git - ', 'Run -', 'GitHub Copilot Chat', 'Notifications - ',
                        'Hammerspoon Console', 'Han han | Microsoft Teams', 'Project - '}

local function isExcludedTitle(winTitle)
    for _, title in ipairs(excludedTitles) do
        if string.match(winTitle, title) then
            return true
        end
    end
    return false
end

hs.hotkey.bind({'⌘', '⌥'}, 'z', function()
    local middleTouch = hs.application.find("MiddleTouch")

    if middleTouch then
        middleTouch:hide()
    end

    local windows = hs.window.allWindows()
    for _, win in ipairs(windows) do
        local winTitle = win:title()
        if string.match(winTitle, 'Google Chrome') then
            presetWin('Google Chrome', {
                x = 0,
                y = 0,
                w = .5,
                h = 1
            }, '7819D603-EA7E-4AD7-B9D6-5C0E4EF9E46F')
        end

        if not win:isFullScreen() and not isExcludedTitle(winTitle) and win:application():name() ~= 'Finder' then
            win:toggleFullScreen()
            hs.timer.usleep(500000)
        end
    end

    loginWechat()
end)

hs.hotkey.bind({'⌘', '⌥'}, 'x', function()
    presetWin('Project - ', {
        x = 0,
        y = 0,
        w = 0.25,
        h = 0.4
    })
    presetWin('Commit - ', {
        x = 0.25,
        y = 0,
        w = 0.5,
        h = 0.4
    })
    presetWin('Notifications - ', {
        x = 0.75,
        y = 0,
        w = 0.25,
        h = 0.4
    })
    presetWin('Run - ', {
        x = 0.75,
        y = 0,
        w = 0.25,
        h = 0.4
    })
    presetWin('GitHub Copilot Chat', {
        x = 0,
        y = 0.4,
        w = 1,
        h = 0.6
    })
    presetWin('Git -', {
        x = 0,
        y = 0.4,
        w = 1,
        h = 0.6
    })
end)

hs.hotkey.bind({'⌘', '⌥', '⇧'}, 'c', function()
    local screens = hs.screen.allScreens()
    for i, screen in ipairs(screens) do
        print('Screen ' .. i .. ': ' .. screen:name())
        print('Screen ' .. i .. ': ' .. screen:getUUID())
    end
end)

hs.hotkey.bind({'⌘', '⌥'}, 't', function()
    local win = hs.window.frontmostWindow()
    if win then
        print(win:title())
    else
        print('No window is currently active.')
    end
end)

function loadPasswords()
    local passwords = {}
    local envFile = io.open("./.env", "r") -- Adjust the path if necessary
    if envFile then
        for line in envFile:lines() do
            if line:match("^password_%d+=") then
                local key, value = line:match("^(.+)=(.+)$")
                passwords[key] = value
            end
        end
        envFile:close()
    end
    return passwords
end

local passwords = loadPasswords()

hs.hotkey.bind({'⌘', '⌥', '⇧'}, 'q', function()
    hs.eventtap.keyStrokes(passwords['password_1'])
    hs.eventtap.keyStroke({}, 'return')
end)

hs.hotkey.bind({'⌘', '⌥', '⇧'}, 'w', function()
    hs.eventtap.keyStrokes(passwords['password_2'])
    hs.eventtap.keyStroke({}, 'return')
end)

hs.hotkey.bind({'⌘', '⇧'}, 'e', function()
    local webStromApp = hs.application.find("WebStorm")

    if webStromApp then
        webStromApp:activate(tree)
    end
end)

function setMode()
    local screen = hs.screen.find('37D8832A-2D66-02CA-B9F7-8F30A301B230')
    local currentMode = screen:currentMode()
    print(string.format("Current screen mode: " .. currentMode.desc))

    local targetWidth = currentMode.w == 1147 and 1800 or 1147 -- Toggle between 1147 and 1800
    local targetHeight = targetWidth == 1800 and 1169 or 745 -- Height for 1800 width or default height for 1147 width
    local targetScale = 2 -- High DPI mode
    local promotionRate = 120 -- Define the promotion refresh rate

    local modes = screen:availableModes()
    local bestMode = nil
    local bestModeKey = nil

    for key, mode in pairs(modes) do
        if mode.w == targetWidth and mode.h == targetHeight and mode.scale == targetScale and mode.freq == promotionRate then
            bestMode = mode
            bestModeKey = key
            break -- Prefer the first mode that matches width, height, scale, and refresh rate
        end
    end

    if bestMode then
        if screen:setMode(bestMode.w, bestMode.h, bestMode.scale, bestMode.freq, bestMode.depth) then
            print("Mode set to: " .. bestModeKey)
        else
            print("Failed to set mode: " .. bestModeKey)
        end
    else
        print("No suitable mode found for width: " .. targetWidth .. ", height: " .. targetHeight ..
                  " with a refresh rate of " .. promotionRate .. "Hz")
    end
end

hs.hotkey.bind({'⌘', '⌥', '⇧'}, 'm', setMode)
