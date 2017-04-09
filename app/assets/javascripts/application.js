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
//= require bootstrap/dropdown
//= require bootstrap/alert
//= require_tree .


// 下拉时显示「顶部导航栏」和「侧边栏」
var $header = $('.header')
var $sidebar = $('#sidebar')
var $category_sidebar = $('.category_sidebar')
var $lp_navbar = $('.lp-navbar')

$(window).scroll(function () {
  if ($(this).scrollTop() > 500) {
    $sidebar.fadeIn()
    $category_sidebar.fadeIn() // 慢慢地显示侧边栏
  } else {
    $sidebar.fadeOut()
    $category_sidebar.fadeOut() // 慢慢地隐藏侧边栏
  }

  if ($(this).scrollTop() > 120) {
    if ($header.is(':animated')) {
      return false
    }
    $('.header_placeholder').show() // 显示「用来占位」的header
    $header.addClass('header_fixed') // 让导航栏固定在顶部
    $header.stop().animate({top: 0}, 600) // 在600ms内，慢慢地出来
  } else {
    $('.header_placeholder').hide()
    $header.removeClass('header_fixed')
    $header.css({top: -80})
  }
})
