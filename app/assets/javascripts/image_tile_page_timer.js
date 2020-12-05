function showImageTilePageTimer() {
  var nowTime = new Date();
  var endsAt = new Date($('#timer').data('competition_ends_at'));

  var remainingTime = Math.floor((endsAt - nowTime)/1000);

  // コンペが終わっていたら，ページを再読込
  if (remainingTime < 0) {
      location.reload();
  }

  var hours = Math.floor(remainingTime/3600);
  var minutes = Math.floor((remainingTime-hours*3600)/60);
  var seconds = remainingTime - hours*3600 - minutes*60;
  var remainingTimeStr = "残り " + hours + "時間" + minutes + "分" + seconds + "秒";

  $('#timer').text(remainingTimeStr);
}
setInterval('showImageTilePageTimer()', 500);

$('#timer').ready(function() {

    $.ajax({
      type: "get",
      url: "/competitions/running",
      contentType: 'application/json',
      dataType: "json",
      success: function(json_data) {
        var ends_at = Date.parse(json_data["ends_at"]);
        $("#timer").data('competition_ends_at', ends_at);
      },
      error: function() {
        alert("Server Error. Pleasy try again later.");
      },
      complete: function() {
      }
    });
});
