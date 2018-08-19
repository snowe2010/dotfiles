--- === TimedExecution ===
---
--- Send clipboard contents to TimedExecution
---
--- Conversion of tldm's pastebin gist to a Spoon https://gist.github.com/tdlm/5eba0299f2924a8aaf46
--- Code by @tdlm, spoon by Tyler Thrailkill <tyler.b.thrailkill@gmail.com>
---
--- https://github.com/snowe2010

local obj = {}
obj.__index = obj

-- Metadata
obj.name = 'TimedExecution'
obj.version = '1.0'
obj.author = 'Tyler Thrailkill <tyler.b.thrailkill@gmail.com>'
obj.license = 'MIT - https://opensource.org/licenses/MIT'

--- TimedExecution.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new('TimedExecution')

--- TimedExecution.starting_at
--- Variable
--- String 
obj.starting_at = nil

--- TimedExecution.ending_at
--- Variable
--- String 
obj.ending_at = nil

--- TimedExecution.every
--- Variable
--- String representing the delay between running your function. 
--- Examples:
---   * "00:20" - every 20 minutes
---   * "01:00" - every hour
obj.every = nil

--- TimedExecution:start()
--- Method
--- Start a timer that runs a function every N minutes
function obj:start(private, expire, format)
   
end

return obj
