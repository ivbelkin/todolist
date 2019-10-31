#! /bin/bash

docker build -t ivbelkin/todolist .

docker run --rm -d -v $(pwd)/app:/app -p 8000:8000 -it --name ivbelkin_todolist ivbelkin/todolist bash
docker exec ivbelkin_todolist /etc/init.d/postgresql start
docker exec ivbelkin_todolist python website/manage.py makemigrations todolist
docker exec ivbelkin_todolist python website/manage.py migrate
docker exec ivbelkin_todolist python website/manage.py runserver 0:8000

docker attach ivbelkin_todolist
