var test;

(function () {
  var isDisqusInitialLoading;

  test = {
    init: function () {

      // 자유게시판 tab click
      $("#freeComments-tab").on("click", function () {
        // Disqus
        disqus_config = function () {
          this.page.url = "https://quizeey.com/community"; // Replace PAGE_URL with your page's canonical URL variable
          this.page.identifier = "forum"; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
        };

        (function () {
          // DON'T EDIT BELOW THIS LINE
          var d = document,
            s = d.createElement("script");
          s.src = "https://questionbank-2.disqus.com/embed.js";
          s.setAttribute("data-timestamp", +new Date());
          (d.head || d.body).appendChild(s);
        })();
      });

      // Disqus tab click
      $("#disqus-tab").on("click", function () {
        if (isDisqusInitialLoading) {
          isDisqusInitialLoading = false;

          // Disqus
          disqus_config = function () {
            this.page.url = "https://quizeey.com/community"; // Replace PAGE_URL with your page's canonical URL variable
            this.page.identifier = "request"; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
          };

          (function () {
            // DON'T EDIT BELOW THIS LINE
            var d = document,
              s = d.createElement("script");
            s.src = "https://questionbank-2.disqus.com/embed.js";
            s.setAttribute("data-timestamp", +new Date());
            (d.head || d.body).appendChild(s);
          })();
        }
      });
    }
  };
})();

test.init();
