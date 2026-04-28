Vagrant.configure("2") do |config|
    config.vm.box="ITTechnik/ubuntu-26"
    config.vm.hostname = "roomcontrol"
    config.vm.network "public_network"

    #Run ./installPlugins.sh first
    config.disksize.size = "120GB" if Vagrant.has_plugin?("vagrant-disksize")

    config.vm.network "forwarded_port", guest: 80, host: 80
    config.vm.network "forwarded_port", guest: 1883, host: 1883

    config.vm.provider "virtualbox" do |vb|
        vb.name = "roomcontrol"
        vb.cpus = 8
        vb.memory = "8192"
    end

    config.vm.provision "file", source: "scripts/", destination: "/home/vagrant/scripts"

    config.vm.provision "shell", run: "once", inline: <<-SHELL
        chmod 774 /home/vagrant/scripts/*
        apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
        timedatectl set-timezone Europe/Berlin

        SHELL

    config.vm.provision "shell", path: "scripts/install-docker.sh", reboot: false, run: "once"
    config.vm.provision "shell", path: "scripts/install-git.sh", reboot: false, run: "once"
    config.vm.provision "shell", path: "scripts/enable-ssh-password-login.sh", reboot: true, run: "once"
end