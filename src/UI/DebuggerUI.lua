-- src/UI/DebuggerUI.lua
local DebuggerUI = {}
DebuggerUI.__index = DebuggerUI

function DebuggerUI.new(enabledSetting)
    local self = setmetatable({}, DebuggerUI)
    self.enabled = (enabledSetting == 1)
    return self
end

-- Efekt motorlarından gelen verileri alıp ekrana çiz
function DebuggerUI:render(absEffect, roadNoiseEffect)
    if not self.enabled then return end
    ui.beginTransparentWindow("Meka FFB Monitor", vec2(300, 100), vec2(20, 200))
    ui.text("Meka FFB Framework - Live Data")
    ui.separator()
    
    -- ABS Durumu için Bar 
    local absFill = math.abs(absEffect.currentForce) / absEffect.gain -- 0 ile 1 arası normalize et
    ui.text(string.format("ABS Effect (Force: %.2f)", absEffect.currentForce))
    -- Arka plan (gri), Doluluk (Kırmızı)
    ui.drawRectFilled(vec2(ui.getCursorX(), ui.getCursorY()), vec2(ui.getAvailableRegionWidth(), 10), rgbm(0.2, 0.2, 0.2, 0.5))
    ui.drawRectFilled(vec2(ui.getCursorX(), ui.getCursorY()), vec2(ui.getAvailableRegionWidth() * absFill, 10), rgbm(1, 0, 0, 0.8))
    ui.newLine(12)

    -- Road Noise Durumu için Bar
    local roadFill = math.abs(roadNoiseEffect.currentForce) / (roadNoiseEffect.gain * 0.1)
    ui.text(string.format("Road Noise (Force: %.2f)", roadNoiseEffect.currentForce))
    ui.drawRectFilled(vec2(ui.getCursorX(), ui.getCursorY()), vec2(ui.getAvailableRegionWidth(), 10), rgbm(0.2, 0.2, 0.2, 0.5))
    ui.drawRectFilled(vec2(ui.getCursorX(), ui.getCursorY()), vec2(ui.getAvailableRegionWidth() * roadFill, 10), rgbm(0, 0.5, 1, 0.8))

    ui.endWindow()
end

return DebuggerUI
