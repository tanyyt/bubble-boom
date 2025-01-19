DieAnimSystem=System({Sspr, DieAnim, Pos},function(ent)
    local dieAnim, sspr, pos = ent[DieAnim], ent[Sspr], ent[Pos]
    if dieAnim.timer >= dieAnim.frameTime then
        if dieAnim.i > #dieAnim.frameTimes then
            sspr.enable = false
            return
        end
        sspr.x=dieAnim.x[dieAnim.i]
        sspr.y=dieAnim.y[dieAnim.i]
        local nextWidth = dieAnim.width[dieAnim.i]
        local nextHeight = dieAnim.height[dieAnim.i]
        SetLocalPos(ent, pos.x - 0.5 * (nextWidth - sspr.width), pos.y - 0.5 * (nextHeight - sspr.height))
        sspr.width=nextWidth
        sspr.height=nextHeight
        dieAnim.timer = 0
        dieAnim.frameTime=dieAnim.frameTimes[dieAnim.i]
        dieAnim.i+=1
    end
    dieAnim.timer+=1
end)