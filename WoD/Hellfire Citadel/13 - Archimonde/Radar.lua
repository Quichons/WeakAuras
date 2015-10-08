--- Actions\On Init\Custom ---

-- Init
aura_env.fChaos = GetSpellInfo(185014)
aura_env.sTorment = GetSpellInfo(184964)
aura_env.fChaosDisplay = true
aura_env.sTormentDisplay = true


--- Trigger\Custom Trigger ---

-- Trigger
function(event, ...)
    local _, subevent, _, _, _, _, _, _, destName, _, _, spellId = ...
    
    if event == "ENCOUNTER_START" then
        aura_env.shackles = {} 
    end
    
    if spellId == 184265 and subevent == "SPELL_CAST_SUCCESS" then
        return true
    end
    if spellId == 184964 then
        if subevent == "SPELL_AURA_APPLIED"  then
            local name = gsub(destName, "%-[^|]+", "")
            local x, y = UnitPosition(name)
            aura_env.shackles[name] = {["x"]=x, ["y"]=y}
            return true
        end
    end
end


--- Display\Custom Function ---

-- Refresh
function()
    local f = WeakAuras["regions"][aura_env.id]["region"]
    f:SetWidth(max(f:GetWidth(), f:GetHeight()))
    f:SetHeight(f:GetWidth())
    local scale = f:GetWidth()/100
    
    f.bg = f.bg or f:CreateTexture(nil, "BACKGROUND", nil, 0)
    f.bg:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_White_Border")
    f.bg:SetAllPoints(f)
    f.bg:SetVertexColor(.3, .3, .3, .7)
    
    f.player = f.player or  f:CreateTexture(nil, "BACKGROUND", nil, 4)
    f.player:SetTexture("Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura118")
    f.player:SetPoint("CENTER", f, "CENTER", 0, 0)
    f.player:SetWidth(10*scale)
    f.player:SetHeight(10*scale)
    
    if aura_env.fChaosDisplay then
        f.players = f.players or {}
        f.lines = f.lines or {}
        
        for i=1,20 do
            f.lines[i] = f.lines[i] or  f:CreateTexture(nil,"BACKGROUND", nil, 2)
            f.lines[i]:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White")
            f.lines[i]:SetVertexColor(0,1,0,1)
            f.lines[i]:Hide()        
            
            f.players[i] = f.players[i] or f:CreateTexture(nil, "BACKGROUND", nil, 3)
            f.players[i]:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_Smooth_Border")
            f.players[i]:SetWidth(4*scale)
            f.players[i]:SetHeight(4*scale)
            f.players[i]:Hide()
        end
    end
    
    if aura_env.sTormentDisplay then
        f.shackles = f.shackles or {}
        f.shackletext = f.shackletext or {}
        
        for i=1,3 do
            f.shackles[i] = f.shackles[i] or f:CreateTexture(nil, "BACKGROUND", nil, 2)
            f.shackles[i]:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_White")
            f.shackles[i]:SetVertexColor(0,0,0.7,.5)
            f.shackles[i]:Hide()
            
            f.shackletext[i] = f.shackletext[i] or  f:CreateFontString(nil, "BACKGROUND")
            f.shackletext[i]:SetFont("Fonts\\FRIZQT__.TTF", 6*scale, "OUTLINE")
            f.shackletext[i]:Hide()
        end
        
        f.shackleself = f.shackleself or f:CreateTexture(nil, "BACKGROUND", nil, 1)
        f.shackleself:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_White")
        f.shackleself:SetVertexColor(0,0,0.7,.5)
        f.shackleself:Hide()
    end
    
    local zoom = 1
    
    for i=1,20 do
        local ax, ay, bx, by, da, db
        local px, py = UnitPosition("player")
        
        if aura_env.fChaosDisplay and UnitDebuff("raid"..i, aura_env.fChaos) then
            local focused = gsub(UnitName("raid"..i), "%-[^|]+", "")
            local wrought = gsub(UnitName(select(8, UnitDebuff("raid"..i, aura_env.fChaos))), "%-[^|]+", "")
            
            if focused then
                ax, ay = UnitPosition(focused)
                da = ((px-ax)^2+(py-ay)^2)^(1/2)
                if da == 0 then zoom = zoom or 1 else zoom = min(2, 1/(da/50), zoom)  end
            end
            
            if wrought then
                bx, by = UnitPosition(wrought)
                db = ((px-bx)^2+(py-by)^2)^(1/2)
                if db == 0 then zoom = min(2, zoom) else zoom = min(2, zoom, 1/(db/50), zoom)  end
            end
        end
        
        if aura_env.sTormentDisplay and UnitDebuff("raid"..i, aura_env.sTorment) then
            local name =  gsub(UnitName("raid"..i), "%-[^|]+", "")
            if not aura_env.shackles[name] then
                print("WA Chaos Error (1): " .. name .. " has Shackles, but no Coords stored!")
            else
                local ax, ay = aura_env.shackles[name].x, aura_env.shackles[name].y
                local da = ((px-ax)^2+(py-ay)^2)^(1/2)  + 26
                if da == 0 then zoom = zoom or 1 else zoom = min(2, 1/(da/50), zoom)  end
            end
        end
    end
    
    local lineidx = 0
    
    if aura_env.fChaosDisplay then
        for i=1,20 do
            local ax, ay, bx, by, da, db
            local px, py = UnitPosition("player")
            
            if UnitDebuff("raid"..i, aura_env.fChaos) then
                lineidx = lineidx + 1
                
                local focused = gsub(UnitName("raid"..i), "%-[^|]+", "")
                local wrought = gsub(UnitName(select(8, UnitDebuff("raid"..i, aura_env.fChaos))), "%-[^|]+", "")
                
                if focused then
                    ax, ay = UnitPosition(focused)
                    da = ((px-ax)^2+(py-ay)^2)^(1/2)
                end
                
                if wrought then
                    bx, by = UnitPosition(wrought)
                    db = ((px-bx)^2+(py-by)^2)^(1/2)
                end
                
                --[[
                if focused then      
                    local colors = RAID_CLASS_COLORS[select(2, UnitClass(focused))]
                    f.sa:SetVertexColor(colors.r, colors.g, colors.b, 1)
                    local radian = math.atan2((py - ay), (px - ax)) - GetPlayerFacing()
                    local ox = scale * zoom * da * math.cos(radian)  
                    local oy = scale * zoom * da * math.sin(radian)  
                    f.sa:SetPoint("CENTER", f, "CENTER", oy, -ox)
                    f.sa:SetText(skull..focused)
                    f.sa:Show()
                else
                    f.sa:Hide()
                    f.line:Hide()
                end
                
                
                if wrought then
                    local colors = RAID_CLASS_COLORS[select(2, UnitClass(wrought))]
                    f.sb:SetVertexColor(colors.r, colors.g, colors.b, 1)
                    local radian = math.atan2((py - by), (px - bx)) - GetPlayerFacing()
                    local ox =  scale * zoom * db * math.cos(radian)  
                    local oy =  scale * zoom * db * math.sin(radian)  
                    f.sb:SetPoint("CENTER", f, "CENTER", oy, -ox)
                    f.sb:SetText(cross..wrought)
                    f.sb:Show()
                else
                    f.sb:Hide()
                    f.line:Hide()
                end
                ]]
                
                if focused and wrought and (ax~=bx or ay~=by) then
                    --extend line beyond focused
                    do
                        local x1 = (px-ax)*(zoom/2)
                        local x2 = (px-bx)*(zoom/2)
                        local y1 = (py-ay)*(zoom/2)
                        local y2 = (py-by)*(zoom/2)
                        local dx = x2-x1
                        local dy = y2-y1
                        local dr = math.sqrt(dx^2 + dy^2)
                        --local dr = max(80, math.sqrt(dx^2 + dy^2))
                        local D =  x1*y2 - x2*y1
                        
                        local t =  ((25)^2) * dr^2 - D^2
                        if t >= 0 then
                            local x1 = ( D*dy - dx*math.sqrt(t))/dr^2
                            local y1 = (-D*dx - dy*math.sqrt(t))/dr^2
                            ax= (px-(x1/(zoom/2)))
                            ay= (py-(y1/(zoom/2)))
                        end
                    end
                    
                    --color
                    local u = ((px-ax)*(bx-ax) + (py-ay)*(by-ay)) / ((bx-ax)^2 + (by-ay)^2)
                    local pdist = 10
                    
                    --[[if u < 0 then
                        cx = ax
                        cy = ay
                    end
                    if u > 1 then
                        cx = bx
                        cy = by
                    end--]] 
                    
                    if u <= 1  then
                        local cx = ax + u*(bx-ax)
                        local cy = ay + u*(by-ay) 
                        pdist = sqrt((px-cx)^2+(py-cy)^2)
                    end
                    
                    if focused == gsub(UnitName("player"), "%-[^|]+", "") or wrought == gsub(UnitName("player"), "%-[^|]+", "") then
                        f.lines[lineidx]:SetVertexColor(0,1,1,1)
                    elseif (pdist < 2.1  or (da == 0 and u == 1/0))  then
                        f.lines[lineidx]:SetVertexColor(1,0,0,1)
                        f.bg:SetVertexColor(.5, .3, .3, .7)
                        if GetTime()  > (aura_env.lastWarn or 0) + 1 then
                            aura_env.lastWarn = GetTime() 
                            PlaySoundFile(WeakAuras.PowerAurasSoundPath.."sonar.ogg", "master")
                        end
                        --[[
                        if not aura_env.warned then
                            PlaySoundFile(WeakAuras.PowerAurasSoundPath.."sonar.ogg", "master")
                            aura_env.warned = true
                        end
                        ]]
                        --else
                        --    f.lines[i]:SetVertexColor(0,1,0,1)
                        --aura_env.warned = nil
                    end
                    
                    --f.height = f.height or {}
                    --f.width = f.width or {}
                    
                    local height = scale * zoom * 3
                    local width =  scale * zoom * ((ax-bx)^2 + (ay-by)^2)^(0.5)
                    
                    if width == 0 then
                        f.lines[lineidx]:Hide()
                    else            
                        --translate
                        local mx, my = (ax+bx)/2, (ay+by)/2
                        local radian = math.atan2((py - my), (px - mx)) - GetPlayerFacing()
                        local dm = ((px-mx)^2+(py-my)^2)^(1/2)
                        local ox =  scale * zoom * dm * math.cos(radian)  
                        local oy =  scale * zoom * dm * math.sin(radian)  
                        f.lines[lineidx]:SetPoint("CENTER", f, "CENTER", oy, -ox)
                        
                        --rotation angle
                        local radian = math.atan2((ax - bx), (ay - by)) + GetPlayerFacing()
                        radian = radian % (2 * math.pi)
                        local angle = radian % (math.pi / 2)
                        
                        local left, top, right, bottom = 0, 0, 1, 1
                        
                        local dy = width * math.cos(angle) * math.sin(angle) * (bottom-top) / height
                        local dx = height * math.cos(angle) * math.sin(angle) * (right - left) / width
                        local ox = math.cos(angle) * math.cos(angle) * (right-left)
                        local oy = math.cos(angle) * math.cos(angle) * (bottom-top)
                        
                        local newWidth = width*math.cos(angle) + height*math.sin(angle)
                        local newHeight = width*math.sin(angle) + height*math.cos(angle)
                        
                        local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy
                        
                        if radian < math.pi / 2 then -- 0 ~ 90
                            ULx = left - dx     ULy = bottom - oy
                            LLx = right - ox    LLy = bottom + dy
                            URx = left + ox     URy = top - dy
                            LRx = right + dx    LRy = top + oy
                        elseif radian < math.pi then -- 90 ~ 180
                            URx = left - dx     URy = bottom - oy
                            ULx = right - ox    ULy = bottom + dy
                            LRx = left + ox     LRy = top - dy
                            LLx = right + dx    LLy = top + oy
                            newHeight, newWidth = newWidth, newHeight
                        elseif radian < 3 * math.pi / 2 then -- 180 ~ 270
                            LRx = left - dx     LRy = bottom - oy
                            URx = right - ox    URy = bottom + dy
                            LLx = left + ox     LLy = top - dy
                            ULx = right + dx    ULy = top + oy
                        else -- 270 ~ 360                
                            LLx = left - dx     LLy = bottom - oy
                            LRx = right - ox    LRy = bottom + dy
                            ULx = left + ox     ULy = top - dy
                            URx = right + dx    URy = top + oy
                            newHeight, newWidth = newWidth, newHeight
                        end
                        
                        f.lines[lineidx]:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)
                        f.lines[lineidx]:SetWidth(newWidth)
                        f.lines[lineidx]:SetHeight(newHeight)
                        f.lines[lineidx]:Show()
                    end
                end
            end
        end
    end
    
    
    local i = 0    
    local px, py = UnitPosition("player")
    
    for j = 1,20 do
        if aura_env.fChaosDisplay and UnitExists("raid"..j) and not UnitIsDead("raid"..j) and gsub(UnitName("raid"..j), "%-[^|]+", "") ~= gsub(UnitName("player"), "%-[^|]+", "") then
            
            local ax, ay = UnitPosition("raid"..j)
            local da = ((px-ax)^2+(py-ay)^2)^(1/2)
            
            if da <  48 / zoom then
                local radian = math.atan2((py - ay), (px - ax)) - GetPlayerFacing()
                local ox = scale * zoom * da * math.cos(radian)  
                local oy = scale * zoom * da * math.sin(radian)  
                local colors = RAID_CLASS_COLORS[select(2, UnitClass("raid"..j))]
                
                f.players[j]:SetPoint("CENTER", f, "CENTER", oy, -ox)
                f.players[j]:SetVertexColor(colors.r, colors.g, colors.b, 1)
                f.players[j]:Show()
            end
        end
        
        if aura_env.sTormentDisplay and UnitExists("raid"..j) and UnitDebuff("raid"..j, aura_env.sTorment) then
            i = i + 1
            local name = gsub(UnitName("raid"..j), "%-[^|]+", "")
            
            
            if not aura_env.shackles[name] then
                print("WA Chaos Error (2): " .. name .. " has Shackles, but no Coords stored!")
            else
                local ax, ay = aura_env.shackles[name].x, aura_env.shackles[name].y
                
                local da = ((px-ax)^2+(py-ay)^2)^(1/2)
                local radian = math.atan2((py - ay), (px - ax)) - GetPlayerFacing()
                local ox = scale * zoom * da * math.cos(radian)  
                local oy = scale * zoom * da * math.sin(radian)  
                f.shackles[i]:SetPoint("CENTER", f, "CENTER", oy, -ox)
                f.shackletext[i]:SetPoint("CENTER", f, "CENTER", oy, -ox)
                
                f.shackles[i]:SetWidth(51*scale*zoom)
                f.shackles[i]:SetHeight(51*scale*zoom)
                
                f.shackletext[i]:SetVertexColor(1,1,1,.7)
                if name == gsub(UnitName("player"), "%-[^|]+", "") then
                    f.shackles[i]:SetVertexColor(0,0,.7,.5)
                    f.shackletext[i]:SetVertexColor(1,0,0,1)
                    f.shackleself:SetVertexColor(.7, 0, .7, .5)
                    f.shackleself:SetPoint("CENTER", f, "CENTER", oy, -ox)
                    
                    f.shackleself:SetWidth(61*scale*zoom)
                    f.shackleself:SetHeight(61*scale*zoom)
                    f.shackleself:Show()
                elseif da < 25.5  then
                    f.shackles[i]:SetVertexColor(.7,0,0,.5)
                else
                    f.shackles[i]:SetVertexColor(0,0.7,0,.5)
                end
                
                local count = 0
                local count2 = 0
                for k=1, 20 do
                    local x, y = UnitPosition("raid"..k)
                    if not UnitIsDead("raid"..k) and ((x-ax)^2 + (y-ay)^2)^(1/2) < 25.5 then
                        if UnitDebuff("raid"..k, aura_env.sTorment) then
                            count2 = count2 + 1
                        else            
                            count = count + 1
                        end
                    end
                end
                
                --f.shackletext[i]:SetText(count .. "/" .. count2)
                f.shackletext[i]:SetText(count)
                f.shackletext[i]:Show()
                f.shackles[i]:Show()
            end
        end
        
    end
    
    return ""
end