$(document).ready(function () {
  // Fetch each repo directly so org-owned and >100-repo users still resolve.
  $(".ghbtn").each(function () {
    var $btn = $(this);
    var user = $btn.attr("user");
    var repo = $btn.attr("repo");
    if (!user || !repo) {
      return;
    }

    $.ajax({
      type: "GET",
      url: "https://api.github.com/repos/" + encodeURIComponent(user) + "/" + encodeURIComponent(repo),
      tryCount: 0,
      retryLimit: 3,
      async: true,
      dataType: "json",
      success: function (data) {
        var stars = typeof data.stargazers_count === "number" ? data.stargazers_count : "–";
        var forks = typeof data.forks_count === "number" ? data.forks_count : "–";
        $btn.children(".star").html('<i class="fa fa-star"></i> ' + stars);
        $btn.children(".fork").html('<i class="fa fa-code-fork"></i> ' + forks);
      },
      error: function (xhr, textStatus) {
        this.tryCount = (this.tryCount || 0) + 1;
        if (textStatus === "timeout" || (xhr.status >= 500 && this.tryCount <= this.retryLimit)) {
          $.ajax(this);
          return;
        }
        $btn.children(".star").html('<i class="fa fa-star"></i> –');
        $btn.children(".fork").html('<i class="fa fa-code-fork"></i> –');
      }
    });
  });
});
