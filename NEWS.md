# 0.0.0.9004

* Migrated from webshot to webshot2 (in order to migrate from Ubuntu 18.04 to
  22.04)

# 0.0.0.9003

* Migrated to ghapps 1.0.0 (which contained breaking API changes)

# 0.0.0.9002

* Skip private repositories (likely caused by a user installing the GitHub App
for their entire account instead of only the workflowr project(s))

* Skip repositories with no GitHub Pages (likely caused by user not yet
activating GitHub Pages)

* Update the fix for potential HTML in publication titles after the CrossRef
update changed the formatting

# 0.0.0.9001

* Support for HTML tags in publication titles
