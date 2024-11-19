require("string_ext");
require("client_ext");
require("mob_ext");
require("npc_ext");
require("entity_list_ext");
require("general_ext");
require("bit");
require("directional");

function StartWinterEvent()
    eq.debug("Starting winter event");
    eq.load_encounter("WinterEvent");
end

function TriggerTimerEvent(e)
    eq.debug("TriggerTimerEvent: " .. e.timer);
	if ( e.timer == "start_winter_event" ) then
		StartWinterEvent();
		return;
	end
end

local zoneid = eq.get_zone_id();
eq.debug("Zone ID: " .. zoneid);

-- If zone is not 0, then load encounter
if zoneid ~= 0 then
    -- eq.register_player_event(Event.timer, TriggerTimerEvent);
    -- eq.register_npc_event("Archmage", Event.timer, 31159, TriggerTimerEvent);
    -- eq.debug("Loading winter event in 1 seconds...");
    -- eq.set_timer("start_winter_event", 1000);

    -- StartWinterEvent();
end

function event_enter_zone(e)
	eq.debug("Event Enter");
    StartWinterEvent();
end
