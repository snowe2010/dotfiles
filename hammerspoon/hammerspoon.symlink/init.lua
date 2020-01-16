hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0
hs.logger.defaultLogLevel = "info"

local window = require 'hs.window'

hyper = {"cmd", "alt", "shift", "ctrl"}
meh = {"alt", "shift", "ctrl"}

hs.loadSpoon("SpoonInstall")

Install=spoon.SpoonInstall
Install:andUse("WindowGrid", {
    config = { gridGeometries = { { "10x3" } } },
    hotkeys = { show_grid = {{"alt"}, "g"} },
    start = true
})
Install:andUse("WindowScreenLeftAndRight", {
    hotkeys = {
        screen_left  = { hyper, "[" },
        screen_right = { hyper, "]" },
    }
})
Install:andUse("WinWin")
Install:andUse("CountDown")
Install:andUse("DismissNotifications", {
    hotkeys = {
        all = {hyper, "'"}
    }
})
Install:andUse("FadeLogo", {
    config = {
        default_run = 1.0,
    },
    start = true
})
Install:andUse("Caffeine", {
    start   = true,
    hotkeys = { toggle = { hyper, "1" } },
})
spoon.Caffeine:clicked() -- start caffeine by default
Install:andUse("Keychain")
Install:andUse("Token", {
    hotkeys = {
        generate = { {"alt", "ctrl"} , "h"}
    },
    config = { secret_key = "token_tunnel" }})
Install:andUse("MoveSpaces", {
    hotkeys = {
        space_right = { {'ctrl','shift'}, '.' },
        space_left  =  { {'ctrl','shift'}, ',' }
    }
})
Install:andUse("Reload", {
    hotkeys = { reload = {{"cmd", "shift", "ctrl"}, "R"} }
})
Install:andUse("Tunnelblick", {
    config = {
        username        = "tyler.thrailkill",
        password_fn     = function() return spoon.Keychain:login_keychain("token_tunnel_pass") .. spoon.Token:get_token() end,
        connection_name = "promontech-openvpn"
    }
})
Install:andUse("Pastebin", {
    config = {
        api_dev_key  = spoon.Keychain:login_keychain("pastebin_dev_key"),
        api_user_key = spoon.Keychain:login_keychain("pastebin_user_key")
    },
    loglevel = "debug"
})
Install:andUse(
  "PersonalHotspot",
  {
    config = {
      hotspotName = "Tyler’s Phone",
      appsToKill = {
        "Dropbox"
      }
    }
  }
)
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
        -- Curried function so it isn't called immediately
        id = function(id) return function () hs.application.launchOrFocusByBundleID(id) end end

        app_keymap = {
            [s.singleKey('s', 'Electron')] = id('com.thegoddessinari.rambox'),
            [s.singleKey('d', 'Fantastical')] = id('com.flexibits.fantastical2.mac'),
            [s.singleKey('f', 'Firefox')] = id('org.mozilla.firefox'),
            [s.singleKey('t', 'iTerm')] = id('com.googlecode.iterm2'),
            [s.singleKey('e', 'Postbox')] = id('com.postbox-inc.postbox'),
            [s.singleKey('l', 'Sublime Text')] = id('com.sublimetext.3'),
            [s.singleKey('m', 'Messages')] = id('com.apple.iChat'),
            [s.singleKey('y', 'Spotify')] = id('com.spotify.client'),
            [s.singleKey('i', 'IDEA')] = id('com.jetbrains.intellij-EAP'),
            [s.singleKey('r', 'RubyMine')] = id('com.jetbrains.rubymine'),
            [s.singleKey('g', 'SourceTree')] = id('com.torusknot.SourceTreeNotMAS'),
            [s.singleKey('c', 'VS Code')] = id('com.microsoft.VSCode'),
            [s.singleKey('k', 'Kitematic')] = id('com.electron.kitematic'),
            [s.singleKey('p', 'Postman')] = id('com.postmanlabs.mac'),
            [s.singleKey('o', 'OneNote')] = id('com.microsoft.onenote.mac'),
            [s.singleKey('n', 'Canary')] = id('com.google.Chrome.canary'),
        }
        hs.hotkey.bind('alt', 'f', s.recursiveBind(app_keymap))

        resize_keymap = {
            [s.singleKey('f', 'fullscreen')] = function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("fullscreen") end,
            [s.singleKey('h', 'Lefthalf of Screen')] = function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfleft") end,
            [s.singleKey('l', 'Righthalf of Screen')] = function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfright") end,
            [s.singleKey('space', 'super fulls creen')] = function() 
                local win = window.focusedWindow()
                -- println(win)
                if win ~= nil then
                    win:setFullScreen(not win:isFullScreen())
                end
            end,
        }
        hs.hotkey.bind('alt', 'r', s.recursiveBind(resize_keymap))

        tools_keymap = {
            [s.singleKey('f', 'file visible')] = function() hs.eventtap.keyStroke({'cmd', 'shift'}, '.') end,
            [s.singleKey('t', 'tunnelblick')] = function() spoon.Tunnelblick:connect() end,
            [s.singleKey('h', 'hammerspoon console')] = function() hs.toggleConsole() end,
            [s.singleKey('v', 'paste unblocker')] = function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end,
            [s.singleKey('s', 'spotify song')] = function() hs.spotify.displayCurrentTrack() end,
            [s.singleKey('p', 'pastebin')] = function() spoon.Pastebin:paste() end,
            [s.singleKey('h', 'hotspot')] = function() spoon.PersonalHotspot:toggle() end,
            [s.singleKey('u', 'trigger notification')] = function() hs.notify.new({title = 'Break Time', informativeText = "TAKE A BREAK!!!", autoWithdraw = false, withdrawAfter = 0}):send() end,
            [s.singleKey('n', 'notifications')] = {
                [s.singleKey('a', 'dismiss all')] = function() 
                hs.osascript.applescript(
                    string.format(
                    [[
                    tell application "System Events" to tell process "Notification Center"
                        click button 1 in every window
                    end tell
                    ]]
                    )
                )
                end,
                [s.singleKey('s', 'click secondary')] = function()
                    hs.osascript.applescript(
                        string.format(
                            [[
                            tell application "System Events" to tell process "Notification Center"
                                try
                                    click button 2 of last item of windows
                                end try
                            end tell
                        ]]
                        )
                    )
                end
            }
        }
        hs.hotkey.bind('alt', 't', s.recursiveBind(tools_keymap))
        
        bookmarks_keymap = {}
        hs.hotkey.bind('alt', 'b', s.recursiveBind(bookmarks_keymap))

        keymap = {
            [s.singleKey('b')] = bookmarks_keymap,
            [s.singleKey('q', 'find+')] = {
                [s.singleKey('D', 'Desktop')] = function() openWithFinder('~/Desktop') end,
                [s.singleKey('p', 'Project')] = function() openWithFinder('~/p') end,
                [s.singleKey('d', 'Download')] = function() openWithFinder('~/Downloads') end,
                [s.singleKey('a', 'Application')] = function() openWithFinder('~/Applications') end,
                [s.singleKey('h', 'home')] = function() openWithFinder('~') end,
                [s.singleKey('f', 'hello')] = function() hs.alert.show('hello!') end
            },
            [s.singleKey('t', 'tools+')] = tools_keymap,
            [s.singleKey('a', 'apps+')] = app_keymap,
            [s.singleKey('r', 'resize+')] = resize_keymap,
        }

        hs.hotkey.bind('alt', 'q', s.recursiveBind(keymap))
    end
})

