local Split = require("nui.split")
local event = require("nui.utils.autocmd").event

local split = Split({
  relative = "editor",
  position = "bottom",
  size = "20%",
})

-- mount/open the component
split:mount()

-- unmount component when cursor leaves buffer
split:on(event.BufLeave, function()
  split:unmount()
end)
