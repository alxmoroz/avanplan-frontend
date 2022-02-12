# Hercules

## Backend Requirements

Backend, JSON based web API based on OpenAPI: http://localhost/api/

Automatic interactive documentation with Swagger UI (from the OpenAPI backend): http://localhost/docs

## Backend local development, additional details

### Migrations

As during local development your app directory is mounted as a volume inside the container, you can also run the migrations with `alembic` commands inside the container and the migration code will be in your app directory (instead of being only inside the container). So you can add it to your git repository.

Make sure you create a "revision" of your models and that you "upgrade" your database with that revision every time you change them. As this is what will update the tables in your database. Otherwise, your application will have errors.


* If you created a new model in `./backend/app/app/models/`, make sure to import it in `./backend/app/app/db/base.py`, that Python module (`base.py`) that imports all the models will be used by Alembic.

* After changing a model (for example, adding a column), inside the container, create a revision, e.g.:

```console
$ alembic revision --autogenerate -m "Add column last_name to User model"
```

* Commit to the git repository the files generated in the alembic directory.

* After creating the revision, run the migration in the database (this is what will actually change the database):

```console
$ alembic upgrade head
```


### Development in `localhost` with a custom domain

You might want to use something different from `localhost` as the domain. For example, if you are having problems with cookies that need a subdomain, and Chrome is not allowing you to use `localhost`.

In that case, you have two options: you could use the instructions to modify your system `hosts` file with the instructions below in **Development with a custom IP** or you can just use `localhost.tiangolo.com`, it is set up to point to `localhost` (to the IP `127.0.0.1`) and all its subdomains too. And as it is an actual domain, the browsers will store the cookies you set during development, etc.

If you used the default CORS enabled domains while generating the project, `localhost.tiangolo.com` was configured to be allowed. If you didn't, you will need to add it to the list in the variable `BACKEND_CORS_ORIGINS` in the `.env` file.

To configure it in your stack, follow the section **Change the development "domain"** below, using the domain `localhost.tiangolo.com`.

After performing those steps you should be able to open: http://localhost.tiangolo.com and it will be server by your stack in `localhost`.

Check all the corresponding available URLs in the section at the end.

### Development with a custom IP

If you are running Docker in an IP address different from `127.0.0.1` (`localhost`) and `192.168.99.100` (the default of Docker Toolbox), you will need to perform some additional steps. That will be the case if you are running a custom Virtual Machine, a secondary Docker Toolbox or your Docker is located in a different machine in your network.

In that case, you will need to use a fake local domain (`dev.hercules.com`) and make your computer think that the domain is served by the custom IP (e.g. `192.168.99.150`).

If you used the default CORS enabled domains, `dev.hercules.com` was configured to be allowed. If you want a custom one, you need to add it to the list in the variable `BACKEND_CORS_ORIGINS` in the `.env` file.

