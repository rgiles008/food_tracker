# Foodie

This application is a LiveView implementation that makes use of the Google maps api to render
food truck data posted to [DataSF](https://data.sfgov.org/Economy-and-Community/Mobile-Food-Facility-Permit/rqzj-sfat/data)

## Completion Time

I only applied to available 2 hours to get the application to where it currently is. If more time was available here are some things that were missed and also things I would have improved on.

* Add availability to use filter types to trim the list down to a food type or location range
* Add ability to reduce the amount of results displayed.
* The application displays the food trucks who have the latest expiring expiration date meaning they are the most current, but adding a cron service to query the list every day or week to get updated results would provide the most up-to-date information
* Add user persistence to allow saving a specific location so that it can be shown in relation to more current trucks

## Development

The application is dockerized so in order to run this application you will need to:

1. Ensure that you have docker, docker-compose and that the docker daemon is running. You can install these using Homebrew or from the [Docker Website](https://docs.docker.com/desktop/).
2. To start the docker daemon you can either open the docker desktop application or you can run `dockerd` in the terminal (you may need to use sudo).
3. In the project directory, run `docker-compose build`
4. Once the build is complete, run `docker-compose up`
5. You may receive an error about the database not being created. If that comes up you can run `docker-compose run web mix ecto.create`
6. Once the project has built you can navigate to the [Local Server](http://localhost:4000)

