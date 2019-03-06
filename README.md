## backup_mongodb_databases
This project build a image helping to run a script to backup MongoDB database.


## How to use this image
### Start a Mongo client instance
`$ docker run --name my-mongo -e MONGO_PASS=mypassword -d biolinh/backup_mongodb`

### ... via docker stack deploy or docker-compose
Example docker-compose.yml for MongoDB:
```
version: '3.5'
services:
  backup_mongodb:
    image: biolinh/backup_mongodb
    container_name: backup_mongodb
    environment:
    - MONGO_USER=myuser
    - MONGO_PASS=mypassword
    - MONGO_HOST=myhost
    - MONGO_BACKUP_DIRECTORY=/backup
    - MONGO_BACKUP_DB=test
    - MONGO_STORED_DAY=7
    volumes:
    - ./backup_mongodb:/backup
    networks:
    - backup_mongodb     
networks: 
  backup_mongodb:
    name: backup_mongodb
```
run `docker-compose up ` to backup database.

## Environment Variables
 
#### **MY_USER**
The variable specifies the user to connect the Mongo server. The đefault value is root

#### **MONGO_PASS**
The variable is mandatory and specifies user's password connecting to Mongo server.

#### **MONGO_HOST**
The variable specifies the host of Mongo server. The default value is localhost.

#### **MONGO_BACKUP_DIRECTORY**
The variable is optional and specifies the location to store the backup files. The default value is /backup.

#### **MONGO_BACKUP_DB**
The variable is mandatory and specifies which database will be backuped.

#### **MONGO_STORED_DAY**
The variable is optional and specifies the day of back up file which will be kept before removed. This feature doesn't be available in version 1.0
The default value is 7 days.
