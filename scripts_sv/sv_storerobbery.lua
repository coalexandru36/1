math.randomseed(os.time())
local safeCooldowns = {}

local stores = {
	{-47.861663818359, -1759.3719482422, 28.421010971069},
	{-46.668876647949, -1758.0550537109, 28.421010971069},
	{1134.1508789063, -982.48638916016, 45.415809631348},
	{-1221.9808349609, -908.28363037109, 11.326354026794},
	{-1486.2336425781, -377.97994995117, 39.163421630859},
	{-2966.4196777344, 390.85485839844, 14.043313026428},
	{373.07879638672, 328.72894287109, 102.56639099121},
	{372.50723266602, 326.4162902832, 102.56639099121},
	{24.464073181152, -1344.9854736328, 28.497026443481},
	{24.404426574707, -1347.2951660156, 28.497026443481},
	{2554.8881835938, 380.85437011719, 107.62294769287},
	{2557.2954101563, 380.78680419922, 107.62294769287},
	{-3041.2126464844, 583.82006835938, 6.9089317321777},
	{-3038.9929199219, 584.50128173828, 6.9089317321777},
	{-3244.6044921875, 1000.2213134766, 11.830711364746},
	{-3242.2651367188, 999.96533203125, 11.830711364746},
	{1164.9465332031, -322.81149291992, 68.205146789551},
	{1165.0662841797, -324.4753112793, 68.205146789551},

	{-43.383319854736, -1748.3692626953, 28.421016693115},
	{1126.85546875, -980.15093994141, 44.415821075439},
	{-1220.8062744141, -915.96447753906, 10.326337814331},
	{-1478.9613037109, -375.39627075195, 38.163410186768},
	{-2959.5825195313, 387.11947631836, 13.043292045593},
	{378.18743896484, 333.33502197266, 102.56645965576},
	{28.238605499268, -1339.1877441406, 28.497045516968},
	{2549.2097167969, 384.93664550781, 107.62303924561},
	{-3047.8762207031, 585.61206054688, 6.908935546875},
	{-3250.001953125, 1004.4180297852, 11.830711364746},
	{1159.5357666016, -314.09973144531, 68.205139160156}
}

Citizen.CreateThread(function()
    while true do 
        Wait(1000)
        if #safeCooldowns >= 1 then 
            for i = 1, #safeCooldowns do 
                safeCooldowns[i].seconds = safeCooldowns[i].seconds - 1 
                if(safeCooldowns[i].seconds <= 0 ) then 
                    safeCooldowns[i].seconds = 60
                    safeCooldowns[i].mins = safeCooldowns[i].mins - 1
                    if (safeCooldowns[i].mins <= 0) then 
                        table.remove(safeCooldowns,i)
                    end
                end
            end
        end
    end
end)

local isSafeOnCooldown = function(safeId)
    for i = 1, #safeCooldowns do 
        if safeCooldowns[i].safeId == safeId then 
            return true 
        end
    end
    return false
end

local removeSafeCooldown = function(safeId)
    for i = 1, #safeCooldowns do 
        if safeCooldowns[i].safeId == safeId then 
            table.remove(safeCooldowns,i)
        end
    end
end

local getThreeRandomNumbers = function()
    local first = math.random(1,5)
    local second = math.random(3,8)
    local third = math.random(5,15)
    return first,second,third
end

local getNumberOfRobbedStores = function()
    return #safeCooldowns
end

local getSafeRemainingMinutes = function(safeId)
    for i = 1, #safeCooldowns do 
        if safeCooldowns[i].safeId == safeId then 
            return safeCooldowns[i].mins
        end
    end
end


local getSafeCoords = function(safeId)
    for i = 1,#stores do 
        if i == safeId then 
            return stores[i]
        end
    end
end

local setSafeOnCooldown = function(safeId)
    table.insert(safeCooldowns,{safeId = safeId, mins = 20, seconds = 60, coords = getSafeCoords(safeId)})
end

RegisterNetEvent('ples:trySR', function(safeId)
    local user_id = vRP.getUserId(source)
    if vRP.getUserHoursPlayed(user_id) < 10 then return vRPclient.notify(source,{'Eroare: Ai nevoie de 10 ore pentru a da jaf'}) end
    if (isSafeOnCooldown(safeId)) then return vRPclient.notify(source,{'Eroare: Cooldown: ' .. getSafeRemainingMinutes(safeId) .. ' minute'}) end;
    if(getNumberOfRobbedStores() >= 5) then vRPclient.notify(source,{'Eroare: Prea multe jafuri in desfasurare!'}) return end
    setSafeOnCooldown(safeId)
    local f,s,t = getThreeRandomNumbers()
    Citizen.SetTimeout(1000 * 10, function()
        local safeCoords = getSafeCoords(safeId)
        TriggerClientEvent('ples:blipSR',-1,safeId,safeCoords,false)
        TriggerEvent('alertPolitie','^1 Ziro NEWS: ^0Un magazin este ^5jefuit ^0chiar acum!')
        TriggerEvent('S_WANTED:addTempWanted', user_id,3,5)
    end)    
    TriggerClientEvent('ples:startSR', source,safeId,{f,s,t},5)
    vRPclient.notify(source,{'Succes: Ai inceput un jaf!'})
end)

RegisterNetEvent('ples:cancelSR', function(safeId)
    removeSafeCooldown(safeId)
end)

RegisterNetEvent('ples:checkSR', function(safeId,result)
    local player = source
    local user_id = vRP.getUserId(player)
    local safeCoords = getSafeCoords(safeId)
    vRPclient.teleport(player,{safeCoords[1],safeCoords[2],safeCoords[3]})
    if result then 
        local amount = math.random(2000000,3500000)
        vRP.giveMoney(user_id, amount)
    else
        vRPclient.notify(player,{'Eroare: Ai esuat jaful!'})
    end
end)

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
    local source = source
    if first_spawn then 
        TriggerClientEvent('ples:initblipsSR', source, #stores)
    end
end)