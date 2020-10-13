## Quick start

Install the bundle:
```
bundle install
```

Make sure the postresql is running on localhost. You may have to change your credentials under /config/database.yml:

```
rake db:create
rake db:migrate
```

Run the development server:

```
rails s
```

Connect to API via http://localhost:3000

## Before commit
Set up overcommit to make sure your code is clean :) :

```bash
gem install overcommit
bundle install --gemfile=.overgems.rb
overcommit --install
```
Then you can commit your changes! And don't forget to run specs before:

```bash
bundle exec rspec
```

## API

Available requests:

Verb | Path
--- | ---
GET | /group_events
POST | /group_events
GET | /group_events/:id
PATCH | /group_events/:id
PUT | /group_events/:id
DELETE | /group_events/:id
