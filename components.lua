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

local nextMove = function (list)
    return {
        name = "nextMove",
        nextMoving = list,
    }
end

-- player only
local isCanMoveOtherSide = function ()
    return {
        name = "isCanMoveOtherSide",
        isEnable = true,
    }
end

local shape = function (type, radius, color)
    local displayObject = nil
    if type == "circle" then
        displayObject = display.newCircle(0, 0, radius * game.map.grid * 0.5)
    elseif type == "path" then
        -- todo
    end

    if color == nil then
        color = {0, 0, 0}
    end
    displayObject:setFillColor(unpack(color));
    return {
        name = "shape",
        display = displayObject,
        color = color,
    }
end

local controlled = function ()
    return {
        name = "controlled",
        isEnable = true,
    }
end

local enemy = function ()
    return {
        name = "enemy",
    }
end

return {
    appearance = appearance,
    position = position,
    shape = shape,
    controlled = controlled,
    enemy = enemy,
    isCanMoveOtherSide = isCanMoveOtherSide,
}