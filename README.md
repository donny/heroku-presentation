heroku-presentation websocket
=============================

# Running

``` bash
bundle install
foreman start
```

# Running on Heroku

``` bash
heroku apps:create appname
heroku labs:enable websockets
git push heroku master
heroku open
```
