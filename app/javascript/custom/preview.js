 // プレビュー表示機能は新規投稿("/new/")か投稿編集("/edit/")ページでのみ有効にする
  //document.addEventListener('DOMContentLoaded', function(){
    window.addEventListener('load', function() {
    // プレビューを表示するための要素を取得
    const ImageList = document.getElementById('image_prev');


    const createImageHTML = (blob) => {
      // 画像を表示するためのdiv要素を生成
      const imageElement = document.createElement('div');
      imageElement.classList.add('preview');
      // 表示する画像を生成
      const blobImage = document.createElement('img');
      // img要素のsrc属性の値をセット
      blobImage.setAttribute('src', blob);

       // 削除ボタンを生成
       const deleteButton = document.createElement('div');
       deleteButton.innerHTML = '<i class="far fa-times-circle"></i>';
       deleteButton.classList.add('preview_btn');

      imageElement.appendChild(blobImage);
      imageElement.appendChild(deleteButton); // 削除ボタンを画像要素の隣に追加

      ImageList.appendChild(imageElement);
    };
    
    if (document.getElementById('select_image')) {
    document.getElementById('select_image').addEventListener('change', function(e){
      // 画像が表示されている場合のみ、すでに存在している画像を削除する（編集ページ用）
      const imageContent = document.querySelector('.preview');
      const editImageContent = document.querySelector('#edit_image');
      const deleteButton = document.querySelector('.preview_btn');
      
      if (imageContent) {
        imageContent.remove();
      }
      if (editImageContent) {
        editImageContent.remove();
        deleteButton.remove();
      }
  

      // 発火したイベントeの中の、targetの中の、filesという配列に格納された画像を変数に代入
      const file = e.target.files[0];
      // 画像のURLを生成
      const blob = window.URL.createObjectURL(file);

      createImageHTML(blob);
    });
  }
  
  });

//}

$(document).on("click", '.preview_btn', function() {
    // フォームに画像を削除するためのフラグを設定する
    $('#post_form').find('#remove_image').val(true);

  // プレビューされた画像を削除する
  $(this).prev().remove(); // 画像要素を削除
  $(this).remove(); // 削除ボタンを削除
  $('#select_image').val(''); // ファイル選択をリセット（選択されたファイルをクリア）
});

