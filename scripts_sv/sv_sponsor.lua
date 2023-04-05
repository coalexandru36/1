local spUtils = {}
local vipUtils = {}
local spCars = {}
local spTags = {}
local CanDoSponsorFacility = "~y~[SPONSOR] ~r~Poti folosii aceasta facilitate peste 1 minut!"
local CanDoVIPFacility = "~g~[VIP MENU] ~r~Poti folosii aceasta facilitate peste 1 minut!"

--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--SPONSOR PACK--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--
local function sp_fixCar(player, choice)
	local user_id = vRP.getUserId(player)
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		TriggerClientEvent('murtaza:fix', player)
		vRPclient.notify(player, {"~y~[SPONSOR] ~g~Ti-ai reparat vehiculul!"})
	else
		vRPclient.notify(player, {CanDoSponsorFacility})
	end
end

local function vip_fixCar(player, choice)
	local user_id = vRP.getUserId(player)
	if(vipUtils[user_id] ~= true)then
		vipUtils[user_id] = true
		TriggerClientEvent('murtaza:fix', player)
		vRPclient.notify(player, {"~g~Ti-ai reparat vehiculul!"})
	else
		vRPclient.notify(player, {CanDoVIPFacility})
	end
end

local function sp_skyFall(player, choice)
	local user_id = vRP.getUserId(player)
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		vRPclient.startSkyFall(player, {})
		vRPclient.notify(player, {"~y~[SPONSOR] ~g~Ai grija sa activezi parasuta!"})
	else
		vRPclient.notify(player, {CanDoSponsorFacility})
	end
end

local function vip_skyFall(player, choice)
	if(vipUtils[user_id] ~= true)then
		vipUtils[user_id] = true
		local user_id = vRP.getUserId(player)
		vRPclient.startSkyFall(player, {})
		vRPclient.notify(player, {"~g~Ai grija sa activezi parasuta!"})
	else
		vRPclient.notify(player, {CanDoVIPFacility})
	end
end

local function sp_rainbowCar(player, choice)
	local user_id = vRP.getUserId(player)
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		vRPclient.setRainbowCar(player, {})
	else
		vRPclient.notify(player, {CanDoSponsorFacility})
	end
end

local function sp_revive(player, choice)
	local user_id = vRP.getUserId(player)
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		vRPclient.varyHealth(player,{200})
		vRP.varyThirst(user_id, -100)
		vRP.varyHunger(user_id, -100)
		SetTimeout(500, function()
			vRPclient.varyHealth(player,{200})
			vRP.varyThirst(user_id, -100)
			vRP.varyHunger(user_id, -100)
		end)
		vRPclient.notify(player, {"~y~[SPONSOR] ~g~Ti-ai refacut viata!"})
		vRP.sendStaffMessage("^5"..vRP.getPlayerName(player).." ^0si-a dat Refa Viata din ^5Sponsor Menu")
	else
		vRPclient.notify(player, {CanDoSponsorFacility})
	end
end

local function vip_reviv(player, choice)
	local user_id = vRP.getUserId(player)	
	if(vipUtils[user_id] ~= true)then
		vipUtils[user_id] = true
		vRPclient.varyHealth(player,{200})
		vRP.varyThirst(user_id, -100)
		vRP.varyHunger(user_id, -100)
		SetTimeout(500, function()
			vRPclient.varyHealth(player,{200})
			vRP.varyThirst(user_id, -100)
			vRP.varyHunger(user_id, -100)
		end)
		vRPclient.notify(player, {"~g~Ti-ai refacut viata!"})
		vRP.sendStaffMessage("^5"..vRP.getPlayerName(player).." ^0si-a dat Refa Viata din ^5VIP Menu")
	else
		vRPclient.notify(player, {CanDoVIPFacility})
	end
end

local function vip_fullMancare(player, choice)
	local user_id = vRP.getUserId(player)	
	if(vipUtils[user_id] ~= true)then
		vipUtils[user_id] = true
		vRP.varyThirst(user_id, -100)
		vRP.varyHunger(user_id, -100)
		SetTimeout(500, function()
			vRP.varyThirst(user_id, -100)
			vRP.varyHunger(user_id, -100)
		end)
		vRPclient.notify(player, {"~g~Ti-ai refacut Mancarea!"})
	else
		vRPclient.notify(player, {CanDoVIPFacility})
	end
end


local function sp_weapons(player, choice)
	local user_id = vRP.getUserId(player)
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		vRPclient.giveWeapons(player,{{
			["WEAPON_PISTOL"] = {
				ammo=200
			},
			["WEAPON_MACHETE"] = {
				ammo=1
			}
		}})
		vRPclient.notify(player, {"~y~[SPONSOR] ~g~Ai primit pachetul de Arme!"})
	else
		vRPclient.notify(player, {CanDoSponsorFacility})
	end
end

