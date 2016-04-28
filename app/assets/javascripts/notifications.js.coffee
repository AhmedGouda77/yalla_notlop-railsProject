class Notifications
  constructor: ->
    @notifications = $("[data-behavior='notifications']")
    @setup() if $("[data-behavior='notifications']").length > 0
  setup: ->
    $("[data-behavior='notification-link']").on "click", @handleClick
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @handleSuccess
    )
  handleClick: (e) =>
    $.ajax(
      url: "/notifications/mark_as_reads"
      dataType: "JSON"
      method: "POST"
    )
  handleSuccess: (data)=>
    console.log(data)
    items = $.map data, (notification) ->
      "<a class='dropdown-item' href='#{notification.url}'>#{notification.actor} #{notification.action} #{notification.notifiable.type}</a>"
    $("[data-behavior='unread-count']").text(items.length)
    $("[data-behavior='notification-items']").html(items)
jQuery ->
  new Notifications