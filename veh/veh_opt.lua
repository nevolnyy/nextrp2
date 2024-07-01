
function toggleEngine(player)
    local vehicle = getPedOccupiedVehicle(player)
    if vehicle and getElementData(vehicle, "owner") == player then
        local engineOn = getElementData(vehicle, "engineOn")
        setVehicleEngineState(vehicle, not engineOn)
        setElementData(vehicle, "engineOn", not engineOn)
    end
end


function toggleLights(player)
    local vehicle = getPedOccupiedVehicle(player)
    if vehicle and getElementData(vehicle, "owner") == player then
        local lightsOn = getVehicleOverrideLights(vehicle) == 2
        setVehicleOverrideLights(vehicle, lightsOn and 1 or 2)   
    end
end


function jumpVehicle(player)
    local vehicle = getPedOccupiedVehicle(player)
    if vehicle and getElementData(vehicle, "owner") == player then
        if isVehicleOnGround(vehicle) then
            local x, y, z = getElementPosition(vehicle)
            setElementPosition(vehicle, x, y, z + 1)
        end
    end
end

-- Привязка клавиш при входе игрока
addEventHandler("onPlayerJoin", root, function()
    bindKey(source, "e", "down", toggleEngine)
    bindKey(source, "l", "down", toggleLights)
    bindKey(source, "lshift", "down", jumpVehicle)
end)

-- Привязка клавиш при входе на сервер
for _, player in ipairs(getElementsByType("player")) do
    bindKey(player, "e", "down", toggleEngine)
    bindKey(player, "l", "down", toggleLights)
    bindKey(player, "lshift", "down", jumpVehicle)
end