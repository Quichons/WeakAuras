--- WeakAura Strings ---
duutgaqivrPfHQ6tQIWOqLCkuPMfPsULQOyxskdtv4yOklts6zOImnrcxJuP2MKW3ejzCQk15uvW7uv09KQYbfPAHKkEOQQMOQcDrvr1gvfP(OQkgjQOCsi0kLkntrkUPQs2PQ0pLenurIwQiLEQWuvXvrf(QQizUsv1Ev(RKQbJCykwSuHhtjtwLUmvBgI(mPmAi40KSAur1RLkA2q62uQDJYVf1WfXYH65sz6exxITlv57QQ04fj15jvTEvr0(bpE7SWEXDXDNfglr1ZpyLMMJ)kF99(yHGvAAoENfI(eFH3ZzYIwIJII4Dr1hF)HQFyrH59CMSqu2(DXTGnIkZwWPfEpNjl(NT7WiaLMS2IsZRxykz6SO086TehffX70zbZy7lIe)xG(NX4sIOYSfLMxVLlylNdMswhlA5c2Y5GPKfjOg9oEYceCLgcYE594Xc0S5UZIsZRZ8EoE6SqmOot2zHDbvu7mzYcNzLlmXXQ7cEFNkoTO086oZkxyIJv3PZIRcjsLvbv0VZc7cQO2zYKfyJLVZc7cQO2zYKfj9sedQZKDwyxqf1otMSaPXsuz2olSlOIANjtwGZO(olSlOIANjtMSazMjH6j99wv3lUQwcQrFigRoBl(PsGQKJZcSRPYSJ(eFHYkZwOUlIe)xG(NX4sIOYmGQUOjgRoB)ZmXOy2otwujhNaXp(8fMIKxhlm3RsuzMbTUGvAAoUTZE5TZcbR00C8ole9j(cRstY2lSknjBVazHzjQmJlUHUabeqaHMTmOaLGA074JbR5YRX2bQpG4Z)tOlqabeqiZyGu9Xtxa9JlVf7FW5sYxUDhoUXf3aDZqxGaciGaciGakb1O3XhdwZLxJTduFaXbtjVgBNl(yJ6YhOA1asbuTAaXxmynx4Z9NqxGaciGaciGasHeiUsqn6D8XG1C51y7a1xFaX)FgJljsgd0XzIXc15Znqccod6ceqabeqabeqabeqaPqcexCWucInoykHl(yJ6YhOA1asbuTAaXxmynxedwZf(6ci(jOg9oMp3CdKGGZGUabeqabeqabeqabeqabeqaHDPGzaj4I)j0fiGaciGaciGaciGaYzxGGUabeqabeqabKZUqxGaciGC2f6ceqabe2LcMbesdAZ)e66S7IwPdVNZKOGePk1lQ)p94upoPN2ZcleCRoxusUgXxyvAs2UUOpXx0eJuAl8EotwWzUbvqyrR0H3ZzskXosvQxeP85PjntwuycwPP54DwyvAs2EbYcZsuzgxCde2LcMbKGloqo7ozYKf)QUcc7L3Jhlyf7dwPP542ERUWyjQmRTZIMyWYolS9wZO5lq8jSbsqWbsmynxakJeOiX)fO)zmUKiQmtxa9twedqPLJ3NDXnxVLlS70zHT3AgnVUOpXxK20r8JlU562ERz08PZIwUWUlqKjogPXY7p97TswR)NYnDMEbBA9)LFvM(JCHDB9NUcZzzmRwwtBYKfxvJZlmlr1ZxyqrxCvTeuJEeTYS9YJtvuLhVfnXy1zlLzftwOtLNtLFTq8ul)ZOz8o7T6EAD)47ksbVVtXJQvKQuvTIkgYNr3vSxoT3htMSOTOATQ14vJ3IE7LxkQYBYg

--[[
Author : Namo
Version : 0.1
Readme :
	Ursoc, annonce le prochain groupe de soak, les signes doivent être rond et carré
]]--

--- WA Sections ---

Custom Trigger

function()
    local playerTargetName = "";
    for i=1, GetNumGroupMembers() do
        playerTargetName = UnitName("raid" .. i .. "target");
        if (playerTargetName == "Corruptor Tentacle") then
            if (UnitIsUnit("raid" .. i .. "targettarget", "player")) then
                return true;
            end 
        end
    end
    return false;
end

