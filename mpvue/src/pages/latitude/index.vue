<template>
<map
  id="myMap"
  class="map"
  :longitude="longitude"
  :latitude="latitude"
  :scale="scale"
  :controls="controls"
  :markers="markers"
  :polyline="polyline"
  @markertap="markertap"
  @controltap="controltap"

  @regionchange="regionchange"
  @begin="regionchange"
  @end="regionchange"

  @tap="touchtap"
  show-location>

  <cover-view v-show="showMarker" class="detail">
    <cover-view @click="hideMarker">close</cover-view>
    {{markerDetail.title}}
  </cover-view>
</map>
</template>

<script src='./index.js'></script>
<style scoped>
.map {
  align-items:stretch;
  display:flex;
  width:100%;
  height: 100%;
}

.detail {
  background: #eee;
}
</style>
