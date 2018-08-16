hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0
hs.logger.defaultLogLevel = "info"

hyper = {"cmd", "alt", "shift", "ctrl"}
meh = {"alt", "shift", "ctrl"}

privatepath = hs.fs.pathToAbsolute(hs.configdir .. '/private')
if not privatepath then
    -- Create `~/.hammerspoon/private` directory if not exists.
    hs.fs.mkdir(hs.configdir .. '/private')
end
privateconf = hs.fs.pathToAbsolute(hs.configdir .. '/private/config.lua')
if privateconf then
    require('private/config')
end

hs.loadSpoon("SpoonInstall")

-- ModalMgr Spoon must be loaded explicitly, because this repository heavily relies upon it.
hs.loadSpoon("ModalMgr")

Install=spoon.SpoonInstall
Install:andUse("WindowGrid", {
    config = { gridGeometries = { { "10x3" } } },
    hotkeys = { show_grid = {{"alt"}, "g"} },
    start = true
})
Install:andUse("WindowScreenLeftAndRight", {
    hotkeys = {
        screen_left = { hyper, "[" },
        screen_right= { hyper, "]" },
    }
})
Install:andUse("WinWin")
Install:andUse("CountDown")
Install:andUse("FadeLogo", {
    config = {
        default_run = 1.0,
    },
    start = true
})
Install:andUse("Caffeine", {
    start = true,
    hotkeys = {
        toggle = { hyper, "1" }
    }
})
Install:andUse("Token", {
    hotkeys = {
        run = {hyper, "F4"}
    },
    config = {
        token = "token_tunnel",
        password = "token_tunnel_pass"
    }
})
Install:andUse("MoveSpaces", {
    hotkeys = {
        space_right = { {'ctrl','shift'}, '.' },
        space_left =  { {'ctrl','shift'}, ',' }
    }
})
Install:andUse("Reload", {
    hotkeys = {
        reload = {{"cmd", "shift", "ctrl"}, "R"},
    }
})
Install:andUse("Tunnelblick", {
    config = {
        username = "tyler.thrailkill",
        password_fn = function() return spoon.Token:get_password() end,
        connection_name = "promontech-openvpn-test"
    }
})
Install:andUse("Seal", {
    hotkeys = { show = { {"cmd"}, "space" } },
    fn = function(s)
        s:loadPlugins({"apps", "calc", "screencapture", "useractions"})
        s.plugins.useractions.actions =
            {
            ["Hammerspoon docs webpage"] = {
                url = "http://hammerspoon.org/docs/",
                icon = hs.image.imageFromName(hs.image.systemImageNames.ApplicationIcon),
                }
            }
        s:refreshAllCommands()
    end,
    start = true,
})
Install:andUse("RecursiveBinder", {
    fn = function(s)
        -- Curried functions so they aren't called immediately
        id = function(id) return function () hs.application.launchOrFocusByBundleID(id) end end
        name = function(name) return function () hs.application.launchOrFocus(name) end end

        app_keymap = {
            [s.singleKey('s', 'Slack')] = id('com.tinyspeck.slackmacgap'),
            [s.singleKey('d', 'Fantastical')] = id('com.flexibits.fantastical2.mac'),
            [s.singleKey('f', 'Firefox')] = id('org.mozilla.firefox'),
            [s.singleKey('t', 'iTerm')] = id('com.googlecode.iterm2'),
            [s.singleKey('e', 'Postbox')] = id('com.postbox-inc.postbox'),
            [s.singleKey('l', 'Sublime Text')] = id('com.sublimetext.3'),
            [s.singleKey('m', 'Messages')] = id('com.apple.iChat'),
            [s.singleKey('y', 'Spotify')] = id('com.spotify.client'),
            [s.singleKey('i', 'Intellij')] = id('com.jetbrains.intellij'),
            [s.singleKey('g', 'SourceTree')] = id('com.torusknot.SourceTreeNotMAS'),
            [s.singleKey('c', 'VS Code')] = id('com.microsoft.VSCode'),
            [s.singleKey('k', 'Kitematic')] = id('com.electron.kitematic_(beta)'),
        }
        hs.hotkey.bind('alt', 'a', s.recursiveBind(app_keymap))

        resize_keymap = {
            [s.singleKey('f', 'fullscreen')] = function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("fullscreen") end,
            [s.singleKey('h', 'Lefthalf of Screen')] = function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfleft") end,
            [s.singleKey('l', 'Righthalf of Screen')] = function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfright") end,
        }
        hs.hotkey.bind('alt', 'r', s.recursiveBind(resize_keymap))

        keymap = {
            [s.singleKey('q', 'find+')] = {
                [s.singleKey('D', 'Desktop')] = function() openWithFinder('~/Desktop') end,
                [s.singleKey('p', 'Project')] = function() openWithFinder('~/p') end,
                [s.singleKey('d', 'Download')] = function() openWithFinder('~/Downloads') end,
                [s.singleKey('a', 'Application')] = function() openWithFinder('~/Applications') end,
                [s.singleKey('h', 'home')] = function() openWithFinder('~') end,
                [s.singleKey('f', 'hello')] = function() hs.alert.show('hello!') end
            },
            [s.singleKey('t', 'tools+')] = {
                [s.singleKey('v', 'file visible')] = function() hs.eventtap.keyStroke({'cmd', 'shift'}, '.') end,
                [s.singleKey('t', 'tunnelblick')] = function() spoon.Tunnelblick:connect() end,
                [s.singleKey('h', 'hammerspoon console')] = function() hs.toggleConsole() end
            },
            [s.singleKey('u', 'token')] = function() spoon.Token.token_keystroke() end,
            [s.singleKey('a', 'open+')] = app_keymap,
            [s.singleKey('r', 'resize+')] = resize_keymap,
        }

        hs.hotkey.bind('alt', 't', s.recursiveBind(keymap))
    end
})

