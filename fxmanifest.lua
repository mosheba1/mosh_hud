fx_version "cerulean"
game "gta5"
author "Mosheba"
description "A watermark for mosh_lobbies"
discord "https://discord.gg/xP67BKbk6A"

lua54 'yes'
ui_page "nui/index.html"

client_script "cl_main.lua"
client_script "config.lua"
server_script "sv_main.lua"

files {
    "nui/index.html",
    "nui/css/style.css",
    "nui/js/main.js",
    "nui/img/logo.png",
}

