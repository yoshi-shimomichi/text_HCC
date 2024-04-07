
$(function(){
    $(".profile_show_nav ul").on("click", "li", function(){
      $(".profile_show_nav ul li.selected").removeClass("selected");
      $(this).addClass("selected");
    });
  });



  $(function () {
    $('#nav_questions').on('click', function () {
        $('#profile_questions').show();
        $('#profile_tweets').hide();
        $('#profile_comments').hide();
        $('#profile_favorite_posts').hide();
        $('#profile_favorite_comments').hide();
    });
    $('#nav_tweets').on('click', function () {
        $('#profile_questions').hide();
        $('#profile_tweets').show();
        $('#profile_comments').hide();
        $('#profile_favorite_posts').hide();
        $('#profile_favorite_comments').hide();
    });
    $('#nav_comments').on('click', function () {
        $('#profile_questions').hide();
        $('#profile_tweets').hide();
        $('#profile_comments').show();
        $('#profile_favorite_posts').hide();
        $('#profile_favorite_comments').hide();
    });
    $('#nav_favorite_posts').on('click', function () {
        $('#profile_questions').hide();
        $('#profile_tweets').hide();
        $('#profile_comments').hide();
        $('#profile_favorite_posts').show();
        $('#profile_favorite_comments').hide();
    });
    $('#nav_favorite_comments').on('click', function () {
        $('#profile_questions').hide();
        $('#profile_tweets').hide();
        $('#profile_comments').hide();
        $('#profile_favorite_posts').hide();
        $('#profile_favorite_comments').show();
    });
});