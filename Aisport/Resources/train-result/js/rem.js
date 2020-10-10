
!(function(win, doc){
  function setFontSize() {
    // 获取window 宽度
    let winWidth =  window.innerWidth;
    // doc.documentElement.style.fontSize = (winWidth / 750) * 100 + 'px' ;
    
    // 750宽度以上进行限制 需要css进行配合
    let size = (winWidth / 750) * 100;
    doc.documentElement.style.fontSize = (size < 100 ? size : 90) + 'px' ;
    // doc.documentElement.style.fontSize = size + 'px' ;
  }

  let evt = 'onorientationchange' in win ? 'orientationchange' : 'resize';

  let timer = null;

  win.addEventListener(evt, function () {
    clearTimeout(timer);

    timer = setTimeout(setFontSize, 300);
    console.log(111)
  }, false);

  win.addEventListener("pageshow", function(e) {
    if (e.persisted) {
      clearTimeout(timer);

      timer = setTimeout(setFontSize, 300);
    }
  }, false);
  // 初始化
  setFontSize();

}(window, document));
