# Why should I care about Docker?

Presentation to Erie Day of Code, 2017.

# Running the presentation

The presentation "runs" as a node server delivering static content, plus some
other goodies. There's a `Procfile` here so this should generally DTRT on
Heroku.

But if you're running the presentation you just need to remember:

    $ npm start

Then point your browser to [localhost](http://localhost:8000) if you need to,
though a window should open automatically.

Other things to remember:

* `s` will bring up speaker notes
* `esc` will give you a birds-eye view of the slides

# Meta

If you're interested in how this presentation system works you should check out
[reveal.js](https://github.com/hakimel/reveal.js/) because it's excellent.
