-- src/Core/MathUtils.lua
local MathUtils = {}

-- Değeri belirli aralıkta tutar (Clamp/Saturate)
function MathUtils.saturate(val)
    return math.max(0, math.min(1, val))
end

-- Basit yuvarlama
function MathUtils.round(x, n)
    n = n or 0
    local m = 10^n
    return math.floor(x * m + 0.5) / m
end

-- Zaman bazlı yumuşatma (Exponential Moving Average)
-- Bu, C++'taki alçak geçiren filtre (Low Pass Filter) mantığıdır.
function MathUtils.smooth(currentValue, targetValue, dt, smoothingFactor)
    local alpha = MathUtils.saturate(dt * smoothingFactor)
    return currentValue + (targetValue - currentValue) * alpha
end

return MathUtils