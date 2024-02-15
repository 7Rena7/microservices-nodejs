# Instructions to run PolyglotProject

1. Create docker network

```bash
sudo docker network create polyglot-project
```

2. Create databases containers (Postgres and MySQL)

```bash
sudo docker run --name database-mysql-security -e MYSQL_ROOT_PASSWORD="password"  -e MYSQL_DATABASE="db_security" -p 3307:3306 -p 33061:33060 --network polyglot-project -d  mysql:8.0.26
```

```bash
sudo docker run --name database-mysql-pay -e MYSQL_ROOT_PASSWORD="password"  -e MYSQL_DATABASE="db_operation" -p 3307:3306 -p 33061:33060 --network polyglot-project -d  mysql:8.0.26
```

```bash
sudo docker run --name database-postgres-invoice -e POSTGRES_PASSWORD="password"  -e POSTGRES_DB="db_invoice" -p 5435:5432 --network polyglot-project -d  postgres:alpine3.14
```

```bash
sudo docker run --name database-mongo-transaction -e MONGO_INITDB_ROOT_USERNAME="polyglot" -e MONGO_INITDB_ROOT_PASSWORD="password"  -p 27018:27017 --network polyglot-project -d  mongo:5.0.2
```

3. Connect to all SQL databases and run migration files.

4. Create centralized configuration service (Nacos)

```bash
sudo docker run --name config-service-test -e MODE=standalone -p 8848:8848 --network polyglot-project -d nacos/nacos-server:v2.0.3
```

5. Go to Nacos dashboard (https://{IP VM in AWS}:{Nacos Port}/nacos) and add the following configurations:

```json
{
  "SERVER_PORT_SECURITY": 5001,
  "SERVER_PORT_INVOICE": 5002,
  "SERVER_PORT_PAY": 5003,
  "SERVER_PORT_TRANSACTION": 5004,
  "NODE_ENV": "development",
  "TOKEN_SECRET": "KeySecret#123pOLYglot#NodeJSMicro",
  "TOKEN_EXPIRATION": "1d",
  "DB_POSTGRES_USER": "postgres",
  "DB_POSTGRES_PASSWORD": "password",
  "DB_POSTGRES_DATABASE_INVOICE": "db_invoice",
  "DB_POSTGRES_HOST": "{IP VM in AWS}",
  "DB_POSTGRES_INVOICE_PORT": 5435,
  "DB_MYSQL_USER": "root",
  "DB_MYSQL_PASSWORD": "password",
  "DB_MYSQL_DATABASE_SECURITY": "db_security",
  "DB_MYSQL_DATABASE_PAY": "db_operation",
  "DB_MYSQL_HOST": "{IP VM in AWS}",
  "DB_MYSQL_PORT": 3307,
  "DB_MONGO_URI": "mongodb://polyglot:password@{IP VM in AWS}:27018",
  "DB_MONGO_DATABASE_MOVEMENT": "db_transaction"
}
```

6. Crate messaging service (Kafka)

```bash
sudo docker run --name bus-service-test -p 2181:2181 -p 9092:9092 --network polyglot-project  -e ADVERTISED_HOST=127.0.0.1 -e NUM_PARTITIONS=3 -d johnnypark/kafka-zookeeper:2.6.0
```

7. Add Kafka configuration variable to Nacos:

```json
{
    ...configurations,
    "KAFKA_SERVER":"{IP VM in AWS}:9092"
}
```
