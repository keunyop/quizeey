$(function() {
  var language = $("meta[http-equiv='content-language']").attr("content");

  if (language == "en") {
    $("#nav-placeholder").load("/html/en/nav.html");
    $("#footer-placeholder").load("/html/en/footer.html");
  } else {
    $("#nav-placeholder").load("/html/nav.html");
    $("#footer-placeholder").load("/html/footer.html");
  }
});

/**
 * Image Lazy Loading
 */
document.addEventListener("DOMContentLoaded", function() {
  var lazyImages = [].slice.call(document.querySelectorAll("img.lazy"));

  if ("IntersectionObserver" in window) {
    let lazyImageObserver = new IntersectionObserver(function(
      entries,
      observer
    ) {
      entries.forEach(function(entry) {
        if (entry.isIntersecting) {
          let lazyImage = entry.target;
          lazyImage.src = lazyImage.dataset.src;
          lazyImage.classList.remove("lazy");
          lazyImageObserver.unobserve(lazyImage);
        }
      });
    });

    lazyImages.forEach(function(lazyImage) {
      lazyImageObserver.observe(lazyImage);
    });
  } else {
    // Possibly fall back to a more compatible method here
  }
});
