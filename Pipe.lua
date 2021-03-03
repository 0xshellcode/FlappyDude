Pipe = Class{}

-- Remember, local is for just the use of this class
local PIPE_IMAGE = love.graphics.newImage('resources/images/cyberPipe.png')

PIPE_SPEED = 60
PIPE_HEIGHT = 430
PIPE_WIDTH = 70

function Pipe:init(orientation, y)
    self.x = VIRTUAL_WIDTH
    self.y = y
    self.width = PIPE_WIDTH
    self.height = PIPE_HEIGHT
    self.orientation = orientation
end

function Pipe:update(dt)
    
end

function Pipe:render()

    -- Render the pipes by mirroring the sencond one based on the location of the first one

    love.graphics.draw(PIPE_IMAGE, self.x, 
        (self.orientation == 'top' and self.y + PIPE_HEIGHT or self.y), 
        0, -- This is meant for the rotation
        1, -- And this is forthe X scale
        self.orientation == 'top' and -1 or 1) -- This is the Y scale, this is the one that we flip
end