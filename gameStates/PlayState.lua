PlayState = Class{__includes = BaseState}

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24

function PlayState:init()
    self.Dude = Dude()
    self.pipePairs = {}
    self.timer = 0

    -- now keep track of our score
    self.score = 0
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
end

function PlayState:update(dt)
    -- update timer for pipe spawning
    self.timer = self.timer + dt

    if self.timer > 2 then
        local y = math.max(-PIPE_HEIGHT + 10, 
            math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        self.lastY = y

        table.insert(self.pipePairs, PipePair(y))
        self.timer = 0
    end

    for k, pair in pairs(self.pipePairs) do
        -- score a point if the pipe has gone past the Dude to the left all the way
        -- be sure to ignore it if it's already been scored
        if not pair.scored then
            if pair.x + PIPE_WIDTH < self.Dude.x then
                self.score = self.score + 1
                pair.scored = true
                sounds['score']:play()
            end
        end

        -- update position of pair
        pair:update(dt)
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    -- update Dude based on gravity and input
    self.Dude:update(dt)

    -- simple collision between Dude and the pipes
    for k, pair in pairs(self.pipePairs) do
        for l, pipe in pairs(pair.pipes) do
            if self.Dude:collides(pipe) then

                -- Lost sound

                sounds['die']:play()
                sounds['ouch']:play()
                sounds['music']:stop()
                gStateMachine:change('score', {
                    score = self.score
                })
            end
        end
    end

    -- reset if we get to the ground
    if self.Dude.y > VIRTUAL_HEIGHT - 15 then

        -- Lost sound

        sounds['die']:play()
        sounds['ouch']:play()
        sounds['music']:stop()

        gStateMachine:change('score', {
            score = self.score
        })
    end
end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(dudeFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    self.Dude:render()
end