$(function(){
  $('#gallery').imagesLoaded(function(){
    $('#gallery').masonry({
      itemSelector: '.image-item',//整理される要素のclassを指定
      columnWidth: 300,     //一列の幅サイズを指定
      isAnimated: true,     //スムースアニメーション設定
      isFitWidth: true,     //親要素の幅サイズがピッタリ
      isRTL: false,         //整理される要素が左右逆になる（読み言語などに）
      gutterWidth: 0,       //整理される要素間の溝の幅を指定
      containerStyle: { position: 'relative' }, //親要素にスタイルを追加できる
      isResizable: true     //ウィンドウサイズが変更された時に並び替え
    });
  });

  // labelの値の初期設定
  $('#label-area').data("current_label", 0);
  $('#label-area').data('border_color', 'blue')

  /*
   *  クリック処理
   */
  
  // 画像を選択
  $(".image-item").on("click", function() {
    var border_color = $('#label-area').data('border_color');
    var current_label = $('#label-area').data('current_label');

    $(this).css("border-color", border_color);
    $(this).data('label', current_label);
    console.log("set label" + current_label);
  });

  // クラスを変更
  $("#label-area div").on("click", function() {
    var button_class_no = $(this).attr("id");

    switch(button_class_no) {
      case "btn-class-1":
	$('#label-area').data('border_color', 'blue');
	$('#label-area').data('current_label', 1);
	break;
      case "btn-class-2":
	$('#label-area').data('border_color', 'green');
	$('#label-area').data('current_label', 2);
	break;
      case "btn-class-3":
	$('#label-area').data('border_color', 'red');
	$('#label-area').data('current_label', 3);
	break;
      case "btn-class-0":
	$('#label-area').data('border_color', 'transparent');
	$('#label-area').data('current_label', 0);
	break;
    }
  });

  // クリック済みのラベルを読み込む
  $("#send-labels").on("click", function() {
    // 多重送信を防ぐため通信完了までボタンをdisableにする
    var button = $(this);
    button.attr("disabled", true);

    // データを準備
    var labels = [];
    $(".image-item").each(function(index, elem) {
      var label = $(elem).data("label");
      var image_id = $(elem).attr("id");

      if (label == undefined) {
	labels.push({"image_id": image_id,
		     "label": 0})
      } else {
	labels.push({"image_id": image_id,
		     "label": label});
      }
    });
    
    // 通信実行
    $.ajax({
      type:"post",                // method = "POST"
      url:"/images/tiles",        // POST送信先のURL
      data:JSON.stringify(labels),  // JSONデータ本体
      contentType: 'application/json', // リクエストの Content-Type
      dataType: "json",           // レスポンスをJSONとしてパースする
      success: function(json_data) {   // 200 OK時
	console.log(json_data);
        // JSON Arrayの先頭が成功フラグ、失敗の場合2番目がエラーメッセージ
        if (!json_data[0]) {    // サーバが失敗を返した場合
          alert("Transaction error. " + json_data[1]);
          return;
        }
        // 成功時処理
	// location.reload();
      },
      error: function() {         // HTTPエラー時
        alert("Server Error. Pleasy try again later.");
      },
      complete: function() {      // 成功・失敗に関わらず通信が終了した際の処理
	button.attr("disabled", false);  // ボタンを再び enableにする
	window.location.href = "/images/tiles";
      }
    });
  });
});
