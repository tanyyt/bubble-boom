BubbleSystem=System({Oval, Player, Bubble, Ab, Hierarchy}, function(ent)
    local oval, player, bubble, ab, hierarchy = ent[Oval], ent[Player], ent[Bubble], ent[Ab], ent[Hierarchy]
    local heightChange = (min(abs(player.xSpeed) / player.maxSpeed, 1) * bubble.maxStretch)
    local widthChange = (min(abs(player.ySpeed) / player.maxSpeed, 1) * bubble.maxStretch)
    local height = bubble.originHeight - heightChange + widthChange * 0.8
    local width = bubble.originWidth - widthChange + heightChange * 0.8
    oval.x0 = -width * 0.5
    oval.x1 = width * 0.5
    oval.y0 = -height * 0.5
    oval.y1 = height * 0.5
    ab.x0 = (-width + bubble.abShrink) * 0.5
    ab.x1 = (width - bubble.abShrink) * 0.5 - 2
    ab.y0 = (-width + bubble.abShrink) * 0.5 + 2
    ab.y1 = (width - bubble.abShrink) * 0.5
    local child1 = hierarchy.children[1]
    local childSpr = child1[Spr]
    local childPos = child1[Pos]
    local trail = hierarchy.children[2]
    local trailSpr = trail[Spr]
    local trailAnim = trail[Anim]
    local trail2 = hierarchy.children[3]
    local trailSpr2 = trail2[Spr]
    local trailAnim2 = trail2[Anim]
    if height == bubble.originHeight and width == bubble.originWidth then
        if bubble.timer % 3 == 0 then
            oval.x0 = oval.x0 -1 + rnd(2)
            oval.x1 = oval.x1 -1 + rnd(2)
            oval.y0 = oval.y0 -1 + rnd(2)
            oval.y1 = oval.y1 -1 + rnd(2)
            SetLocalPos(hierarchy.children[1], -5 + rnd(2),- 5 + rnd(2))
        end
        childSpr.enable = true
        trailSpr.enable = false
        trailSpr2.enable = false
        bubble.ifSfxPlayed = false
        Stop(trail)
        Stop(trail2)
    else
        childSpr.enable = false
        if height > bubble.originHeight then
            if bubble.ifSfxPlayed == false then
                sfx(3)
                bubble.ifSfxPlayed = true
            end
            trailSpr.enable = false
            trailSpr2.enable = true
            Stop(trail)
            if trailAnim2.isPlaying then
            else
                Replay(trail2)
            end
            if player.ySpeed > 0 then
                trailSpr2.flipY=true
                SetLocalPos(trail2,-bubble.originWidth * 0.35,-height-2)
            else
                trailSpr2.flipY=false
                SetLocalPos(trail2,-bubble.originWidth * 0.35,height-4)
            end
        else
            if bubble.ifSfxPlayed == false then
                sfx(3)
                bubble.ifSfxPlayed = true
            end
            trailSpr2.enable = false
            trailSpr.enable = true
            Stop(trail2)
            if trailAnim.isPlaying then
            else
                Replay(trail)
            end
            if player.xSpeed > 0 then
                trailSpr.flipX=true
                SetLocalPos(trail,-width-2,-bubble.originHeight * 0.35)
            else
                trailSpr.flipX=false
                SetLocalPos(trail,width-4,-bubble.originHeight * 0.35)
            end
        end
    end
    bubble.timer+=1
end)

BubbleSystem2=System({Oval, Bubble, Reward}, function (ent)
    local bubble, oval = ent[Bubble], ent[Oval]
    if bubble.timer % 3 == 0 then
        oval.x0 = -bubble.originWidth * 0.5 + rnd(1)
        oval.x1 = bubble.originWidth * 0.5 + rnd(1)
        oval.y0 = -bubble.originHeight * 0.5 + rnd(1)
        oval.y1 = bubble.originHeight * 0.5 + rnd(1)
        if oval.col == 12 then
            oval.col = 7
        else
            oval.col = 12
        end
    end
    bubble.timer+=1
end)