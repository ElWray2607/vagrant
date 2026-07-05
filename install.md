# Installationsanleitung – Vagrant (Windows)

## Voraussetzungen

Folgende Software muss auf dem Windows-System installiert sein, bevor Vagrant verwendet werden kann:

- **Windows 10 / 11** (64-Bit)
- **VirtualBox** (empfohlen: Version 7.0.x)
- **Vagrant**

---

## 1. VirtualBox installieren

1. Öffne die offizielle VirtualBox-Downloadseite:  
   👉 https://www.virtualbox.org/wiki/Downloads

2. Lade das Installationspaket für **Windows hosts** herunter.

3. Führe die `.exe`-Datei aus und folge dem Installationsassistenten.

4. Starte den Computer **neu** nach der Installation.

---

## 2. Vagrant installieren

1. Öffne die offizielle Vagrant-Downloadseite:  
   👉 https://developer.hashicorp.com/vagrant/install

2. Wähle **Windows** und lade das Installationspaket herunter.

3. Führe das Installationspaket aus und folge dem Assistenten.

4. Starte den Computer **neu** nach der Installation.

5. Überprüfe die Installation in der Eingabeaufforderung (CMD) oder PowerShell:

   ```powershell
   vagrant --version
   ```

---

## 3. Vagrant-Plugins installieren

Das Projekt benötigt zusätzliche Vagrant-Plugins. Installiere sie mit folgendem Befehl:

```bash
./installPlugins.sh
```

## 4. Start und Login

Die VM kann mit `vagrant up` gestartet werden. Sobald diese gestartet ist, kann man sich mit `vagrant ssh` einloggen.

## 5. Starten der Docker Services

Zum starten der Docker Services müssen diese Befehler aufgerufen werden:

`deploy-service homeassistant`
`deploy-service mosquitto`
`deploy-service proxy`

## 6. Aktivieren von mDNS

### 6.1 Avahi-Daemon installieren

```bash
sudo apt update
sudo apt install avahi-daemon avahi-utils
sudo systemctl enable avahi-daemon
sudo systemctl start avahi-daemon
```

### 6.2 Netzwerkinterface ermitteln

Mit folgendem Befehl alle verfügbaren Netzwerkinterfaces anzeigen:

``` bash
ip addr show
```

### 6.3 Konfigurationsdatei anpassen

Öffne die Datei und setze folgende Werte: `/etc/avahi/avahi-daemon.conf`

| Eintrag                             | Wert           |
|-------------------------------------|----------------|
| `use-ipv4`                          | `yes`          |
| `use-ipv6`                          | `no`           |
| `publish-aaaa-on-ipv4`              | `no`           |
| (unter [server]) `allow-interfaces` | z. B. `enp0s8` |

### 6.4 Dienst neu starten

``` bash
sudo systemctl restart avahi-daemon
```
