# pymongo-api

## Как запустить

Запускаем mongodb и приложение

```shell
docker compose up -d
```

Заполняем mongodb данными

```shell
./scripts/mongo-init.sh
```

## Как проверить

### Если вы запускаете проект на локальной машине

Откройте в браузере http://localhost:8080

### Если вы запускаете проект на предоставленной виртуальной машине

Узнать белый ip виртуальной машины

```shell
curl --silent http://ifconfig.me
```

Откройте в браузере http://<ip виртуальной машины>:8080

## Доступные эндпоинты

Список доступных эндпоинтов, swagger http://<ip виртуальной машины>:8080/docs

-----------------

### Решение

#### Задание 1



#### Задание 2 

1. Перейти в директорию с проектом:

    ```shell
    cd mongo-sharding
    ```

2. Для запуска проекта – выполнить:

    ```shell
    docker compose up --build -d
    ```

3. Инициализировать шарды и заполнить БД данными:

    ```shell
    ./setup_sharded_cluster.sh 
    ```


#### Задание 3 

1. Перейти в директорию с проектом:

    ```shell
    cd mongo-sharding-repl
    ```

2. Для запуска проекта – выполнить:

    ```shell
    docker compose up --build -d
    ```

3. Инициализировать шарды и реплики и заполнить БД данными:

    ```shell
    ./setup_sharded_repl.sh 
    ```

#### Задание 4 

1. Перейти в директорию с проектом:

    ```shell
    cd sharding-repl-cache
    ```

2. Для запуска проекта – выполнить:

    ```shell
    docker compose up --build -d
    ```

3. Инициализировать шарды и реплики и заполнить БД данными:

    ```shell
    ./setup_sharded_repl.sh  
    ```

