Start with

```bash
rails db:prepare
rails s -p 3001
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
