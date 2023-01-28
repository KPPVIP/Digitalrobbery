Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  }
  





  
  Citizen.CreateThread(function ()
      while ESX == nil do
          TriggerEvent('esx:getSharedObject', function(obj) 
              ESX = obj
          end)
  
          Citizen.Wait(1)
      end
  
      if ESX.IsPlayerLoaded() then
          ESX.PlayerData = ESX.GetPlayerData()
      end
  end) 
  
  RegisterNetEvent('esx:setJob')
  AddEventHandler('esx:setJob', function(job)
      ESX.PlayerData.job = job
  end)

local lastara = 0  
local lastara2 = 0
local lastara3 = 0
local lastara4 = 0
  
  local start = {
    [1] = {x = -656.68, y = -858.77, z = 24.49, info = 'Başlangıç Yeri'},
}  

local aras = {
 {x = -660.52, y = -857.27, z = 24.49, info = 'Eşyalar kutular'},
}

local aras2 = {
  {x = -659.0, y = -859.01, z = 24.49, info = 'Kameralar'},
}

local aras3 = {
    {x = -661.81, y = -861.81, z = 24.49, info = 'Kutular2'},
  }
 
  local aras4 = {
    {x = -659.22, y = -861.75, z = 24.49, info = 'Bilgisayar'},
  }

    
  
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.0002+ factor, 0.025, 0, 0, 0, 50)
end  

function hasanAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
	end)
end

function hasananim2()
    hasanAnim("missheist_jewel", "smash_case")
    exports["aex-bar"]:taskBar(4500, "Aranıyor! ")   
    ClearPedTasks(PlayerPedId())
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(5)
    end
end

RegisterNetEvent('kapitoggle')
AddEventHandler('kapitoggle', function()
    local kapi = GetHashKey(Config.Kapi)

end)
  

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        local coords, letSleep  = GetEntityCoords(PlayerPedId()), true
        for k,v in pairs(start) do
            if Vdist2(GetEntityCoords(PlayerPedId(), false), v.x, v.y, v.z) < 1 then
                letSleep = false
                DrawText3Ds(v.x, v.y, v.z+0.50, "[E] Soyguna Basla")
                if IsControlJustReleased(0,119) then
                    ESX.TriggerServerCallback('hsntq:copCount', function(cops)
                        if cops >= Config.LSPD then -- polis sayısı
                        exports["aex-bar"]:taskBar(5000, "Soygun Başlıyor! ")  
                        TriggerServerEvent('hsn:notifff')
                        TriggerEvent('hsnanim')
                        TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Tüm Dükkanı Soy!', length = 3500})
                        TriggerEvent('hsn:start')
                        TriggerEvent('hsn:start2')
                        TriggerEvent('hsn:start3')
                        TriggerEvent('hsn:start4')
                    else
                            TriggerEvent("notification", 'Şehirde yeterli polis yok', 2)      
                        end       
                    end)
                    return
                end               
            end
        end
        if letSleep then
            Citizen.Wait(1000)
        end
    end
end) 


Citizen.CreateThread(function()
      
	while true do
		Wait(1)
		if animazione == true then
			if not IsEntityPlayingAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 3) then
				TaskPlayAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 8.0, 8.0, -1, 17, 1, false, false, false)
			end
		end
	end
end)


RegisterNetEvent( 'hsnanim' )
AddEventHandler( 'hsnanim', function() 
    ClearPedSecondaryTask(GetPlayerPed(-1))
    loadAnimDict( "anim@heists@keycard@" ) 
    TaskPlayAnim( GetPlayerPed(-1), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 48, 0, 0, 0, 0 )
    Citizen.Wait(850)
    ClearPedTasks(GetPlayerPed(-1))

end)



RegisterNetEvent('hsn:start')
AddEventHandler('hsn:start', function()
Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        local playerPed = GetPlayerPed(-1)
        local coords, shn  = GetEntityCoords(PlayerPedId()), true
        for k,v in pairs(aras) do
            if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1 then
                DrawText3Ds(v.x, v.y, v.z+0.50, "[E] Ara")
                if IsControlJustReleased(0,119) then
                    if lastara ~= k then
                        lastara = k
                    hasananim2()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('hsn:para')
                    else
                    ESX.ShowNotification('Burayı Zaten Soydun Burası Boş')  
                    end 
                end
            end
        end
    end
end)
end)



RegisterNetEvent('hsn:start2')
AddEventHandler('hsn:start2', function()
Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        local playerPed = GetPlayerPed(-1)
        local coords, shn  = GetEntityCoords(PlayerPedId()), true
        for k,v in pairs(aras2) do
            if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1 then
                DrawText3Ds(v.x, v.y, v.z+0.50, "[E] Ara")
                if IsControlJustReleased(0,119) then
                    if lastara2 ~= k then
                        lastara2 = k
                    hasananim2()                      
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('hsn:para')
                    else
                    ESX.ShowNotification('Burayı Zaten Soydun Burası Boş') 
                    end
                end
            end
        end
    end
end)
end)

RegisterNetEvent('hsn:start3')
AddEventHandler('hsn:start3', function()
Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        local playerPed = GetPlayerPed(-1)
        local coords, shn  = GetEntityCoords(PlayerPedId()), true
        for k,v in pairs(aras3) do
            if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1 then
                DrawText3Ds(v.x, v.y, v.z+0.50, "[E] Ara")
                if IsControlJustReleased(0,119) then
                    if lastara3 ~= k then
                        lastara3 = k
                    hasananim2()   
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('hsn:para')
                    else
                    ESX.ShowNotification('Burayı Zaten Soydun Burası Boş') 
                    end     
                end
            end
        end
    end
end)
end)

RegisterNetEvent('hsn:start4')
AddEventHandler('hsn:start4', function()
Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        local playerPed = GetPlayerPed(-1)
        local coords, shn  = GetEntityCoords(PlayerPedId()), true
        for k,v in pairs(aras4) do
            if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1 then
                DrawText3Ds(v.x, v.y, v.z+0.50, "[E] Ara")
                if IsControlJustReleased(0,119) then
                    if lastara4 ~= k then
                        lastara4 = k
                    hasananim2() 
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('hsn:para')
                    else
                    ESX.ShowNotification('Burayı Zaten Soydun Burası Boş') 
                    end
                end
            end
        end
    end
end)
end)





RegisterNetEvent('hsn:setblip')
AddEventHandler('hsn:setblip', function()
    local coords = {x = -560.6, y = 282.09, z = 85.68}
    exports["mythic_notify"]:SendAlert("infrom", "Teknoloji Marketi Soyuluyor Yetiş!", 5000, {["background-color"] = "#CD472A", ["color"] = "#ffffff"})
    blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 161)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 75)
end)
  