Comment = (data) ->
  self =
    name: ko.observable(data.name)
    content: ko.observable(data.content)
    created_at: ko.observable(data.created_at)
  self

ItemViewModel = (data) ->
  self =
    comments: ko.observableArray(data)
    comment: ko.observable("")
    unshiftComment: (data) ->
      self.comments.unshift(new Comment(data))
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
