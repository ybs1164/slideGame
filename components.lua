local appearance = function ()
    return {
        name = "appearance",
        isEnable = true,
    }
end

local position = function (x, y)
    if x == nil then
        return {
            name = "position",
            x = 0,
            y = 0,
        }
    else
        return {
            name = "position",
            x = x, 
            y = y,
        }
    end
end

local shape = function (display, color)
    if color == nil then
        color = {0, 0, 0}
    end
    display:setFillColor(unpack(color));
    return {
        name = "shape",
        display = display,
        color = color,
    }
end

local playerControlled = function ()
    return {
        name = "playerControlled",
        isEnable = true,
    }
end

local enemyControlled = function ()
    return {
        name = "enemyControlled",
        isEnable = true,
    }
end

return {
    appearance = appearance,
    position = position,
    shape = shape,
    playerControlled = playerControlled,
    enemyControlled = enemyControlled,
}