# Jenkins with mounted host drive

Create data folder
```bash
mkdir data
```

Start jenkins with -v

```bash
sudo docker run --rm --name=myjenkins -v /home/vagrant/data:/var/jenkins_home -p 80:8080 jenkins:1.554.3
```

# Version update
```bash
sudo docker run --rm --name=myjenkins -v /home/vagrant/data:/var/jenkins_home -p 80:8080 jenkins:weekly
```


# Data container

```bash
sudo docker run -d --name jenkins-data jenkins /bin/bash
```

```bash
sudo docker run --rm --volumes-from=jenkins-data -p 80:8080 -it jenkins
```

## Access data container
```bash
sudo docker run --rm --volumes-from=jenkins-data -it ubuntu /bin/bash
```