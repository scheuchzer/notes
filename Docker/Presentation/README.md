# Docker

## Was ist Docker

- Docker Engine
	- A portable, lightweight application runtime and packaging tool.
- Docker Hub
	- Image registry

## Unterschied VM und Application Container

- Kernel des Hosts ist auch Kernel des Containers!


### Demo

- Da Docker noch nicht nativ unter Windows läuft, brauchen wir eine VM mit Linux
  - Microsoft arbeitet mit Docker daran
- start VM
  - Dauert lange
- Einfaches hello world mit docker -> schnell


## Container sind ja gar nichts neues

- Die Grundlage von Docker waren Linux Containers (LXC)
	- Kernel 2.6.24 (24.01.2008)
- Eigentlich gibt's sowas ähnliches schon lange
	- chroot
- Komplette isolation durch Kernel Namespaces
	- Process Tree
	- Network
	- User IDs
	- Mounted File Systems
	- CPU
	- Memory
- Docker setzt seit 0.9 auf libconatiner anstelle von LXC
	- 10.03.2014


## Und Windows?

- "Microsoft will Docker für Windows entwickeln"
	- Support für Azure, Windows Server und Windows
	- [Heise.de 15.10.2014](http://www.heise.de/developer/meldung/Anwendungs-Container-Microsoft-will-Docker-fuer-Windows-entwickeln-2425205.html)

- Bis es soweit ist hilft z.B. Vagrant weiter

## Hello World

- Disposable Environment
- Container sind darauf ausgelegt einen einzigen Prozess auszuführen

## Eigener Container erstellen

- Immutable Images

## Eigener Container erstellen (Infrastructure as Code)

- Automate everything
- Keep everything in source control
- Dockerfile
	- Hat ein Parent `FROM`
	- Umgebungsvariablen `ENV`
	- Führt Befehle aus (zur Buildzeit) `RUN`
	- Volumes `VOLUME`
	- Hat max 1 Einstiegspunkt (zur Laufzeit) `CMD`

Jedes Kommando fügt einen neuen Layer hinzu. Nach dem Befehl wir der Container committed und dient als Ausgangspunkt für den nächsten Schritt.


## Trenne Applikation und Daten

- Container sollten eine Applikaton ausführen, nicht eine Maschine (oder VM)
- Application Container sollten vergänglich sein (`--rm`)
- Halte Daten in Daten-Container


### Beispiel Jenkins

- Docker Image `jenkins`
- Sichert alle Daten ins Volume `/var/jenkins_home`
- Entweder ein Verzeichnis vom Host mounten
- oder Data-Container verlinken

### Backup usw?

- Separater Container verbunden mit Daten-Container

## Docker Universum

Management:

- Host
	- [Fig](http://www.fig.sh/)
- Serverfarm
	- [Flocker](https://clusterhq.com/)
- Cluster
	- [Docker Swarm](https://github.com/docker/swarm)

Eigene Docker Registry:

- [Blog](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-docker-registry-on-ubuntu-14-04)


Zero-to-Docker:

- [Vagrant](https://www.vagrantup.com/)
- [Docker Machine](https://github.com/docker/machine)
	- Virtualbox
	- Digital Ocean
	- Microsoft Azure
	- Amazon EC2
	- Google Compute Engine
	- VMware Fusion
	- VMWare vCloud Air
	- VMware vSphere
	- OpenStack
	- Rackspace
	- Softlayer

## Ponihof oder was?

- [Gartner: Anwendungs-Container mit Docker für Unternehmeneinssatz nur eingeschränkt zu empfehlen (13.01.2015)](http://www.heise.de/developer/meldung/Gartner-Anwendungs-Container-mit-Docker-fuer-Unternehmeneinssatz-nur-eingeschraenkt-zu-empfehlen-2517118.html)

- Wohin mit Docker?
 - Führung
 - Allerweltstool oder Standard

## Alternativen

- CoreOS und Rocket