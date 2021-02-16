document.addEventListener("turbolinks:load", function () {
  jQuery(function($) {
    $('.bg-slider').bgSwitcher({
      images: ['/images/castle.jpg',
               '/images/japan.jpg',
               '/images/mountain.jpg',
               '/images/pathway.jpg',
               '/images/temple.jpg'], // 切り替える背景画像を指定
    });
  });
});
