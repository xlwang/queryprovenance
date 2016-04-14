

var addQueryToLog = function(queries) {
}

var renderQueryLog = function(opts) {
  var queries = opts.queries;

  var source   = $("#querylog-template").html();
  var template = Handlebars.compile(source);
  $("#querylog-container").html(template(opts));

  _.each(queries, function(q, i) {
    $("#q-"+q.id).click(function() {
      $("#querytext").text(q.query);

    });
  });


};


