local move = function(pos, dir, cmo, smooth) -- can move other side
    local isAbove = function (pos)
        local x, y = unpack(pos)
        return x < 0 or x >= game.map.size or y < 0 or y >= game.map.size
    end

    local dx, dy = unpack(dir)

    if cmo then
        pos.x = pos.x + dx
        pos.y = pos.y + dy
        if isAbove({pos.x, pos.y}) then 
            pos.x = (pos.x + game.map.size)%game.map.size
            pos.y = (pos.y + game.map.size)%game.map.size
        end
        return true
    elseif not isAbove({pos.x + dx, pos.y + dy}) then
        pos.x = pos.x + dx
        pos.y = pos.y + dy
        return true
    end

    return false
end

return {
    move = move
}