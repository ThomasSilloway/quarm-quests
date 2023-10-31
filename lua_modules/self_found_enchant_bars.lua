local enchant_bars = {}

function enchant_bars.check_bars_quest_dialogue(self, other, message)
    local is_self_found = other:IsSelfFound() == 1 or other:IsSoloOnly() == 1;
	if(is_self_found) then
		if(message:findi("enchantments")) then
			if (other:GetLevel() >= 8) then
				-- TODO: Include more dialogue once gold bars and other bars are supported
				self:Say("You wish to explore the deeper mysteries of metallurgy and magic? A noble path. The enchantment of metal bars is a delicate art. Present me with 5 platinum pieces, and your silver bar, and we shall begin the process of its transformation.");
			else
				self:Say("You are a bit too inexperienced to be dabbling in such magic, aren't you?");
			end
		end
	end
end

function enchant_bars.check_for_bars_to_enchant(item_lib, self, other, trade)

    local is_self_found = other:IsSelfFound() == 1 or other:IsSoloOnly() == 1;
    local num_bars = 0;
    local bar_id = 16500;
    local plat_cost = 5;

    if(is_self_found) then
        if (other:GetLevel() >= 8) then
            -- Handin: Silver bar
            if(item_lib.check_turn_in(self, trade, {item1 = bar_id, item2 = bar_id, item3 = bar_id, item4 = bar_id, platinum = plat_cost * 4}, 0)) then
                num_bars = 4;
            elseif(item_lib.check_turn_in(self, trade, {item1 = bar_id, item2 = bar_id, item3 = bar_id, platinum = plat_cost * 3}, 0)) then	
                num_bars = 3;
            elseif(item_lib.check_turn_in(self, trade, {item1 = bar_id, item2 = bar_id, platinum = plat_cost * 2}, 0)) then
                num_bars = 2;
            elseif(item_lib.check_turn_in(self, trade, {item1 = bar_id, platinum = plat_cost}, 0)) then
                num_bars = 1;
            end
            
            if(num_bars > 0) then
                repeat
                    other:SummonCursorItem(16504, 1); -- Enchanted Silver Bar
                    num_bars = num_bars - 1;
                until num_bars == 0
                self:Say("Your silver bar has been successfully imbued with the mystical energies you seek. Behold, its transformation is complete. May this enchanted metal serve as a testament to your growing intellect and mastery over the arcane. Use it with keen insight on your journey.");
                self:CastSpell(667,self:GetID()); -- Spell: Enchant Silver
            end	
        end	
    end
end

return enchant_bars;
