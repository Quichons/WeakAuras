--- WeakAura Strings ---
duuVfaGikfxsPsgLuLtjv1RukOzrsDlLQSlvvdJsCmsYYKqptPuMgLuxdQyBkvQVjbnovPoNsH6DQkUNa2NsfDqivwOsP6HsGjkqxuvPnsjXhHuoPQOvcvntLQ6MkvyNQc)KssdvPeTuLI0tvzQcDvkL2Qsr5RkLWEj(RsgmQdtQfRuspwqtMexw0MLOpdjJgQ0PrSALIy2qCBjTBf)wkdNs1Yr65qz6uDDk2Uu57kfY4Hu15vLSELcmFLIQ9dwujr5QYPiNIeLRSn(r2GuEu0ICkeSnXmHoPlLtJGiNcbZoI(vmrVl3UcXKl0G5TAmrVlxPzcDsBaUxFapWadmW00n0byTHQx509tgpPJgjsQjfyyZdaSfG1JcWyoLmO(lB0Q27zZUu9xAJAG1gQELt3pz8KoAKiPMuG3dy0spsQzV(9bUrb2YhaFokYzgNsqHkPsuUqdM3QYvAMqN0gG71hWdmWadmPey0spsQzV(aVtG1gQELt3pz8KoAKiPMuGDCZbWdmWadmWadmWAdvVYP7NmEshnsKutkWba2YhapWadmWadmWatt3qhGDQj)a4bgyGbohfaFokIlhnrrAt8L9uoprVlNo0jDzKsqHkP7OPKYJ9uzroYq8vyRAhj9urEOsoDOtAdMeLJmexIYP0wHgmVvLTlxObZBv50gQELt3pMPwBtWwRIYOPkN9eb5zqGdaSQ34yTLpaETHQx509tgpPJgjsQjf4aaB5dGxBO6voD)TYsS0dAOAN0gGdaSQ3w(iU4Y9YQLLyPlp2gowKtROqCsB0ilNsqHkPysuC52iIIJRyLclSOfRX5DHfFx06Tv0IfPCpRFl3yQrkbfQKIjpujhUjbfUUyfCku1737w1U34cXrfo4u0IuUN1VLJOi3wGUf6sh3xyRZuRTjyRvrz0uLcckhstRir5CnsoUeLRAqCIefxC5uiLLKqdI)sIYvniorIIlUC0gskr5QgeNirXfxo7D2DnsoUeLRAqCIefxC5k1HoPnsuUQbXjsuCXLJQdtjkx1G4ejkU4IlNtjOqLujkN)YEkxObZBv5cnyERU8x2t5YUCC5cnyERUWLOKYfAW8wvUSlhhtUcS6o2o6IR9TkARVB23hXLTpSYZ9JF30VbLl0G5TQCLMj0jTb4El1aVudmMzRF7YXvd8snWyndnmrZ2Nbvd8snWl1aVud8snWl1aVud8snWy2teKNk9b8admWatkbgZS1VD54ahiaW2CB5393Fva6U46STGc(ENnaRhfGXSNiipvaoqaG1gQELt3pMPwBtWwRIYOPkN9eb5zqG1JcWyndnmrZ2NbboqaGTDioA2(mypBSJOFLuB6dSEuagT0JKA2RpW7eyTHQx509tgpPJgjsQjfyh3Ca8admWadmWadS2q1RC6(jJN0rJej1KcCaGrl9iPM96d8gcS2q1RC6(BLLyPh0q1oPnFa8admWadmWadmnDdDa2PM8dGhyGbg4Cua85OiU4YHjxX)I)f)vjxN8qL1fvjUi

--[[
Author : Aethys
Version : 1.0 (12.07.2016)
Readme :
	WeakAura that displays the internal cooldown of Summon Doomguard (useful if you got the legendary).
]]--


--- Actions\On Init\Custom ---

-- Init
aura_env.summonDoomguardSpellID = 18540;
aura_env.internalTimer = 0;
aura_env.offsetDuration = 180;

--- Trigger\Custom Trigger ---

-- Trigger [COMBAT_LOG_EVENT_UNFILTERED]
function (_, _, subEvent, _, sourceGUID, _, _, _, _, _, _, _, spellId)
    if subEvent == "SPELL_CAST_SUCCESS" and spellId == aura_env.summonDoomguardSpellID and sourceGUID == UnitGUID("player") and GetTime() > aura_env.internalTimer then
        aura_env.internalTimer = GetTime() + aura_env.offsetDuration;
        return true;
    end
end

-- Untrigger
function ()
    if GetTime() > aura_env.internalTimer then
        aura_env.internalTimer = 0;
        return true;
    end
end

--- Display\Display Text [%c] [Every Frame]
-- Custom function
function ()
    return aura_env.internalTimer ~= 0 and string.format("%1.f", aura_env.internalTimer - GetTime()) or 0;
end
