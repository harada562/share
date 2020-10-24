/**
 * 到達したら要素を表示させる
 */
function showElementAnimation() {

  const element = document.getElementsByClassName('js-animation');
  if(!element) return; // 要素がなかったら処理をキャンセル
  
  const showTiming = window.innerHeight > 268 ? 200 : 40; // 要素が出てくるタイミングはここで調整
  const scrollY = window.pageYOffset;
  let windowH = window.innerHeight;

  for(let i=0;i<element.length;i++) { let elemClientRect = element[i].getBoundingClientRect(); let elemY = scrollY + elemClientRect.top; if(scrollY + windowH - showTiming > elemY) {
      element[i].classList.add('is-show');
    } else if(scrollY + windowH < elemY) {
      // 上にスクロールして再度非表示にする場合はこちらを記述
      element[i].classList.remove('is-show');
    }
  }
}
showElementAnimation();
window.addEventListener('scroll', showElementAnimation);

