var x = document.getElementById("demo");
var location = document.getElementById("user-location");



const getLocation = () => {
  if (navigator.geolocation) {
    navigator.geolocation.watchPosition(showPosition);
  } else {
    x.innerHTML = "Geolocation is not supported by this browser.";
  }
}


function showPosition(position) {
  var query = `${position.coords.latitude}, ${position.coords.longitude}`;
  x.innerHTML="Latitude: " + position.coords.latitude +
    "<br>Longitude: " + position.coords.longitude;
  Rails.ajax({
      url: "/search-ajax",
      type: "get",
      data: `location[latitude]=${position.coords.latitude}&location[longitude]=${position.coords.longitude}`,
    })
  }

const triggerLocation = () => {
  location.addEventListener("click", () => {
    getLocation()
  })
}

export { triggerLocation }
