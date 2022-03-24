local render = function (entities)

    local function getRealPosition(pos)
        local x = pos.x * grid + start + grid/2 + game.map.width/2
        local y = pos.y * grid + start + grid/2 + game.map.height/2
        return x, y 
    end

    local function draw(app, pos, sha)
        sha.display.isVisible = app.isEnable
        if not app.isEnable then
            return
        end

        x, y = getRealPosition(pos)

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

    local move = function(pos, cmo)
        local isAbove = function (pos)
            x, y = unpack(pos)
            return x < 0 or x >= game.map.size or y < 0 or y >= game.map.size
        end

        dx, dy = unpack(dir)

        if cmo and cmo.isEnable then
            pos.x = pos.x + dx
            pos.y = pos.y + dy
            if isAbove({pos.x, pos.y}) then 
                pos.x = pos.x % game.map.size
            end
        elseif isAbove({pos.x + dx, pos.y + dy}) then
            pos.x = pos.x + dx
            pos.y = pos.y + dy
        end
    end

    for key, entity in ipairs(entities) do
        local curComponents = entity.getComponents()
        
        if curComponents.appearance and curComponents.position then
            move(curComponents.position, curComponents.isCanMoveOtherSide)
        end
    end
end

return {
    render= render,
    movement= movement,
    controller= controller
}