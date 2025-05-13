fx_version 'cerulean'
game 'gta5'

author 'YourName'
description 'Money System using interact resource'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/css/style.css',
    'html/js/app.js',
    'locales/*.json'
}

dependencies {
    'qb-core',
    'interact', 
    'oxmysql'
}