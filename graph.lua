local graph = {}
local pxl = require "pxl"
local ABS, CEIL = math.abs, math.ceil

--[[
  graph is a library for making shit graphs with linear graphic functions or how this shit named
]]


local function CLAMP(x, min, max)
    if x < min then return min end
    if x > max then return max end
    return x
end

local function draw_line(canvas, x1, x2, y1, y2, color)
    if x1 == x2 and y1 == y2 then
        canvas[CEIL(y1-0.5)][CEIL(x1-0.5)] = color
        return
    end
    local function linelow(x1,y1,x2,y2)
        local dx = x2 - x1
        local dy = y2 - y1
        local yi = 1
        if dy < 0 then
            yi = -1
            dy = -dy
        end
        local D =  (2*dy)-dx
        local y = y1
        for x=x1, x2 do
            canvas[CEIL(y-0.5)][CEIL(x-0.5)] = color
            if D > 0 then
                y = y + yi
                D = D + (2 * (dy-dx))
            else
                D = D + 2*dy
            end
        end
    end

    local function linehight(x1,y1,x2,y2)
        local dx = x2 - x1
        local dy = y2 - y1
        local xi = 1
        if dx < 0 then
            xi = -1
            dx = -dx
        end
        local D =  (2*dx)-dy
        local x = x1
        for y=y1, y2 do
            canvas[CEIL(y-0.5)][CEIL(x-0.5)] = color
            if D > 0 then
                x = x + xi
                D = D + (2 * (dx-dy))
            else
                D = D + 2*dx
            end
        end
    end

    if ABS(y2 - y1) < ABS(x2 - x1) then
        if x1 > x2 then
            linelow(x2, y2, x1, y1)
        else
            linelow(x1, y1, x2, y2)
        end
    else
        if y1 > y2 then
            linehight(x2, y2, x1, y1)
        else
            linehight(x1, y1, x2, y2)
        end
    end
end

function graph.new(size, marks_step, graph_step, marks, graph_color, color, background, monitor)
    local self = setmetatable({},{__index = graph})
    self.size = size
    self.marks_step = marks_step or 1
    self.marks = marks
    self.color = color or colors.white
    self.graph_color = graph_color or colors.blue
    self.bg = background
    self.graph_step = graph_step or 1
    self.dots = {}
    self.graph = {}
    self.center = {CEIL((ABS(self.size[1][1]) + ABS(self.size[1][2]))-0.5)/2, CEIL(ABS(self.size[2][1]) + ABS(self.size[2][2])-0.5)/2}
    self.nums = {{}}
    self.canv = pxl.new(monitor, background or colors.black)
    -- graph base
    for i=0, CEIL((ABS(self.size[1][1]) + ABS(self.size[1][2]))-0.5) do
        table.insert(self.graph,{i, 0})
        self.nums[1][i] = self.size[1][1] + i
    end
    for i=0, CEIL(ABS(self.size[2][1]) + ABS(self.size[2][2])-0.5) do
        table.insert(self.graph,{0 + self.center[1], i - self.center[2]})
    end

    -- Marks
    if self.marks then
        for i=0, CEIL((ABS(self.size[1][1]) + ABS(self.size[1][2]))-0.5), marks_step do
            table.insert(self.graph,{i, -1})
            table.insert(self.graph,{i, 1})
        end

        for i=0, CEIL(ABS(self.size[2][1]) + ABS(self.size[2][2])-0.5), marks_step do
            table.insert(self.graph,{1 + self.center[1], i - self.center[2]})
            table.insert(self.graph,{-1 + self.center[1], i - self.center[2]})
        end
    end

    return self
end

function graph:process(f)
    self.dots = {}  
    pxl.restore(self.canv, self.bg)
    for x=0, CEIL((ABS(self.size[1][1]) + ABS(self.size[1][2]))-0.5), self.graph_step do
        table.insert(self.dots, {x,0-CLAMP(f(self.nums[1][x]), self.size[2][1], self.size[2][2])})
    end
end

function graph:render(x,y)
    x,y = x or self.center[1], y or self.center[2]
    local _x = 0
    local _y= 0
    for i=1, #self.graph do
        _x = CEIL((self.graph[i][1]+x)-0.5)
        _y = CEIL((self.graph[i][2]+y)-0.5)
        self.canv.canvas[_y][_x] = self.color
    end
    for i=1, #self.dots do
        local dot = self.dots[i]
        local n_dot = self.dots[i+1] or self.dots[i]
        draw_line(self.canv.canvas, dot[1]+x,
                                    n_dot[1]+x,
                                    dot[2]+y,
                                    n_dot[2]+y, self.graph_color)
    end
    self.canv:render()
end

return graph