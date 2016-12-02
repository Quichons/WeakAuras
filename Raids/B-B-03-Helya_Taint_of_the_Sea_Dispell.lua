--- WeakAura Strings ---


--[[
Author : Aethys
Version : 1.0 (12.01.2016)
Readme :
	WeakAura that display the name of the Damage Dealer you should dispell. You need to set your name in the Actions\On Init section.
TODO :
    Clean up things, add class color.
]]--


--- Actions\On Init\Custom ---

-- Init
-- Can be edited / Should be edited.
aura_env.Dispellers = {
    -- DD 1
    "Aeliel",
    -- DD 2
    "Jarkinn",
    -- DD 3
    "Dhyn"
};
aura_env.defaultText = ""; -- You can put whatever you want, "" if you want to shows nothing while Idle.
aura_env.TaintoftheSeaSpellID = 228054;
aura_env.afterTimer = 0.1;
aura_env.fadeTimer = 10;

-- Core
aura_env.triggerTimer = 0;
WA_Aethys_Helya_TaintoftheSeaSpellName = GetSpellInfo(aura_env.TaintoftheSeaSpellID); -- Need to be Global to be called inside C_Timer.After
WA_Aethys_Helya_DebuffedPlayer = {}; -- Need to be Global to be called inside C_Timer.After

function aura_env.FetchPlayers ()
    table.wipe(WA_Aethys_Helya_DebuffedPlayer);
    local playerName;
    for i = 1, 20 do
        if UnitDebuff("raid"..tostring(i), WA_Aethys_Helya_TaintoftheSeaSpellName) and UnitGroupRolesAssigned("raid"..tostring(i)) == "DAMAGER" then
            playerName = UnitName("raid"..tostring(i))
            table.insert(WA_Aethys_Helya_DebuffedPlayer, playerName);
        end
    end
    if #WA_Aethys_Helya_DebuffedPlayer >= 2 then
        table.sort(WA_Aethys_Helya_DebuffedPlayer, function(a, b) return a < b; end);
    end
end

--- Trigger\Custom Trigger ---

-- Trigger [COMBAT_LOG_EVENT_UNFILTERED]
function (_, _, subEvent, _, _, _, _, _, _, _, _, _, spellId)
    if subEvent == "SPELL_AURA_APPLIED" and spellId == aura_env.TaintoftheSeaSpellID and GetTime() > aura_env.triggerTimer then
        aura_env.triggerTimer = GetTime() + aura_env.fadeTimer;
        C_Timer.After(aura_env.afterTimer, aura_env.FetchPlayers);
        return true;
    end
end

-- Untrigger
function ()
    if GetTime() > aura_env.triggerTimer then
        table.wipe(WA_Aethys_Helya_DebuffedPlayer); -- Needed to take in account the afterTimer.
        return true;
    end
end

--- Display\Display Text [%c] [Every Frame]
-- Custom function
function ()
    for Key, Value in pairs(aura_env.Dispellers) do
        if Value == UnitName("player") then
            if Key <= #WA_Aethys_Helya_DebuffedPlayer then
                return WA_Aethys_Helya_DebuffedPlayer[Key];
            end
        end
    end
    return aura_env.defaultText;
end
