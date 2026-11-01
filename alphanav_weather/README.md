# AlphaNav Weather

A weather hub for Home Assistant: it takes the forecasts you ask for, shows them on a map, sends daily alerts to
your phone and cuts small files for the boat.

## Install

1. Settings, Add-ons, Add-on Store, the menu at the top right, Repositories.
2. Add `https://github.com/giomengu/alphanav-weather-addon`.
3. Install AlphaNav Weather, start it, and turn on Show in sidebar.

For `amd64` and `aarch64` machines.

## Who sees what

Through Home Assistant's sidebar you are the admin. On port 3010 anyone who can reach it sees the map and the
forecasts on it, and nothing else; the boat needs a key, made in Access, and every setting needs the admin key,
which the add-on's log shows once on the first start. To put port 3010 online, put it behind HTTPS: keys travel
in the clear without it, and a browser gives its position only to a secure page.
