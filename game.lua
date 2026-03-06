local CELL = 5
local SIZE = CELL -1
local WIDTH = love.graphics.getWidth()
local HEIGHT = love.graphics.getHeight()
-- Pour une bordure on met SIZE = CELL - 1

local Game = {
    rows = math.floor(HEIGHT / CELL),
    columns = math.floor(WIDTH / CELL),
    board = {},
    second_board = {},
    delay_target = 8,
    delay_count = 1,
}

-- Utilise rows et columns car dans la logique d'accès dans une liste on cherche par rows puis à l'intérieur columns

function Game:load()
    math.randomseed(os.time())

    -- Creation du board 
    for row = 1, self.rows do
        self.board[row] = {}
        self.second_board[row] = {}
        for column = 1, self.columns do
            self.board[row][column] = 0   
            self.second_board[row][column] = 0
        end
    end
    self:reset()
end
-- On créer le board avec des tables vides pour les rows et des 0 dans les collonnes

function Game:reset()
    for row, columns in ipairs(self.board) do
        for column, _ in ipairs(columns) do
            self.board[row][column] = love.math.random(0, 1)
        end
    end    
end

function Game:clear()
    for row, columns in ipairs(self.board) do
        for column, _ in ipairs(columns) do
            self.board[row][column] = 0
        end
    end    
end

function Game:update()
    if self.delay_count >= self.delay_target then
        for row, columns in ipairs(self.board) do
            for column, value in ipairs(columns) do
                local count = 0
                for y = row - 1, row + 1 do
                    for x = column, column + 1 do
                        if not (row == y and column == x) then -- ligne pour éviter de toucher au rectangle du centre
                            local wrapper_row = ((y - 1) % self.rows) + 1 -- modulo pour gérer les cas ou ça sortirait de l'écran
                            local wrapper_column = ((x - 1) % self.columns) + 1
                            count = count + self.board[wrapper_row][wrapper_column]
                        end
                    end
                end
                if value == 1 and count > 1 and count < 4 then 
                    self.second_board[row][column] = 1
                elseif value == 0 and count == 3 then 
                    self.second_board[row][column] = 1
                else 
                    self.second_board[row][column] = 0
                end
            end
        end
        local temp = self.board
            self.board = self.second_board
            self.second_board = temp

            self.delay_count = 1
    else
        self.delay_count = self.delay_count + 1
    end  
end



function Game:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 0, 0, WIDTH, HEIGHT)

    love.graphics.setColor(0, 0, 0)

    for row, columns in ipairs(self.board) do
        for column, value in ipairs(columns) do
            if value == 1 then
                local x = (column - 1) * CELL
                local y = (row - 1) * CELL
                love.graphics.rectangle("fill", x, y, SIZE, SIZE)
            end
        end
    end    



end    

return Game