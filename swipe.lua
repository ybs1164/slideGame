local touchTimeMax = 300
local touchTimer = nil
local minDistance = 5
local revPos = {0, 0}
local f = nil

local function test()
    touchTimer = nil
end

local function setFunc(g)
    f = g
end

local function swipe(evt)
    if evt.phase == "began" then
        touchTimer = timer.performWithDelay(
            touchTimeMax,
            test
        )
        revPos = {evt.x, evt.y}
    elseif evt.phase == "ended" then
        if touchTimer ~= nil then
            timer.cancel(touchTimer)
            touchTimer = nil

            local rx, ry = unpack(revPos)
            rx = evt.x - rx
            ry = evt.y - ry

            local dis = math.sqrt(rx*rx+ry*ry)

            if dis > minDistance then
                local dir = math.atan2(ry, rx)
                local dirList = {
                    -math.pi * 0.75,
                    -math.pi * 0.5,
                    -math.pi * 0.25,
                    0,
                    math.pi * 0.25,
                    math.pi * 0.5,
                    math.pi * 0.75,
                    math.pi,
                    -math.pi
                }
                local dList = {
                    {-1, -1},
                    {0, -1},
                    {1, -1},
                    {1, 0},
                    {1, 1},
                    {0, 1},
                    {-1, 1},
                    {-1, 0},
                    {-1, 0}
                }
                local function getDirection()
                    for k, v in ipairs(dirList) do
                        if v + math.pi*0.125 > dir and v - math.pi*0.125 <= dir then
                            return k
                        end
                    end
                end

                if f ~= nil then
                    f(dList[getDirection()])
                end
            end
        end
    end
end

return { swipe, setFunc }