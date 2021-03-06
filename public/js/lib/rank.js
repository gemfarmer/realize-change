// Generated by CoffeeScript 1.6.3
(function() {
  var addAnswersToRank, dataTemplate, source;

  source = $("#rank-template").html();

  dataTemplate = Handlebars.compile(source);

  addAnswersToRank = function(data) {
    return $.get('/getanswers', data, function(answers) {
      console.log("answeranswer:", answers);
      console.log("data.future", data.future, "data.goals", data.goals);
      return $('#choicesRepo').html(dataTemplate(answers));
    });
  };

  $(function() {
    addAnswersToRank({
      randomize: true,
      future: false,
      goals: true
    });
    $('#moreToRank').on('click', function(e) {
      e.preventDefault();
      return addAnswersToRank({
        randomize: true,
        future: false,
        goals: true
      });
    });
    return $(document).on('click', ".vote", function(e) {
      var chosenId, otherId;
      e.preventDefault();
      chosenId = $(this).data('id');
      otherId = $(this).data('idt');
      return $.get("/upvote", {
        chosenId: chosenId,
        otherId: otherId
      }, function(err, fromServer) {
        console.log(fromServer);
        return addAnswersToRank({
          randomize: true,
          future: false,
          goals: true
        });
      });
    });
  });

}).call(this);
