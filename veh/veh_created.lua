
local playerVehicles = {}

-- Функция создания транспорта
function createVehicleForPlayer(player, model)
    -- Удаление старого транспортного средства, если оно существует
    if playerVehicles[player] then
        destroyElement(playerVehicles[player])
    end

    -- Получение позиции игрока
    local x, y, z = getElementPosition(player)
    local rx, ry, rz = getElementRotation(player)
    
    -- Создание нового транспортного средства
    local vehicle = createVehicle(model, x + 5, y, z, 0, 0, rz)
    if not vehicle then
        outputChatBox("Неправильная модель транспорта.", player, 255, 0, 0)
        return
    end

    -- Установка транспортного средства для игрока
    playerVehicles[player] = vehicle

    -- Установка владельца транспорта
    setElementData(vehicle, "owner", player)

    -- Доступ только владельцу
    addEventHandler("onVehicleStartEnter", vehicle, function(enteringPlayer, seat)
        if getElementData(source, "owner") ~= enteringPlayer then
            cancelEvent()
            outputChatBox("Вы не владелец этого транспорта!", enteringPlayer, 255, 0, 0)
        end
    end)

    -- Установка двигателя в выключенное состояние при создании
    setVehicleEngineState(vehicle, false)
    setElementData(vehicle, "engineOn", false)
    
    -- Отключение двигателя при входе в транспортное средство
    addEventHandler("onVehicleEnter", vehicle, function(enteringPlayer, seat)
        if getElementData(source, "owner") == enteringPlayer then
            setVehicleEngineState(source, false)
        end
    end)

    outputChatBox("Транспорт создан: " .. model, player, 0, 255, 0)
end

addCommandHandler("veh", function(player, command, model)
    if not model then
        outputChatBox("Использование: /veh [model]", player, 255, 255, 255)
        return
    end
    createVehicleForPlayer(player, model)
end)

-- Удаление транспортного средства при выходе игрока
addEventHandler("onPlayerQuit", root, function()
    if playerVehicles[source] then
        destroyElement(playerVehicles[source])
        playerVehicles[source] = nil
    end
end)


