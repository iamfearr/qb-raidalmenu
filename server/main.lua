RegisterServerEvent('json:dataStructure')
AddEventHandler('json:dataStructure', function(data)
    -- ??
end)

RegisterServerEvent('qb-radialmenu:trunk:server:Door')
AddEventHandler('qb-radialmenu:trunk:server:Door', function(open, plate, door)
    TriggerClientEvent('qb-radialmenu:trunk:client:Door', -1, plate, door, open)
end)

RegisterNetEvent('vehiclekeys:server:GiveVehicleKeys', function(plate, target)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.GiveKeyMenu then
        if CheckOwner(plate, Player.PlayerData.citizenid) then
            if QBCore.Functions.GetPlayer(target) ~= nil then
                TriggerClientEvent('vehiclekeys:client:SetOwner', target, plate)
                TriggerClientEvent('QBCore:Notify', src, "you gave the key!")
                TriggerClientEvent('QBCore:Notify', target, "you recived the key!")
            end
        else
            TriggerClientEvent('QBCore:Notify', source,  "You don't own this car", "error")
        end
    else
        if CheckOwner(plate, Player.PlayerData.citizenid) then
            if QBCore.Functions.GetPlayer(target) ~= nil then
                TriggerClientEvent('vehiclekeys:client:SetOwner', target, plate)
                TriggerClientEvent('QBCore:Notify', src, "you gave the key!")
                TriggerClientEvent('QBCore:Notify', target, "you recived the key!")
            else
                TriggerClientEvent('QBCore:Notify', source,  "người chơi không online", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', source,  "You don't own this car", "error")
        end
    end
end)