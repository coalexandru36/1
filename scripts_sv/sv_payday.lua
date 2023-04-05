local minute = 59
local secunde = 59

CreateThread(function()
    while true do
        secunde = secunde - 1
        if secunde == 0 then
            if minute >= 1 then secunde = 59 end;
            minute = minute - 1
            if minute <= 0 and secunde <= 1 then
                minute = 59
                secunde = 59
                doPayDay()
            end
        end
        GlobalState.minute = minute
        GlobalState.secunde = secunde

        TriggerClientEvent('hud:updateThings', -1, "payday", minute.. "m " ..secunde.."s")
        --TriggerClientEvent('utdHud:client:updatePayday', -1, "")
        Wait(1000)
    end
end)

function doPayDay()
    local users = vRP.getUsers()
    for user_id, thePlayer in pairs(users) do
        user_id = parseInt(user_id)
        thePlayer = parseInt(thePlayer)
        if thePlayer then
            local salary = 1000000
            local diamante = 1
            local hasFaction = vRP.hasUserFaction(user_id)
            if hasFaction then
                local theFaction = vRP.getUserFaction(user_id)
                local fType = vRP.getFactionType(theFaction)
                if fType then
                    local theRank = vRP.getFactionRank(user_id)
                    local theSalary = vRP.getFactionRankSalary(theFaction, theRank)
                    salary = (salary or 0) + (theSalary or 0)
                end
            end
            local isVip = vRP.isUserVip(user_id)
            if isVip then
                local vipRank = vRP.getVipLvl(user_id)
                local vipSalary = vRP.getVipSalary(vipRank)
                if vipSalary >= 1 then
                    salary = (salary or 0) + (vipSalary or 0) + (theSalary or 0)
                end
            end
            vRP.giveMoney(user_id, tonumber(salary))
            vRP.giveDiamante(user_id, tonumber(diamante))
            vRPclient.doPayDay(thePlayer, {tonumber(salary)})
        end
    end
end

RegisterCommand("paydaybonus", function(player)
	local user_id = vRP.getUserId(player)
	if vRP.isUserDeveloper(user_id)then
		doPayDay()
		TriggerClientEvent("chatMessage", -1, "^1PayDay Bonus: ^0Tot server-ul a primit payday-ul mai rapid cu ajutorul lui ^1".. vRP.getPlayerName(player))
        vRPclient.paydayAnnouncement(-1, {"                                Ai primit ~r~bonus-salariu~w~\nAi primit un ~r~giftpoint ~w~pentru activitatea petrecuta pe ~r~server."})
	else
		vRPclient.notify(player,{"~r~Eroare: ~w~ ~w~Nu ai acces la comanda de bonus"})
	end
end)