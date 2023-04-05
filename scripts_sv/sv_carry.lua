-- local carry = {}

-- RegisterServerEvent('cmg2_animations:sync')
-- AddEventHandler('cmg2_animations:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
-- 	if not targetSrc or carry[source] then return end;
-- 	carry[source] = true
-- 	TriggerClientEvent('cmg2_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
-- 	TriggerClientEvent('cmg2_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
-- end)

-- RegisterServerEvent('cmg2_animations:stop')
-- AddEventHandler('cmg2_animations:stop', function(targetSrc)
-- 	if not targetSrc or not carry[source] then return end;
-- 	carry[source] = nil
-- 	TriggerClientEvent('cmg2_animations:cl_stop', targetSrc)
-- end)

-- AddEventHandler("vRP:playerLeave", function(_, player)
-- 	if not carry[player] then return end;
-- 	carry[player] = nil;
-- end)