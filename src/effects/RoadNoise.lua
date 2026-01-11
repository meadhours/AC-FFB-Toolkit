-- src/Effects/RoadNoise.lua
local MathUtils = require('src/Core/MathUtils')

local RoadNoise = {}
RoadNoise.__index = RoadNoise

function RoadNoise.new(gainSetting)
    local self = setmetatable({}, RoadNoise)
    self.gain = gainSetting or 0.3
    self.currentForce = 0
    self.smoothedSpeed = 0
    return self
end

function RoadNoise:calculate(carPhysics, dt)
    local speedKmh = carPhysics.speedKmh

    -- smooth speed
    self.smoothedSpeed = MathUtils.smooth(self.smoothedSpeed, speedKmh, dt, 5)

    -- speed effect
    local speedFactor = MathUtils.saturate(self.smoothedSpeed / 150) -- 150 km/h'de max

    -- random road noise 
    local noise = (math.random() * 2 - 1) -- -1 ile 1 arası rastgele sayı

    self.currentForce = noise * speedFactor * self.gain * 0.1 -- 0.1 ile ölçekleme 
    return self.currentForce
end

return RoadNoise