resource "virtualbox_vm" "node" {
    count = 2
    name = "${format("node-%02d", count.index+1)}"
    url = "https://atlas.hashicorp.com/ubuntu/boxes/trusty64/versions/14.04/providers/virtualbox.box"
    image = "./virtualbox-ubuntu.box"
    cpus = 2
    memory = "512mib"

    network_adapter {
        type = "bridged"
        host_interface = "en0"
    }
    provisioner "local-exec" {
        inline = [
            "sleep 30 && echo -e \"[webserver]\n${element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 2)} ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant\" > inventory &&  ansible-playbook -i inventory playbook.yml",
        ]
        connection {
            type     = "ssh"
            user     = "vagrant"
            password = "vagrant"
        }
    }

}
