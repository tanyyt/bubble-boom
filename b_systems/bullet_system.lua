BulletSystem = System(
    { Bullet, Pos, Line, Ab }, function(ent)
        local bullet, pos, line, ab = ent[Bullet], ent[Pos], ent[Line], ent[Ab]
        bullet.speed = bullet.speed + bullet.speedChange
        if bullet.timer >= bullet.lifetime then
            HierarchyRemoveDelay(ent)
            return
        end
        local length = bullet.speed * bullet.originLength
        if bullet.dir == TO_LEFT then
            SetLocalPos(ent, pos.localX - bullet.speed, pos.localY)
            line.x0 = -length * 0.5
            line.x1 = length * 0.5
            ab.x0 = -length * 0.5
            ab.x1 = length * 0.5
        elseif bullet.dir == TO_RIGHT then
            SetLocalPos(ent, pos.localX + bullet.speed, pos.localY)
            line.x0 = -length * 0.5
            line.x1 = length * 0.5
            ab.x0 = -length * 0.5
            ab.x1 = length * 0.5
        elseif bullet.dir == TO_UP then
            SetLocalPos(ent, pos.localX, pos.localY - bullet.speed)
            line.y0 = -length * 0.5
            line.y1 = length * 0.5
            ab.y0 = -length * 0.5
            ab.y1 = length * 0.5
        else
            SetLocalPos(ent, pos.localX, pos.localY + bullet.speed)
            line.y0 = -length * 0.5
            line.y1 = length * 0.5
            ab.y0 = -length * 0.5
            ab.y1 = length * 0.5
        end
        bullet.timer += 1
    end
)