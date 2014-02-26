$(function(){
  var root_el = document.getElementById('projection');
  if (!root_el) {
    return;
  }
  var root_el = d3.select(root_el);

  var parseDate = d3.time.format('%Y-%m-%d').parse

  var margin = {top: 20, right: 20, bottom: 30, left: 50},
  width = 960 - margin.left - margin.right,
  height = 500 - margin.top - margin.bottom;

  var x = d3.time.scale()
      .range([0, width]);

  var y = d3.scale.linear()
      .range([height, 0]);

  var xAxis = d3.svg.axis()
      .scale(x)
      .orient("bottom");

  var yAxis = d3.svg.axis()
      .scale(y)
      .orient("left");

  var area = d3.svg.area()
      .x(function(d) { return x(d.date); })
      .y0(height)
      .y1(function(d) { return y(d.amount); });

  var svg = root_el.append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  var table = root_el.append('table');

  d3.json('projection.json', function(error, data) {
    if (error) {
      throw error;
    }

    data.forEach(function(d) {
      d.date = parseDate(d.date);
    });

    data_date_extents = d3.extent(data, function(d) { return d.date; });
    earliest_date_in_data = data_date_extents[0];
    latest_date_in_data = data_date_extents[1];
    today = moment().startOf('day').toDate();
    end_of_2014 = parseDate('2014-12-31');

    start_date = d3.min([earliest_date_in_data, today]);
    end_date = d3.max([latest_date_in_data, end_of_2014]);

    x.domain(d3.extent(data, function(d) { return d.date; }));
    y.domain([0, d3.max(data, function(d) { return d.amount; })]);

    var past_data = [];
    var future_data = [];
    var today = new Date();

    data.forEach(function(d) {
      if (d.date < today) {
        console.log('past');
        past_data.push(d);
      } else {
        future_data.push(d);
        console.log('future');
      }
    });

    // ensure that the past and the future have no gap between them
    past_data.push(future_data[0]);

    svg.append("path")
        .datum(past_data)
        .attr("class", "area past")
        .attr("d", area);

    svg.append("path")
        .datum(future_data)
        .attr("class", "area future")
        .attr("d", area);

    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);

    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("Price ($)");

    // and now for the table
    table
      .selectAll('tr')
      .data(data)
      .enter().append('tr')
      .selectAll('td')
      .data(function(d){return [d.date, d.amount];})
      .enter().append('td')
      .text(function(d){return d;});
  });
});
