$(document).on("click", '#new_comment_btn', function() {
    $('#comment_form_for_posts').show();
});

$(document).on("click", '#cancel_comment_btn', function() {
  $('#comment_form_for_posts').hide();
});

/*
<button id="new_comment_btn", class="btn btn_text">コメント</button>

<div id="comment_form_for_posts", style= "display: none;">
<%= render 'comments/form',post: @post, comment: @comment %>
</div>

<div id="comment_form">
  <%= form_with model: [post, comment] do |f| %>
    <%= render 'shared/error_messages', object: f.object %>
    <div class="mb-3">
      <%= f.text_area :body, class: 'form-control mb-3', rows: "3"%>
      <div class="post_form_image mb-3">
        <label class="form_image_button">
          <i class="fas fa-images"></i>
          <p>画像を追加する</p>
          <%= f.file_field :comment_image, class: "hidden", id: 'select_image', accept: 'image/*' %>
          <%= f.hidden_field :comment_image_cache %>
        </label>
        <span id="image_prev"></span>
        <%= image_tag comment.comment_image.url, id: 'edit_post_image' if comment.comment_image.present? %>
      </div>
      <div class="btn_submit">
        <%= f.submit t('helpers.submit.comment'), class: 'btn btn_text' %>
      </div>
    </div>
  <% end %>
</div>
*/