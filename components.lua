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

local smoothly = function (x, y)
    if x == nil then
        return {
            name = "smoothly",
            sx = 0,
            sy = 0,
        }
    else
        return {
            name = "smoothly",
            sx = x,
            sy = y,
        }
    end
end

-- {{0, 0}}
local nextMove = function (list)
    return {
        name = "nextMove",
        nextMoving = list,
    }
end

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
        local function drawPath(path)
            local tex = graphics.newTexture({
                type = "canvas",
                width = 512,
                height = 512,
            })

            -- todo 

            return tex
        end

        -- todo 

        return drawPath()
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

return {
    appearance = appearance,
    position = position,
    nextMove = nextMove,
    shape = shape,
    controlled = controlled,
    isCanMoveOtherSide = isCanMoveOtherSide,
}