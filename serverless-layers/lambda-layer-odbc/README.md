# Guide to build the lambda layer for running pyodbc with SQL Server driver (and also pyhumps)

### AWS Lambda puts your code source in `/var/task` i.e. your code in `/yourrepo/` will become `/var/task/yourrepo/` in AWS Lambda environment. This is key information. 

### Basic Steps to build the layer and source zips:
- **STEP 00** : Go to `lambda-layer-odbc` directory on your local machine.
- **STEP 01** : To build the docker image, open a terminal and run `docker build -t <dockerImageName>:latest ./docker-build/` command.  
- **STEP 02** : Run the docker image with this command `docker run -it --rm --name <runningContainerName> <dockerImageName>:latest bash`. This will ease your pain of killing the container when you are not using it anymore.  
- **STEP 03** : In the docker bash terminal, activate python virtual env named `layer` using `source layer/bin/activate` command.  
- **STEP 04** : Install the python dependencies using `pip install -r requirements.txt --target ./python --no-deps` and check for errors.  
- **STEP 05** : If above step is completed successfully, it is time to zip the needed directories and copy them to your local machine. **Do not exit** the docker terminal.
- **STEP 06** : Zip the `python` directory using `zip -r /python.zip ./python/`. This will be your **lambda layer** zip.
- **STEP 07** : Zip the `source` directory using `(cd /source/ && zip -r /source.zip ./)`. This will be your **lambda code source** zip.
- **STEP 08** : Open another terminal in `lambda-layer-odbc` directory and run the following commands to download the zip files:
    - `docker cp <runningContainerName>:python.zip ./`  
    - `docker cp <runningContainerName>:source.zip ./`  
- **STEP 09** : Check the zip files. If okay, exit the docker terminal with `exit` command in bash.  

### Additional Steps:
- **Include your code to source** : You can either  
    1. add your code in `./docker-build/source/` directory before running the `docker build` command, or
    2. unzip the source.zip after building it, add your code there, and re-zip it. This can help you avoid naming conflict with any other necessary directories in `source.zip`.   
    **Note**: Ensure root directory in source.zip is `/` when unzipped i.e. no parent level directory named `/source/` is there, otherwise your root directory will become `/var/task/source/` instead of `/var/task/` in lambda environment.  
- **GCC error during pyodbc compile**: The Dockerfile has the steps to install C/C++ dependencies but in a rare case of facing this issue, run `yum install -y gcc gcc-c++` to install necessary dependencies and run `pip install` again.  
- **Check odbc ini files** : Check if `odbcinst.ini` has correct driver path location, and also check if `odbc.ini` file has correct reference in it. For SQL Server ODBC Driver to work properly, you have to have the driver along with your code in `/var/task/` location in Lambda environment.  