* Open your `hosts` file with administrative privileges using a text editor:
  * **Note for Windows**: If you are in Windows, open the main Windows menu, search for "notepad", right click on it, and select the option "open as Administrator" or similar. Then click the "File" menu, "Open file", go to the directory `c:\Windows\System32\Drivers\etc\`, select the option to show "All files" instead of only "Text (.txt) files", and open the `hosts` file.
  * **Note for Mac and Linux**: Your `hosts` file is probably located at `/etc/hosts`, you can edit it in a terminal running `sudo nano /etc/hosts`.

* Additional to the contents it might have, add a new line with the custom IP (e.g. `192.168.99.150`) a space character, and your fake local domain: `dev.hercules.com`.

The new line might look like:

```
192.168.99.100    dev.hercules.com
```

* Save the file.
  * **Note for Windows**: Make sure you save the file as "All files", without an extension of `.txt`. By default, Windows tries to add the extension. Make sure the file is saved as is, without extension.

...that will make your computer think that the fake local domain is served by that custom IP, and when you open that URL in your browser, it will talk directly to your locally running server when it is asked to go to `dev.hercules.com` and think that it is a remote server while it is actually running in your computer.

To configure it in your stack, follow the section **Change the development "domain"** below, using the domain `dev.hercules.com`.

After performing those steps you should be able to open: http://dev.hercules.com and it will be server by your stack in `localhost`.

Check all the corresponding available URLs in the section at the end.

### Change the development "domain"

If you need to use your local stack with a different domain than `localhost`, you need to make sure the domain you use points to the IP where your stack is set up. See the different ways to achieve that in the sections above (i.e. using Docker Toolbox with `local.dockertoolbox.tiangolo.com`, using `localhost.tiangolo.com` or using `dev.hercules.com`).

To simplify your Docker Compose setup, for example, so that the API docs (Swagger UI) knows where is your API, you should let it know you are using that domain for development. You will need to edit 1 line in 2 files.

* Open the file located at `./.env`. It would have a line like:

```
DOMAIN=localhost
```

* Change it to the domain you are going to use, e.g.:

```
DOMAIN=localhost.tiangolo.com
```

## Deployment

You can deploy the stack to a Docker Swarm mode cluster with a main Traefik proxy, set up using the ideas from <a href="https://dockerswarm.rocks" target="_blank">DockerSwarm.rocks</a>, to get automatic HTTPS certificates, etc.

And you can use CI (continuous integration) systems to do it automatically.

But you have to configure a couple of things first.


#### Deployment Technical Details

Building and pushing is done with the `docker-compose.yml` file, using the `docker-compose` command. The file `docker-compose.yml` uses the file `.env` with default environment variables. And the scripts set some additional environment variables as well.

The deployment requires using `docker stack` instead of `docker-swarm`, and it can't read environment variables or `.env` files. Because of that, the `deploy.sh` script generates a file `docker-stack.yml` with the configurations from `docker-compose.yml` and injecting the environment variables in it. And then uses it to deploy the stack.

You can do the process by hand based on those same scripts if you wanted. The general structure is like this:


### Continuous Integration / Continuous Delivery

If you use GitLab CI, the included `.gitlab-ci.yml` can automatically deploy it. You may need to update it according to your GitLab configurations.

If you use any other CI / CD provider, you can base your deployment from that `.gitlab-ci.yml` file, as all the actual script steps are performed in `bash` scripts that you can easily re-use.

GitLab CI is configured assuming 2 environments following GitLab flow:

* `prod` (production) from the `production` branch.
* `stag` (staging) from the `master` branch.

If you need to add more environments, for example, you could imagine using a client-approved `preprod` branch, you can just copy the configurations in `.gitlab-ci.yml` for `stag` and rename the corresponding variables. The Docker Compose file and environment variables are configured to support as many environments as you need, so that you only need to modify `.gitlab-ci.yml` (or whichever CI system configuration you are using).

## Project generation and updating, or re-generating

This project was generated using https://github.com/tiangolo/full-stack-fastapi-postgresql with:

```bash
pip install cookiecutter
cookiecutter https://github.com/tiangolo/full-stack-fastapi-postgresql
```

You can check the variables used during generation in the file `cookiecutter-config-file.yml`.

You can generate the project again with the same configurations used the first time.

That would be useful if, for example, the project generator (`tiangolo/full-stack-fastapi-postgresql`) was updated, and you wanted to integrate or review the changes.

You could generate a new project with the same configurations as this one in a parallel directory. And compare the differences between the two, without having to overwrite your current code but being able to use the same variables used for your current project.

To achieve that, the generated project includes the file `cookiecutter-config-file.yml` with the current variables used.

You can use that file while generating a new project to reuse all those variables.

For example, run:

```console
$ cookiecutter --config-file ./cookiecutter-config-file.yml --output-dir ../project-copy https://github.com/tiangolo/full-stack-fastapi-postgresql
```

That will use the file `cookiecutter-config-file.yml` in the current directory (in this project) to generate a new project inside a sibling directory `project-copy`.
