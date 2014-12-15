Comment = (data) ->
  self =
    id: ko.observable(data.id)
    name: ko.observable(data.name)
    content: ko.observable(data.content)
    created_at: ko.observable(data.created_at)
    url: "/comments/#{data.id}"
  self

ItemViewModel = (data) ->
  self =
    comments: ko.observableArray((new Comment(d) for d in data))
    unshiftComment: (data) ->
      self.comments.unshift(new Comment(data))
    removeComment: (data) ->
      self.comments.remove (comment) ->
        comment.id() == data.commentId
  self

$ ->
  KC_COMMENT = window.KC_COMMENT = window.KC_COMMENT ? {}
  KC_COMMENT.applyBindings = (key, data) ->
    itemViewModel = new ItemViewModel(data)
    ko.applyBindings(itemViewModel)

    pusher = new Pusher(key)
    channel = pusher.subscribe("test")
    channel.bind 'create', (data) ->
      $.ajax
        dataType: "json"
        url: "/comments/#{data.commentId}.json"
        success: (data) ->
          itemViewModel.unshiftComment(data)
    channel.bind 'destroy', (data) ->
      itemViewModel.removeComment(data)
