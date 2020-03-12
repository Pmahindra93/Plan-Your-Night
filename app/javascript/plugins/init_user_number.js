function initUserNumber() {
  // Find the flash on the page
        console.log("heeree");
  const flash = document.getElementById("users-number-flash")
  // If it's there
  if (flash) {
    // Set a timer for every x seconds
    // setInterval it kind of timer every 1000 = 1 sec
    window.setInterval(function() {
      if (flash) {
        // Check the number of users
        const venueId = flash.dataset.venueId;
        fetch(`/venues/${venueId}/user_number`)
          .then(response => response.json())
          .then(json => json.number + 10)
          .then(number => {
            // If it's > 10, show the flash, otherwise hide the flash
            if (number > 11) {
              flash.classList.remove('d-none');
            } else {
              flash.classList.add('d-none');
            }
            // Update the number shown on the page
            const numberSpan = document.getElementById("number-to-update");
            if (numberSpan) {
              numberSpan.innerHTML = number;
            }
          });
      }
    }, 5000);
  }
}

export { initUserNumber };
