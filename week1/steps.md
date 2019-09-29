# Steps and Working Notes
## Vagrant

### Manually Install dependencies and run
- `vagrant init`
- Edit the `Vagrantfile`
  - set the base image (`ubuntu/bionic`)
  - set `config.vm.network "forwarded_port"` to forward traffic to the guest (host port must be > 1024 unless Vagrant is running as root)
  - set the `config.vm.provider` (virtualbox)
- `vagrant up`
- Use `vagrant scp` to copy jar file in: https://howtoprogram.xyz/2017/08/13/copy-files-folders-host-guest-vagrant/
  - `vagrant plugin install vagrant-scp`
  - `vagrant scp <local_source_file_path> <vm_destination_file_path`
- Install dependencies:
  - `sudo apt-get update`
  - `sudo apt-get install openjdk-11-jre-headless`
- Run jar:
  - `java -jar <path-to-jar>`
- Curl to exposed port:
  - `curl localhost:8081`

### Script provisioning of jar file and installation of dependencies
- Subsequently, script it via Vagrant file provisioner