hs.hotkey.bindSpec({"alt", "h"}, 'Show Window Hints', function() hs.hints.windowHints() end)

spaces = require("hs._asm.undocumented.spaces")
spotify_watcher = hs.application.watcher.new(function(app_name, event_type, app)
    if (app_name == 'Spotify' and hs.application.watcher.launched == event_type) then
        local win = app:mainWindow()
        if win ~= nil then
            local currentSpace = spaces.activeSpace()
            win:setFullScreen(true)
            repeat until win:isFullScreen()
            -- timer = hs.timer.delayed.new(2, function()  end)
            -- timer:start()
            spaces.changeToSpace(currentSpace)
        end

    end

end)
-- spotify_watcher:start()

function walk_around_notification() 
    print("sending notification to take a break")
    hs.notify.new({title = 'Break Time', informativeText = "TAKE A BREAK!!!", autoWithdraw = false, withdrawAfter = 0}):send()
end
notify_table = {}
for h=8,18 do 
    print("creating timer for " .. h .. ":00")
    table.insert(notify_table,
        hs.timer.doAt(h..":00","1d", function () 
            print("sending notification to take a break at " .. h .. ": 00")
            hs.notify.new({title = 'Break Time', informativeText = "TAKE A BREAK!!!", autoWithdraw = false, withdrawAfter = 0}):send()
        end)
    )
    print("creating timer for " .. h .. ":30")
    table.insert(notify_table,
        hs.timer.doAt(h..":30","1d", function () 
            print("sending notification to take a break at " .. h .. ": 30")
            hs.notify.new({title = 'Break Time', informativeText = "TAKE A BREAK!!!", autoWithdraw = false, withdrawAfter = 0}):send()
        end)
    ) 
end

-- bundleID = "com.google.Chrome.app.Default-ffkcnngijbamigpamhifoipldnddpfbj"
-- hs.urlevent.openURLWithBundle("https://promontech.atlassian.net/browse/LP-14215", bundleID)