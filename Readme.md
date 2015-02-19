# REST service with API

This service is being developed as part of the sample solution for
http://trycatch.us assesment.

## It must by API (REST, JSON)

- [X] It must be secured by basic auth
- [X] It must contain User model ­ with different roles (admin, user, guest)
- [X] It must limit access to given part of API depend of User role
- [X] Admin has access to everything
- [X] User can read all, create all, but update and deleted only his records
- [X] Guest has only read access
- [X] There should be at least 2 different models except User
- [X] Those models should be in relation (1 to many)


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
  - *longitude* Float
  - *latitude* Float
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
> bundle rackup # to run http server
```

## Motivations to this solution

I am using more exotic technologies, partly for myself to try them, but
mostly that I can show you, it is not programmed by Stack Overflow. And to show,
that I am able to think outside of the box.

In its final version I guess it has everything what was in the assesment TODO
list. But there are few rought parts, which would be refactored in the real
world. Mainly Domain::Store is just a sham for some more advanced mapper/command
type thing.

Bear in mind, I was trying hard to have as minimal solution to this problem
as possible.

I am looking forward for what you think about it.

[1]: http://roda.jeremyevans.net
[2]: http://sequel.jeremyevans.net
[3]: http://rspec.info
[4]: https://github.com/brynary/rack-test
