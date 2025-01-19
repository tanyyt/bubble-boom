ShooterSystem = System(
    { Shooter, Circ, Pos }, function(ent)
        local shooter, circ, pos = ent[Shooter], ent[Circ], ent[Pos]
        if shooter.timer >= shooter.delay then
            sfx(4)
            Entity(Ab{x0=0,y0=0,x1=0,y1=0}, Bullet { dir = shooter.dir, originLength = 5, lifetime = 20, speedChange = 1.5 }, Pos { localX = pos.x, localY = pos.y }, Line { x0 = 0, y0 = 0, x1 = 0, y1 = 0, col = circ.col }, Hierarchy {})
            HierarchyRemoveDelay(ent)
            return
        end
        if shooter.isWarning and shooter.timer % shooter.warningInternal==0 then
            circ.r = shooter.warningR
            shooter.isWarning = false
        elseif shooter.timer % shooter.warningInternal==1 then
            circ.r = shooter.r
            shooter.isWarning = true
        end
        shooter.timer += 1
    end
)