import { getMarkers, getPolyline } from '@/api/index';

export default {
  data: () => ({
    schedule: null,
    scale: 16,
    latitude: '31.22114',
    longitude: '121.54409',
    markers: [],
    polyline: [],
    showMarker: false,
    markerDetail: {},
    controls: [{
      id: 1,
      iconPath: '/static/2.svg',
      position: {
        left: 0,
        top: 300 - 50,
        width: 50,
        height: 50,
      },
      clickable: true,
    }],
  }),
  methods: {
    controltap(...args) {
      this.scale = (this.scale + 1) % 15;
      console.log('controltap', args, this.scale);
    },
    hideMarker() {
      this.showMarker = false;
    },
    markertap({ mp }) {
      console.log('markertap', mp);
      const markerId = mp.markerId;
      const [marker] = this.markers.filter(i => i.id === markerId);
      this.markerDetail = marker;
      this.showMarker = true;
    },
    touchtap() {
      wx.showToast({
        title: 'touch',
        icon: 'success', // loading
        duration: 1500,
        mask: true,
      });
    },
    regionchange(e) {
      // return;
      // wx.showToast({ title: `asdf${e.type}` });
      // if (this.schedule) return;

      // this.schedule = setTimeout(() => {
      //   this.schedule = null;
      //   const ctx = wx.createMapContext('myMap');
      //   ctx.getCenterLocation({
      //     success: ({ latitude, longitude }) => {
      //       this.markers.push({ latitude, longitude, id: Date.now() });
      //     },
      //   });
      // }, 3000);
    },
  },
  async created() {
    try {
      // const { latitude, longitude } = await wx.getLocationSync({ type: 'wgs84' });
      // this.latitude = latitude;
      // this.longitude = longitude;
      this.ctx = wx.createMapContext('myMap');
      this.markers = getMarkers();
      this.polyline = getPolyline();
    } catch (e) {
      console.log('error', e);
    }
  },
};
