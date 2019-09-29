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
- Subsequently, script it via Vagrant file and shell provisioners

```
config.vm.provision "file", source: 'hello-spring-boot-0.1.0.jar', destination: '/home/vagrant/hello-spring-boot-0.1.0.jar'

config.vm.provision "shell", inline: <<-SHELL
  apt-get update
  apt-get install -y openjdk-11-jre-headless
  java -jar hello-spring-boot-0.1.0.jar
SHELL
```

Note: the shell provisioner runs as root, so the above means that the java process is running as root, which is insecure

### (EXTRA) Run the jar file as a service
- https://computingforgeeks.com/how-to-run-java-jar-application-with-systemd-on-linux/
- https://fabianlee.org/2018/04/15/java-spring-boot-application-as-a-service-using-systemd-on-ubuntu-16-04/

### Write Ansible playbook to deploy and run jar
- https://github.com/remyma/ansible-springboot/blob/master/tasks/main.yml
