------------------- ON RESSOURCE START PRINT --------------------

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	print('Die Ressource ' .. resourceName .. ' wurde gestartet.')
  end)
  
------------------------------------------------------------------

ESX = nil
ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('dv_personalmenu:getJob')
AddEventHandler('dv_personalmenu:getJob', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.label
    return job
end)

RegisterNetEvent('dv_personalmenu:getJobLabel')
AddEventHandler('dv_personalmenu:getJobLabel', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local jobgrade = xPlayer.job.grade_label
    return jobgrade
end)
