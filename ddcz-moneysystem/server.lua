local QBCore = exports['qb-core']:GetCoreObject()
local activePiles = {}

QBCore.Functions.CreateCallback('money:checkMoney', function(source, cb, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    cb(Player.Functions.GetMoney('cash') >= amount)
end)

QBCore.Functions.CreateCallback('money:getAllCash', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    cb(Player.Functions.GetMoney('cash'))
end)

RegisterNetEvent('money:createMoney', function(coords, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player.Functions.RemoveMoney('cash', amount) then
        local pileId = #activePiles + 1
        activePiles[pileId] = {
            coords = coords,
            amount = amount
        }
        
        TriggerClientEvent('money:client:addPile', -1, pileId, coords, amount)
        
        SetTimeout(Config.MoneyDrop.autoRemove * 60000, function()
            if activePiles[pileId] then
                TriggerClientEvent('money:client:removePile', -1, pileId)
                activePiles[pileId] = nil
            end
        end)
    end
end)

RegisterNetEvent('money:pickup', function(pileId)
    local src = source
    if activePiles[pileId] then
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddMoney('cash', activePiles[pileId].amount)
        TriggerClientEvent('money:client:removePile', -1, pileId)
        activePiles[pileId] = nil
    end
end)

RegisterNetEvent('money:exchange', function(type, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local rate = Config.Exchange.rates[type]
    amount = math.floor(tonumber(amount))

    if type == 'cashToBank' then
        if Player.Functions.RemoveMoney('cash', amount) then
            Player.Functions.AddMoney('bank', math.floor(amount * rate))
            TriggerClientEvent('QBCore:Notify', src, ('Směněno %s$ hotovosti na %s$ v bance'):format(amount, math.floor(amount * rate)), 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, 'Nemáš dostatek hotovosti!', 'error')
        end
    elseif type == 'bankToCash' then
        if Player.Functions.RemoveMoney('bank', amount) then
            Player.Functions.AddMoney('cash', math.floor(amount * rate))
            TriggerClientEvent('QBCore:Notify', src, ('Směněno %s$ z banky na %s$ hotovosti'):format(amount, math.floor(amount * rate)), 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, 'Nemáš dostatek peněz v bance!', 'error')
        end
    end
end)