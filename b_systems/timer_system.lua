TimerSystem=System({Txt, Timer}, function(ent)
    local txt, timer = ent[Txt], ent[Timer]
    if timer.isStop then
        if btnp(4) then
            QueueCb(function()
                ClearWorld()
                InitScene()
            end)
        end
        return
    end
    timer.time += 1
    txt.str = timer.time
end)