// Generated by CoffeeScript 1.6.3
(function() {
  $(function() {
    var $answerFuture, $answerGoals, $answerPrompt, $answerRepo, $answers, $seeAnswers;
    $('#goalsAlert').hide();
    $('#futureAlert').hide();
    $seeAnswers = $('#seeAnswers');
    $seeAnswers.css({
      opacity: "0"
    });
    $answers = $('#answers');
    $answerRepo = $('#answerRepo');
    $answerPrompt = $("#answerPrompt");
    $(document).on('click', '#addAnswer', function(e) {
      var val;
      e.preventDefault();
      val = $('#answerPrompt').serialize();
      if ($('#answerFuture').val() && $('#answerGoals').val()) {
        $answers.hide();
        $answerRepo.append('<div class="container"><div class="jumbotron row"><h3>Thanks for your participation!</h3><a href="/auth/google">Login</a><span> to check out other people\'s </span><a href="/seeanswers">dreams</a></div></div>');
        $.get('/sendanswer', val, function(data) {});
        return console.log(data);
      } else if ($('#answerFuture').val()) {
        return $('#goalsAlert').show();
      } else if ($('#answerGoals').val()) {
        return $('#futureAlert').show();
      } else {
        $('#futureAlert').show();
        return $('#goalsAlert').show();
      }
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
