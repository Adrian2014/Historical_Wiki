var startYear=1900, endYear=2000, precision=10;
var animating = false;
var blocks = [];

var Block = function(posts, index) {
  this.posts = posts;
  this.i = index;
}

window.onload = function() {
  var data, timeline

  // Create the framework for the timeline
  timeline = d3.select("body")
    .insert('div', '.container')
    .attr('class','timeline');
  timeline.append("div").attr('class', 'canvas');
  timeline.append("span").attr('class', 'start-date').text(startYear);
  timeline.append("span").attr('class', 'end-date').text(endYear);
  d3.select('body').append("div").attr('class', 'clear')

  // Create the blocks on the timeline
  getData(startYear, endYear, precision);

  // add onhover methods for the class

}

function getData(startYear, endYear, precision) {
  var data;
  $.get(
    '/posts/getdata', 
    { start_year:startYear, end_year:endYear, precision:precision },
    function(response) {
      blocks = response
    }, 'json'
  )
}