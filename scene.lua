function InitScene()
    music(-1)
    -- create entities
    Entity(DrawSystemData { dcs = {} })
    local playerEnt = Entity(Player { speedChange = 0.2, maxSpeed = 3 }, Ab{ x0 = -5, y0 = -5, x1 = 5, y1 = 5, intersects={} }, Oval { x0 = -5, y0 = -5, x1 = 5, y1 = 5, col = 12 }, Pos { x = 64, y = 64, localX = 64, localY = 64 }, Hierarchy {children={}}, Bubble { ifSfxPlayed=false, maxStretch = 7, originWidth = 10, originHeight = 10, flicker = 1, flickerSpeed = 0.3, abShrink = 1.5 })
    Entity(Timer {isStop=false}, Pos { localX = 0, localY = 0 }, Txt {col = 7}, Hierarchy {})
    Entity(ShooterGenerator { minGenerateInternal = 10, generateInternal = 60, timer = 0, internal = 0, generateInternalChange = -0.1, generateCountChange = 0.2 })
    local childEnt = Entity(Pos{localX=-4,localY=-4}, Hierarchy{}, Spr{id=73})
    local effectEnt = Entity(Pos{localX=0,localY=0}, Hierarchy{}, Spr{enable=false,id=74}, Anim{isPlaying=false,states={Spr{id=74},Spr{id=75},Spr{id=76},Spr{id=77},Spr{id=78},Spr{id=79}},frames={0,4,8,10,12,16},isLoop=true})
    local effectEnt2 = Entity(Pos{localX=0,localY=0}, Hierarchy{}, Spr{enable=false,id=105}, Anim{isPlaying=false,states={Spr{id=105},Spr{id=106},Spr{id=107},Spr{id=108},Spr{id=109},Spr{id=110}},frames={0,4,8,10,12,16},isLoop=true})
    SetParent(playerEnt, childEnt)
    SetParent(playerEnt, effectEnt)
    SetParent(playerEnt, effectEnt2)
    -- add systems
    AddSystems(HierarchyActiveSystem, HierarchyPosSystem, AbSystem, PlayerSystem, BubbleSystem, TimerSystem, BulletSystem, GeneratorShooterSystem, ShooterSystem, BubbleSystem2)
    AddDrawSystems(DrawSystem, OvalSystem, TxtSystem, LineSystem, CircSystem, SsprSystem, DieAnimSystem, SprSystem, SprAnimSystem)
end