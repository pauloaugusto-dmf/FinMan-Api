# FinMan API

API for a system to manage finances in a simple and easy way

<table>
    <tr>
        <td>Ruby</td>
        <td>3.1.2</td>
    </tr>
    <tr>
        <td>Ruby on Rails</td>
        <td>7.0.2</td>
    </tr>
    <tr>
        <td>Postgresql</td>
        <td>13</td>
    </tr>
</table>

# Settings to run the project

Note: To run this project it is necessary to have Docker and Docker-Compose installed. For more information visit [Docker Docs](https://docs.docker.com/)

```bash
# clone the repository
git clone https://github.com/pauloaugusto-dmf/FinMan-Api.git

# Access the project folder
cd ecommerce_rails_api

# start the container
make up

# create the database
make db-create

# migrate the database
make db-migrate
```

### Open the browser at the address `http://0.0.0.0:3000` 
<br>

# Other useful commands

Note: These commands need the container to be active
```bash
# run container with logs
make up-logs

# run the tests
make test

# show the logs
make logs

# run the rails console
make console

# finish the container
make down
```