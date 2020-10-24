
// 二個目のswiperの初期化
var mySwiper2 = new Swiper('.gallery-thumbs', {
      // slide位置を固定させない
      freeMode: true,
      watchSlidesVisibility: true,
      watchSlidesProgress: true,

      // slideの間隔
      spaceBetween: 10,
      // 一度にスライドできる枚数
      slidesPerView: 3
});


// 一個目のswiperの初期化
var mySwiper1 = new Swiper('.gallery-top', {
      // slideの間隔
      spaceBetween: 10,
      navigation: {
            // 次のページの写真を指定
            nextEl: '.swiper-button-next',
            // 前ページボタンの写真を指定
            prevEl: '.swiper-button-prev'
      },
      thumbs: {
        swiper: mySwiper2
      }
});
