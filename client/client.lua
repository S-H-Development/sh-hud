local vehicleNUI = false
local idNUI = false

-- Swapping NUI Thread 
CreateThread(function()
    while true do 
        Wait(200)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle then
            vehicleNUI = true
            SendNUIMessage({window = "vehiclehud"})
        elseif idNUI then
            vehicleNUI = false
            idNUI = true
            SendNUIMessage({window = "mainhud"})
        end
    end
end)


-- ID NUI
CreateThread(function()
    while true do 
        Wait(200)

        local heading = getPlayerHeading()
        local compassDir = ""
        if heading >= 337.5 or heading < 22.5 then
            compassDir = "N"
        elseif heading >= 22.5 and heading < 67.5 then
            compassDir = "NW"
        elseif heading >= 67.5 and heading < 112.5 then
            compassDir = "W"
        elseif heading >= 112.5 and heading < 157.5 then
            compassDir = "SW"
        elseif heading >= 157.5 and heading < 202.5 then
            compassDir = "S"
        elseif heading >= 202.5 and heading < 247.5 then
            compassDir = "SE"
        elseif heading >= 247.5 and heading < 292.5 then
            compassDir = "E"
        elseif heading >= 292.5 and heading < 337.5 then
            compassDir = "NE"
        end

        if IsPedInAnyVehicle(PlayerPedId()) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            local plate = GetVehicleNumberPlateText(vehicle)
            local entityspeed = GetEntitySpeed(vehicle) * 2.236936
            local speed = math.ceil(entityspeed)
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            local gear = GetVehicleCurrentGear(vehicle)
            local fuel = tostring(math.ceil(GetVehicleFuelLevel(vehicle)))

            if (speed == 0 and gear == 0) or (speed == 0 and gear == 1) then
                gear = 'N'
            elseif speed > 0 and gear == 0 then
                gear = 'R'
            end

            idNUI = false
            vehicleNUI = true
            SendNUIMessage({
                type = "vehiclehud",
                id = GetPlayerServerId(PlayerId()),
                plate = plate,
                speed = speed,
                gear = gear,
                fuel = fuel,
                direction = compassDir
            })
        else
            idNUI = true
            vehicleNUI = false
            SendNUIMessage({
                type = "mainhud",
                id = GetPlayerServerId(PlayerId()),
                direction = compassDir,
            })
        end
    end
end)

-- Compass Heading Function
function getPlayerHeading()
    local playerPed = PlayerPedId()
    local heading = GetEntityHeading(playerPed)
    return (heading + 360) % 360
end
