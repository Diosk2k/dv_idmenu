fx_version 'adamant'

game 'gta5'

description 'Personal menu for JSfourcards'
Author 'DV DEV'

version '1.0.0'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/en.lua',
	'config.lua',
	'server.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/en.lua',
	'config.lua',
	'client.lua'
}

shared_script '@es_extended/imports.lua'