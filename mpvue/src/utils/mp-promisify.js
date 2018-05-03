const NOT_PROMISIFY_METHODS_RE = /^(on|create)|Sync$/g;
const notPromisifyMethods = {
  stopRecord: true,
  getRecorderManager: true,
  pauseVoice: true,
  stopVoice: true,
  pauseBackgroundAudio: true,
  stopBackgroundAudio: true,
  getBackgroundAudioManager: true,
  createMapContext: true,
  canIUse: true,
  hideToast: true,
  hideLoading: true,
  showNavigationBarLoading: true,
  hideNavigationBarLoading: true,
  pageScrollTo: true,
  drawCanvas: true,
  stopPullDownRefresh: true,
};

Object.keys(wx).forEach((method) => {
  if (!(notPromisifyMethods[method] || NOT_PROMISIFY_METHODS_RE.test(method)) && !wx[`${method}Sync`]) {
    wx[`${method}Sync`] = (...args) => new Promise((resolve, reject) => {
      wx[method]({
        success(res) {
          resolve(res);
        },
        fail(e) {
          reject(e);
        },
        ...args,
      });
    });
  }
});
