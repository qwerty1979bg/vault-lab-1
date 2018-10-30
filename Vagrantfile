Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "256"
  end

#  config.vm.define name="web1" do |node|
#    node.vm.box = "xenial"
#    node.vm.hostname = "web1"
#    node.vm.provision "shell", path: "provision_web.sh"
#  end

  config.vm.define name="mysql" do |node|
    node.vm.box = "qwerty1979/mysql"
    node.vm.hostname = "mysql"
    node.vm.provision "shell", path: "provision_mysql.sh"
    node.vm.provision "shell", path: "provision_web.sh"
#    node.vm.network :forwarded_port, guest: 3306, host: 3306
  end

end
