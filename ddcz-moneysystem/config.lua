Config = {
    Locale = 'en',
    Debug = false,

    MoneyDrop = {
        command = 'cash',
        commandAll = 'cashall',
        propModel = 'prop_anim_cash_pile_01',
        autoRemove = 10, -- minutes
        dropAll = {
            confirmTime = 5000,
            warningMessage = "Really drop ALL cash? Type /cashall again to confirm!"
        }
    },

    Exchange = {
        locations = {
            vector3(1175.56, 2706.84, 38.09),
            vector3(265.45, 213.89, 101.68)
        },
        rates = {
            cashToBank = 0.98,
            bankToCash = 0.95
        }
    }
}