# Camellia-Cultivar

## Instructions

To run this project locally, you will need:
- Java
- Maven

### Backend
You should start by initializing the backend project before launching the web application

On the base directory of the project run

```
cd /backend/camellia
mvn package
```

After that start the bash script to kick-start the Spring application with
```
sh ../run_docker.sh
```


### Web application

The web application is a simple React project

To start it, just the following commands on the `/webapp` directory
```
npm install
npm start
```
