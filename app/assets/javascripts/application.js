// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.elevatezoom
//= require jquery.fancybox
//= require_tree .


$(document).on("turbolinks:load", function() {

  // выпадалки подкатегорий в главном меню
  $("#mainmenu .show-pop").hover(function() {
    $(this).find(".pop").toggle();
  });

  // выпадалки для брендов по первым буквам в главном меню
  $("#brandmenu > ul > li").hover(function() {
    $(this).find(".sub").toggle();
  });

  // зумилка фоток на странице карточки товара
  $(".images > .big > [data-zoom-image]").elevateZoom({
    gallery: "product-gallery",
    scrollZoom: true, 
    cursor: "pointer"
  });

  // форма поиска в шапке
  $("#search-main").on("submit", function(e) {
    e.preventDefault();
    window.location.href = $(this).attr("action") + $(this).find("input[name=query]").val();
  });

  // дефолтовые значения для fancybox
  $.fancybox.defaults.lang = 'ru';
  $.fancybox.defaults.i18n = {
    'ru' : {
      CLOSE : 'Закрыть',
      NEXT        : 'Вперед',
      PREV        : 'Назад',
      ERROR       : 'The requested content cannot be loaded. <br/> Please try again later.',
      PLAY_START  : 'Запустить слайдшоу',
      PLAY_STOP   : 'Остановить слайдшоу',
      FULL_SCREEN : 'На весь экран',
      THUMBS      : 'Миниатюры'
    }
  };

});
