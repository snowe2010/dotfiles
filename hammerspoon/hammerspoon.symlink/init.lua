hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0
hs.logger.defaultLogLevel = "info"

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
Install:andUse("Token", {config = { secret_key = "token_tunnel" }})
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
        connection_name = "promontech-openvpn-test"
    }
})
Install:andUse("Pastebin", {
    hotkeys = {
        paste = { "cmd", "1" }
    },
    config = {
        api_dev_key  = spoon.Keychain:login_keychain("pastebin_dev_key"),
        api_user_key = spoon.Keychain:login_keychain("pastebin_user_key"),
        expire       = "N",
        format       = "dfljkdfklj"
    },
    loglevel = "debug"
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

function doIt()
    local GITHUB_API_PATH = "https://api.github.com"
    local GITHUB_API_USER = "snowe2010"
    local GITHUB_API_TOKEN = spoon.Keychain:login_keychain("github_api_key")
    local GITHUB_REPOS = {
      "promontech/lp-server"
    }
    
    local rate_limit_percentage
    
    local menu_bar_refresh_time = 60
    local menu_bar = hs.menubar.new()
    local menu_items = {}
    
    menu_bar:setTitle("0")
    
    -- Helper: get table length
    function get_table_length(T)
      local count = 0
      for _ in pairs(T) do count = count + 1 end
      return count
    end
    
    -- Helper: do pull request from Github
    function get_pull_requests(repo, callback)
        hs.http.doAsyncRequest(
            GITHUB_API_PATH .. "/repos/" .. repo .. "/pulls",
            "GET",
            "",
            {
                Authorization = "Basic " .. hs.base64.encode(GITHUB_API_USER .. ":" .. GITHUB_API_TOKEN)
            },
            function (code, body, headers)
                if code == 200 then
                    local decoded_body = hs.json.decode(body)
                    callback(decoded_body)
                else
                    print("Error: The code was", code)
                    print(hs.inspect(headers))
                    callback(nil)
                end
                
                rate_limit_percentage = 100 - (( headers["X-RateLimit-Remaining"] / headers["X-RateLimit-Limit"] ) * 100)
                print(tostring(rate_limit_percentage) .. "%", "rate limit used")
            end
        )
    end
    
    -- Build menu over again
    function build_menu()
        local pull_requests
    
        menu_items = {}
        table.insert(menu_items, {
            title = "Refresh",
            fn = function() build_menu() end
        })
    
        for repo_key,repo in pairs(GITHUB_REPOS) do
            get_pull_requests(repo, function (decoded_body)
                
                if decoded_body == nil then
                    print("There was an error trying to retrieve the pull requests!")
                end
    
                pull_requests = decoded_body
    
                for k,v in pairs(pull_requests) do
                    table.insert(menu_items, {
                        title = repo .. ": "..v.title,
                        fn = menu_item_callback(v.number),
                        number = v.number,
                        html_url = v.html_url
                    })
                end
    
                menu_bar:setTitle(tostring(get_table_length(menu_items) - 1))
                menu_bar:setMenu(menu_items)
            end)
        end
    
        buildMenuTimer = hs.timer.doAfter(menu_bar_refresh_time, function() build_menu() end)
    end
    
    -- Action: open url in default browser
    function open_url_in_browser(url)
        hs.urlevent.openURLWithBundle(url, hs.urlevent.getDefaultHandler('http'))
    end
    
    -- Callback: for menu item
    function menu_item_callback(item_id)
        return function()
            for k,v in pairs(menu_items) do
                if item_id == v.number then
                    open_url_in_browser(v.html_url)
                    return
                end
            end
        end
    end
    
    build_menu()
end


Install:andUse("RecursiveBinder", {
    fn = function(s)
        -- Curried functions so they aren't called immediately
        id = function(id) return function () hs.application.launchOrFocusByBundleID(id) end end
        name = function(name) return function () hs.application.launchOrFocus(name) end end
        key = function(table, key, name, id) 
            table[s.singleKey(key, name)] = id
        end

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

        tools_keymap = {
            [s.singleKey('f', 'file visible')] = function() hs.eventtap.keyStroke({'cmd', 'shift'}, '.') end,
            [s.singleKey('t', 'tunnelblick')] = function() spoon.Tunnelblick:connect() end,
            [s.singleKey('h', 'hammerspoon console')] = function() hs.toggleConsole() end,
            [s.singleKey('v', 'paste unblocker')] = function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end,
            [s.singleKey('s', 'spotify song')] = function() hs.spotify.displayCurrentTrack() end,
            [s.singleKey('p', 'pull requests')] = function() doIt() end
        }
        hs.hotkey.bind('alt', 't', s.recursiveBind(tools_keymap))
        
        bookmarks_keymap = {}
        hs.hotkey.bind('alt', 't', s.recursiveBind(tools_keymap))

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

        hs.hotkey.bind('alt', 'f', s.recursiveBind(keymap))
    end
})

hs.hotkey.bindSpec({"alt", "h"}, 'Show Window Hints', function() hs.hints.windowHints() end)
