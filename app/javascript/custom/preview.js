 // プレビュー表示機能は新規投稿("/new/")か投稿編集("/edit/")ページでのみ有効にする
 if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener('DOMContentLoaded', function(){
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
//      if (blobImage.src || document.querySelector('#edit_post_image')) {
        imageElement.appendChild(deleteButton); // 削除ボタンを画像要素の隣に追加
//      }
      ImageList.appendChild(imageElement);
    };

    document.getElementById('select_image').addEventListener('change', function(e){
      // 画像が表示されている場合のみ、すでに存在している画像を削除する（編集ページ用）
      const imageContent = document.querySelector('img');
      const deleteBtn = document.querySelector('.preview_btn');
      if (imageContent) {
        imageContent.remove();
        if (deleteBtn) {
          deleteBtn.remove();
        }
      }

      // 発火したイベントeの中の、targetの中の、filesという配列に格納された画像を変数に代入
      const file = e.target.files[0];
      // 画像のURLを生成
      const blob = window.URL.createObjectURL(file);

      createImageHTML(blob);
    });
  });
}

$(document).on("click", '.preview_btn', function() {
    // フォームに画像を削除するためのフラグを設定する
    $('#post_form').find('#remove_image').val(true);

  // プレビューされた画像を削除する
  $(this).prev().remove(); // 画像要素を削除
  $(this).remove(); // 削除ボタンを削除
  $('#select_image').val(''); // ファイル選択をリセット（選択されたファイルをクリア）
});

