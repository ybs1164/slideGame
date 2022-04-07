-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local components = require("components")
local systems = require("systems")
local getEntity = require("entity")
local swipe, setSwipeFunc = unpack(require("swipe"))

local function printTable( t )
 
    local printTable_cache = {}
 
    local function sub_printTable( t, indent )
 
        if ( printTable_cache[tostring(t)] ) then
            print( indent .. "*" .. tostring(t) )
        else
            printTable_cache[tostring(t)] = true
            if ( type( t ) == "table" ) then
                for pos,val in pairs( t ) do
                    if ( type(val) == "table" ) then
                        print( indent .. "[" .. pos .. "] => " .. tostring( t ).. " {" )
                        sub_printTable( val, indent .. string.rep( " ", string.len(pos)+8 ) )
                        print( indent .. string.rep( " ", string.len(pos)+6 ) .. "}" )
                    elseif ( type(val) == "string" ) then
                        print( indent .. "[" .. pos .. '] => "' .. val .. '"' )
                    else
                        print( indent .. "[" .. pos .. "] => " .. tostring(val) )
                    end
                end
            else
                print( indent..tostring(t) )
            end
        end
    end
 
    if ( type(t) == "table" ) then
        print( tostring(t) .. " {" )
        sub_printTable( t, "  " )
        print( "}" )
    else
        sub_printTable( t, "  " )
    end
end

game = {
    map = {
        size = 2,
        width = display.contentWidth,
        height = display.contentHeight,
        grid = (display.contentWidth - 150) / 2,
        start = -(display.contentWidth - 150 / 2),
    },
    turn = "player",
    cases = {
    }
}

local rect = nil

local function drawMap(map)
    local tex = graphics.newTexture({
        type = "canvas",
        width = map.width,
        height = map.height
    })
    local size = map.size
    local grid = map.grid
    local start = map.start

    tex:setBackground(1, 1, 1)

    local side = display.newRoundedRect(0, 0, size*grid, size*grid, 3)
    side:setStrokeColor(-1, 0, 0)
    side.strokeWidth = 4
    tex:draw(side)

    for i = 1, size-1 do
        local line = display.newLine(start + i*grid, start, start + i*grid, start + size*grid)
        line:setStrokeColor(-1, 0, 0)
        line.strokeWidth = 4
        tex:draw(line)
    end

    for i = 1, size-1 do
        local line = display.newLine(start, start + i*grid, start + size*grid, start + i*grid)
        line:setStrokeColor(-1, 0, 0)
        line.strokeWidth = 4
        tex:draw(line)
    end

    tex:invalidate()
    
    return tex
end

function setMap(size)
    game.map.size = size
    game.map.grid = (game.map.width - 150) / size
    game.map.start = -game.map.grid * size / 2

    local mapTex = drawMap(game.map)

    if rect ~= nil then
        rect:removeSelf()
    end

    rect = display.newImageRect(
        mapTex.filename,
        mapTex.baseDir,
        game.map.width,
        game.map.height
    )
    rect.x = display.contentCenterX
    rect.y = display.contentCenterY

    rect:addEventListener("touch", swipe)
end

local objects = {}

local function getGameStatus()
    local status = {}
    for _, object in ipairs(objects) do
        status[#status+1] = {
            x = object.x,
            y = object.y,
            id = object.name
        }
    end
    status.turn = game.turn

    return status
end

local function generateNextGameStatus(status)
    local function copy(value)
        if type(value) ~= 'table' then return value end
        local res = {}
        for k, v in pairs(value) do res[copy(k)] = copy(v) end
        return res
    end

    local nextGameList = {}
    if status.turn == "player" then

        nextGameList[#nextGameList+1] = copy(status)
        for _, object in ipairs(status) do
            local components = object.getComponents()
            if components.controlled and components.controlled.isEnable then
                if components.position and components.nextMove then
                    for i, v in components.nextMove.list do
                        
                    end
                end
            end
        end
    elseif status.turn == "enemy" then

    end
end

function generateAllGameStatus(status)
    -- todo 
end


setMap(4)

local player = getEntity()

player.addComponent(components.appearance())
player.addComponent(components.position(1, 1))
player.addComponent(components.nextMove({
    {1, 0},
    {1, 1},
    {0, 1},
    {-1, 1},
    {-1, 0},
    {-1, -1},
    {0, -1},
    {1, -1}
}))
player.addComponent(components.shape("circle", 0.7))
player.addComponent(components.isCanMoveOtherSide())
player.addComponent(components.controlled())

table.insert(objects, player)

local function controlPlayer(pos)
    if game.turn == "enemy" then
        return
    end
    if systems.controller(objects, pos) then
        game.turn = "enemy"
    end
end

setSwipeFunc(controlPlayer)

local function frame(evt)
    systems.render(objects)
end

Runtime:addEventListener("enterFrame", frame)