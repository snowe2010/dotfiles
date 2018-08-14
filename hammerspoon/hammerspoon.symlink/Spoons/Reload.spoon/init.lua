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

function obj:init()
end

local function reload()
    if obj.clearConsole then
        hs.console.clearConsole()
        hs.reload()
    end
end

function obj:bindHotkeys(keys)
    hs.hotkey.bindSpec(keys['reload'], 'Reload Configuration',
        function()
            print("here")
            reload()
        end
    )
end

return obj
