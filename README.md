Start with

```bash
bin/rails db:drop
bin/rails db:drop:cache
bin/rails db:drop:cable
bin/rails db:drop:queue
bin/rails db:create
bin/rails db:create:cache
bin/rails db:create:cable
bin/rails db:create:queue
bin/rails db:migrate
bin/dev
```

or

```bash
rails s -p 3002
```

and after

```bash
bin/jobs start
```

## Fixes with

This will run rubocop and brakeman

```bash
bin/fix_before_push
```
