var mapOptions = {
  zoom: 13,
  center: new google.maps.LatLng(40.7127, 74.0059)
}

var map = new google.maps.Map(document.getElementById("map"), mapOptions);

var transitLayer = new google.maps.TransitLayer();
transitLayer.setMap(map);