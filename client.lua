-------------------------------------------------
-- Created by DV Dev
-------------------------------------------------------
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData = {}

ESX = nil
ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

function OpenLicensesInformation()
  ESX.UI.Menu.Close()

  ESX.UI.Menu.Open('default',GetCurrentResourceName(),'more_info',
  { 
  title = _U('titleInfo'), 
  align = 'left', 
  elements = {
      {label = _U('seedriver'), value = 'seeDriver'},
      {label = _U('showdriver'), value = 'showDriver'},
      {label = _U('seeguns'), value = 'seeGuns'},
      {label = _U('showguns'), value = 'showGuns'},
    },
  }, function(data, menu)

    local player, distance = ESX.Game.GetClosestPlayer()
    
    if data.current.value == 'seeDriver' then
      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
    elseif data.current.value == 'showDriver' then
      if distance ~= -1 and distance <= 3.0 then
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')  
      else
        ESX.ShowNotification('Niemand in der Nähe um Ausweis zu zeigen')  
      end
    elseif data.current.value == 'seeGuns' then
      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapons') 
    elseif data.current.value == 'showGuns' then
      if distance ~= -1 and distance <= 3.0 then
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapons') 
      else
        ESX.ShowNotification('Niemand in der Nähe um Ausweis zu zeigen') 
      end
    end
  end, function(data, menu) 
  menu.close() 
  end)
end

function OpenMenuPersonal()
    ESX.UI.Menu.CloseAll()

    local DataJob = ESX.GetPlayerData()
    local ids = true
    local job = DataJob.job.label
    local jobgrade = DataJob.job.grade_label

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'dv_menu',
      {
        title    = _U('title'),
        align    = 'left',
        elements = {
          {label = _U('showid'), value = 'showid'},
          {label = _U('seeid'), value = 'seeid'},
          {label = _U('infoLicenses'), value = 'licenses_interaction'},
        },
      },
      function(data, menu)

        local player, distance = ESX.Game.GetClosestPlayer()

          if data.current.value == 'infoids' then
          ExecuteCommand("ids")                                                    
          if ids then
            ids = false
            ESX.ShowNotification('IDs <span style="color:yellow">aktiviert</span')  
          else
            ids = true
            ESX.ShowNotification('IDs <span style="color:yellow">deaktiviert</span') 
          end
        elseif data.current.value == 'showid' then
          local player, distance = ESX.Game.GetClosestPlayer()
          if distance ~= -1 and distance <= 3.0 then
	          TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player)) 
          else
            ESX.ShowNotification('Keine Spieler in der<span style="color:yellow"> in der nähe</span>')  
          end
        elseif data.current.value == 'seeid' then
          TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))  
        elseif data.current.value == 'licenses_interaction' then
          OpenLicensesInformation()
        elseif data.current.value == 'billing_menu' then
          ShowBillsMenu()                                     
        elseif data.current.value == 'stadistics' then
          ExecuteCommand("habilidades")                        
        end
      end,
      function(data, menu)
        menu.close()
      end
    )
end

--Key Controls
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlPressed(0,  168) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'dv_menu')  then
      OpenMenuPersonal()
    end
  end
end)
