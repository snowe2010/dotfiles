--- === Reload Hammerspoon ===
---
--- Reload Hammerspoon. Includes ability to clear console
---
--- Tyler Thrailkill <tyler.b.thrailkill@gmail.com>
---
--- https://github.com/snowe2010

local obj = {}
obj.__index = obj

-- Metadata
obj.name = 'Reload'
obj.version = '1.0'
obj.author = 'Tyler Thrailkill <tyler.b.thrailkill@gmail.com>'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

--- Reload.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new('Reload')

--- Reload.clearConsole
--- Variable
--- Boolean setting whether to clear the Hammerspoon console upon reload. Default is true
obj.clearConsole = true

local function reload() 
    if obj.clearConsole then
        hs.console.clearConsole()
        obj.logger.d("obj.clearConsole was set to true")
    end
    obj.logger.d("Reloading")
    hs.reload()
end

--- Reload:bindHotkeys(mapping)
--- Method
--- Binds hotkeys for Reload
---
--- Parameters:
---  * mapping - A table containing hotkey objifier/key details for the following items:
---   * reload - reload Hammerspoon
function obj:bindHotkeys(keys)
    hs.hotkey.bindSpec(keys['reload'], 'Reload Configuration',
        function()
            reload()
        end
    )
end

return obj
