fx_version 'cerulean'
game 'gta5'

description 'QB-RadialMenu'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@qb-garages/config.lua',
    'client/main.lua',
    'client/clothing.lua',
    'client/trunk.lua',
    'client/stretcher.lua'
}

server_scripts {
    'server/trunk.lua',
    'server/stretcher.lua'
}

files {
    'html/index.html',
    'html/css/main.css',
    'html/js/main.js',
    'html/js/RadialMenu.js',
}

lua54 'yes'