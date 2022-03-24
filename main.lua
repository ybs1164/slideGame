-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local components = require("components")
local systems = require("systems")
local getEntity = require("entity")
local swipe, setFunc = unpack(require("swipe"))

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
        height = display.contentHeight
    },
    turn = "player",
}

function setMapSize(size)
    game.map.size = size
    grid = (game.map.width - 150) / size
    start = -grid * size / 2
end

setMapSize(4)


local objects = {}

local function drawMap(map)
    local tex = graphics.newTexture({
        type = "canvas",
        width = map.width,
        height = map.height
    })
    local size = map.size

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

local mapTex = drawMap(game.map)

local rect = display.newImageRect(
    mapTex.filename,
    mapTex.baseDir,
    game.map.width,
    game.map.height
)
rect.x = display.contentCenterX
rect.y = display.contentCenterY

rect:addEventListener("touch", swipe)

local player = getEntity()

player.addComponent(components.appearance())
player.addComponent(components.position(1, 1))
player.addComponent(components.shape(display.newCircle(0, 0, grid * 0.35)))
player.addComponent(components.isCanMoveOtherSide())

table.insert(objects, player)

local function move(pos)
    systems.controller(objects, pos)
end

setFunc(move)

local function frame(evt)
    systems.render(objects)
end

Runtime:addEventListener("enterFrame", frame)