local CELL = 10
local SIZE = CELL 
local WIDTH = love.graphics.getWidth()
local HEIGHT = love.graphics.getHeight()
-- Pour une bordure on met SIZE = CELL - 1

local Game = {
    rows = math.floor(HEIGHT / CELL),
    column = math.floor(WIDTH / CELL),
    board = {},
}

function Game:load()

end

return Game