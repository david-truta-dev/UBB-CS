# Online Shop Backend

# Spring Profiles

1. `[default]`
2. `local` - when running on the same server as the DB
3. `cognito` - when using cognito as the authorization server

# Running with PostgreSQL Database on a remote server

1. Build the Frontend: Run `npm install` && `npm run build` in the `frontend` folder.
2. Build the Backend: Run `mvn clean package` in the backend folder.
3. Run the JAR created in the `target` folder.
`java -Dspring.profiles.active=with-form -DPOSTGRES_HOST={POSTGRES_HOST} -DPOSTGRES_PORT={POSTGRES_PORT} -DPOSTGRES_USER={POSTGRES_USER} -DPOSTGRES_PASSWORD={POSTGRES_PASSWORD} -jar shop-0.0.1-SNAPSHOT.jar`

`POSTGRES_HOST`: IP of the server running the postgres service.

`POSTGRES_PORT`: Port on which the PostgreSQL runs  (default 5432)

`POSTGRES_USER`: Username for the PostgreSQL Database

`POSTGRES_USER`: Password for the PostgreSQL Database

4. The app will be running on port 8080. To login using the credentials stored in DB:
`http://localhost:8080`  
Username: `user`  
Password: `password`  