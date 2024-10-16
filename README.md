# ByteBazaar

ByteBazaar is a multi-container application that includes a frontend, backend, and database service. The application is orchestrated using Docker Compose, which handles the building and running of the containers for each service.

## Services
- **Frontend**: Built with Angular, the frontend service is served using Nginx.
- **Backend**: A Spring Boot application that connects to the MariaDB database.
- **Database**: MariaDB is used for persisting data, and the schema is automatically loaded on container startup.

## Prerequisites
Before you can run the application, make sure you have installed [Docker Desktop](https://www.docker.com/products/docker-desktop/).

## Environment Variables
You need to define the following environment variables to configure the backend and database:
1. [.env (resources)](ByteBazaarBackend\src\main\resources\example.env):
    ```.env
    MARIADB_USER=USERNAME
    MARIADB_PASSWORD=PASSWORD
    MARIADB_HOST=mariadb # <-- servicename
    MARIADB_PORT=3306 # <-- MariaDB uses port 3306 inside of the container
    DB_NAME=bytebazaarDB
    ```
2. [.env (backend directory)](ByteBazaarBackend\example.env):
    ```.env
    SECRET_KEY=JWS-Key
    ```
You'll also need to adjust the values inside of the [.env](example.env)file in the root direcotry. This file is used by Docker Compose to inject values into the containers.
```.env
MARIADB_USER=USERNAME
MARIADB_PASSWORD=PASSWORD
MARIADB_PORT=3306
DB_NAME=bytebazaarDB_v2
SECRET_KEY=JWT_SECRET
```
> [!Note]
> The values of this .env file need to correspond to the previous ones.

## Running the Application
1. Clone the repository
    ```bash
    git clone https://github.com/4g-13Eh/ByteBazaar.git
    cd ByteBazaar
    ```
2. Build and Run the Containers
    Ensure that Docker is running, and then use the following command to build and start the application:
    ```bash
    docker-compose up --build
    ```
    This will build the frontend and backend containers, start MariaDB, and run the application. The containers for each service will be started in the following order:
    1. MariaDB(Database)
    2. Backend (Spring Boot)
    3. Frontend (Angular)
3. Access the Application
    Once the containers are running, you can access the application at:
    - **Frontend**: http://localhost:4200
    - **Backend**: http://localhost:8080
    > [!Note]
    > If you have changed the ports in the docker-compose.yml file, update the URLs accordingly.

## Database Initialization
The MariaDB container will automatically initialize the database using the [schema.sql](ByteBazaarBackend\schema.sql) file. This schema is loaded on the first run when the database is empty.
To modify the database schema, edit the schema.sql file and rebuild the containers by running:
```bash
docker-compose down
docker-compose up --build
```

## Stopping the Application
To stop the running containers, run:
```bash
docker-compose down
```
This will stop and remove all the running containers.

## Troubleshooting
- If the containers fail to start, ensure that your .env file is correctly configured and that all required environment variables are set.
- To view logs from a specific container, run:
    ```bash
    docker-compose logs <service-name>
    ```
    For example, to view logs for the backend service:
    ```bash
    docker-compose logs backend
    ```
- If the database schema does not load, ensure that the schema.sql file is mounted correctly in the MariaDB container and that the volume is empty.

## License
This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.
