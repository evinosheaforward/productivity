var loadData = function(){
                $.ajax({
                  type: 'GET',
                  contentType: 'application/json; charset=utf-8',
                  url: '/accomplishments',
                  dataType: 'json',
                  success: function(data){
										console.log("Going to do the thing!");
                    drawBarPlot(data);
                  },
                  failure: function(result){
                    error();
                  }
                });
              };

function error() {
    console.log("Something went wrong!");
}


function drawBarPlot(data){
	// set the dimensions and margins of the graph
	var margin = {top: 20, right: 20, bottom: 30, left: 50};
	var width = 768 - margin.left - margin.right;
  var height = 400 - margin.top - margin.bottom;

	var prodMax = 10 + d3.max(data, function(d) {
		return (d.timeProductive/d.timeWorking)*100;
	});
	var workMax = d3.max(data, function(d) { return d.timeWorking; });

	// Create the Scale we will use for the Axes
	// var xScale = d3.scaleLinear()
	// 	.domain([0, workMax])
	// 	.range([0, width]);
	//
	// var yScale = d3.scaleLinear()
	// 	.domain([0, prodMax])
	// 	.range([0, height]);
	//
	// // Create the axes to be called later
	// var xAxis = d3.axisBottom.scale(xScale);
	// var yAxis = d3.asixLeft.scale(yScale);

	var svg = d3.select("#plot-container").append("h2")
		.text("Time vs Productivity")
		.append("svg")
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
		.attr("transform", "translate(60, 350)")
		.attr("font-size", "1.2em");

  svg.append("text")
		.attr("transform", "translate(240, 395)")
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
		.selectAll("circle")
		.data(data)
	  .enter().append("circle")
      .attr("class", "dot")
			.attr("cx", function(d) {
				return 60 + xScale(d.timeWorking);
			})
			.attr("cy", function(d) {
				return yScale(100 * d.timeProductive/d.timeWorking);
			})
			.attr("r", 10)
			.style("fill", "blue")

			// .data(data)
			// // .enter()
			// .append("circle")
			// // .selectAll(".dot")
			// // .data(data)
	  	// // .enter()
			// // .append("circle")
      // // .attr("class", "dot")
			// .attr("fill", "blue");
			// .attr("r", 10)
		// 	// Add the scatterplot
	 // svg.selectAll("dot")
	 //      .data(data)
	 //    .enter().append("circle")
	 //      .attr("r", 20)
	 //      .attr("cx", function(d) { return x(d.timeWorking/100); })
	 //      .attr("cy", function(d) { return y(d.timeProductive/100); });
	//
	// svg.append("g")
	//       .attr("class", "y axis")
	//       .call(yAxis)
	//     	.append("text")
	//       .attr("class", "label")
	//       .attr("transform", "rotate(-90)")
	//       .attr("y", 6)
	//       .attr("dy", ".71em")
	//       .style("text-anchor", "end")
	//       .text("Sepal Length (cm)");
	//
	// svg.append("g")
  //      .attr("class", "x axis")
  //      .attr("transform", "translate(0," + height + ")")
  //      .call(xAxis)
  //    	 .append("text")
  //      .attr("class", "label")
  //      .attr("x", width)
  //      .attr("y", -6)
  //      .style("text-anchor", "end")
  //      .text("Sepal Width (cm)");
	 //
	 // svg.append("path")
   //     .data([data])
   //     .attr("class", "line")
   //     .attr("d", valueline);
	 //
		// 	 // Add the scatterplot
   // svg.selectAll("dot")
   //     .data(data)
   //   .enter().append("circle")
   //     .attr("r", 5)
   //     .attr("cx", function(d) { return x(d.timeWorking); })
   //     .attr("cy", function(d) { return y(d.timeProdutive); });


}
