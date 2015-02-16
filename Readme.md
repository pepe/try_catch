# REST service with API

This service is being developed as part of the sample solution for
http://trycatch.us assesment.

I am using more exotic technologies, partly for myself to try them, but
mostly that I can show you, it is not programmed by Stack Overflow.

Also bear in mind, I will try hard to have as minimal solution to this problem
as possible.

## It must by API (REST, JSON)

- [ ] It must be secured by basic auth
- [ ] It must contain User mode ­ with different roles (admin, user, guest)
- [ ] It must limit access to given part of API depend of User role
- [ ] Admin has access to everything
- [ ] User can read all, create all, but update and deleted only his records
- [ ] Guest has only read access
- [ ] There should be at least 2 different models except User
- [ ] Those models should be in relation (1 to many)


## Technologies

- [Roda](http://roda.jeremyevans.net) as router and authenticator
- [Sequel](http://sequel.jeremyevans.net) as ORM
- [RSpec](http://rspec.info) and [Capybara](http://jnicklas.github.io/capybara/) for testing purposes

## Domain specification

Every domain object have unique identifier *id*.

**Private:**

- User
  - *call sign* String
  - *password* String
  - *role* String

**Public:**

- *Tree*
  - *common name* String
  - *latin name* String
  - *positionable* Boolean
  - have many *positions*

- *Position*
  - *longitude* String
  - *latitude* String
  - *living* Boolean
  - belongs to one *tree*


## domain API

Trees needs admin role for any change. Cannot be deleted
- */trees*
  - *GET* - returns list of all the trees
  - *GET /:id* - returns one tree
  - *GET /:id/positions* - returns list of all the positions of the tree
  - *POST* - creates a new tree
  - *PATCH /:id* - changes the tree information

Positions can be created, changed and deleted with hierarchy specified in the
main outline.
- */positions*
  - *GET* - returns list of all positions
  - *GET /:id* - returns one position
  - *GET /tree/:tree_id* - returns list of all positions of given tree
  - *POST /tree/:tree_id* - creates a new position of the tree
  - *PATCH /:id* - changes the position information
  - *DELETE /:id* - deletes the position
