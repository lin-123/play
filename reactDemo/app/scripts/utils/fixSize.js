(function(){
  // 根据窗口的宽度设置fontSize的单位值
  // 针对嵌套的窗口或手机上横屏状态 重置fontSize的单位值
  document.documentElement.style.fontSize = 10 * innerWidth / 320 + 'px';
  addEventListener('load', function() {
    setTimeout(function(){
        document.documentElement.style.fontSize = 10 * innerWidth / 320 + 'px';
    }, 480);
    // 判断窗口是否在一个框架中
    var isInApp = (window.self != window.top);
    if (!isInApp) {
        window.parent.postMessage({name: 'web:inject', token: Math.random().toString(), usertype: 1}, '*');
    }
  })
  addEventListener('orientationchange', function() {
      document.documentElement.style.fontSize = 10 * innerWidth / 320 + 'px'
  });
}).call(this)
