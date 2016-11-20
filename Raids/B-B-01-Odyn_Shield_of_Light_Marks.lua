--- WeakAura Strings ---
dyKrgaGiO0NGGmkvfNsP0SGu3srXUGIHbjDmLkldv5zqIPjeDnLITju13GGACikohQkENq4EkQoik1crvPhcrmruWfHO2iIQpQQ0iHq6KOKvQQAMOq3evvTtHKFIOKHcbyPOQYtrAQGCvLQ2keiFfI0BruQ7cbQ9s1Fb1GLoSclgc1JvLMmuDzv2mI8zanAvXPPy1cPETqLzJk3wr2nL(nqdhfTCbpxjtx01ry7cLVdb04vu68amFie7NSVZHC6KtXDkUd5uCZkAc7BAIDoDWX5uCZIj3aa0nB6uNgoGgqleaMNtZB20PJ30e7GcgGaVa)bXppQz2HQtnwtc)coXK7Yd3JANthVPb0UCiNASM0HCkoi8lXkbNC(60xIvco50bryaF2yygKYlazMUG6CvuXSjc9Ju2WSV8bWc(bqi6X39SyqDUkwSrOF9tIW(MgqR6GimGpBmmtJqCikGq0dOra4LQF2QFvvvvsGbvww8Bw15Q7qRgPkoO(vvvvvvvvnKu3Bn539Sy4dwedUwyXGjbxzWyb(HLf)MD7w15ZvrkBy2x(ayb)aie947EwmOMpNv)QQQQQQQQQQQQZmJkzunlvACeCC6xvvvvvvvvvvv1qsDV1KSwFdGemz8g4x4dwMCdaxa7wvWG6ERjzT(gajyYETmRCyZpyzYnaCbSBvZNZQFvvvvvvvvvvvvvvvv6L8ByWHgbGx(blIbxlSyWKGRmySa)WYIFZUfdgS5ia8sSOvjZ2i0VQQQQQQQQQQQ6XTo9RQQQQQQQQQQQQQQQYmyS5hSKnI8so5KtE8XJkQipwauzF5dGfIeqWQizyTGP60ieNA(CQ0hZXHRcssLrdWNunhbGxIwfaibcfovlyQoSQJ1YSYHnXGqy3gH(vvvvvvvvvvvvplU(vvvvvvvvplU(vvvvplU(plUNE6udUtrkBy2x(aybtFmhhUkijvgnaFsv(pcX5ueObpFCYJCdQOepkOe5gu5HccZNn8CsZSHNtTetqbdqGxy5rTZPpNb4t6Kh5gurjEuqjYnOYdfeMpB45KMzdpNYboWDiNMdUZMoKtNi4sJd5PNo9SVGe28cgCNUJpBiJtjwh8zFbjS5fm4oFDkUHejZlbxcWHC6ebxACip90PbqUZHC6ebxACip90PmJXmhCNnDiNorWLghYtpDkPXBAaToKtNi4sJd5PNonmEphYPteCPXH80tpDAgmabEbhYPjaMNtFjwj4KtFjwj4KtjryFtdOv9dmAvy0QlceJCSZMOvHrRUajcV339SyaTkmAvy0QWOvHrRcJwfgTkmA1fZJJJf(w9RQQQAiPUiqmYXoBQoFUkwkcazgzegjSPqWui28dcR6WIRUyECCSWvNpxLhpYSlEEQ5Zz1VQQQQQQQkszdZ(Yhal4haHOhF3ZIb15QlqIW79DplgIq)QQQQQQQQibgYmDbmSjLx4ZGimGpBmmds5fGmtxaT6GimGpBmmtJqCikGq0dOra4LBJq)QQQQNfx)Nf3PVeReCcobW8C6f7SPtVyNnxofjKf)5lBiygjRVWiJGqoki49rrolgHqMFiZGtFjwj4e8Jb)CAAMoCp90PlNYddpm8WSZPX8O2fjVDE6oa

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
