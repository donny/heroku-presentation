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

# Notes

Beware of the non master branch on Heroku
https://devcenter.heroku.com/articles/multiple-environments#advanced-linking-local-branches-to-remote-apps
git push websocket websocket:master
