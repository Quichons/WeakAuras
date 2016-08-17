--- WeakAura Strings ---
dKdJdaGlPcBdvPMjuA2aDyOQ7bsDBf(lizNGWEvTBfTFYOOunmPk)gYLrzOsfnyXWPehuQkNIs5yufNJskNwk)uQKzHQOwov8qPQYtLSmOYZrLjsjvtvPMmvA6ixev1RKQQEgf66a2ii6ZuWMvITlvQpsjPVIQittj13rvWirvO3PKmAkY4PK4KuL6wOk5AuuNhkwjOEmv13Ok5757xJxUVC)(LBJZciEmBMvOxVCygAO5gJf2lIzf6f50myG589lcJf2lFaocnE5dWrObuMAUSx(aCeA8YhGJqJxlatFQHMk2TjyffffqKpEqf(dleMcerkqR0BLGvuuuwqoknfOv8WZkwLrqamWIqK3eBWz3MIlsWkkkkkkkkTffSievGiIhXZ5nXg2B2uitSPGvuuuuuuuuuuuWIqubIi7nBReSIIIIIIIcdKJjyffffffffffff(dleMcerkqRWFyHWuGisP)kEwjyffffffff20vWkkkkSPRGvuuuAlk8hwimfiIuGgAfRYiiagyriYBIn4SBtHmXMcwrrrrrrrPFGiogweISBBLIGvuuuytxbZMUVyDZMe3lSD11gQU6Kpe8T(lFaocnGIWyH9I1nBsNEbmjNMbdmNVF5dWrOXRfGPp1qtf72eSIIIIdJaCMkKdaBLGztxblyblybl4tV4HMlz6qU2CpJ82OX1M7HZOxwZmUVWlZ4EXXax6e1M0lS8HC)Acm2ondgyoChcpVmXAgmrhY1M7zK3gnU2CpCg9YAMX9fEzg3RM7lEQpO6JrMWWbfK45O(aieweIEbIW7(9l32YsZhaKW89Rbai1((0Pxoiq23VgaGu77tNE5G3N99Rbai1((0PxeEq2K((1aaKAFF60Rf8(udn)(1aaKAFF60Px4N(MqoDIAt6fw(qUp9I7fUo80rVoW51RUpeEwJZZPF

--[[
Author : Aethys
Version : 1.0 (06.18.2016)
Readme :
    WeakAura that loot items as soon as the loot window is opened. (Faster than default Blizz' Auto Loot)
]]--


--- Actions\On Init\Custom ---

-- Init


--- Trigger\Custom Trigger ---

-- Trigger [LOOT_OPENED]

function ()
    local EmptySlot = 0;
    for i = 1, GetNumLootItems() do
        if LootSlotHasItem(i) then
            LootSlot(i);
        else
            EmptySlot = EmptySlot + 1;
        end
    end
    if EmptySlot == GetNumLootItems() then
        CloseLoot(); 
    end
end



-- Untrigger
function ()
    return true;
end





