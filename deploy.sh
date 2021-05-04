#!/bin/bash

# fonction generation d'un mot de passe
generationMDP() {
	openssl rand -hex 12
}

echo "Bienvenue dans le systeme de deploiement de conteneurs Nextcloud"

echo "saisisez le nom du client s'il vous plait"
read NomClient

mkdir -p ${NomClient}_nextcloud && cd ${NomClient}_nextcloud

echo "veuillez saisir l'url souhaité pour votre instance ex : cloud.daqg-info.ovh
p.s. : l'url souhaite doit pointer vers l'ip de ce serveur"
read NEXTCLOUD_URL

echo "veuillez saisir la limite de la memoire allouee en m"
read MEM_LIMIT

echo "veuillez saisir la memoire reservee en m"
read MEM_RESERVATION

echo "veuillez saisir la limite du CPU en %"
read CPU_LIMIT

wget -O docker-compose.yaml https://github.com/anastas001/nextcloud_docker/raw/main/docker-compose.yaml

# generation du mot de passe sql
MYSQL_PASS=$(generationMDP)
MYSQL_ROOT=$(generationMDP)

echo "le script va generer un mot de passe aleatoire"

NEXTCLOUD_ADMIN_PASSWORD=$(generationMDP)

SERVICE=Nextcloud_${NomClient}

sed -i "s/SERVICE/$SERVICE/g" docker-compose.yaml

echo "NEXTCLOUD_URL=$NEXTCLOUD_URL
NEXTCLOUD_ADMIN_PASSWORD=$NEXTCLOUD_ADMIN_PASSWORD
MYSQL_PASS=$MYSQL_PASS
MYSQL_ROOT=$MYSQL_ROOT
SQL_NAME=SQL_$NomClient
NX_NAME=Nextcloud_$NomClient
MEM_LIMIT=${MEM_LIMIT}M
MEM_RESERVATION=${MEM_RESERVATION}M
CPU_LIMIT=$CPU_LIMIT" > .env

docker-compose up -d
echo "Voici le recapitulatif de votre instance, enregistrez bien ces infos

adresse de l'instance : ${NEXTCLOUD_URL}
identifiant : igloonet
mot de passe : ${NEXTCLOUD_ADMIN_PASSWORD}

"
