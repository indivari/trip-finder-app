function postRating(locationId, rating) {
  fetch("/ratings", {
    method: "POST", // *GET, POST, PUT, DELETE, etc.
    cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
    headers: {
      "Content-Type": "application/json",
      // 'Content-Type': 'application/x-www-form-urlencoded',
    },
    redirect: "follow", // manual, *follow, error
    referrerPolicy: "no-referrer", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
    body: JSON.stringify({ locationId, rating }),
  });
  alert("You rated this location : " + rating);
}

function showRatings(container, locationId, currentRating) {
  for (var i = 1; i <= 5; i++) {
    var star = document.createElement("div");
    star.innerText = i;
    const className = i <= currentRating ? "highlighted" : "blank";
    star.className = className;
    star.dataset.rating = i;
    star.addEventListener("click", (evt) =>
      postRating(locationId, evt.target.dataset.rating)
    );
    container.appendChild(star);
  }
}
