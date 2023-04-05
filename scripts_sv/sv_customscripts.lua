--------------------------------------------------------

--------------------HOPSITAL

--------------------------------------------------------

local bedsLocations, usedBeds = {
    [1] = {x = -797.14, y = -1231.29, z = 7.25, h = 142.96, model = 1631638868};
    [2] = {x = -800.99, y = -1227.95, z = 7.25, h = 142.96, model = 1631638868};
    [3] = {x = -805.52, y = -1224.05, z = 7.25, h = 142.96, model = 1631638868};
    [4] = {x = -809.12, y = -1221.04, z = 7.25, h = 142.96, model = 1631638868};
    [5] = {x = -812.11, y = -1224.56, z = 7.25, h = 317.26, model = 1631638868};
    [6] = {x = -809.66, y = -1226.70, z = 7.25, h = 317.26, model = 1631638868};
    [7] = {x = -806.74, y = -1228.98, z = 7.25, h = 317.26, model = 1631638868};
    [8] = {x = -804.08, y = -1231.26, z = 7.25, h = 317.26, model = 1631638868};
    [9] = {x = -800.06, y = -1234.67, z = 7.25, h = 317.26, model = 1631638868};
}, {};

RegisterNetEvent("vrp_hospital:SendToBed", function(bedId, isRevive)
    local player = source;
	if not (bedsLocations[bedId] and not bedsLocations[bedId]["taken"] and not usedBeds[player]) then return end;
	return(function ()
        usedBeds[player] = bedId;
        bedsLocations[bedId]["taken"] = true;
		TriggerClientEvent("vrp_hospital:SendBed", player, bedId, bedsLocations[bedId], isRevive);
		TriggerClientEvent("vrp_hospital:SetBed", -1, bedId, true);
	end)();
end);

RegisterNetEvent("vrp_hospital:hospitalCheckInPay", function ()
	local player = source;
	local user_id = vRP["getUserId"](player);
	return (user_id and vRP["tryPayment"](user_id, 150));
end);

RegisterNetEvent("vrp_hospital:LeaveBed", function(bedId)
    local player = source;
	if not (bedsLocations[bedId] and bedsLocations[bedId]["taken"] and (usedBeds[player] == bedId)) then return end;
    return(function ()
        usedBeds[player] = nil;
        bedsLocations[bedId]["taken"] = nil;
        TriggerClientEvent("vrp_hospital:SetBed", -1, bedId, false);
    end)();
end);

AddEventHandler("vRP:playerLeave", function (...)
    local args = {...};
    local player = tonumber(args[2]);
    return(player and usedBeds[player] and (function ()
        local bedId = usedBeds[player];
        usedBeds[player] = nil;
        bedsLocations[bedId]["taken"] = nil;
        TriggerClientEvent("vrp_hospital:SetBed", -1, bedId, false);
    end)());
end);