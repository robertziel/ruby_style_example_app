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

## To do
* It may be useful to validate if duration matches start_date and end_date (especially if all 3 attributes are provided via API)
* Validation translations should be added

## Uncertainties
* It is said that: `The group event should run for a whole number of days e.g.. 30 or 60.`. In mathematics, whole numbers are the basic counting numbers 0, 1, 2, 3, 4, 5, 6, … and so on. It means it cannot be one and half day, which makes sense even without this tip.
But also there are example numbers 30 and 60 are the whole number of days. The question is if the author mean the whole number of days as theoretical mathematical numbers or period that matches 30, 60 and so on. In the second case it seems like the whole number is a duration divisible by 30.
It is pretty unclear. First version seems to be more logical but second version may be also possible especially if the sentence is written by non-technical person.
Certainly, the best solution would be asking which version in that case is right. If it is not possible to get such information at the moment the first version should be implemented as it is less time consuming and can be quickly changed to second version in the future if required. But I have implemented the second version as it is more complex and I want to show that it would be not a problem to make it working.
