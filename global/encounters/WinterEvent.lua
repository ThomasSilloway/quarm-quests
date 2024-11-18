function GetRandomMob()
    local mobList = eq.get_entity_list():GetMobList()
    local mobs = {}
    
    if mobList then
        for mob in mobList.entries do
            if mob.valid then
                table.insert(mobs, mob)
            end
        end
    end

    local mobCount = #mobs
    if mobCount == 0 then
        return nil -- No mobs in the list
    end

    local randomIndex = math.random(1, mobCount)
    return mobs[randomIndex]
end

function event_encounter_load(e)
    local gnome = 31159
    local randomMob = GetRandomMob()
    
    if randomMob then
        eq.spawn2(gnome, 0, 0, randomMob:GetX(), randomMob:GetY(), randomMob:GetZ(), randomMob:GetHeading())
        eq.zone_emote(15, "A gnome has appeared at " .. randomMob:GetX() .. ", " .. randomMob:GetY() .. ", " .. randomMob:GetZ())
    else
        eq.zone_emote(15, "No mobs found to spawn the gnome.")
    end
end

