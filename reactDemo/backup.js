// setInterval 闭包
this.timer = setInterval(function () {
  var opacity = this.state.opacity;
  opacity -= .05;
  if (opacity < 0.1) {
    opacity = 1.0;
  }
  this.setState({
    opacity: opacity
  });
}.bind(this), 100);
