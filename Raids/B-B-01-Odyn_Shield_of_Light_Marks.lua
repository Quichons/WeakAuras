--- WeakAura Strings ---
dyKlgaGiO0NuvLgLs0PucZckULcYUuQggK4yQkTmuQNbrMgLuxtrABkO(geOXbH6COK6DkG7POCqiPfsjXdHGMik0fHO2ik4JQQmsiGtIIwPszMOe3eLKDQQWpvvvnuvvrlLsspfPPcYvvuTvvfLVQQO6TQQc3vvrAVs(lIgS4WuzXqipwjnzeUSkBgQ8zGA0a50u1QvGETIWSPu3wH2nQ(nOgoLy5u8Cvz6sDDaBhQ67QkIXRi68qQ5RQQSFY13cQOJfLOOefurj8Vbb4RTh)vuNTDrj8pl2o0q3KDrlQ5a7H5qOTCfTVj7I6wBp(dY4bd(mScM4Qpg6lkf1T2Ey(RGkQN77cQOeWKRaVgESSsrxbEn8yrDagh5XXV7W1NbYpEgLzkOSpDaT5amoYJJFheAZGUFZzYOYmfSyhqBAdhaFT9WCfhGXrEC87JoZeiaAZGoiNb81klxOnffffCWgfMCIBsLzkFXOyTcbS2uuuuuuuu84uMZ99V5mzCjweb)Ey33B4xB8CWlzYjUjxSqz2mfhGXrEC87GqBg09BotgvAqhxBkkkkkkkkkkkkdnKcIv8pf6ea22AtrrrrrrrrrrrXJtzo33mF)mWawy5CeNzjwl2o0Nb7cfyJYCUVz((zGbSG675FTJ3lXAX2H(myxO0GoU2uuuuuuuuuuuuuuuuOxBvNNaYzaF9sSic(9WUV3WV245GxYKtCtUyFhB7mGVglgfeVyaTPOOOOOOOOOOOC2VtBkkkkkkkkkkkkkkkkwmEEVe7F8VvgyGbggEyuqbz3dTcQxdc97FMpvbHoohUvgDMjuAqNcfK)SjuGXPWIhmOwPDgWxJrbnmWFnNchUvCCf375FTJ37)f7Ib0MIIIIIIIIIIIYXj0MIIIIIIIYXj0MIIIYXj02XjQU6I6jk6NJkjQxdc9JKcYF2ekW4uyXdguRWkNzII(jEIguXG1trbPHrcjRNIcBKqqwpLDHBOPSlkhyeY4bd(mV6JVff05bdQlgSEkkinmsiz9uuyJecY6PSlCdnLDrTHDefurBN9X7cQOJa2TVGQU6IE8vyaEFgprr)Y6PiUOaVJ84RWa8(mEIYkfLWJdNFfWUrxqfDeWU9fu1vxudS9vqfDeWU9fu1vxul4T0o7J3furhbSBFbvD1ffNBT9W8cQOJa2TVGQU6IACRxbv0ra72xqvxD1fTnEWGptbv0gTLRORaVgESOh(J3VIIW)ZkRGkejl))hjYFgYFaro)dgyYceYwfzgl6kWRHhjB0wUIE4pEx0vGxdpwuCa812dZxsIrHeJYdariJ)4ngfsmkpyaZ69BotgXOqIrHeJcjgfsmkKyuiXOqIr5z5STzsSqBkkkkECkpaeHm(J3kZMPGL(NiZclKievkejfcvRcHvXXjuEwoBBMekZMPWMnI)omBLg0X1MIIIIIIIIdW4ipo(DqOnd6(nNjJkZuEWaM173CMmoG2uuuuuuuuqijKF8m7OIRpZshGXrEC87oC9zG8JNbJIdW4ipo(9rNzceaTzqhKZa(6fdOnfffLJtOTJtu0vGxdpscYtCfT9Jhr1vx0xrzVZEN9(3IIV(4R1S)wDva

--[[
Author : Aethys
Version : 1.0 (11.20.2016)
Readme :
	WeakAura to mark the Shield of Light target with a Skull.
TODO :
    Added a marker cleaner. (Remove the skull on Cast Success)
]]--


--- Actions\On Init\Custom ---

-- Init
aura_env.afterTimer = 0.5;
WA_Aethys_hyrjaGUID = "";

function aura_env.markHyrjaTarget ()
    for Index = 1, 4 do
        if UnitGUID("boss"..tostring(Index)) == WA_Aethys_hyrjaGUID then
            -- 8 is Skull
            if UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") then
                SetRaidTarget("boss"..tostring(Index).."target", 8);
            else
                print("[|cFFFF6600Easy Aethys|r] Cannot mark the Shield of Light target, you're not an assistant.'");
            end
        end
    end
end


--- Trigger\Custom Trigger ---

-- Trigger [COMBAT_LOG_EVENT_UNFILTERED]
function (_, _, subEvent, _, sourceGUID, _, _, _, _, _, _, _, spellId)
    if subEvent == "SPELL_CAST_START" and spellId == 228162 then
        WA_Aethys_hyrjaGUID = sourceGUID;
        C_Timer.After(aura_env.afterTimer, aura_env.markHyrjaTarget);
    end
end
