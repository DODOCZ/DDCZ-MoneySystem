local QBCore = exports['qb-core']:GetCoreObject()
local moneyPiles = {}
local confirmDropAll = false

-- ► ZÁKLADNÍ FUNKCE ◄ --
local function AddMoneyInteraction(pileId, coords, amount)
    exports['qb-target']:AddBoxZone("money_"..pileId, coords, 0.8, 0.8, {
        name = "money_"..pileId,
        heading = 0,
        debugPoly = Config.Debug,
        minZ = coords.z - 1,
        maxZ = coords.z + 1
    }, {
        options = {
            {
                type = "client",
                icon = "fas fa-money-bill-wave",
                label = "Sebrat "..amount.."$",
                action = function()
                    TriggerServerEvent('money:pickup', pileId)
                end
            }
        },
        distance = 2.5
    })
end

RegisterNetEvent('money:client:addPile', function(pileId, coords, amount)
    moneyPiles[pileId] = {
        coords = coords,
        amount = amount,
        prop = CreateObject(GetHashKey(Config.MoneyDrop.propModel), coords.x, coords.y, coords.z - 0.9, true, true, true)
    }
    AddMoneyInteraction(pileId, coords, amount)
end)

RegisterNetEvent('money:client:removePile', function(pileId)
    if moneyPiles[pileId] then
        exports['qb-target']:RemoveZone("money_"..pileId)
        DeleteObject(moneyPiles[pileId].prop)
        moneyPiles[pileId] = nil
    end
end)

-- ► PŘÍKAZY ◄ --
RegisterCommand(Config.MoneyDrop.command, function(_, args)
    local amount = tonumber(args[1])
    if not amount or amount <= 0 then return end

    QBCore.Functions.TriggerCallback('money:checkMoney', function(hasMoney)
        if hasMoney then
            local coords = GetEntityCoords(PlayerPedId())
            TriggerServerEvent('money:createMoney', coords, amount)
            QBCore.Functions.Notify('Hodil jsi '..amount..'$ na zem', 'success')
        else
            QBCore.Functions.Notify('Nemáš dostatek peněz!', 'error')
        end
    end, amount)
end)

RegisterCommand(Config.MoneyDrop.commandAll, function()
    if not confirmDropAll then
        confirmDropAll = true
        QBCore.Functions.Notify(Config.MoneyDrop.dropAll.warningMessage, 'primary', Config.MoneyDrop.dropAll.confirmTime)
        SetTimeout(Config.MoneyDrop.dropAll.confirmTime, function()
            confirmDropAll = false
        end)
    else
        confirmDropAll = false
        QBCore.Functions.TriggerCallback('money:getAllCash', function(amount)
            if amount > 0 then
                local coords = GetEntityCoords(PlayerPedId())
                TriggerServerEvent('money:createMoney', coords, amount)
                QBCore.Functions.Notify('Odhodil jsi všechny své peníze ('..amount..'$)', 'success')
            else
                QBCore.Functions.Notify('Nemáš žádné peníze k odhození!', 'error')
            end
        end)
    end
end)

-- ► SMĚNÁRNA ◄ --
local function OpenExchange()
    exports['qb-menu']:openMenu({
        {
            header = '💰 Směnárna měn',
            isMenuHeader = true
        },
        {
            header = 'Hotovost → Banka',
            txt = 'Kurz: '..(Config.Exchange.rates.cashToBank * 100)..'%',
            params = {
                event = 'money:client:exchange',
                args = { type = 'cashToBank' }
            }
        },
        {
            header = 'Banka → Hotovost',
            txt = 'Kurz: '..(Config.Exchange.rates.bankToCash * 100)..'%',
            params = {
                event = 'money:client:exchange',
                args = { type = 'bankToCash' }
            }
        },
        {
            header = '❌ Zavřít',
            params = {
                event = 'qb-menu:closeMenu'
            }
        }
    })
end

RegisterNetEvent('money:client:exchange', function(data)
    local input = exports['qb-input']:ShowInput({
        header = '💱 '..(data.type == 'cashToBank' and 'Hotovost → Banka' or 'Banka → Hotovost'),
        submitText = "Potvrdit",
        inputs = {
            {
                text = "Částka",
                name = "amount",
                type = "number",
                isRequired = true
            }
        }
    })

    if input and input.amount then
        TriggerServerEvent('money:exchange', data.type, tonumber(input.amount))
    end
end)

-- ► INICIALIZACE ◄ --
CreateThread(function()
    for i, coords in ipairs(Config.Exchange.locations) do
        exports['qb-target']:AddBoxZone("exchange_"..i, coords, 1.5, 1.5, {
            name = "exchange_"..i,
            heading = 0,
            minZ = coords.z - 1,
            maxZ = coords.z + 1
        }, {
            options = {
                {
                    label = 'Směnárna',
                    icon = 'fa-solid fa-exchange-alt',
                    action = OpenExchange
                }
            },
            distance = 2.5
        })
    end
end)