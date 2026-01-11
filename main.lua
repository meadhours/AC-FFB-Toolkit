-- main.lua

-- 1. settings
local settings = ac.INIConfig.scriptSettings()
local ABSEffect = require('src/Effects/ABSEffect')
local RoadNoise = require('src/Effects/RoadNoise')
local DebuggerUI = require('src/UI/DebuggerUI')
local absEngine = ABSEffect.new(settings.ABS_GAIN)
local roadNoiseEngine = RoadNoise.new(settings.ROAD_NOISE_GAIN)
local debugger = DebuggerUI.new(settings.DEBUG_UI_ENABLED)

local simTime = 0

-- update loop
function script.update(ffbInput, dt)
    simTime = simTime + dt
    
    local carPhysics = ac.getCarPhysics(0)
    local absForce = absEngine:calculate(carPhysics, simTime)
    local roadNoiseForce = roadNoiseEngine:calculate(carPhysics, dt)
    debugger:render(absEngine, roadNoiseEngine)
    return ffbInput + absForce + roadNoiseForce
end