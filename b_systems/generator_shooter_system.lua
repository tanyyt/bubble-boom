GeneratorShooterSystem = System(
    { ShooterGenerator }, function(ent)
        local generator = ent[ShooterGenerator]
        if generator.timer >= generator.internal then
            for i = 1, generator.generateCount do
                local randomDir = flr(rnd(4))
                local randomX
                local randomY
                if randomDir == TO_UP then
                    randomX = rnd(127)
                    randomY = 126
                elseif randomDir == TO_DOWN then
                    randomX = rnd(127)
                    randomY = 0
                elseif randomDir == TO_LEFT then
                    randomX = 126
                    randomY = rnd(127)
                else
                    randomX = 0
                    randomY = rnd(127)
                end
                sfx(5)
                Entity(Ab{ x0=0,y0=0,x1=2,y1=2 }, Shooter { r = 1, warningR = 3, warningInternal = 6, delay = 30, dir = randomDir }, Pos { localX = randomX, localY = randomY }, Circ { x = 0, y = 0, r = 1, col = 8, isFill = true }, Hierarchy {})
            end
            generator.internal = rnd(generator.generateInternal)
            generator.timer = 0
            generator.generateInternal = max(generator.generateInternalChange + generator.generateInternal, generator.minGenerateInternal)
            generator.generateCount = min(generator.generateCountChange + generator.generateCount, 7)
        end
        generator.timer += 1
        local rewardEnt=QueryWorldSingle({Reward})
        if nil == rewardEnt then
            local rX = 10 + rnd(108)
            local rY = 10 + rnd(108)
            Entity(Reward{}, Pos{localX=rX, localY=rY}, Hierarchy{}, Ab{x0=-2,y0=-2,x1=2,y1=2}, Oval{x0=-1,y0=-1,x1=1,y1=1,col=12}, Bubble{timer=0, originWidth = 2, originHeight = 2})
        end
    end
)