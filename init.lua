--[[
IMPORTS
--]]

local grid = require "modules.grid"
local layouts = require "modules.layouts"
local apps = require "modules.apps"
-- local pomodoro = require "modules.pomodoro"

--[[
MAIN
--]]

-- Capture the hostname, so we can make this config behave differently across my Macs
hostname = hs.host.localizedName()

-- Ensure the IPC command line client is available
hs.ipc.cliInstall()

-- Watchers and other useful objects
configFileWatcher = nil
wifiWatcher = nil
screenWatcher = nil
usbWatcher = nil
appWatcher = nil

-- window hints
hs.hints.showTitleThresh = 0

-- Define monitor names for layout purposes
local display_home  = "f.lux profile"
local display_laptop  = "Color LCD"
local display_monitor = "Thunderbolt Display"

-- Defines for WiFi watcher
homeSSID = "The LAN Before Time" -- My 2.5 home WiFi SSID
homeSSID5 = "The LAN Before Time+" -- My 5.0 home WiFi SSID
lastSSID = hs.wifi.currentNetwork()

-- Defines for screen watcher
lastNumberOfScreens = #hs.screen.allScreens()
print('Last number of screens: ' .. lastNumberOfScreens)

-- Set grid options
hs.grid.MARGINX     = 0
hs.grid.MARGINY     = 0
hs.grid.ui.textSize = 50
hs.grid.HINTS       = {
    {'1',  '2',  '3',  '4',  '5',  '6',  '7',  '8',  '9',  '0'},
    {'Q',  'W',  'E',  'R',  'T',  'Y',  'U',  'I',  'O',  'P'},
    {'A',  'S',  'D',  'F',  'G',  'H',  'J',  'K',  'L',  ';'},
    {'Z',  'X',  'C',  'V',  'B',  'N',  'M',  ',',  '.',  '/'}
}

-- Set window animation off. It's much smoother.
hs.window.animationDuration = 0

-- Defines for window grid
if (hostname == "Bessie") then
    hs.grid.GRIDWIDTH = 6
    hs.grid.GRIDHEIGHT = 6
else
    hs.grid.GRIDWIDTH = 12
    hs.grid.GRIDHEIGHT = 12
end

--[[
KEYBINDINGS
--]]

local mash      = {"cmd", "alt", "ctrl"}
local mashshift = {"cmd", "alt", "ctrl", "shift"}

hs.hotkey.bind(mash,      'G', function() hs.hints.windowHints(grid.getAllValidWindows()) end)
hs.hotkey.bind(mashshift, 'G', function() hs.grid.show() end)

hs.hotkey.bind(mash,      ';', function() hs.grid.snap(hs.window.focusedWindow()) end)
hs.hotkey.bind(mash,      "'", function() hs.fnutils.map(hs.window.visibleWindows(), hs.grid.snap) end)

hs.hotkey.bind(mash,      '=', function() hs.grid.resizeWindowWider() end)
hs.hotkey.bind(mash,      '-', function() hs.grid.resizeWindowThinner() end)
hs.hotkey.bind(mashshift, '=', function() hs.grid.resizeWindowTaller() end)
hs.hotkey.bind(mashshift, '-', function() hs.grid.resizeWindowShorter() end)

hs.hotkey.bind(mash,      'left', function() hs.grid.pushWindowLeft() end)
hs.hotkey.bind(mash,      'right', function() hs.grid.pushWindowRight() end)
hs.hotkey.bind(mash,      'up', function() hs.grid.pushWindowUp() end)
hs.hotkey.bind(mash,      'down', function() hs.grid.pushWindowDown() end)

