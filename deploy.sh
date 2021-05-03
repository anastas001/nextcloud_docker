#!/bin/bash

# fonction generation d'un mot de passe
generationMDP() {
	openssl rand -hex 12
}

echo "Bienvenue dans le systeme de deploiement de conteneurs Nextcloud"

echo "saisisez le nom du client s'il vous plait"
read NomClient

mkdir $NomClient && cd $NomClient

echo "veuillez saisir l'url souhaité pour votre instance ex : cloud.daqg-info.ovh"
read NEXTCLOUD_URL

git clone https://github.com/anastas001/nextcloud_docker && cd nextcloud_docker

# generation du mot de passe sql
MYSQL_PASS=$(generationMDP)
mysqlroot=$(generationMDP)

echo "le script va generer un mot de passe aleatoire"

NEXTCLOUD_ADMIN_PASSWORD=$(generationMDP)


echo "NEXTCLOUD_URL=$NEXTCLOUD_URL
NEXTCLOUD_ADMIN_PASSWORD=$NEXTCLOUD_ADMIN_PASSWORD
MYSQL_PASS=$MYSQL_PASS
MYSQL_ROOT=$mysqlroot
SQL_NAME=SQL_$NomClient
NX_NAME=Nextcloud_$NomClient" > .env

docker-compose up -d
echo "Voici le recapitulatif de votre instance, enregistrez bien ces infos

adresse de l'instance : ${NEXTCLOUD_URL}
identifiant : igloonet
mot de passe : ${NEXTCLOUD_ADMIN_PASSWORD}

"
