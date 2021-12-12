QBCore = exports['qb-core']:GetCoreObject()
local inRadialMenu = false

RegisterCommand('radialmenu', function()
	QBCore.Functions.GetPlayerData(function(PlayerData)
        if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] and not IsPauseMenuActive() then
			openRadial(true)
			SetCursorLocation(0.5, 0.5)
		end
	end)
end)

RegisterKeyMapping('radialmenu', 'Open Radial Menu', 'keyboard', 'F1')

--Qb-garages
CreateThread(function()
    for k, v in pairs(Garages) do --Public Garage
        exports['polyzonehelper']:AddBoxZone("InGarage", Garages[k].pz, Garages[k].length, Garages[k].width, {
            name="InGarage",
            heading=Garages[k].heading,
            minZ=Garages[k].minZ,
            maxZ=Garages[k].maxZ,
            debugPoly=Garages[k].debugPz
        })
    end
    for k, v in pairs(JobGarages) do --Job Garage
        exports['polyzonehelper']:AddBoxZone("InJobGarage", JobGarages[k].pz, JobGarages[k].length, JobGarages[k].width, {
            name="InJobGarage",
            heading=JobGarages[k].heading,
            minZ=JobGarages[k].minZ,
            maxZ=JobGarages[k].maxZ,
            debugPoly=JobGarages[k].debugPz
        })
    end
    for k, v in pairs(GangGarages) do --Gang Garage
        exports['polyzonehelper']:AddBoxZone("InGangGarage", GangGarages[k].pz, GangGarages[k].length, GangGarages[k].width, {
            name="InGangGarage",
            heading=GangGarages[k].heading,
            minZ=GangGarages[k].minZ,
            maxZ=GangGarages[k].maxZ,
            debugPoly=GangGarages[k].debugPz
        })
    end
    for k, v in pairs(Depots) do --Depot Garage
        exports['polyzonehelper']:AddBoxZone("InDepots", Depots[k].pz, Depots[k].length, Depots[k].width, {
            name="InDepots",
            heading = Depots[k].heading,
            debugPoly= Depots[k].debugPz
        })
    end
end)

local inGarage = false
local inDepots = false
local inJobGarage = false
local inGangGarage = false

AddEventHandler('polyzonehelper:enter', function(name)
    if LocalPlayer.state["isLoggedIn"] then
        if name == "InGarage" then
            inGarage = true
            print('Garage: enter')
        elseif name == "InDepots" then
            inDepots = true
            print('Depot: enter')
        elseif name == "InJobGarage" then
            inJobGarage = true
            print('JobGarage: Enter')
        elseif name == "InGangGarage" then
            inGangGarage = true
            print('GangGarage: Enter')
        end  
    end
end)

AddEventHandler('polyzonehelper:exit', function(name)
    if LocalPlayer.state["isLoggedIn"] then
        if name == "InGarage" then
            inGarage = false
            print('Garage: exit')
        elseif name == "InDepots" then
            inDepots = false
            print('Depot: exit')
        elseif name == "InJobGarage" then
            inJobGarage = false
            print('JobGarage: Exit')
        elseif name == "InGangGarage" then
            inGangGarage = false
            print('GangGarage: Exit')
        end
    end
end)

exports("ZoneType", function(Zone)
    if Zone == "GarageZone" then
        return inGarage
    elseif Zone == "DepotZone" then
        return inDepots
    elseif Zone == "JobGarageZone" then
        return inJobGarage
    elseif Zone == "GangGarageZone" then
        return inGangGarage
    end
end)
--

function setupSubItems()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["isdead"] then
            if PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" then
                Config.MenuItems[4].items = {
                    [1] = {
                        id = 'emergencybutton2',
                        title = 'Emergencybutton',
                        icon = '#general',
                        type = 'client',
                        event = 'police:client:SendPoliceEmergencyAlert',
                        shouldClose = true,
                    },
                }
            end
        else
            if Config.JobInteractions[PlayerData.job.name] ~= nil and next(Config.JobInteractions[PlayerData.job.name]) ~= nil then
                Config.MenuItems[4].items = Config.JobInteractions[PlayerData.job.name]
<<<<<<< HEAD
            else 
=======
            else
>>>>>>> e8437c3cbcb1f2dd8a090bc2ee17f4d7f996718c
                Config.MenuItems[4].items = {}
            end
        end
    end)

