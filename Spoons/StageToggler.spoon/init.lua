local obj = {}
obj.__index = obj

-- Metadata
obj.name = "StageManager"
obj.version = "1.0.0"
obj.license = "MIT - https://opensource.org/licenses/MIT"

local defaultsPath = '/usr/bin/defaults'
local windowManagerDomain = 'com.apple.WindowManager'
local globallyEnabledKey = 'GloballyEnabled'

function toggleStageManager ()
  hs.task.new(
    defaultsPath,
    function (exitCode, stdOut, stdErr)
      hs.task.new(
        defaultsPath,
        nil,
        {
          'write',
          windowManagerDomain,
          globallyEnabledKey,
          '-int',
          string.find(stdOut, '0') and '1' or '0'
        }
      ):start()
    end,
    {
      'read',
      windowManagerDomain,
      globallyEnabledKey
    }
  ):start()
end

hs.hotkey.bind({'shift', 'control'}, 'ESCAPE', toggleStageManager)

return obj
