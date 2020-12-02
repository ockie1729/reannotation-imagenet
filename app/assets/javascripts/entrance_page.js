function showClock() {
  var nowTime = new Date();

  var msg = nowTime.toLocaleString();
  $('#entrance_msg').text(msg);
}
setInterval('showClock()', 500);
