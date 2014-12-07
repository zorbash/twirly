class app.Router extends Backbone.Router
  cache = {}

  routes:
    '': 'index'
    'posts/:card_id.html': 'postsShow'
    'users/:id.html': 'usersShow'

  index: -> @_showView($('#posts'))

  postsShow: (card_id) ->
    @_fetchContent("posts/#{card_id}.html").then (data) => @_showView($('#post'), data)

  usersShow: (id) ->
    @_fetchContent("users/#{id}.html").then (data) => @_showView($('#user'), data)

  _showView: ($view, content) ->
    $('.view').hide()
    $view.html(content) if content
    $view.show()

  _fetchContent: (url) ->
    dfd = $.Deferred()
    return dfd.resolve(cache[url]) if cache[url]

    $.ajax(url).then (data) -> cache[url] = data

