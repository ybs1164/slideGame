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

    for key, entity in pairs(entities) do
        local curComponents = entity.getComponents()
        if curComponents.appearance and curComponents.position and curComponents.shape then
            draw(curComponents.appearance, curComponents.position, curComponents.shape)
        end

        -- todo
    end
end

local movement = function (entities)

end

local controller = function (entities)
    for key, entity in ipairs(entities) do
        local curComponents = entity.getComponents()
        
        if curComponents.appearance and curComponents.position then
            if curComponents.playerControlled then
            elseif curComponents.enemyControlled then
            end
        end
    end
end

return {
    render= render,
    movement= movement,
    controller= controller
}