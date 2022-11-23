# Flask SCIM Server
**NOTE:** This is not meant to be a fully-fledged, IDP-agnostic SCIM server. 

This code example allows you to sync user accounts and groups from a SCIM-enabled directory server, like Azure AD, to a PostgreSQL database. For exploring the synced data, a [pgAdmin](http://pgadmin.org) instance is provided. 

## Dependencies:
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Setting up via Docker
First, create an ```.env``` file, including the necessary environment variables:

```env
POSTGRES_HOST=db
POSTGRES_DB=scim
POSTGRES_USER=scim
POSTGRES_PASSWORD=123456

API_BEARER=12345678

PGADMIN_DEFAULT_EMAIL=admin@example.com
PGADMIN_DEFAULT_PASSWORD=pgadminpass
PGADMIN_LISTEN_ADDRESS=0.0.0.0
```

Thereafter, you're ready to start the containers:
1.  Build and start docker containers with ```docker-compose up```
2.  Run the following commands to create migrations and tables in the ```scim``` database:
    - ```docker-compose exec server python manage.py db init```
    - ```docker-compose exec server python manage.py db migrate```
    - ```docker-compose exec server python manage.py db upgrade```

3. Everything should now be set up and you have your SCIM server running at http://127.0.0.1:5000.

## Setting up a reverse proxy for SSL
- The ports exposed by the Docker containers are solely accessible via localhost, for security reasons a reverse proxy, like [nginx](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/), providing SSL is highly recommended

## Configuring and testing your directory server for SCIM provisioning
Now it's time to configure your directory server for syncing data to this server via the SCIM v2 API. 
E.g., for Azure Active Directory, create a new *Enterprise Application*. 
Within the *Provision User Accounts* step, you set the Tenant URL to the endpoints of your service, like `https://example.com:5443/scim/v2/`, and enter the value of the `API_BEARER` as *Secret Token*. 
Afterwards, click the *Test Connection* button to see if all works as expected.