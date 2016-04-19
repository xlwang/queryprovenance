
var app = (function() {

  var workload = null;
  var modifiedQueryId = null;

  var renderComplaints = function(complaints) {
    console.log(complaints);

  };


  var renderRepairs = function(opts) {
    var source   = $("#table-template").html();
    var template = Handlebars.compile(source);
    $("#qfix-data-container").html(template(opts.table1));
    $("#alt-data-container").html(template(opts.table2));

    $("#err_q").text(opts.query);
    $("#qfix_q").text(opts.qfix_query);
    $("#alt_q").text(opts.alt_query);
  };


  var loadAndRenderWorkloads = function(opts) {
    $.get("/workloads/", {}, function(resp) {
      var source   = $("#workloads-template").html();
      var template = Handlebars.compile(source);
      console.log(resp)
      $("#workloads-container").html(template(resp));
    });
  };



  var loadWorkload = function(workload) {
    renderQueryLog({})
    $("#datatable-container").empty();

    var data =  { workload: workload };
    $.get("/workload/", data, function(resp) {
      renderWorkload(resp);
    });
    
  };

  var renderWorkload = function(workloadData) {
    var source   = $("#table-template").html();
    var template = Handlebars.compile(source);
    $("#datatable-container").html(template(workloadData.table));

    renderQueryLog(workloadData);
  }


  var renderQueryLog = function(opts) {
    var queries = opts.queries;

    var source   = $("#querylog-template").html();
    var template = Handlebars.compile(source);
    $("#querylog-container").html(template(opts));

    _.each(queries, function(q, i) {
      $("#q-"+q.id).click(function() {
        $("#querytext").text(q.query);
        modifiedQueryId = q.id;

      });
    });


  };

  var computeComplaints = function() {
    if (modifiedQueryId !== null) {
      data = {
        workload: workload,
        qid: modifiedQueryId,
        query: $("#querytext").text()
      };
      $.get("/complaints/", data, function(resp) {
        renderComplaints(resp.data);
      });
    }
  };


  var submitPressed = function() {
    $.get("/solve/", { qid: modifiedQueryId }, function(resp) {
      $("#result-view").show();
      renderRepairs(resp);
    });
  };

  return {
    loadAndRenderWorkloads: loadAndRenderWorkloads,
    renderQueryLog: renderQueryLog,
    submitPressed: submitPressed,
    loadWorkload: loadWorkload,
    renderWorkload: renderWorkload,
    renderRepairs: renderRepairs,
    renderComplaints: renderComplaints
  };

})()