local function vipBronze_weapons(player,choice)
	local user_id = vRP.getUserId(player)	
	if(vipUtils[user_id] ~= true)then
		vipUtils[user_id] = true
		vRPclient.giveWeapons(player,{{
			["WEAPON_BAT"] = {ammo = 1},
			["WEAPON_SWITCHBLADE"] = {ammo = 1}
		}})
		vRPclient.notify(player,{"Ai primit pachetul de arme specific!"})
	else
		vRPclient.notify(player, {CanDoVIPFacility})
	end
end

local function vipGold_weapons(player,choice)
	local user_id = vRP.getUserId(player)	
	if(vipUtils[user_id] ~= true)then
		vipUtils[user_id] = true
		vRPclient.giveWeapons(player,{{
			["WEAPON_PISTOL"] = {ammo = 125},
			["WEAPON_MINISMG"] = {ammo = 125}
		}})
		vRPclient.notify(player,{"Ai primit pachetul de arme specific!"})
	else
		vRPclient.notify(player, {CanDoVIPFacility})
	end
end

local function sp_goldWeapons(player, choice)
	local user_id = vRP.getUserId(player)
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		vRPclient.giveWeapons(player,{{
			["WEAPON_ASSAULTRIFLE"] = {
				ammo=200,
				supressor="COMPONENT_AT_AR_SUPP_02",
				flash="COMPONENT_AT_AR_FLSH",
				yusuf="COMPONENT_ASSAULTRIFLE_VARMOD_LUXE",
				grip="COMPONENT_AT_AR_AFGRIP",
				scope="COMPONENT_AT_SCOPE_MACRO"
			},
			["WEAPON_MICROSMG"] = {
				ammo=200,
				supressor="COMPONENT_AT_PI_SUPP",
				flash="COMPONENT_AT_AR_FLSH",
				yusuf="COMPONENT_SMG_VARMOD_LUXE",
				scope="COMPONENT_AT_SCOPE_MACRO_02"
			},
			["WEAPON_SWITCHBLADE"] = {
				ammo=1
			},
			["WEAPON_PISTOL"] = {
				ammo=250
			},
		}})
		--vRPclient.upgradeSponsorGoldWeapons(player, {})
		vRPclient.notify(player, {"~y~[SPONSOR] ~g~Ai primit pachetul de Arme (GOLD)!"})
	else
		vRPclient.notify(player, {CanDoSponsorFacility})
	end
end

local function sp_chatTag(player, choice)
	local user_id = vRP.getUserId(player)
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		vRP.prompt(player, "Tag:", "", function(player, theTag)
			theTag = tostring(theTag)
			if(string.len(theTag) <= 10)then
				spTags[user_id] = tostring(theTag)
				vRPclient.notify(player, {"~y~[SPONSOR] ~g~Custom tag setat: ~b~"..theTag})
			else
				vRPclient.notify(player, {"~y~[SPONSOR] ~r~Tag-ul nu poate depasii 10 caractere!"})
			end
		end)
	else
		vRPclient.notify(player, {CanDoSponsorFacility})
	end
end
--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--SPONSOR PACK--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--

--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--SKINS-CARS--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--
local function sp_Child(player, choice)
	vRPclient.setSponsorSkin(player,{"S_M_Y_AirWorker"})
	
end


local function sp_spawnCar(player, choice)
	local user_id = vRP.getUserId(player)
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		vRPclient.spawnVehicle(player,{"16ss"})
	else
		vRPclient.notify(player, {CanDoSponsorFacility})
	end
end

local function sp_spawnCar2(player, choice)
	local user_id = vRP.getUserId(player)
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		vRPclient.spawnVehicle(player,{"16ss"})
	else
		vRPclient.notify(player, {CanDoSponsorFacility})
	end
end

local function sp_spawnRCCar(player,choice)
	local user_id = vRP.getUserId(player)
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		vRPclient.startRCCar(player,{})
	else
		vRPclient.notify(player, {CanDoSponsorFacility})
	end
end
--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--SKINS-CARS--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--

vRP.registerMenuBuilder("main", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id ~= nil then
		local choices = {}

		if vRP.isUserSponsor(user_id) then
			choices["Sponsor Menu"] = {function(player,choice)
				vRP.buildMenu("Sponsor Menu", {player = player}, function(menu)
					menu.name = "Sponsor Menu"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu(player) end
					-- menu["Masinuta Teleghidata"] = {sp_spawnRCCar,"🕹️ > Porneste masinuta teleghidata pe care o poti controla din tableta! (Pentru Amuzament/Distractie, sa NU fie folosita in RolePlay)"}
					 menu["Sky Fall"] = {sp_skyFall,"☁️ > Arunca-te cu parasuta (Sa NU fie folosita in RolePlay)"}
					 menu["Spala Masina"] = {function(player,choice) TriggerClientEvent('washTheCar',player) end,"Spala-ti masina!"}
					menu["Fix Masina"] = {sp_fixCar,"🔧 > Repara-ti vehiculul"}
					menu["Refa Viata"] = {sp_revive,"🏥 > Refa-TI viata"}
					menu["Pachet Arme"] = {sp_goldWeapons,"🔫 > Da-ti un pachet de arme"}
					-- menu["🔫Pachet Arme (GOLD)🔫"] = {sp_goldWeapons,"🔫 > Da-ti un pachet de arme (GOLD) (Sa NU fie folosita in RolePlay)"}
					menu["Rainbow Masina"] = {sp_rainbowCar,"🌈 > Fa masina ta Rainbow."}
					-- menu["🚁Elicopter Sponsor🚁"] = {sp_spawnCar,"🏎️ > Spawneaza elicopter sponsor (Sa NU fie folosita in RolePlay)"}
					menu["Masina Sponsor"] = {sp_spawnCar2,"🏎️ > Spawneaza Masina Sponsor ( SA NU FIE FOLOSITA IN ROLEPLAY )"}
					-- menu["🏷️Custom Chat Tag🏷️"] = {sp_chatTag,"🏷️ > Pune-ti un tag custom in chat"}
					-- menu["👶🏻Skin Copil👶🏻"] = {sp_Child,"👶🏻 > Transforma-te in Copil</br>(SKINUL ACTUAL ITI VA FII STERS) (Sa NU fie folosita in RolePlay)"}
					vRP.openMenu(player,menu)
				end)
			end, "Sponsor Menu"}
		end
		add(choices)
	end
end)

