class Notifications
  constructor: ->
    @notifications = $("[data-behavior='notifications']")
    @setup() if $("[data-behavior='notifications']").length > 0
  setup: ->
    self = @

    $("[data-behavior='notification-link']").on "click", @handleClick

    $(document).on "click", ".join_btn", ( ->
      console.log $(this).attr("id")
      console.log $(this).attr("order_id")
      console.log $(this).attr("nid")
      btn = $(this)
      $.ajax(
        url: "/notifications/make_join"
        dataType: "JSON"
        method: "POST"
        data: 
          id: $(this).attr("id")
          order_id: $(this).attr("order_id")
          n_id: $(this).attr("nid")
        success: ->
          btn.remove()
      )
    )

    (worker = ->
      $.ajax
        url: "/notifications.json"
        method: "GET"
        success:self.handleSuccess
        complete: ->
        setTimeout worker, 10000

        )()
  handleClick: (e) =>
    $.ajax(
      url: "/notifications/mark_as_read"
      dataType: "JSON"
      method: "POST"
      success: ->
        $("[data-behavior='unread-count']").text(0)
    )

  handleSuccess: (data)=>
    console.log(data)
    num = 0
    items = $.map data, (notification) ->
      num = notification.number
      if notification.action == 'invited'
        "<li> #{notification.actor.name} #{notification.action} you to an #{notification.notifiable.type}<a class='btn btn-success join_btn' id='#{notification.actor.id}' order_id='#{notification.order.id}' nid='#{notification.nid}' >join</a></li>"
      else
        "<li><a class='dropdown-item' href='#{notification.url}'>#{notification.actor.name} #{notification.action} an #{notification.notifiable.type}</a></li>"
    $("[data-behavior='unread-count']").text(num)
    $("[data-behavior='notification-items']").html(items)
jQuery ->
  new Notifications
