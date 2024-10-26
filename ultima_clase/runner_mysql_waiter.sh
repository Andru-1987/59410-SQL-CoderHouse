#!/usr/bin/


docker compose up -d --build


# Wait until MySQL is ready

until docker compose logs mysql | grep "/usr/sbin/mysqld: ready for connections."; do 
    echo -n .; 
    sleep 1;
done

echo "MySQL is ready."

docker exec -e MYSQL_PWD="coderhouse" mysql mysql -u root  -e "source pagos.sql"
echo "Se ha concluido la carga --> listo para romper codigo SQL"

