spaces = require("hs._asm.undocumented.spaces")

-- hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "W", function()
--   hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
-- end)

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

-- local laptopScreen = "Color LCD"
--   local windowLayout = {
--       {"Postbox",       nil, laptopScreen, hs.layout.left50,    nil, nil},
--       {"Fantastical 2", nil, laptopScreen, hs.layout.right50,   nil, nil},
--       {"Slack",         nil, laptopScreen, hs.layout.maximized, nil, nil},
--       {"Messages",      nil, laptopScreen, nil, nil, hs.geometry.rect(0, -48, 400, 48)},
--   }
--   hs.layout.apply(windowLayout)

-- get the user space for the space number. if a 
getSpace = function(spaceNumber) 
  a = spaces.layout()

  for k, v in pairs(a) do
    print(k, v)
    if (k == spaceNumber) then return v end
    for g, h in pairs(v) do
      print(g, h) 
      if (g == spaceNumber) then return h end
    end
  end
end

printSpaces = function() 
  local layout = spaces.layout()
  local activeSpaceId = spaces.activeSpace()
  local laptopScreen = "Color LCD"
  local ultrawide = "LG ULTRAWIDE"

  for k, v in pairs(layout) do
    print(k, v)
    if (k == spaceNumber) then return v end
    for g, h in pairs(v) do
      print(g, h)
      if (h == activeSpaceId) then
        print("owned")
      elseif next(spaces.spaceOwners(h)) ~= nil then
        print("owned")
      else
        print("not owned")
      end
    end
  end
end

moveAppToSpace = function(appName, space)
  print("moving app " .. appName .. " to space " .. space)
  pirs = hs.application.get(appName):allWindows()
  print(pirs)
  for k,v in pairs(pirs) do 
    print('pair keys:')
    print(k, v)
    print(v:id()) 
    print("moving window " .. space)
    spaces.moveWindowToSpace(v:id(), getSpace(space))
  end
end

-- print(doesSpaceExist(3))

recreateAllSpaces = function() 
  local layout = spaces.layout()
  local activeSpaceId = spaces.activeSpace()
  local laptopScreen = "Color LCD"
  local ultrawide = "LG ULTRAWIDE"

  for k, v in pairs(layout) do
    print(k, v)
    if (k == spaceNumber) then return v end
    for g, h in pairs(v) do
      print(g, h)
      if (h == activeSpaceId) then
        print("owned")
      elseif next(spaces.spaceOwners(h)) ~= nil then
        print("owned")
      else
        print("not owned")   
        spaces.removeSpace(h, true)
      end
    end
  end

  local screen1Id = activeSpaceId
  local screen2Id = spaces.createSpace()
  local screen3Id = spaces.createSpace()
  local screen4Id = spaces.createSpace(true)

  local newLayout = spaces.layout()
  for k, v in pairs(newLayout) do
    for g,h in pairs(v) do
      print(g, h)
    end
  end
  
end
printSpaces()
hs.application.launchOrFocus("Spotify")
hs.window.focusedWindow():setFullScreen(false)
-- recreateAllSpaces()
-- moveAppToSpace('Sublime Text', 2)