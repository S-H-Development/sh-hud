CreateThread(function()
    while true do 
        Wait(200)

        if IsPedInAnyVehicle(PlayerPedId()) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            local plate = GetVehicleNumberPlateText(vehicle)
            local entityspeed = GetEntitySpeed(vehicle) * 2.236936 -- MPH 
            local speed = math.ceil(entityspeed)
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            local gear = GetVehicleCurrentGear(vehicle)
            local fuel = tostring(math.ceil(GetVehicleFuelLevel(vehicle)))

            if (speed == 0 and gear == 0) or (speed == 0 and gear == 1) then
                gear = 'N'
            elseif speed > 0 and gear == 0 then
                gear = 'R'
            end

            SendNUIMessage({
                type = "vehiclehud",
                speed = speed,
                gear = gear,
                fuel = fuel,
            })
        else
            SendNUIMessage({
                type = "closeAll"
            })
        end
    end
end)
