cd camellia/

mvn package

cd ..

docker-compose rm -f
docker-compose pull
docker-compose up --build
