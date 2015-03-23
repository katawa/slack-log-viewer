# Contributing

## Naming Conventions

### branch policy

- `master`
  - will be deployed to heroku
- `feature/*`
  - snake_case is preferred
  - branch for new feature / new codes
- `hotfix/*`
  - branch for critical bug which must be applied immediately to all branches

### Ruby version
- 2.2.0

### Ruby coding style

- snake_case is preferred
- single quote `'` is preferred
- please use Ruby 2.x's `symbol: 'variable'` syntax instead of *hash rockets* (`=>`)


## PR flow

### 1. Write code

```bash
git checkout -b feature/fix_search_icon
vim app/view/search/show.slim
git commit -a -m 'use glyphicon for search icon'
git push -u origin feature/fix_search_icon
```

### 2. Pull request

- Open https://github.com/katawa/slack-log-viewer and press the pull request button
- You can self-merge & deploy when you've received >=1 review comment(s)
- That's all!