<<<<<<< HEAD
    RegisterNetEvent('qb-radialmenu:client:flipvehicle', function()
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        if DoesEntityExist(vehicle) then
            exports['progressbar']:Progress({
                name = "flipping_vehicle",
                duration = 5000,
                label = "Fliping Vehicle...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "random@mugging4",
                    anim = "struggle_loop_b_thief",
                    flags = 49,
                }
            }, function(status)
                SetVehicleOnGroundProperly(vehicle)
            end)
        else
            QBCore.Functions.Notify('No vehicle nearby', 'error', 2500) 
        end
    end)

    if Config.GiveKeyMenu then
        RegisterNetEvent('vehiclekeys:client:GiveKeys', function(target)
            local Vehicle, VehDistance = QBCore.Functions.GetClosestVehicle()
            local plate = QBCore.Functions.GetPlate(Vehicle, true)
            local Player, Distance = GetClosestPlayer()
            if Vehicle ~= -1 and Player ~= 0 and VehDistance < 2.3 then
                if Player ~= -1 and Player ~= 0 and Distance < 2.3 then
                    TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', plate, GetPlayerServerId(Player))
                else
                    QBCore.Functions.Notify('No one nearby', 'error')
                end
            else
                QBCore.Functions.Notify('No vehicle nearby', 'error')
            end
        end)
    else
        RegisterNetEvent('vehiclekeys:client:GiveKeys', function(target)
            local plate = QBCore.Functions.GetPlate(GetVehiclePedIsIn(PlayerPedId(), true))
            TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', plate, target)
        end)
    end

