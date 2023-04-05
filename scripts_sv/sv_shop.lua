local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP","snCore")

local shopMenu = {name="Shop",css = {top="75px",header_color="rgba(51, 153, 255,1.0)"}}

--local webURL = "https://discord.com/api/webhooks/870037373864521739/qxHcZKl2CT8imEAP7X1k2k5KoTacJKKTDxXWTuIp1Ufb7aqHJwnPqTHU-DhTdHKfOGtc"

local buy = function(user_id,price)
	if not user_id then return end;
	if vRP.tryPaymentDiamante({user_id,price}) then 
		return true 
	end
	local source = vRP.getUserSource({user_id})
	TriggerClientEvent('chatMessage', source,'Nu ai destule ^1diamante!')
	return false 
end

-- local log = function(user_id,perk)
-- 	local s = vRP.getUserSource({user_id})
-- 	local name = GetPlayerName(s)
-- 	local string = 'Jucatorul [' .. user_id .. '] ' .. name .. ' a cumparat ' .. perk
-- 	PerformHttpRequest(webURL,function(err, text, headers) end, 'POST', json.encode({content = string}), { ['Content-Type'] = 'application/json' })
-- end

local perks = {
	['+10 KG'] = {15,function(user_id)
		if buy(user_id,15) then 
			vRPclient.notify(vRP.getUserSource({user_id}),{'Ai cumparat +10 KG!'})
			vRP.levelUp({user_id, "physical", "strength"})
			--log(user_id,'+10 KG')
		end
	end},
    ['2.500.000$'] = {5,function(user_id)
		if buy(user_id,5) then 
		
			vRP.giveMoney({user_id,2500000})
		end
	end},

	['15.000.000$'] = {30,function(user_id)
		if buy(user_id,30) then 

			vRP.giveMoney({user_id,15000000})
		end
	end},

	['30.000.000$'] = {50,function(user_id)
		if buy(user_id,50) then 
	
			vRP.giveMoney({user_id,30000000})
		end
	end}
}

for k,v in pairs(perks) do 
	shopMenu[k] = {function(player,choice)
        v[2](vRP.getUserId({player}))
    end,'Pret: ' .. v[1] .. ' diamante'}
end

RegisterCommand('shop', function(p)
	vRP.openMenu({p,shopMenu})
end)

local function ch_openShop(player,ch)
	vRP.openMenu({player,shopMenu})
end

vRP.registerMenuBuilder({"main", function(add, data)
    local user_id = vRP.getUserId({data.player})
    if user_id ~= nil then
    local choices = {}
        choices["Shop"] = {ch_openShop,''}
        add(choices)
     end
end})