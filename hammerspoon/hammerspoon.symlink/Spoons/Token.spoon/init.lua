--- === Token ===
---
--- generate google authenticator token value keystrokes
--- Retrieve a google authenticator token seed from keychain and use this to calculate the current value
--- Simulate keystrokes for this token value
---
--- written by Teun Vink <github@teun.tv>, converted to spoon by Tyler Thrailkill <snowe>
---
--- https://github.com/teunvink/hammerspoon
local obj={}
obj.__index = obj

-- Metadata
obj.name = "Token"
obj.version = "1.0"
obj.author = "Teun Vink <github@teun.tv>"
obj.homepage = "https://github.com/teunvink/hammerspoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

function obj:init()
end


-- Internal function used to find our location, so we know where to load files from
local function script_path()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end
obj.spoonPath = script_path()

local gauth = dofile(obj.spoonPath.."/gauth.lua")

-- code is based on:
--   https://github.com/imzyxwvu/lua-gauth/blob/master/gauth.lua (with small modifications)
--   https://github.com/kikito/sha.lua

-- read a password from a keychain
function password_from_keychain(name)
    -- 'name' should be saved in the login keychain
    local cmd="/usr/bin/security 2>&1 >/dev/null find-generic-password -gl " .. name .. " | sed -En '/^password: / s,^password: \"(.*)\"$,\\1,p'"
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
    return (result:gsub("^%s*(.-)%s*$", "%1"))
end

-- read a token seed from keychain, generate a code and make keystrokes for it
function token_keystroke(token_name)
    local token = password_from_keychain(token_name)
    local hash = gauth.GenCode(token, math.floor(os.time() / 30))

    -- generate keystrokes for the result
    hs.eventtap.keyStrokes(("%06d"):format(hash))
end

function obj:bindHotKeys(keys)
    hs.hotkey.bind(keys["hotkey"][1], keys["hotkey"][2], function()
        spoon.Token:token_keystroke(keys["keychain_label"])
    end)
end

return obj