hs.hotkey.bind(mashshift, 'left', function() hs.window.focusedWindow():focusWindowWest() end)
hs.hotkey.bind(mashshift, 'right', function() hs.window.focusedWindow():focusWindowEast() end)
hs.hotkey.bind(mashshift, 'up', function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(mashshift, 'down', function() hs.window.focusedWindow():focusWindowSouth() end)

hs.hotkey.bind(mash,      'M', function() hs.grid.maximize_window() end)
hs.hotkey.bind(mash,      'F', function() hs.window.focusedWindow():toggleFullScreen() end)
hs.hotkey.bind(mash,      'C', grid.center_fullscreen)
hs.hotkey.bind(mashshift, 'C', function() hs.window.focusedWindow():centerOnScreen(nil, true) end)

-- Halves
hs.hotkey.bind(mash,      'J', grid.snap_north)
hs.hotkey.bind(mash,      'K', grid.snap_south)
hs.hotkey.bind(mash,      'L', grid.snap_east)
hs.hotkey.bind(mash,      'H', grid.snap_west)
hs.hotkey.bind(mash,      'U', grid.snap_northwest)
hs.hotkey.bind(mash,      'I', grid.snap_northeast)
hs.hotkey.bind(mash,      'O', grid.snap_southwest)
hs.hotkey.bind(mash,      'Y', grid.snap_southeast)

-- Thirds
hs.hotkey.bind(mashshift, 'H', grid.snap_west_one_third)
hs.hotkey.bind(mashshift, 'J', grid.snap_west_two_thirds)
hs.hotkey.bind(mashshift, 'K', grid.snap_east_one_third)
hs.hotkey.bind(mashshift, 'L', grid.snap_east_two_thirds)
hs.hotkey.bind(mashshift, 'Y', grid.snap_north_one_third)
hs.hotkey.bind(mashshift, 'U', grid.snap_north_two_thirds)
hs.hotkey.bind(mashshift, 'I', grid.snap_south_one_third)
hs.hotkey.bind(mashshift, 'O', grid.snap_south_two_thirds)

-- Screens
hs.hotkey.bind(mash,      'N', function() hs.grid.pushWindowNextScreen() end)
hs.hotkey.bind(mash,      'P', function() hs.grid.pushWindowPrevScreen() end)

-- Pomodoro key binding
-- hs.hotkey.bind(mash,      '9', pomodoro.pom_enable)
-- hs.hotkey.bind(mash,      '0', pomodoro.pom_disable)
-- hs.hotkey.bind(mashshift, '0', pomodoro.pom_reset_work)

-- Apps launcher
hs.hotkey.bind(mashshift, '9', function() apps.launcher:show() end)

-- Layouts chooser
hs.hotkey.bind(mashshift, '0', function() layouts.chooser:show() end)

-- Defines for window maximize toggler
frameCache = {}

-- Toggle a window between its normal size, and being maximized
function toggle_window_maximized()
    local win = hs.window.focusedWindow()
    if frameCache[win:id()] then
        win:setFrame(frameCache[win:id()])
        frameCache[win:id()] = nil
    else
        frameCache[win:id()] = win:frame()
        win:maximize()
    end
end

--[[
CALLBACKS
--]]

-- Callback function for application events
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        if (appName == "Finder") then
            -- Bring all Finder windows forward when one gets activated
            appObject:selectMenuItem({"Window", "Bring All to Front"})
        end
    end
end

-- Callback function for WiFi SSID change events
function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()

    print("ssidChangedCallback: old:"..(lastSSID or "nil").." new:"..(newSSID or "nil"))
    if newSSID == homeSSID or newSSID == homeSSID5 and lastSSID ~= homeSSID or lastSSID ~= homeSSID5 then
        -- We have gone from something that isn't my home WiFi, to something that is
        print('at home')
    elseif newSSID ~= homeSSID or newSSID ~= homeSSID5 and lastSSID == homeSSID or lastSSID == homeSSID5 then
        -- We have gone from something that is my home WiFi, to something that isn't
        print('left home')
    end

    lastSSID = newSSID
end

-- Callback function for USB device events
-- function usbDeviceCallback(data)
--     print("usbDeviceCallback: "..hs.inspect(data))
--     if (data["productName"] == "ScanSnap S1300i") then
--         event = data["eventType"]
--         if (event == "added") then
--             hs.application.launchOrFocus("ScanSnap Manager")
--         elseif (event == "removed") then
--             app = hs.appfinder.appFromName("ScanSnap Manager")
--             app:kill()
--         end
--     end
-- end

-- Callback function for changes in screen layout
function screensChangedCallback()
    print("screensChangedCallback")
    newNumberOfScreens = #hs.screen.allScreens()
    local notificationMessage = ''
    -- FIXME: This is awful if we swap primary screen to the external display,
    -- all the windows swap around, pointlessly.
    if lastNumberOfScreens ~= newNumberOfScreens then
        if newNumberOfScreens == 1 then
            hs.layout.apply(internal_display)
            notificationMessage='Internal display layout applied'
        elseif newNumberOfScreens == 2 then
            hs.layout.apply(dual_display)
            notificationMessage='Internal display layout applied'
        end

        hs.notify.new({
            title='Screens Changed',
            informativeText=notificationMessage
        }):send()
    end

    lastNumberOfScreens = newNumberOfScreens
end

-- Fancy config reload
function reloadConfig(paths)
    doReload = false
    for _,file in pairs(paths) do
        if file:sub(-4) == ".lua" then
            print("A lua file changed, doing reload")
            doReload = true
        end
    end
    if not doReload then
        print("No lua file changed, skipping reload")
        return
    end

    hs.reload()
end

--[[
WATCHERS
--]]

-- Create and start our callbacks
-- start app launch watcher
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

screenWatcher = hs.screen.watcher.new(screensChangedCallback)
screenWatcher:start()

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

-- usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
-- usbWatcher:start()

configFileWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig)
configFileWatcher:start()

-- Finally, show a notification that we finished loading the config successfully
hs.notify.new({
    title='Hammerspoon',
    informativeText='Config loaded'
}):send()