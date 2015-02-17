# REST service with API

This service is being developed as part of the sample solution for
http://trycatch.us assesment.

I am using more exotic technologies, partly for myself to try them, but
  mostly that I can show you, it is not programmed by Stack Overflow.

Also bear in mind, I will try hard to have as minimal solution to this problem
as possible.

## It must by API (REST, JSON)

- [X] It must be secured by basic auth
- [X] It must contain User model ­ with different roles (admin, user, guest)
- [X] It must limit access to given part of API depend of User role
- [ ] Admin has access to everything
- [ ] User can read all, create all, but update and deleted only his records
- [ ] Guest has only read access
- [ ] There should be at least 2 different models except User
- [ ] Those models should be in relation (1 to many)


## Technologies

- [Roda][1] as router and authenticator
- [Sequel][2] as ORM
- [RSpec][3] and [Rack-test][4] for testing purposes
- SQLite in memory adapter.
```
brew install sqlite
```

## Domain specification

Every domain object have unique identifier *id* Integer

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
  - *creator_id* Integer
  - belongs to one *tree*


## API

Every request is authenticated by basic http authentication

Trees needs admin role for any change. Cannot be deleted
- */trees*
  - *GET* - returns list of all the trees
  - *GET /:id* - returns one tree
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

## Development

```
> git clone https//github.com/pepe/try_catch
> cd try_catch
> bundle install
..................
> bundle exec rspec # to run specs
```

[1]: http://roda.jeremyevans.net
[2]: http://sequel.jeremyevans.net
[3]: http://rspec.info
[4]: https://github.com/brynary/rack-test
