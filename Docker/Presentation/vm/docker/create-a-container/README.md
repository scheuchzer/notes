# Create a new container

Not the preferred way to do, but works:

Start a container in interactive mode.

```bash
sudo docker run --name "myubuntu" --rm -it ubuntu /bin/bash
```

Create a file.

```bash
echo "HELLO WORLD" > hello.txt
ls -l
```

Open a new terminal window and commit the changes you've done to the container.

```bash
sudo docker commit myubuntu demo/myubuntu
```

Display the newly created image.

```bash
sudo docker images
```

Start the new image.

```bash
sudo docker run --rm -it demo/myubuntu
```