hs.hotkey.bindSpec({"alt", "h"}, 'Show Window Hints', function() hs.hints.windowHints() end)

----------------------------------------------------------------------------------------------------
-- clipshowM modal environment
if spoon.ClipShow then
    spoon.ModalMgr:new("clipshowM")
    local cmodal = spoon.ModalMgr.modal_list["clipshowM"]
    cmodal:bind('', 'escape', 'Deactivate clipshowM', function()
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    cmodal:bind('', 'Q', 'Deactivate clipshowM', function()
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    cmodal:bind('', 'N', 'Save this Session', function()
        spoon.ClipShow:saveToSession()
    end)
    cmodal:bind('', 'R', 'Restore last Session', function()
        spoon.ClipShow:restoreLastSession()
    end)
    cmodal:bind('', 'B', 'Open in Browser', function()
        spoon.ClipShow:openInBrowserWithRef()
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    cmodal:bind('', 'S', 'Search with Bing', function()
        spoon.ClipShow:openInBrowserWithRef("https://www.bing.com/search?q=")
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    cmodal:bind('', 'M', 'Open in MacVim', function()
        spoon.ClipShow:openWithCommand("/usr/local/bin/mvim")
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    cmodal:bind('', 'F', 'Save to Desktop', function()
        spoon.ClipShow:saveToFile()
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    cmodal:bind('', 'H', 'Search in Github', function()
        spoon.ClipShow:openInBrowserWithRef("https://github.com/search?q=")
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    cmodal:bind('', 'G', 'Search with Google', function()
        spoon.ClipShow:openInBrowserWithRef("https://www.google.com/search?q=")
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    cmodal:bind('', 'L', 'Open in Sublime Text', function()
        spoon.ClipShow:openWithCommand("/usr/local/bin/subl")
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    
    -- Register clipshowM with modal supervisor
    hsclipsM_keys = hsclipsM_keys or {"alt", "C"}
    if string.len(hsclipsM_keys[2]) > 0 then
        spoon.ModalMgr.supervisor:bind(hsclipsM_keys[1], hsclipsM_keys[2], "Enter clipshowM Environment", function()
            -- We need to take action upon hsclipsM_keys is pressed, since pressing another key to showing ClipShow panel is redundant.
            spoon.ClipShow:toggleShow()
            -- Need a little trick here. Since the content type of system clipboard may be "URL", in which case we don't need to activate clipshowM.
            if spoon.ClipShow.canvas:isShowing() then
                spoon.ModalMgr:deactivateAll()
                spoon.ModalMgr:activate({"clipshowM"})
            end
        end)
    end
end

----------------------------------------------------------------------------------------------------
-- countdownM modal environment
if spoon.CountDown then
    spoon.ModalMgr:new("countdownM")
    local cmodal = spoon.ModalMgr.modal_list["countdownM"]
    cmodal:bind('', 'escape', 'Deactivate countdownM', function() spoon.ModalMgr:deactivate({"countdownM"}) end)
    cmodal:bind('', 'Q', 'Deactivate countdownM', function() spoon.ModalMgr:deactivate({"countdownM"}) end)
    cmodal:bind('', 'tab', 'Toggle Cheatsheet', function() spoon.ModalMgr:toggleCheatsheet() end)
    cmodal:bind('', '0', '5 Minutes Countdown', function()
        spoon.CountDown:startFor(5)
        spoon.ModalMgr:deactivate({"countdownM"})
    end)
    for i = 1, 9 do
        cmodal:bind('', tostring(i), string.format("%s Minutes Countdown", 10 * i), function()
            spoon.CountDown:startFor(10 * i)
            spoon.ModalMgr:deactivate({"countdownM"})
        end)
    end
    cmodal:bind('', 'return', '25 Minutes Countdown', function()
        spoon.CountDown:startFor(25)
        spoon.ModalMgr:deactivate({"countdownM"})
    end)
    cmodal:bind('', 'space', 'Pause/Resume CountDown', function()
        spoon.CountDown:pauseOrResume()
        spoon.ModalMgr:deactivate({"countdownM"})
    end)
    
    -- Register countdownM with modal supervisor
    hscountdM_keys = hscountdM_keys or {"alt", "I"}
    if string.len(hscountdM_keys[2]) > 0 then
        spoon.ModalMgr.supervisor:bind(hscountdM_keys[1], hscountdM_keys[2], "Enter countdownM Environment", function()
            spoon.ModalMgr:deactivateAll()
            -- Show the keybindings cheatsheet once countdownM is activated
            spoon.ModalMgr:activate({"countdownM"}, "#FF6347", true)
        end)
    end
end

-- ----------------------------------------------------------------------------------------------------
-- -- resizeM modal environment
-- if spoon.WinWin then
--     spoon.ModalMgr:new("resizeM")
--     local cmodal = spoon.ModalMgr.modal_list["resizeM"]
--     cmodal:bind('', 'escape', 'Deactivate resizeM', function() spoon.ModalMgr:deactivate({"resizeM"}) end)
--     cmodal:bind('', 'Q', 'Deactivate resizeM', function() spoon.ModalMgr:deactivate({"resizeM"}) end)
--     cmodal:bind('', 'tab', 'Toggle Cheatsheet', function() spoon.ModalMgr:toggleCheatsheet() end)
--     cmodal:bind('', 'A', 'Move Leftward', function() spoon.WinWin:stepMove("left") end, nil, function() spoon.WinWin:stepMove("left") end)
--     cmodal:bind('', 'D', 'Move Rightward', function() spoon.WinWin:stepMove("right") end, nil, function() spoon.WinWin:stepMove("right") end)
--     cmodal:bind('', 'W', 'Move Upward', function() spoon.WinWin:stepMove("up") end, nil, function() spoon.WinWin:stepMove("up") end)
--     cmodal:bind('', 'S', 'Move Downward', function() spoon.WinWin:stepMove("down") end, nil, function() spoon.WinWin:stepMove("down") end)
--     cmodal:bind('', 'H', 'Lefthalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfleft") end)
--     cmodal:bind('', 'L', 'Righthalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfright") end)
--     cmodal:bind('', 'K', 'Uphalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfup") end)
--     cmodal:bind('', 'J', 'Downhalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfdown") end)
--     cmodal:bind('', 'Y', 'NorthWest Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerNW") end)
--     cmodal:bind('', 'O', 'NorthEast Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerNE") end)
--     cmodal:bind('', 'U', 'SouthWest Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerSW") end)
--     cmodal:bind('', 'I', 'SouthEast Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerSE") end)
--     cmodal:bind('', 'F', 'Fullscreen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("fullscreen") end)
--     cmodal:bind('', 'C', 'Center Window', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("center") end)
--     cmodal:bind('', '=', 'Stretch Outward', function() spoon.WinWin:moveAndResize("expand") end, nil, function() spoon.WinWin:moveAndResize("expand") end)
--     cmodal:bind('', '-', 'Shrink Inward', function() spoon.WinWin:moveAndResize("shrink") end, nil, function() spoon.WinWin:moveAndResize("shrink") end)
--     cmodal:bind('shift', 'H', 'Move Leftward', function() spoon.WinWin:stepResize("left") end, nil, function() spoon.WinWin:stepResize("left") end)
--     cmodal:bind('shift', 'L', 'Move Rightward', function() spoon.WinWin:stepResize("right") end, nil, function() spoon.WinWin:stepResize("right") end)
--     cmodal:bind('shift', 'K', 'Move Upward', function() spoon.WinWin:stepResize("up") end, nil, function() spoon.WinWin:stepResize("up") end)
--     cmodal:bind('shift', 'J', 'Move Downward', function() spoon.WinWin:stepResize("down") end, nil, function() spoon.WinWin:stepResize("down") end)
--     cmodal:bind('', 'left', 'Move to Left Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("left") end)
--     cmodal:bind('', 'right', 'Move to Right Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("right") end)
--     cmodal:bind('', 'up', 'Move to Above Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("up") end)
--     cmodal:bind('', 'down', 'Move to Below Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("down") end)
--     cmodal:bind('', 'space', 'Move to Next Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("next") end)
--     cmodal:bind('', '[', 'Undo Window Manipulation', function() spoon.WinWin:undo() end)
--     cmodal:bind('', ']', 'Redo Window Manipulation', function() spoon.WinWin:redo() end)
--     cmodal:bind('', '`', 'Center Cursor', function() spoon.WinWin:centerCursor() end)
    
--     -- Register resizeM with modal supervisor
--     hsresizeM_keys = hsresizeM_keys or {"alt", "R"}
--     if string.len(hsresizeM_keys[2]) > 0 then
--         spoon.ModalMgr.supervisor:bind(hsresizeM_keys[1], hsresizeM_keys[2], "Enter resizeM Environment", function()
--             -- Deactivate some modal environments or not before activating a new one
--             spoon.ModalMgr:deactivateAll()
--             -- Show an status indicator so we know we're in some modal environment now
--             spoon.ModalMgr:activate({"resizeM"}, "#B22222")
--         end)
--     end
-- end

----------------------------------------------------------------------------------------------------
-- Register Hammerspoon console
hsconsole_keys = hsconsole_keys or {"alt", "Z"}
if string.len(hsconsole_keys[2]) > 0 then
    spoon.ModalMgr.supervisor:bind(hsconsole_keys[1], hsconsole_keys[2], "Toggle Hammerspoon Console", function() hs.toggleConsole() end)
end

----------------------------------------------------------------------------------------------------
-- Finally we initialize ModalMgr supervisor
spoon.ModalMgr.supervisor:enter()
