# Example: Using Flyway and Spawn to test database migrations

This demo repo is an example of how to use [Flyway](https://flywaydb.org/) and [Spawn](https://spawn.cc/) to test database migrations with GitHub Actions.

For the full tutorial please refer to the Flyway documentation: [Testing Flyway migrations in a CI pipeline](https://flywaydb.org/documentation/tutorials/migrationtesting)

### RDS database preparation

Before starting change the directory:

```bash
cd rds
```

1. Create a new RDS database instance in AWS. The database should be publicly accessible and have a username and password set.

```bash
PGPASSWORD=<RDS_PASSWORD> ./create-pagila-db.sh
```

Check the status of the database instance and wait when it's active.

2. Insert the data into the database.

Got to AWS RDS console and copy the endpoint of the database. Then run the following command:

```bash
PAGILA_HOST=<RDS_HOST> PAGILA_USERNAME=postgres PAGILA_PASSWORD=<RDS_PASSWORD> ./insert-data.sh 
```

3. Create GitHub secretes

You need to set following variables:
- `PAGILA_HOST`
- `PAGILA_ADMIN_USERNAME`
- `PAGILA_ADMIN_PASSWORD`
