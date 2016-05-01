(function(){
  window.MapsApp = window.MapsApp || {};

  var ELEMENT = {
    getPlacesInputs: '#js-get-places',
    form: 'form.search-place',
    mapContainer: '#map',
    loadingContainer: '.message-container.loading',
  }

  var MapsApp = function(){
    this.map;
    this.mapContainer = $(ELEMENT.mapContainer);
    this.getPlacesInputs = $(ELEMENT.getPlacesInputs);
    this.form = $(ELEMENT.form);
    this.currentPosition;
    this.currentInput;
  }

  MapsApp.prototype.init = function () {
    var mapsApp = this;

    if ("geolocation" in navigator){
      navigator.geolocation.getCurrentPosition(onLocation, onError);
    }
    function onLocation(position){
      mapsApp.currentPosition = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      }
      mapsApp.createMap();
      mapsApp.setAutocomplete();
      mapsApp.addListeners();
      mapsApp.loadMarkers();
      $(ELEMENT.loadingContainer).fadeOut();
      mapsApp.mapContainer.fadeIn();
    }

    function onError(err){
      console.log("What are you using, IE 7??", err);
    }
  }

  MapsApp.prototype.addListeners = function () {
    var mapsApp = this;
    this.form.on('submit', function (e) {
      e.preventDefault();
      var place = mapsApp.currentInput;
      if (place.geometry.location) {
        mapsApp.map.setCenter(place.geometry.location);
        mapsApp.saveMarker(place.geometry.location);
        mapsApp.map.setZoom(5);
      }
      else {
        alert("The place has no location...?")
      }
    })
  }

  MapsApp.prototype.loadMarkers = function() {
    var mapsApp = this;
    var markers = JSON.parse(localStorage.getItem('markers')) || [];
    markers.forEach(function(marker){
      mapsApp.addMarker(marker);
    });
  }

  MapsApp.prototype.createMap = function () {
    this.map = new google.maps.Map($('#map')[0], {
      center: this.currentPosition,
      zoom: 5
    });
  }

  MapsApp.prototype.setAutocomplete = function () {
    var mapsApp = this;
    var input = mapsApp.getPlacesInputs[0];
    var autocomplete = new google.maps.places.Autocomplete(input);
    autocomplete.addListener('place_changed', function(){
      mapsApp.currentInput = autocomplete.getPlace();
    });
  }

  MapsApp.prototype.saveMarker = function (position) {
    this.addMarker(position);
    debugger;
    var markers = JSON.parse(localStorage.getItem('markers')) || [];
    markers.push(position);
    localStorage.setItem('markers', JSON.stringify(markers));
  }

  MapsApp.prototype.addMarker = function (position) {
    var marker = new google.maps.Marker({
        position: position,
        map: this.map
    });
    return marker;
  }

  window.MapsApp = MapsApp;
})();
