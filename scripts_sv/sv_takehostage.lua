RegisterServerEvent('TakeHostage:sync')
AddEventHandler('TakeHostage:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
  	TriggerClientEvent('cmg3_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
  	TriggerClientEvent('cmg3_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('TakeHostage:stop')
AddEventHandler('TakeHostage:stop', function(targetSrc)
  	TriggerClientEvent('cmg3_animations:cl_stop', targetSrc)
end)

local carry = {}

RegisterServerEvent('Carry:sync')
AddEventHandler('Carry:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	if not targetSrc or carry[source] then return end;
	carry[source] = true
  	TriggerClientEvent('Carry:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
  	TriggerClientEvent('Carry:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('Carry:stop')
AddEventHandler('Carry:stop', function(targetSrc)
	if not targetSrc or not carry[source] then return end;
	carry[source] = nil
  	TriggerClientEvent('Carry:cl_stop', targetSrc)
end)

AddEventHandler("vRP:playerLeave", function(_, player)
	if carry[player] then 
		carry[player] = nil;
	end
end)