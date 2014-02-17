heroku-presentation jokes
=============================

# Running

``` bash
pip freeze > requirements.txt
foreman start
```

# Running on Heroku

``` bash
heroku apps:create appname
heroku addons:add mongohq
git push heroku master
heroku open
```
