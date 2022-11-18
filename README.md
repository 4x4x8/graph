# Graph
Graph is library for graphics functions for ComputerCraft.

# How to use:
First you need to create folder and place Graph with [pxl](https://github.com/4x4x8/pxl) in it.


and just create new Graph object.
```lua
-- size, marks_step, graph_step, marks, graph_color, color, background, monitor
local lib = require "graph"
local graph = lib.new({{-50, 50},{-50,50}}, 10, 3, true, colors.blue, colors.white, colors.black, term)
```

Now about parameters:
```lua
--[[
size: {{x_from, x_to}, {y_from, y_to}} -- size of the graph
marks_step: 0-inf                            -- step of marks iterator
graph_step: 0-inf                      -- graph iteration step
marks: true-false                      -- shows marks on every marks step iterator
graph_color: colors.(color)            -- color of graph line.
color:       colors.(color)            -- color of graph axises.
background:  colors.(color)            -- background color
monitor:     (cc monitor)              -- monitor where we display graphic.
]]
```

Then we give it a function:
```lua
graph:process(function(x) return x^2 end)
```
and then just render:
```lua
graph:render(60,60) -- X,Y position
```

# IM LAZY TO MAKE IT BIGGER OR SOMETHING PLEASE LIKE IT OK??
