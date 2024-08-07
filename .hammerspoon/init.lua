local application = require("hs.application")
local spaces = require("hs.spaces")

hs.hotkey.bind({ "ctrl" }, "i", function()
  local appName = "Alacritty"
  local app = application.get(appName)

  if app == nil then
   application.launchOrFocus(appName)
  elseif app:isFrontmost() then
    app:hide()
  else
    local active_space = spaces.focusedSpace()
    local alacritty_win = app:focusedWindow()
    spaces.moveWindowToSpace(alacritty_win, active_space)
    app:setFrontmost()
  end
end)

