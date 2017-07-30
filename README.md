# Installation

## Requirements:

- ruby 2.3+
- yarn
- postgresql

## Getting Started:

```
git clone https://github.com/tamura2004/vue_handsontable.git workplan
cd workplan
bundle install
rails db:create
rails db:migrate
rails db:seed_fu
yarn
bundle exec rspec
rails s
```

### install yarn
[https://yarnpkg.com/lang/en/docs/install/](https://yarnpkg.com/lang/en/docs/install/)

```
choco install yarn
pg_dump mydatabase --data-only --inserts > seeds.sql
```