=======
>>>>>>> e8437c3cbcb1f2dd8a090bc2ee17f4d7f996718c
    local Vehicle = GetVehiclePedIsIn(PlayerPedId())

    if Vehicle ~= nil or Vehicle ~= 0 then
        local AmountOfSeats = GetVehicleModelNumberOfSeats(GetEntityModel(Vehicle))

        if AmountOfSeats == 2 then
            Config.MenuItems[3].items[3].items = {
                [1] = {
                    id    = -1,
                    title = 'Driver',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [2] = {
                    id    = 0,
                    title = 'Passenger',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
            }
        elseif AmountOfSeats == 3 then
            Config.MenuItems[3].items[3].items = {
                [4] = {
                    id    = -1,
                    title = 'Driver',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [1] = {
                    id    = 0,
                    title = 'Passenger',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [3] = {
                    id    = 1,
                    title = 'Other',
                    icon = 'caret-down',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
            }
        elseif AmountOfSeats == 4 then
            Config.MenuItems[3].items[3].items = {
                [4] = {
                    id    = -1,
                    title = 'Driver',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [1] = {
                    id    = 0,
                    title = 'Passenger',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [3] = {
                    id    = 1,
                    title = 'Rear Left',
                    icon = 'caret-down',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [2] = {
                    id    = 2,
                    title = 'Rear Right',
                    icon = 'caret-down',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
            }
        end
    end
    -- qb-garages
    if inGarage then
        Config.MenuItems[5] = {
            id = 'garage',
            title = 'Parking Garage',
            icon = 'parking',
            items = {
                {
                    id = 'garagetake',
                    title = 'Take Out Vehicle',
                    icon = 'warehouse',
                    type = 'client',
                    event = 'Garages:PutOutGarage',
                    shouldClose = true
                },
                {
                    id = 'garagesave',
                    title = 'Park Vehicle',
                    icon = 'car',
                    type = 'client',
                    event = 'Garages:PutInGarage',
                    shouldClose = true
                },
            },
        }
    elseif inDepots then
        Config.MenuItems[5] = {
            id = 'depots',
            title = 'Hayes Depots',
            icon = 'question',
            items = {
                {
                    id = 'depotstake',
                    title = 'Take Vehicle',
                    icon = 'car',
                    type = 'client',
                    event = 'Garages:TakeOutDepots',
                    shouldClose = true
                },
            },
        }
    elseif inJobGarage then
        Config.MenuItems[5] = {
            id = 'jobgarage',
            title = 'Parking',
            icon = 'parking',
            items = {
                {
                    id = 'jobgaragetake',
                    title = 'Take Out Vehicle',
                    icon = 'warehouse',
                    type = 'client',
                    event = 'Garage:PutOutJob',
                    shouldClose = true
                },
                {
                    id = 'jobgaragesave',
                    title = 'Park Vehicle',
                    icon = 'car',
                    type = 'client',
                    event = 'Garage:PutInJob',
                    shouldClose = true
                },
            },
        }
    elseif inGangGarage then
        Config.MenuItems[5] = {
            id = 'ganggarage',
            title = 'Parking',
            icon = 'parking',
            items = {
                {
                    id = 'ganggaragetake',
                    title = 'Take Out Vehicle',
                    icon = 'warehouse',
                    type = 'client',
                    event = 'Garage:PutOutGang',
                    shouldClose = true
                },
                {
                    id = 'ganggaragesave',
                    title = 'Park Vehicle',
                    icon = 'car',
                    type = 'client',
                    event = 'Garage:PutInGang',
                    shouldClose = true
                },
            },
        }
    elseif not inGarage and not inDepots and not inGangGarage and not inJobGarage then
        Config.MenuItems[5] = nil
    end
end

function openRadial(bool)
    setupSubItems()

    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        radial = bool,
        items = Config.MenuItems
    })
    inRadialMenu = bool
end

function closeRadial(bool)
    SetNuiFocus(false, false)
    inRadialMenu = bool
end

function getNearestVeh()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    return vehicleHandle
end

RegisterNUICallback('closeRadial', function()
    closeRadial(false)
end)

RegisterNUICallback('selectItem', function(data)
    local itemData = data.itemData

    if itemData.type == 'client' then
        TriggerEvent(itemData.event, itemData)
    elseif itemData.type == 'server' then
        TriggerServerEvent(itemData.event, itemData)
    end
end)

RegisterNetEvent('qb-radialmenu:client:noPlayers', function(data)
    QBCore.Functions.Notify('There arent any people close', 'error', 2500)
end)

RegisterNetEvent('qb-radialmenu:client:giveidkaart', function(data)
    -- ??
end)

RegisterNetEvent('qb-radialmenu:client:openDoor', function(data)
    local string = data.id
    local replace = string:gsub("door", "")
    local door = tonumber(replace)
    local ped = PlayerPedId()
    local closestVehicle = nil

    if IsPedInAnyVehicle(ped, false) then
        closestVehicle = GetVehiclePedIsIn(ped)
    else
        closestVehicle = getNearestVeh()
    end

    if closestVehicle ~= 0 then
        if closestVehicle ~= GetVehiclePedIsIn(ped) then
            local plate = QBCore.Functions.GetPlate(closestVehicle)
            if GetVehicleDoorAngleRatio(closestVehicle, door) > 0.0 then
                if not IsVehicleSeatFree(closestVehicle, -1) then
                    TriggerServerEvent('qb-radialmenu:trunk:server:Door', false, plate, door)
                else
                    SetVehicleDoorShut(closestVehicle, door, false)
                end
            else
                if not IsVehicleSeatFree(closestVehicle, -1) then
                    TriggerServerEvent('qb-radialmenu:trunk:server:Door', true, plate, door)
                else
                    SetVehicleDoorOpen(closestVehicle, door, false, false)
                end
            end
        else
            if GetVehicleDoorAngleRatio(closestVehicle, door) > 0.0 then
                SetVehicleDoorShut(closestVehicle, door, false)
            else
                SetVehicleDoorOpen(closestVehicle, door, false, false)
            end
        end
    else
        QBCore.Functions.Notify('There is no vehicle in sight...', 'error', 2500)
    end
end)

RegisterNetEvent('qb-radialmenu:client:setExtra', function(data)
    local string = data.id
    local replace = string:gsub("extra", "")
    local extra = tonumber(replace)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    if veh ~= nil then
        local plate = QBCore.Functions.GetPlate(closestVehicle)
        if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            SetVehicleAutoRepairDisabled(veh, true) -- Forces Auto Repair off when Toggling Extra [GTA 5 Niche Issue]
            if DoesExtraExist(veh, extra) then
                if IsVehicleExtraTurnedOn(veh, extra) then
                    SetVehicleExtra(veh, extra, 1)
                    QBCore.Functions.Notify('Extra ' .. extra .. ' Deactivated', 'error', 2500)
                else
                    SetVehicleExtra(veh, extra, 0)
                    QBCore.Functions.Notify('Extra ' .. extra .. ' Activated', 'success', 2500)
                end
            else
                QBCore.Functions.Notify('Extra ' .. extra .. ' is not present on this vehicle ', 'error', 2500)
            end
        else
            QBCore.Functions.Notify('You\'re not a driver of a vehicle!', 'error', 2500)
        end
    end
end)

RegisterNetEvent('qb-radialmenu:trunk:client:Door', function(plate, door, open)
    local veh = GetVehiclePedIsIn(PlayerPedId())

    if veh ~= 0 then
        local pl = QBCore.Functions.GetPlate(veh)

        if pl == plate then
            if open then
                SetVehicleDoorOpen(veh, door, false, false)
            else
                SetVehicleDoorShut(veh, door, false)
            end
        end
    end
end)

local Seats = {
    ["-1"] = "Driver's Seat",
    ["0"] = "Passenger's Seat",
    ["1"] = "Rear Left Seat",
    ["2"] = "Rear Right Seat",
}

RegisterNetEvent('qb-radialmenu:client:ChangeSeat', function(data)
    local Veh = GetVehiclePedIsIn(PlayerPedId())
    local IsSeatFree = IsVehicleSeatFree(Veh, data.id)
    local speed = GetEntitySpeed(Veh)
    local HasHarnass = exports['qb-smallresources']:HasHarness()
    if not HasHarnass then
        local kmh = (speed * 3.6);

        if IsSeatFree then
            if kmh <= 100.0 then
                SetPedIntoVehicle(PlayerPedId(), Veh, data.id)
                QBCore.Functions.Notify('You are now on the  '..data.title..'!')
            else
                QBCore.Functions.Notify('This vehicle is going too fast..')
            end
        else
            QBCore.Functions.Notify('This seat is occupied..')
        end
    else
        QBCore.Functions.Notify('You have a race harness on you cant switch..', 'error')
    end
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

exports('radialmenu', function(id, data)
    Config.MenuItems[id] = data
end)
