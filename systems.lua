local method = require("lib.method")

local render = function (entities)

    local function getRealPosition(pos)
        local w, h = game.map.width, game.map.height
        local grid, start = game.map.grid, game.map.start

        local x = pos.x * grid + start + grid/2 + w/2
        local y = pos.y * grid + start + grid/2 + h/2

        return x, y 
    end

    local function draw(app, pos, sha)
        sha.display.isVisible = app.isEnable
        if not app.isEnable then
            return
        end

        local x, y = getRealPosition(pos)

        sha.display.x = x
        sha.display.y = y

    end

    for key, entity in ipairs(entities) do
        local curComponents = entity.getComponents()
        if curComponents.appearance and curComponents.position and curComponents.shape then
            draw(curComponents.appearance, curComponents.position, curComponents.shape)
        end

        -- todo
    end
end

local movement = function (entities)

end

local controller = function (entities, dir)
    for key, entity in ipairs(entities) do
        local curComponents = entity.getComponents()
        
        if curComponents.appearance and curComponents.position then
            if curComponents.controlled and curComponents.controlled.isEnable then
                method.move(
                    curComponents.position,
                    dir,
                    curComponents.isCanMoveOtherSide and curComponents.isCanMoveOtherSide.isEnable
                )
                return true
            end
        end
    end

    return false
end

return {
    render = render,
    move = move,
    movement = movement,
    controller = controller
}