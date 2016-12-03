--- WeakAura Strings ---
dWJXeaWsQQQ2LcSnjrntQs)fqZgshgQUjvvPld62k58OKDQOAVQ2Te7N8tfrdda)gvNMkdfGmyXWHsheG6ukshts15KK0cPQQCDG(MKuwofEivv4PsTmkYZrXeLKQPQutMsMoYfPQ8kQQINPGEhezJOuMfvvYMHW2PO(OKeFLQk6ZqX3LezKuvPMgkvJMQy8scDsfHBjj4Ask3dIALuQhRqJsr5x)73R3wVT((TLJblkoRnSI073GfYWHbd0473JGmeF9w2Yw2Yw2NEBaX44LnlSW3eSI0B8rYzgUnCyWan8xUf8Zb4TR4iGJ8fwuibT(86VXhjhVW89BxXrF)2IdCeKH4R7FVhbzi(6noOboqyX8aFlSeRgLtkiRaasNo9MbIIaqCxHE71hB734wwoYXl4OajdhgmqdMVp9gVm6HBaiURqV96JT97k5SipNn2RbWWkpCi71aW0WQv1AMoIkuZ07c4AB4WGbAW851FtgomyGgF)MyHf(EeKH4R3JGmeFbKyHf(gAgwO3JGmeF9gbyzKC8IYSPYwrrrXHqPWjLjyApoeK)dzvDELkZMQqEGfzROOOOOOOGdAGdewmpW3clXQr5KcYkaGKSvuuuuuuuqWnuCkiRu3VuQcKMdU8Y50eeCXmBQIfx2kkkkkkkkkkkkoekE5CQr5KFJZmbbxZCtvipWISvuuuuuuuuuuuuuuu8Y5uJYPzUPijBffffffffffffikdu2kkkkkkkkkkkkkkkk4Gg4aHfZd8TWsSAuoPGScoOboqyX8aFlSeRgLtk(JsDKKTIIIIIIIIIIIcSyjBffffffffyXs2kkkkkkkkoek4Gg4aHfZd8TWsSAuoPGmYkvbsZbxE5CAccUyMnvH8alYwrrrrrrrrrrrXpq5mqVConBkskYwrrrrrrrbwSKTIIIcSyjBffffdibAuuqGJYars2WI1BOzyHyE7DYj3aNeq(M7R6Vhbzi(cOhNf8n5wqRtV9aDy8qNn2RbWWkpCi71aW0WQv1AMoIkuZ0BuoU13VjCuyH((9ceLCFF60BlhceUrquI13VxGOK77tNEBGpc)(9ceLCFF60Be4JKJx((9ceLCFF60BSMXs4OWc997fik5((0P3gCu43VxGOK77tNo92z92pbmqadjpSyaYgodbyqI7LZPtVzEBAGPbMgu)T5pVo7MQF6h

--[[
Author : Aethys
Version : 1.0 (06.18.2016)
Readme :
    WeakAura that loot items as soon as the loot window is opened. (Faster than default Blizz' Auto Loot)
    Can be disabled by letting Shift key down.
]]--


--- Actions\On Init\Custom ---

-- Init
aura_env.EmptySlot = 0;

--- Trigger\Custom Trigger ---

-- Trigger [LOOT_OPENED]
function ()
    if not IsShiftKeyDown() then
        aura_env.EmptySlot = 0;
        for i = 1, GetNumLootItems() do
            if LootSlotHasItem(i) then
                LootSlot(i);
            else
                aura_env.EmptySlot = aura_env.EmptySlot + 1;
            end
        end
        if aura_env.EmptySlot == GetNumLootItems() then
            CloseLoot(); 
        end
    end
    return false;
end
