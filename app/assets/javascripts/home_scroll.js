//スクロール量を取得する関数
function getScrolled() {
 return ( window.pageYOffset !== undefined ) ? window.pageYOffset: document.documentElement.scrollTop;
}

//トップに戻るボタンの要素を取得
var topButton = document.getElementById( 'page-top' );

//ボタンの表示・非表示
window.onscroll = function() {
  ( getScrolled() > 500 ) ? topButton.classList.add( 'fade-in' ): topButton.classList.remove( 'fade-in' );
};

//トップに移動する関数
function scrollToTop() {
  var scrolled = getScrolled();
  window.scrollTo( 0, Math.floor( scrolled / 2 ) );
  if ( scrolled > 0 ) {
    window.setTimeout( scrollToTop, 30 );
  }
};

//イベント登録
topButton.onclick = function() {
  scrollToTop();
};