var app = (function() {

	var workload = null;
	var modifiedQueryId = null;
	var querylogsize = null;
	var workloaddata = null;

	var renderComplaints = function(complaints) {
		console.log(complaints);

	};


	var renderRepairs = function(opts) {
		var source = $("#table-template").html();
		var template = Handlebars.compile(source);
		$("#qfix-data-container").html(template(opts.table1));
		$("#alt-data-container").html(template(opts.table2));

		$("#err_q").text(opts.query);
		$("#qfix_q").text(opts.qfix_query);
		$("#alt_q").text(opts.alt_query);
	};


	var loadAndRenderWorkloads = function(opts) {
		$.get("/workloads/", {}, function(resp) {
			var source = $("#workloads-template").html();
			var template = Handlebars.compile(source);
			console.log(resp)
			$("#workloads-container").html(template(resp));
		});
	};

	var loadQuerylogSize = function(qlogsize) {
		querylogsize = qlogsize;
	}

	var loadWorkload = function(workload) {
		renderQueryLog({})
		$("#datatable-container").empty();
		var data = {
			workload: workload,
			querylogsize: querylogsize
		};
		$.get("/workload/", data, function(resp) {
			renderWorkload(resp);
		});

	};

	var renderWorkload = function(workloadData) {
		workloaddata = workloadData;
		var source = $("#table-template").html();
		var template = Handlebars.compile(source);
		$("#datatable-container").html(template(workloadData.table));

		renderQueryLog(workloadData);
	}


	var renderQueryLog = function(opts) {
		var queries = opts.queries;

		var source = $("#querylog-template").html();
		var template = Handlebars.compile(source);
		$("#querylog-container").html(template(opts));

		_.each(queries, function(q, i) {
			$("#q-" + q.id).click(function() {
				// $("#querytext").text(q.query);
				if ($("#q-" + q.id + ' pre').hasClass('highlight')) {
					$("#q-" + q.id + ' pre').removeClass('highlight');
					modifiedQueryId = -1;
					q.query.dirtyquery = '';
					q.query.corrupted = false;
					$("#q-" + q.id + "-dirty td").html('' + q.query.dirtyquery);
					$("#q-" + q.id + "-clean").removeClass('corrupted');
					$("#q-" + q.id + "-dirty").removeClass('dirty');
					workloaddata.table.rows[5].iscomplaint = false;
				} else {
					$("#q-" + q.id + ' pre').addClass('highlight');
					modifiedQueryId = q.id;
					q.query.dirtyquery = q.query.cached;
					q.query.corrupted = true;
					var tmp = $("#q-" + q.id + "-dirty td")
					$("#q-" + q.id + "-clean").addClass('corrupted');
					$("#q-" + q.id + "-dirty td").html('' + q.query.dirtyquery);
					$("#q-" + q.id + "-dirty").addClass('dirty');
					workloaddata.table.rows[5].iscomplaint = true;
				
				}
				$("#datatable-container").empty();
				var source = $("#table-template").html();
				var template = Handlebars.compile(source);
				$("#datatable-container").html(template(workloaddata.table));
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
		$.get("/solve/", {
			qid: modifiedQueryId
		}, function(resp) {
			$("#result-view").show();
			renderRepairs(resp);
		});
	};

	return {
		loadQuerylogSize: loadQuerylogSize,
		loadAndRenderWorkloads: loadAndRenderWorkloads,
		renderQueryLog: renderQueryLog,
		submitPressed: submitPressed,
		loadWorkload: loadWorkload,
		renderWorkload: renderWorkload,
		renderRepairs: renderRepairs,
		renderComplaints: renderComplaints
	};

})()
