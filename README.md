Before launching the project, you need to create a `.env` file at the root of the project directory to configure the environment variables required for the services. This file should include variables such as database passwords, user names, and any other configurations your services might need. Ensure you set `DOMAIN_NAME=localhost` in your `.env` file to properly configure the domain name for the services.

## Installation

1. **Clone the repository**:

    ```bash
    git clone
    ```

2. **Navigate to the project directory**:

    ```bash
    cd inception
    ```

3. **Create and configure your `.env` file as described in the Configuration section**.

    A template for the `.env` file might look like this:

    ```
    # Environment configuration
    DOMAIN_NAME=localhost
    MYSQL_ROOT_PASSWORD=examplepassword
    MYSQL_USER=exampleuser
    MYSQL_PASSWORD=exampleuserpassword
    MYSQL_DATABASE=exampledb
    ```

    Make sure to replace the placeholder values with your actual data.

4. **Launch the project**:

    Using the Makefile, you can build and start all the services with the configured environment variables.

    ```bash
    make all
    ```

    This command will initiate the Docker-compose process, which reads the `docker-compose.yml` and `.env` files, building the necessary Docker images, and starting up the containers as defined.

## Usage

After successfully launching the services:

- **Web Server**: Your web application will be accessible at `https://localhost`.
- **Admin Interface**: To manage the database, access the admin tool (like phpMyAdmin) at `https://localhost:<admin_port>`. Be sure to replace `<admin_port>` with the actual port number you configured in your `docker-compose.yml` file.

## Cleanup

To clean up your environment, you can use the Makefile commands designed for this purpose:

- **To stop and remove the containers, networks, and volumes**:

    ```bash
    make down
    ```

- **For a full cleanup, including removing all images used by the project**:

    ```bash
    make fclean
    ```

    This will ensure that all components related to the project are removed, freeing up your system resources.

