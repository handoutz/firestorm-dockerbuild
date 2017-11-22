# firestorm-dockerbuild
Docker image with build environment (Ubuntu 16.04, gcc-4.7) for Firestorm Deployment
## Why using a docker container for this
Firestorm is using a whole own set of its own shared libraries with outdated versions. It's just able to compile successfully on very specific versions of system libraries and just with gcc-4.7. And it needs many dependencies and custom builds that would trash up every rather new and up-to-date system.
By using a docker container, you don't have to worry about system-updates breaking the build environment and you don't have to install shady packages.
## HowTo Install
Install docker if not already installed (use your package manager of choice, like apt-get on debian, instead of dnf)
```
dnf install docker
```
Run Docker (you have to run docker every time when you need it)
```
systemctl start docker
```
Clone repository and build Docker image
```
git clone https://github.com/uriesk/firestorm-dockerbuild.git
cd firestorm-dockerbuild
docker build -t firestorm-buildenv .
```
Copy the autobuild script to PATH (/usr/local/bin is the best place, if you have it in $PATH)
```
cp ./autobuild /usr/bin/autobuild
```
## HowTo use it
To compile Firestorm, you have to:

Install mercurial
```
dnf install mercurial
```
Clone Firestorm repository 
```
hg clone http://hg.phoenixviewer.com/phoenix-firestorm-lgpl
```
Configure Firestorm
```
autobuild -m64 configure -c ReleaseFS_open -- --clean -DLL_TESTS:BOOL=FALSE
```
Build firestorm
```
autobuild -m64 build -c ReleaseFS_open
```
Done. The Firestorm Binaries are now located in build-linux-x86_64/newview/packaged or as archive in build-linux-x86_64/newview/Phoenix_FirestormOS-private-[version number].tar.xz
## How it works
The Docker image contains the Ubuntu System with the correct gcc version and build envrionment.
When you run the autobuild script (the script from this repo here), it runs the image, mounts the current directory inside the image, and executes the LindenLab autobuild with the arguments you give it there.
