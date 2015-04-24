var time
$('#ptime').countdown(first, function(event) {
  $(this).html(event.strftime('%D 天 %H:%M:%S'));
})