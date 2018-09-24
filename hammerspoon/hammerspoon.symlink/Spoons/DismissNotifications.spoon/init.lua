--- === DismissNotifications ===
---
--- Send clipboard contents to DismissNotifications
---
--- Conversion of tldm's pastebin gist to a Spoon https://gist.github.com/tdlm/5eba0299f2924a8aaf46
--- Code by @tdlm, spoon by Tyler Thrailkill <tyler.b.thrailkill@gmail.com>
---
--- https://github.com/snowe2010

local obj = {}
obj.__index = obj

-- Metadata
obj.name = 'DismissNotifications'
obj.version = '1.0'
obj.author = 'Tyler Thrailkill <tyler.b.thrailkill@gmail.com>'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

--- DismissNotifications.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new('DismissNotifications')

function obj:dismiss_all()
    code, output, descriptor =
        hs.osascript.applescript(
        string.format(
            [[
        tell application "System Events" to tell process "Notification Center"
            click button 1 in every window
        end tell
        ]]
        )
    )
    obj.logger.df('Dismissed all notifications [code=%s, output=%s, descriptor=%s]', code, output, descriptor)
end

function obj:dismiss_top()
    code, output, descriptor =
        hs.osascript.applescript(
        string.format(
            [[
            tell application "System Events" to tell process "Notification Center"
                try
                    click button 1 of last item of windows
                end try
            end tell
        ]]
        )
    )
    obj.logger.df('Dismissed top notification [code=%s, output=%s, descriptor=%s]', code, output, descriptor)
end


function obj:click_top()
    code, output, descriptor =
        hs.osascript.applescript(
        string.format(
            [[
            tell application "System Events" to tell process "Notification Center"
                try
                    click last item of windows
                end try
            end tell        ]]
        )
    )
    obj.logger.df('Clicked top notification [code=%s, output=%s, descriptor=%s]', code, output, descriptor)
end


function obj:click_top_secondary()
    code, output, descriptor =
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
    obj.logger.df('Clicked top secondary button [code=%s, output=%s, descriptor=%s]', code, output, descriptor)
end

--- DismissNotifications:bindHotkeys(mapping)
--- Method
--- Binds hotkeys for DismissNotifications
---
--- Parameters:
---  * mapping - A table containing hotkey objifier/key details for the following items:
---   * all - dismiss all notifications
---   * top - dismiss the top notification
---   * top_click - click the top notification
---   * top_secondary - click the top notifications second option
function obj:bindHotkeys(keys)
    hs.hotkey.bindSpec(
        keys['all'],
        'Dismiss all notifications',
        function()
            self.dismiss_all()
        end
    )
end

return obj
