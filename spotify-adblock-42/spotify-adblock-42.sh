#!/usr/bin/env bash

if ! flatpak list | grep com.spotify.Client; then
	if locale | grep language == LANGUAGE=es; then
		echo "Spotify no instalado, instalalo primero"
	else
		echo "Spotify not installed, install it first"
	fi	
else
	
	mkdir -p ~/.spotify-adblock/repo && git clone https://github.com/abba23/spotify-adblock.git ~/.spotify-adblock/repo && cd ~/.spotify-adblock/repo

	echo "Making..." && make

	cp target/release/libspotifyadblock.so ~/.spotify-adblock/spotify-adblock.so
	mkdir -p ~/.var/app/com.spotify.Client/config/spotify-adblock && cp config.toml ~/.var/app/com.spotify.Client/config/spotify-adblock
	flatpak override --user --filesystem="~/.spotify-adblock/spotify-adblock.so" --filesystem="~/.config/spotify-adblock/config.toml" com.spotify.Client

	cp ./spotify-launcher ~/.local/share/applications/com.spotify.Client.desktop
	echo "Success! Cleaning"
	rm -rf ~/.spotify-adblock/repo
	
fi
	
