// Generated by CoffeeScript 1.6.3
(function() {
  $(function() {
    var $answerFuture, $answerGoals, $seeAnswers;
    $seeAnswers = $('#seeAnswers');
    $seeAnswers.css({
      opacity: "0"
    });
    $(document).on('click', '#addAnswer', function(e) {
      var countryOfOrigin, val;
      e.preventDefault();
      countryOfOrigin = geoplugin_countryName();
      console.log(countryOfOrigin);
      val = $('#answerPrompt').serialize();
      $('#answerFuture').val('');
      $('#answerGoals').val('');
      $.get('/sendanswer', val, function(data) {
        $seeAnswers.css({
          opacity: "1"
        });
        $('#success').addClass("show");
        return setTimeout(function() { $("#success").removeClass("show"); }, 3000 );;
      });
      $('#answers').hide();
      return $('#answerRepo').append('<div class="container"><div class="jumbotron row"><h3>Thanks for your participation!</h3><p>Enjoy your dream browsing</p></div></div>');
    });
    $answerFuture = $('#answerFuture');
    $answerGoals = $('#answerGoals');
    $answerFuture.on('keyup', function(e) {
      var $countdownFuture, val;
      e.preventDefault();
      val = $answerFuture.val();
      console.log(val.length);
      $countdownFuture = $('#countdownFuture');
      return $countdownFuture.val(300 - val.length);
    });
    return $answerGoals.on('keyup', function(e) {
      var $countdownGoals, val;
      e.preventDefault();
      val = $answerGoals.val();
      console.log(val.length);
      $countdownGoals = $('#countdownGoals');
      return $countdownGoals.val(150 - val.length);
    });
  });

}).call(this);
