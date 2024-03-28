 // プレビュー表示機能は新規投稿("/new/")か投稿編集("/edit/")ページでのみ有効にする
if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener('DOMContentLoaded', function(){
    // プレビューを表示するための要素を取得
    const ImageList = document.getElementById('image_prev');

    const createImageHTML = (blob) => {
      // 画像を表示するためのdiv要素を生成
      const imageElement = document.createElement('div');
      // 表示する画像を生成
      const blobImage = document.createElement('img');
      // img要素のsrc属性の値をセット
      blobImage.setAttribute('src', blob);

      // 生成したHTMLの要素をブラウザに表示させる
      imageElement.appendChild(blobImage);
      ImageList.appendChild(imageElement);
    };

    document.getElementById('post_prev').addEventListener('change', function(e){
      // 画像が表示されている場合のみ、すでに存在している画像を削除する（編集ページ用）
      const imageContent = document.querySelector('img');
      if (imageContent){
        imageContent.remove();
      }

      // 発火したイベントeの中の、targetの中の、filesという配列に格納された画像を変数に代入
      const file = e.target.files[0];
      // 画像のURLを生成
      const blob = window.URL.createObjectURL(file);

      createImageHTML(blob);
    });
  });
}
