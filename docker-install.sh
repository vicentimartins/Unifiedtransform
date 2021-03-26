if ! [ -x "$(command -v docker-compose)" ]; then
    echo 'docker-compose is not installed thus cannot scaffold your app. Sorry, bud...' >&2
    sleep 1
    exit 1
fi

echo "Scaffolding your app using Docker... This will take a while..."
sleep 1
sudo docker-compose up -d --build
sudo docker-compose run --rm php composer install -o
sudo docker-compose run --rm php php artisan migrate:fresh

export $(grep -v '#.*' .env | xargs)
echo ""
echo "Unifiedtransform is ready on localhost:$DOCKER_WEBSERVER_HOST."
echo ""
sleep 1