vRP.registerMenuBuilder("main", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id ~= nil then
		local choices = {}
	
		if(vRP.isUserVipBronze(user_id))then
			choices["VIP Menu"] = {function(player,choice)
				vRP.buildMenu("vipMenu", {player = player}, function(menu)
					menu.name = "VIP Menu"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.closeMenu(player) end
					menu["Meniu Arme Albe"] = {vipBronze_weapons, "🔪 > Primesti un pachet de arme albe. Ai grija ce faci cu ele!"}
					menu["Spala Masina"] = {function(player,choice) TriggerClientEvent('washTheCar',player) end,"Spala-ti masina!"}
					menu["Neoane Rainbow"] = {function(player,choice) TriggerClientEvent("toggleRainbowNeon",player) end,"Fa-ti neoanele masinii RGB"}
					if vRP.isUserVipSilver(user_id) then
						menu["Fum Roti Rainbow"] = {function(player,choice) TriggerClientEvent("toggleRainbowTyres",player) end,"Fa-ti fumul masinii RGB"}
						menu["Mancare si Apa Full"] = {vip_fullMancare,"💧 > Apa si Mancare FULL"}
					end
					if vRP.isUserVipGold(user_id) then
						menu["Masina Rainbow"] = {function(player,choice) TriggerClientEvent("toggleRainbowVehicle",player) end,""}
						menu["Meniu Arme Mici"] = {vipGold_weapons, "🔪 > Primesti un pachet de arme mici. Ai grija ce faci cu ele!"}
						--menu["Skin Copil"] = {sp_Child,"👶🏻 > Transforma-te in Copil</br>(SKINUL ACTUAL ITI VA FII STERS) (Sa NU fie folosita in RolePlay)"}
					end
					if vRP.isUserVipDiamond(user_id) then
						menu["Refa Viata"] = {vip_reviv,"🏥 > Refati viata (Sa NU fie folosita in RolePlay)"}
						menu["Xenoane Rainbow"] = {function(player,choice) TriggerClientEvent("toggleRainbowLumini",player) end,""}
					end
					if vRP.isUserVipSupreme(user_id) then
						menu["Fix Masina"] = {vip_fixCar,"🔧 > Repara-ti vehiculul (Sa NU fie folosita in RolePlay)"}
					end
					vRP.openMenu(player,menu)
				end)
			end, "Meniu VIP"}
		end
		add(choices)
	end
end)

function vRP.getSponsorTag(user_id)
	if spTags[user_id] then
		theTag = spTags[user_id]
		return theTag
	else
		return false 
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		local users = vRP.getUsers()
		for i, v in pairs(users) do
			if(vRP.isUserSponsor(i)) and (spUtils[i] == true)then
				spUtils[i] = nil
				vRPclient.notify(v, {"~y~[SPONSOR] ~g~Acum Iti Poti Folosii Facilitatile De Sponsor!"})
			end
			if(vRP.isUserVipBronze(i)) and (vipUtils[i] == true) then
				vipUtils[i] = nil
				vRPclient.notify(v, {"~y~[VIP Meniu] ~g~Acum Iti Poti Folosii Facilitatile VIP!"})
			end
		end
	end
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
	if(spCars[user_id] ~= nil)then
		vRPclient.deleteSponsorCar()
		spCars[user_id] = nil
	end
	if(spTags[user_id] ~= nil)then
		spTags[user_id] = nil
	end
end)

RegisterNetEvent("baseevents:enteredVehicle")
AddEventHandler("baseevents:enteredVehicle", function(theVehicle, theSeat, vehicleName)
	if(theSeat == -1)then
		if(vehicleName == "SENNA" or vehicleName == "SENNA")then
			local user_id = vRP.getUserId(source)
			if not(vRP.isUserSponsor(user_id))then
				vRPclient.teleportOutOfSponsorCar(source, {theVehicle})
				vRPclient.notify(source, {"[SPONSOR] ~r~Nu poti conduce masina de ~y~Sponsor"})
			end
		end
	end
end)