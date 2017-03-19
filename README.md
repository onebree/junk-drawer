# junk-drawer

junk drawer for reddit

finally organize all your saved junk from reddit

## Dependencies

- Git for cloning the repository
- Ruby version 2.4.0
- PostgreSQL version >= 9.5
- Node.js for a JavaScript runtime

## Setup

For instructions on setting up a working dev environment:

[Setup wiki article](https://github.com/onebree/junk-drawer/wiki/setup)

Note: These instructions are for Ubuntu 16.

These instructions cover:

- Installing Git
- Installing Ruby 2.4.0
- Setting up PostgreSQL
- Installing Node.js

Once everything is setup, you can clone this project:

```bash
$ git clone git@github.com:onebree/junk-drawer.git
```

## Running

To run the app locally, run the Rails server, and visit `localhost:3000/`.

```bash
$ rails s
```

In development, the Reddit omniauth strategy cannot be tested. Instead, you'll be redirected to the developer strategy. Log in with any nickname you want.

To work with the database or IRB, run the Rails console:

```bash
$ rails c
```
