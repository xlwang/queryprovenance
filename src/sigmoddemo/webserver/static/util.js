var app = (function() {

	var exp_id = 0;
	var workload = null;
	var workloadname = null;
	var modifiedQueryId = null;
	var querylogsize = null;
	var workloaddata = null;

	var renderComplaints = function(complaints) {
		console.log(complaints);

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
	
	var selectTuple = function(option, t) {
		var table = document.getElementById("table-workload");
		var addorremove = 0;
		var mode = ""
		if (option == "1") {
			// select all
			mode = "selectall";
			for (var i = 0, row; row = table.rows[i]; i++) {
				if (t.is(':checked')) {
					addorremove = 1;
					row.classList.add("highlightcompl");
				} else {
					row.classList.remove("highlightcompl");
				}	
			}
		} else if (option == "2") {
			// select all complaints
			mode = "selectallcompl"
			for (var i = 0, row; row = table.rows[i]; i++) {
				if (!row.classList.contains("complaint")) {
					continue;
				}
				if (t.is(':checked')) {
					addorremove = 1;
					row.classList.add("highlightcompl");
				} else {
					row.classList.remove("highlightcompl");
				}
		
			}
		}
		var data = {
			exp_id: exp_id,
			row_keys: mode,
			addorremove: addorremove
		}
		$.get("/updatecomplaint/", data, function(resp){});
	}

	var loadWorkload = function(workload) {
		exp_id = exp_id + 1;
		workloadname = workload;
		renderQueryLog({})
		$("#datatable-container").empty();
		var data = {
			workload: workload,
			querylogsize: querylogsize,
			exp_id: exp_id
		};
		$.get("/workload/", data, function(resp) {
			renderWorkload(resp);
		});

	};

	var renderWorkload = function(workloadData) {
		workloaddata = workloadData;
		var selectallcheckbox = document.getElementById("selectall");
		var selectallcomplcheckbox = document.getElementById("selectallcompl");
		selectallcheckbox.style.visibility = "visible";
		selectallcomplcheckbox.style.visibility = "visible";
		var selectalltext = document.getElementById("selectalltext");
		var selectallcompltext = document.getElementById("selectallcompltext");
		selectalltext.style.visibility = "visible";
		selectallcompltext.style.visibility = "visible";
		
		renderQueryLog(workloadData);
		renderWorkloadData();
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
					// corrupt current query
					var data = {
						workload: workloadname,
						query: q.id,
						exp_id: exp_id,
						qlogsize: workloaddata.queries.length,
						mode: 'clean'
					};
					$.get("/corrupt/", data, function(resp) {
						workloaddata.table = resp.table;
						q.query.dirtyquery = '';
						renderCorruptQuery(q);
					});
				} else {
					$("#q-" + q.id + ' pre').addClass('highlight');
					// corrupt current query
					var data = {
						workload: workloadname,
						query: q.id,
						exp_id: exp_id,
						qlogsize: workloaddata.queries.length,
						mode: 'corrupt'
					};
					$.get("/corrupt/", data, function(resp) {
						workloaddata.table = resp.table;
						q.query.dirtyquery = resp.dirtyquery;
						renderCorruptQuery(q);
					});
				}
			});
		});

	};
	
	var renderCorruptQuery = function(query) {
		var q = query;
		if (q.query.dirtyquery != "") {
			q.query.corrupted = true;
			var tmp = $("#q-" + q.id + "-dirty td")
			$("#q-" + q.id + "-clean").addClass('corrupted');
			$("#q-" + q.id + "-dirty td").html('' + q.query.dirtyquery);
			$("#q-" + q.id + "-dirty").addClass('dirty');
		} else {
			q.query.corrupted = false;
			$("#q-" + q.id + "-dirty td").html('' + q.query.dirtyquery);
			$("#q-" + q.id + "-clean").removeClass('corrupted');
			$("#q-" + q.id + "-dirty").removeClass('dirty');
		}
		renderWorkloadData();
	}
	
	var renderWorkloadData = function() {
		$("#datatable-container").empty();
		var source = $("#table-template").html();
		var template = Handlebars.compile(source);
		$("#datatable-container").html(template(workloaddata.table));
		$(".table_data td").on("click", function() {
		    var tr = $(this).parent();
			var addorremove = 0;
		    if(tr.hasClass("highlightcompl")) {
		        tr.removeClass("highlightcompl");
		    } else {
				addorremove = 1;
		        tr.addClass("highlightcompl");
		    }

			var data = {
				exp_id: exp_id,
				row_keys: tr[0].id,
				addorremove: addorremove
			}
			$.get("/updatecomplaint/", data, function(resp){});
		});
	}

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

	var renderRepairs = function(opts) {
		var source = $("#table-template").html();
		var template = Handlebars.compile(source);
		$("#qfix-data-container").html(template(opts.table1));
		$("#alt-data-container").html(template(opts.table2));

		$("#err_q").text(opts.query);
		$("#qfix_q").text(opts.qfix_query);
		$("#alt_q").text(opts.alt_query);
	};
	
	return {
		loadQuerylogSize: loadQuerylogSize,
		loadAndRenderWorkloads: loadAndRenderWorkloads,
		renderQueryLog: renderQueryLog,
		submitPressed: submitPressed,
		loadWorkload: loadWorkload,
		renderWorkload: renderWorkload,
		renderRepairs: renderRepairs,
		renderComplaints: renderComplaints,
		selectTuple: selectTuple
	};

})()
