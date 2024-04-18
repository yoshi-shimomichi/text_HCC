$(document).on("click", '#new_comment_btn', function() {
  $('.reply-comment-form').hide();
  $('.edit-comment-form').hide();
  $('#comment_form_for_posts').show();
});

$(document).on("click", '#cancel_comment_btn', function(event) {
  event.preventDefault(); // デフォルトの送信動作をキャンセル
  $('#comment_form_for_posts').hide();
});



$(document).on("click", ".edit-comment-btn", function () {
  $('.reply-comment-form').hide();
  $('.edit-comment-form').hide();
  const commentId = $(this).data('comment-id');
  const commentShow = $('#show-comment-' + commentId);
  const commentEdit = $('#edit-comment-' + commentId);

  commentShow.hide();
  commentEdit.show();

});

$(document).on("click", '#cancel_comment_update_btn', function(event) {
  event.preventDefault(); // デフォルトの送信動作をキャンセル

  const commentId = $(this).data('comment-id');
  const commentShow = $('#show-comment-' + commentId);
  const commentEdit = $('#edit-comment-' + commentId);

  commentShow.show();
  commentEdit.hide();
});



$(document).on("click", '.reply_comment_btn', function() {
  const commentId = $(this).closest('.show_comment').attr('id').split('-')[1];
  const commentReply = $('#reply-comment-' + commentId);

  // 他の返信フォームを非表示にする
  $('.reply-comment-form').hide();
  
  // 対応する返信フォームを表示する
  commentReply.show();
});

$(document).on("click", '#cancel_comment_reply_btn', function(event) {
  event.preventDefault(); // デフォルトの送信動作をキャンセル

  // 対応する返信フォームを表示する
  $('.reply-comment-form').hide();
});

