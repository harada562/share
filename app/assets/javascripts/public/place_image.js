var mySwiper = new Swiper('.swiper-container', {
      // アニメーション
      effect: 'cube',
      // ループ
      loop: true,
      // スライドスピード
      speed: 200,
      navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev'
      },
      pagination: {
            el: '.swiper-pagination',
            type: 'bullets',
            clickable: true
      },
      // 自動スライド
      autoplay: {
            delay: 2000,
            stopOnLastSlide: false,
            disableOnInteraction: false,
            reverseDirection: false
      },
});