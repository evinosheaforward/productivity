var loadData = function(){
                $.ajax({
                  type: 'GET',
                  contentType: 'application/json; charset=utf-8',
                  url: "/accomplishments",
                  dataType: 'json',
                  success: function(data){
										console.log("Making the plot!");
                    drawScatterPlot(data);
                  },
                  failure: function(result){
                    error();
                  }
                });
              };

function error() {
  console.log("Ajax GET request failed for accomplishments!");
}

// Handle datetime parsing for ruby dates
function parseTime(s) {
	var p = d3.timeParse("%Y-%m-%dT%H:%M");
	return p(s.substring(0, 16));
}

function drawScatterPlot(data){
	var radius = 7.5;
	// set the dimensions and margins of the graph
	var margin = {top: 20, right: 20, bottom: 50, left: 50};
	var width = 768 - margin.left - margin.right;
  var height = 400 - margin.top - margin.bottom;

	var prodMax = 5 + d3.max(data, function(d) {
		return (d.timeProductive/d.timeWorking)*100;
	});
	var workMax = d3.max(data, function(d) {
		return +d.timeWorking;
	});

	// Productivity vs time working on task
	var svg = d3.select("#prodWorking")
		.attr("width", width + margin.left + margin.right)
		.attr("height", height + margin.top + margin.bottom);

	var xScale = d3.scaleLinear()
		.domain([0, workMax])
		.range([0, width]);
	var yScale = d3.scaleLinear()
		.domain([prodMax, 0])
		.range([0, height]);

	var xAxis = d3.axisBottom().scale(xScale);
	var yAxis = d3.axisLeft().scale(yScale);

	svg.append("g")
		.call(xAxis)
		.attr("transform", "translate(60, 330)")
		.attr("font-size", "1.2em");

  svg.append("text")
		.attr("transform", "translate(240, 380)")
		.attr("fill", "#000")
		.text("Time Working (Minutes)")
		.attr("font-size", "1.2em");

	svg.append("g")
		.call(yAxis)
		.attr("transform", "translate(60, 0)")
		.attr("font-size", "1.2em");

	svg.append("text")
	  .attr("fill", "#000")
		.attr("transform", "translate(20, 250) rotate(-90)")
		.attr("font-size", "1.2em")
		.text("Productivity (%)");

	svg.append("g")
		.selectAll(".dot")
		.data(data)
	  .enter().append("circle")
      .attr("class", "dot")
			.attr("cx", function(d) {
				return 60 + xScale(d.timeWorking);
			})
			.attr("cy", function(d) {
				return yScale(100 * d.timeProductive/d.timeWorking);
			})
			.attr("r", radius)
			.style("fill", "blue")

	// Productivity over time plot
	var prodTime = d3.select("#timeProd")
		.attr("width", width + margin.left + margin.right)
		.attr("height", height + margin.top + margin.bottom);

	var timeMin = d3.min(data, function(d) {
		return parseTime(d.date);
	});
	var timeMax = d3.max(data, function(d) {
		return parseTime(d.date);
	});

	xScale = d3.scaleTime()
		.domain([timeMin, timeMax])
		.range([0, width]);
	yScale = d3.scaleLinear()
		.domain([prodMax, 0])
		.range([0, height]);

	xAxis = d3.axisBottom().scale(xScale);
	yAxis = d3.axisLeft().scale(yScale);

	prodTime.append("g")
    .attr("class", "axis")
    .attr("transform", "translate(60," + height + ")")
    .call(xAxis
            .tickFormat(d3.timeFormat("%m-%d-%y")))
    .selectAll("text")
      .style("text-anchor", "end")
      .attr("dx", "-.8em")
      .attr("dy", ".15em")
      .attr("transform", "rotate(-65)")
			.attr("font-size", "1.2em");

	prodTime.append("g")
		.call(yAxis)
		.attr("transform", "translate(60, 0)")
		.attr("font-size", "1.2em");

	prodTime.append("text")
	  .attr("fill", "#000")
		.attr("transform", "translate(20, 250) rotate(-90)")
		.attr("font-size", "1.2em")
		.text("Productivity (%)");

	prodTime.append("g")
		.selectAll(".prog")
		.data(data)
	  .enter().append("circle")
			.attr("class", "prog")
			.attr("cx", function(d) {
				return 60 + xScale(parseTime(d.date));
			})
			.attr("cy", function(d) {
				return yScale(100 * d.timeProductive/d.timeWorking);
			})
			.attr("r", radius)
			.style("fill", "blue");
}
