FROM openjdk:8-jdk-alpine
COPY target/shop-1.0.jar shop-1.0.jar
ENTRYPOINT java -Dspring.profiles.active=cognito -DOAUTH_ISSUER_URL=${OAUTH_ISSUER_URL} -DPOSTGRES_HOST=${POSTGRES_HOST} -DPOSTGRES_PASSWORD=${POSTGRES_PASSWORD} -jar shop-1.0.jar