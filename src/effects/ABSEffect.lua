-- src/Effects/ABSEffect.lua
local MathUtils = require('src/Core/MathUtils')

local ABSEffect = {}
ABSEffect.__index = ABSEffect

-- Constructor
function ABSEffect.new(gainSetting)
    local self = setmetatable({}, ABSEffect)
    self.gain = gainSetting or 0.5
    self.frequency = 15 -- 
    self.currentForce = 0 -- 
    return self
end

-- calculate metodu
function ABSEffect:calculate(carPhysics, simTime)
    -- check wheel status for force feedback
    local absLeft = carPhysics.wheels[0].abs
    local absRight = carPhysics.wheels[1].abs
    local totalAbs = absLeft + absRight

    if totalAbs <= 0.01 then
        self.currentForce = 0
        return 0
    end

    -- sinusoidal wave calculation
    local wave = math.sin(simTime * self.frequency * 2 * math.pi)
    
    -- better mechanical feel with some random jitter
    local jitter = 0.8 + math.random() * 0.4

    -- caltulate final force
    self.currentForce = wave * self.gain * jitter
    return self.currentForce
end

return ABSEffect