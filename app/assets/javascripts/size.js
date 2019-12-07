$(document).on('turbolinks:load', function(){

  function append_size_form(){
    var html = `
      <div class="form-group size" id="size_wrapper">
        <label for="product_size_id">
        サイズ
          <span class="form-require">必須</span>
        </label>
        <div class="select-wrap">
          <i class="fas fa-angle-down"></i>
          <select class="select-default" name="product[size_id]" id="product_size">
            <option id="size_select">---</option>
          </select>
        </div>
      </div>

      <div class="form-group" id="brand_wrapper">
        <label for="product_brand_id">
        ブランド
          <span class="form-arbitrary">任意</span>
        </label>
        <div class="select-wrap">
          <input placeholder="例) シャネル" default="default" class="input-default brand" type="text" id="product_brand_id">
          <input name="product[brand_id]" type="hidden" class="hidden-default brand_hidden">
        </div>
      </div>`
    return html;
  }
  $(".category-box").on("change", "#child_category", function(){
    var urlhost = location.host
    var rurl =  "http://" + urlhost + "/products/get_size"
    var append_select = $(this).find(".append_select")
    var size_type_id = append_select.data("size-id")
    $.ajax({
      type: 'GET',
      url: rurl,
      data: {size_type_id: size_type_id},
      dataType: 'json'
    })
    .done(function(sizes){
      if($(".size").length == 0) {
        var size_form = append_size_form()
        $(".category-box").after(size_form)
      }
      sizes.forEach(function(size){
        if(size.size_type_id != undefined) {
          $("#product_size").append(`<option value=${size.id}>${size.name}</option>`)
        }
      })
    })
  })
})