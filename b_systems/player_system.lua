local function getBtnpSingle()
    if btn(0) then
        return 0
    end
    if btn(1) then
        return 1
    end
    if btn(2) then
        return 2 
    end
    if btn(3) then
        return 3
    end
    return -1
end

PlayerSystem=System({Player, Pos, Oval, Ab}, function(ent)
    local player, pos, oval, ab = ent[Player], ent[Pos], ent[Oval], ent[Ab]
    local b = getBtnpSingle()
    if b == 0 then
        if player.xSpeed > 0 then
            player.xSpeed = max(player.xSpeed - 1.5 * player.speedChange, -player.maxSpeed)
        else
            player.xSpeed = max(player.xSpeed - player.speedChange, -player.maxSpeed)
        end
    elseif b == 1 then
        if player.ySpeed < 0 then
            player.xSpeed = min(player.xSpeed + 1.5 * player.speedChange, player.maxSpeed)
        else
            player.xSpeed = min(player.xSpeed + player.speedChange, player.maxSpeed)
        end
    else
        if player.xSpeed > 0 then
            player.xSpeed = max(player.xSpeed - player.speedChange, 0)
        elseif player.xSpeed < 0 then
            player.xSpeed = min(player.xSpeed + player.speedChange, 0)
        end
    end
    
    if b == 2 then
        if player.ySpeed > 0 then
            player.ySpeed = max(player.ySpeed - 1.5 * player.speedChange, -player.maxSpeed)
        else
            player.ySpeed = max(player.ySpeed - player.speedChange, -player.maxSpeed)
        end
    elseif b == 3 then
        if player.ySpeed < 0 then
            player.ySpeed = min(player.ySpeed + 1.5 * player.speedChange, player.maxSpeed)            
        else
            player.ySpeed = min(player.ySpeed + player.speedChange, player.maxSpeed)            
        end
    else
        if player.ySpeed > 0 then
            player.ySpeed = max(player.ySpeed - player.speedChange, 0)
        elseif player.ySpeed < 0 then
            player.ySpeed = min(player.ySpeed + player.speedChange, 0)
        end
    end
    
    SetLocalPos(ent, min(max(pos.localX + player.xSpeed, -oval.x0), 128 - oval.x1 - 1), min(max(pos.localY + player.ySpeed, -oval.y0), 128 - oval.y1 - 1))
    
    if #ab.intersects > 0 then
        local timer = QueryWorldSingle({Timer})[Timer]
        for i=1,#ab.intersects do
            local reward = ab.intersects[i][Reward]
            if reward then
                sfx(2)
                timer.time += min(flr(timer.time * 0.15, 300))
                HierarchyRemoveDelay(ab.intersects[i])
            else
                sfx(1)
                music(0, nil, 7)
                timer.isStop = true
                local gameOverEnt = Entity(Sspr{x=8,y=0,width=64,height=64}, Pos{localX=32, localY=32}, Hierarchy{children={}})
                local recordEnt = Entity(Txt{str="your record is " .. timer.time .. "\n\npreess 🅾️ to retry",col=7}, Pos{localX=-4,localY=64}, Hierarchy{})
                SetParent(gameOverEnt, recordEnt)
                Entity(Sspr{width=8,height=8}, DieAnim{timer=0,frameTime=0,i=1,x={72,80,96,0},y={0,0,0,64},width={8,16,32,64},height={8,16,32,64},frameTimes={4,4,4,4}}, Pos{localX=pos.localX,localY=pos.localY}, Hierarchy{})
                HierarchyRemoveDelay(ent)
            end
        end
    end
end)