$(document).on('turbolinks:load', function(){
  var box_count = 0;
  var box_count2 = 0;

  function append_productimages(image, box_count2) {
    var html = `
            <li class="sell-upload__item">
              <figure class="sell-upload__figure portrait">
                <img src="${image}" id="image${box_count2}">
              </figure>
              <div class="sell-upload__button">
                <a id="upload-item__edit">編集</a>
                <a id="upload-item__delete">削除</a>
            </li>`
    return html;
  }

  function change_class_to_increment(name) {
    if($(".sell-upload-items") && box_count < 6){
      box_count += 1
      box_count2 += 1
      var add_box = $("have-item-" + box_count.toString(10));
      var remove_box = $("have-item-" + (box_count - 1).toString(10));
      if($(".sell-upload-items").next().length){
        $(".sell-upload-items:last").removeClass(remove_box.selector).addClass(add_box.selector);
      } else {
        $(".sell-upload-items").removeClass(remove_box.selector).addClass(add_box.selector);
      }
      $(".sell-upload__drop-box").removeClass(remove_box.selector).addClass(add_box.selector);
    }
  }

  function change_class_to_decrement(delete_target) {
    if(($(".sell-upload-items").next().children().length > 0)) {
      var reduce_box = delete_target.parent()
      reduce_box.removeClass("have-item-" + box_count.toString(10))
      $(".sell-upload__drop-box").removeClass("have-item-" + box_count.toString(10))
      box_count -= 1
      box_count2 -= 1
      reduce_box.addClass("have-item-" + box_count.toString(10))
      $(".sell-upload__drop-box").addClass("have-item-" + box_count.toString(10))
      if(box_count == 4) {
        $(".sell-upload__drop-box").prop('style', "display:block;")
      }
      if(box_count == 0) {
        $(".sell-upload__item:last").remove();
      }
    } else {
      var reduce_box = delete_target.parent()
      $(".sell-upload__drop-box").removeClass("have-item-" + box_count.toString(10))
      if(box_count == 0) {
        box_count += 5
      }
      reduce_box.removeClass("have-item-" + box_count.toString(10))
      box_count -= 1
      box_count2 -= 1
      reduce_box.addClass("have-item-" + box_count.toString(10))
      $(".sell-upload__drop-box").addClass("have-item-" + box_count.toString(10))
      if(box_count == 4) {
        $(".sell-upload-items:last").remove();
      }
    }
  }

  $("#input_files").on("change", function(){
    imagesPreview(this);
  });

  var imagesPreview = function(input) {
    if (input.files) {
      var filesAmount = input.files.length;
      var files = input.files;
      for (i = 0; i < filesAmount; i++) {
        (function() {
          var j = i;
          var file = files[j]; 
          var reader = new FileReader();
          reader.onload = function(e) {
            var src = e.target.result;
            var name = files[j].name;
            var upload_image = {name: name, image: src};
            insert_image = append_productimages(src, box_count2);
            if($(".sell-upload-items").next().length) {
              $(".sell-upload-items:last").children("ul").append(insert_image);
              change_class_to_increment(name)
              if(box_count == 5){
                $(".sell-upload__drop-box").prop('style', "display:none;")
              }
            } else {
              $(".sell-upload-items").children("ul").append(insert_image);
              change_class_to_increment(name)
              if(box_count == 5){
                $(".sell-upload__drop-box").removeClass("have-item-" + box_count.toString(10))
                var insert_box = append_uploadbox()
                var append_box = $(".sell-upload-items__container").append(insert_box)
                box_count = 0
                $(".sell-upload__drop-box").addClass("have-item-" + box_count.toString(10))
              }
            }
          };
          reader.readAsDataURL(file);
        })();
      }
    }
  };

  function append_uploadbox() {
    var html = `
      <div class="sell-upload-items have-item-0">
        <ul>
        </ul>
      </div>
    `
    return html;
  }

  $(".sell-dropbox__container").on("click", "#upload-item__delete", function(){
    var delete_target = $(this).parents(".sell-upload__item")
    var target_tag = delete_target.children("figure")
    var target_tag2 = target_tag.children("img")
    var target_id = target_tag2.attr("id")
    var file_list = document.getElementsByTagName("img")
    change_class_to_decrement(delete_target)
    delete_target.remove();
  })

  $(".sell-dropbox__container").on("click", "#upload-item__edit", function(){
    var edit_target = $(this).parents(".sell-upload__item").find("img")
    var target_img = edit_target.attr("src")
    var modal = append_modal_window(target_img)
    $(".sell-upload__box").after(modal)
    var new_canvas = append_new_canvas();
    $(".sell-upload__box").after(new_canvas);
    $("#modal").removeClass("hidden");
    $("#mask").removeClass("hidden");

    function draw_mask(ctx) {
      ctx.globalAlpha = 0.5;
      ctx.fillStyle = "#000";
      ctx.beginPath();
      ctx.lineTo(ctx.canvas.width, 0);
      ctx.lineTo(ctx.canvas.width, ctx.canvas.height);
      ctx.lineTo(0, ctx.canvas.height);
      ctx.lineTo(0, 0);
      ctx.closePath();
    
      ctx.moveTo(65, 65);
      ctx.lineTo(65, 315);
      ctx.lineTo(315, 315);
      ctx.lineTo(315, 65);
      ctx.closePath();
      ctx.fill();
      ctx.globalAlpha = 1;
    }

    const cvs = document.getElementById("canvas")
    const cw = cvs.width
    const ch = cvs.height
    const out = document.getElementById("new_canvas")
    const ow = out.width
    const oh = out.height

    let ix = 0    // 中心座標
    let iy = 0
    let v = 1.0   // 拡大縮小率
    const img  = new Image()
    img.src = target_img;
    img.onload = function( _ev ){   // 画像が読み込まれた
      ix = img.width  / 2
      iy = img.height / 2
      let scl = parseInt( oh / img.height * 1000 )
      var slider = document.getElementById("slider")
      slider.value = scl;
      scaling(scl)
    }
    img.onerror = function() {
      alert('画像の読み込み失敗');
    };

    function scaling(_v) {        // スライダーが変った
      v = parseInt(_v) * 0.001
      draw_canvas(ix, iy)       // 画像更新
    }

    var range = document.getElementById("slider");
    range.oninput = function() {
      var _v = document.getElementById("slider").value
      document.getElementById("slider").setAttribute("value", _v);
      v = parseInt(_v) * 0.001
      draw_canvas( ix, iy ) 
    }
  
    function draw_canvas( _x, _y ){     // 画像更新
      const ctx = cvs.getContext( '2d' )
      ctx.fillStyle = "#888"
      ctx.fillRect( 0, 0, cw, ch )    // 背景を塗る
      ctx.drawImage( img,
          0, 0, img.width, img.height,
          (cw/2)-_x*v, (ch/2)-_y*v, img.width*v, img.height*v,
      )
      draw_mask(ctx);
    }

    let mouse_down = false      // canvas ドラッグ中フラグ
    let sx = 0                  // canvas ドラッグ開始位置
    let sy = 0
    cvs.ontouchstart =
    cvs.onmousedown = function ( _ev ){     // canvas ドラッグ開始位置
    mouse_down = true
      sx = _ev.pageX
      sy = _ev.pageY
      return false // イベントを伝搬しない
    }
    cvs.ontouchend =
    cvs.onmouseout =
    cvs.onmouseup = function ( _ev ){       // canvas ドラッグ終了位置
      if ( mouse_down == false ) return
      mouse_down = false
      draw_canvas( ix += (sx-_ev.pageX)/v, iy += (sy-_ev.pageY)/v )
      return false // イベントを伝搬しない
    }
    cvs.ontouchmove =
    cvs.onmousemove = function ( _ev ){     // canvas ドラッグ中
      if ( mouse_down == false ) return
      draw_canvas( ix + (sx-_ev.pageX)/v, iy + (sy-_ev.pageY)/v )
      return false // イベントを伝搬しない
    }
    
    var complete = document.getElementById("complete")
    complete.onclick = function() {
      $("#modal").addClass("hidden");
      $("#mask").addClass("hidden");
      crop_img(edit_target);
      $("#new_img").remove();
    }
    
    function crop_img(edit_target){                // 画像切り取り
      const out = document.getElementById("new_canvas")
      const ow = out.width
      const oh = out.height
      const ctx = out.getContext("2d")
      ctx.fillStyle = "#888"
      ctx.fillRect( 0, 0, ow, oh )    // 背景を塗る
      ctx.drawImage( img,
        0, 0, img.width, img.height,
        (ow/2)-ix*v, (oh/2)-iy*v, img.width*v, img.height*v,
      )
      const data = out.toDataURL('image/png');
      var image_id = edit_target.attr("id");
      var change_image = document.getElementById(image_id)
      change_image.src = data;
    }

    var cancel = document.getElementById("cancel")
    cancel.onclick = function() {
      $("#mask").remove();
    }
  })

  function append_modal_window(target_img) {
    var html = `
      <div id="mask" class="hidden">
        <div id="modal" class="hidden">
          <div class="modal__header clearfix">
            <h3 class="left">写真を切り取る</h3>
            <div class="right">
              <a href>
                <i class="fas fa-camera"></i>
                <span>写真を変更する</span>
              </a>
              <input type="file" style="display: none;">
            </div>  
          </div>
          <div class="modal__editor">
            <canvas id="canvas" width="380px" height="380px" style="cursor: grab;"></canvas>
            <div class="modal__range">
              <i class="fas fa-camera"></i>
              <input id="slider" type="range" step="0.01" value='10' min='10' max='400' class="input-range-default">
              <i class="fas fa-camera"></i>
            </div>
          </div>
          <div class="modal__errors">
          </div>
          <div class="modal__btn clearfix">
            <a id="cancel" class="btn-default btn-gray left">キャンセル</a>
            <a id="complete" class="btn-default btn-red right">完了</a>
          </div>
        </div>
      </div>
    `
    return html;
  }

  function append_new_canvas() {
    var html = `
      <div id="new_img" class="hidden">
        <canvas id="new_canvas" width="250px" height="250px"></canvas>
      </div>
      `
      return html;
  }

  //カテゴリー
  $(function(){
    // カテゴリーセレクトボックスのオプションを作成
    function appendOption(category){
      var html = `<option class="append_select" value="${category.id}" data-size-id="${category.size_type_id}">${category.name}</option>`;
      return html;
    }
    // 子カテゴリーの表示作成
    function appendChidrenBox(insertHTML){
      var childSelectHtml = '';
      childSelectHtml = `
        <div class="select-wrap" id="children_wrapper">
          <select class="select-default" id="child_category" name="children_category">
            <option value="---">---</option>
            ${insertHTML}
          </select>
          <i class='fas fa-angle-down'></i>
        </div>`;
      $(".category-box").append(childSelectHtml);
    }
    function appendGrandchidrenBox(insertHTML){
      var grandchildSelectHtml = '';
      grandchildSelectHtml = `
        <div class="select-wrap" id="grandchildren_wrapper">
          <select class="select-default" id="grandchild_category" name="grandchild_category">
            <option value="---">---</option>
            ${insertHTML}
          </select>
          <i class='fas fa-angle-down'></i>
        </div>`;
      $(".category-box").append(grandchildSelectHtml);
    }
    // 親カテゴリー選択後のイベント
    $('#parent_category').on('change', function(){
      var urlhost = location.host
      var rurl = "http://" + urlhost+ "products/get_category_children"
      var parentCategory = document.getElementById('parent_category').value; //選択された親カテゴリーの名前を取得
      if (parentCategory != "---"){ //親カテゴリーが初期値でないことを確認
        $.ajax({
          url: rurl,
          type: 'get',
          data: { parent_name: parentCategory},
          dataType: 'json'
        })
        .done(function(children){
          $('#children_wrapper').remove(); //親が変更された時、子以下を削除する
          $('#grandchildren_wrapper').remove();
          $('#size_wrapper').remove();
          $('#brand_wrapper').remove();
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChidrenBox(insertHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除する
        $('#grandchildren_wrapper').remove();
        $('#size_wrapper').remove();
        $('#brand_wrapper').remove();
      }
    });

    $(".category-box").on('change', '#child_category', function(){
      var childId = $('#child_category').val(); //選択された子カテゴリーのidを取得
      if (childId != "---"){ //子カテゴリーが初期値でないことを確認
        var urlhost = location.host
        var rurl = "http://" + urlhost+ "products/get_category_grandchildren"
        $.ajax({
          url: rurl,
          type: 'GET',
          data: { child_id: childId },
          dataType: 'json'
        })
        .done(function(grandchildren){
          if (grandchildren.length != 0) {
            $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除するする
            $('#size_wrapper').remove();
            $('#brand_wrapper').remove();
            var insertHTML = '';
            grandchildren.forEach(function(grandchild){
              insertHTML += appendOption(grandchild);
            });
            appendGrandchidrenBox(insertHTML);
          }
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
        $('#size_wrapper').remove();
        $('#brand_wrapper').remove();
      }
    });
  });

  //配送方法
  function append_formGroup() {
    var html = `
      <div class="form-group">
        <label for="shipping_area">
        配送の方法
          <span class="form-require">必須</span>
        </label>
        <div class="select-wrap">
          <i class="fas fa-angle-down"></i>
          <select id="shipping_method", name="product[shipping_method]", class="select-default">
          </select>
        </div>
      </div>
    `
    return html;
  };

  function cash_on_delivery(selectId){
    var arr = [
      {val:"---", txt:"---"},
      {val:"未定", txt:"未定"},
      {val:"クロネコヤマト", txt:"クロネコヤマト"},
      {val:"ゆうパック", txt:"ゆうパック"},
      {val:"ゆうメール", txt:"ゆうメール"},
      {val:"ゆうパケット", txt:"ゆうパケット"},
      {val:"レターパック", txt:"レターパック"},
      {val:"普通郵便(定形、定形外)", txt:"普通郵便(定形、定形外)"},
      {val:"クリックポスト", txt:"クリックポスト"},
      {val:"らくらくメルカリ便", txt:"らくらくメルカリ便"},
    ];
   
    for(var i=0;i<arr.length;i++){
      let op = document.createElement("option");
      op.value = arr[i].val;
      op.text = arr[i].txt;
      selectId.appendChild(op);
    }
  };

  function shipping_included(selectId){
    var arr = [
      {val:"---", txt:"---"},
      {val:"未定", txt:"未定"},
      {val:"クロネコヤマト", txt:"クロネコヤマト"},
      {val:"ゆうパック", txt:"ゆうパック"},
      {val:"ゆうメール", txt:"ゆうメール"},
    ];

    for(var i=0;i<arr.length;i++){
      let op = document.createElement("option");
      op.value = arr[i].val;
      op.text = arr[i].txt;
      selectId.appendChild(op);
    }
  };

  const selectId = document.getElementById("product_shipping_charge")
  $(selectId).change(function() {
    if($(document.getElementById("shipping_method")).length) {
      var shippingMethodId = document.getElementById("shipping_method");
      var parent = shippingMethodId.closest(".form-group");
      parent.remove();
    }

    if($(this).val() !== "---") {
      var parent = $(this).closest(".form-group");
      parent.after(append_formGroup());
      var selectId = document.getElementById("shipping_method");
      if($(this).val() == "着払い(購入者負担)") {
        cash_on_delivery(selectId);
      } else if($(this).val() == "送料込み(出品者負担)") {
        shipping_included(selectId);
      }
    } 
  });

  $("#product_selling_price").on("keyup", function(){
    var raw_price = $(this).val()
    if(300 <= raw_price && 9999999 >= raw_price) {
      var fee = raw_price * 0.1
      var profit = raw_price - fee
      $("#fee").text("¥" + Math.floor(fee))
      $("#profit").text("¥" + Math.floor(profit))
    } else if(raw_price < 300 || 9999999 < raw_price) {
      var fee = "-"
      var profit = "-"
      $("#fee").text(fee)
      $("#profit").text(profit)
    }
  })

})