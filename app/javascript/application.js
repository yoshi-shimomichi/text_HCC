// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

//= require jquery3
//= require popper
//= require bootstrap

import "@hotwired/turbo-rails"
import "controllers"
import "./custom/preview"
import "./custom/autocomplete/@hotwired--stimulus"
import "./custom/autocomplete/jquery"
import "./custom/autocomplete/stimulus-autocomplete"

$(function(){
    $('.alart').fadeOut(1000);  //４秒かけて消えていく
  });

  $(window).on('scroll', function() {
    scrollHeight = $(document).height();
    scrollPosition = $(window).height() + $(window).scrollTop();
    if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
            $('.jscroll').jscroll({
              contentSelector: '.skill-list',
              nextSelector: 'span.next:last a'
            });
    }
  });