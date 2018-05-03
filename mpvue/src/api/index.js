export const getMarkers = () => {
  // todo
  console.log('');

  return [{
    id: 0,
    latitude: 31.21113,
    longitude: 121.54409,
    title: 'id: 0,',
    width: 50,
    height: 50,
    label: {
      bgColor: 'white',
      borderRadius: 4,
      content: 'title: id: 0,,',
      color: 'black',
      display: 'BYCLICK',
    },

  }, {
    id: 1,
    latitude: 31.215212,
    longitude: 121.528664,
    title: 'id: 1,',
    width: 50,
    height: 50,
    label: {
      bgColor: 'white',
      borderRadius: 4,
      content: 'title: id: 1,,',
      color: 'black',
      display: 'BYCLICK',
    },
  }, {
    id: 2,
    latitude: 31.213577,
    longitude: 121.53849,
    title: 'id: 2,',
  }, {
    id: 3,
    latitude: 31.214577,
    longitude: 121.54409,
    title: 'id: 3,',
  }];
};

export const getPolyline = () => {
  // todo
  console.log('');

  return [{
    points: [{
      longitude: 113.3245211,
      latitude: 23.10229,
    }, {
      longitude: 113.324520,
      latitude: 23.21229,
    }],
    color: '#FF0000DD',
    width: 2,
    dottedLine: true,
  }];
};
