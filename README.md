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
marks_step: 0-inf                      -- step of marks iterator
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

# Examples of functions:
graph_step = 3

Parabola | y=x^2

![image](https://user-images.githubusercontent.com/83549287/202788536-5b7e5559-be3b-49f5-bdbc-a180b7419c08.png)

Cubic function | y=x^3

![image](https://user-images.githubusercontent.com/83549287/202788929-f1f63cab-51f1-447b-8f5a-14d1f6558301.png)

Absolute Value Function | y=abs(x)

![image](https://user-images.githubusercontent.com/83549287/202789064-b2b16a94-e84d-4b18-99d8-a4b6fcb0d90d.png)


# IM LAZY TO MAKE IT BIGGER OR SOMETHING PLEASE LIKE IT OK??
