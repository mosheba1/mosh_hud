const maxLength = 18 // To prevent long names from runing the hud

var app = new Vue({
    el: '#initapp',
    data: {
        serverName: "Mosheba Development",
        server_logo: "https://i.ibb.co/7kZ3mCm/transparent.png",
        player: 'Mosh',
        player_fps: 90,
        playerpingofc: 11,
        ID: 2,
        discord: "https://discord.gg/vHjGHxDs",
        website_link: "https://mosheba-development.tebex.io/",
        active_players: 0,


        // ICONS 
        ID_ICON: "",
        PLAYERS_ICON: "",
        LOBBY_ICON: "",
        FPS_ICON: "",
        DISCORD_ICON: "",
        WEBSITE_ICON: "",


        elements: []
    },
    computed: {
        serverPlayers: function() {
            if(this.player.length > maxLength) {
                return this.player.substring(0, maxLength - 3) + ".."
            } else {
                return this.player
            }
        }
    }
})

const getEvent = (event, data = {}, cb = (() => {})) => {
    fetch(`https://${GetParentResourceName()}/${event}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify(data)
    }).then(response => response.json()).then(response => {
        cb(response)
    })
}

function keepitUpdated() {
    getEvent("mosh_hud:HandInfo", {}, response => {
        Object.keys(response).forEach(key => {
            let value = response[key]

            if(key == "player_fps") {
                if(value < 10) {
                    value = `${value}&nbsp;&nbsp;`
                } else if(value < 100) {
                    value = `${value}&nbsp;`
                }
            }
            app[key] = value
        })
    })
}

keepitUpdated()
setInterval(keepitUpdated, 1000)


window.addEventListener('message', function(event) {
    const data = event.data;

    if(data.action) {
        if(data.action == "hide_hud") {
            var x = document.getElementById("initapp");
            x.style.display = "none";
        } else if (data.action == "show_hud") {
            var x = document.getElementById("initapp");
            x.style.display = "block";
        }
    }
});

getEvent("ready")
