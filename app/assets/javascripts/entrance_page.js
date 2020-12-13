function showClock() {
  var nowTime = new Date();

  // 次のコンペが存在して，開始していたらページ遷移
  var startsAt = $('#entrance_timer').data('competition_starts_at');
  if (startsAt !== undefined) {
    if ((startsAt-nowTime)<0) {
      window.location.href = '/';
    }
  }

  var msg = nowTime.toLocaleString();
  $('#entrance_timer').text(msg);
}
setInterval('showClock()', 500);

$(document).on('turbolinks:load', function() {
    $.ajax({
      type: "get",
      url: '/competitions/next',
      contentType: 'application/json',
      dataType: "json",
      success: function(json_data) {
        // 次のコンペが存在していたら，その時間を保存
        var has_next = json_data['has_next'];
        if (has_next !== null) {
          $('#entrance_timer').data('competition_starts_at', Date.parse(json_data['starts_at']));
        }
      },
      error: function() {
        alert('Server Error. Pleasy try again later.(Entrance Page)');
      },
      complete: function() {
      }
    });
});
