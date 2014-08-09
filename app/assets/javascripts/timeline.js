var MAX_YEAR = 2100;
var MIN_YEAR = -6000;

var blocks = [];
var precision = 100;

var stack = [ [MIN_YEAR, MAX_YEAR] ],
  lastStack = function() { return stack[stack.length - 1] };

var currentLayer;

function canvasWidth() {
  return $('.timeline .frame').width();
}

function blockWidth() {
  return (precision / (MAX_YEAR - MIN_YEAR))
}

window.onload = function() {
  var timeline;

  // Create the framework for the timeline
  timeline = d3.select('body')
    .insert('div', '.container')
    .attr('class','timeline');
  timeline.append("span").attr('class', 'start-date');
  timeline.append("span").attr('class', 'end-date');
  $('.timeline').append("<center><a style='margin: 0 auto'>Zoom Out</a></center>")
  timeline.append("div").attr('class', 'frame')
    .append('svg').attr('class', 'canvas')
    .append('g');
  timeline.append("div").attr('class', 'dropdown')
  d3.select('body').append("div").attr('class', 'clear')

  currentLayer = d3.select('.canvas g');
  $('.timeline .dropdown').hide();

  // Create the blocks on the timeline
  focusCanvas(MIN_YEAR, MAX_YEAR);
  getData(MIN_YEAR, MAX_YEAR);

  // add onhover methods for the class
  $('.timeline').on('mouseenter', 'g:last-child rect', function(e) { showDropdown(this, e); });
  $('.timeline').on('mouseleave', function() { hideDropdown(); });

  $('.timeline').on('click', 'g:last-child rect', function() { zoomIn(this); });
  $('.timeline a').click(function(){ zoomOut() });

  $(window).on('resize', function(e) {
    resizeCanvas(lastStack()[0], lastStack()[1])
  })
}





function showDropdown(element, event) {
  var offset = event.offsetX + parseInt($(element).parent().parent().css('left')) - 100;
  dropdown = $('.timeline .dropdown')

  if($(element).find('li').length > 0) {
    dropdown.html($(element).html());
    dropdown.css('width', '200px');
    dropdown.css('left', offset + "px");
    if(parseInt(dropdown.css('left')) > $(window).width() - 260) {
      dropdown.css('left', ($(window).width() - 260) + "px");
    };
    dropdown.slideDown('fast');
  }
}

function hideDropdown() {
  $('.timeline .dropdown').slideUp('fast');
}

function getData(startYear, endYear) {
  $.get(
    '/posts/getdata', 
    { start_year:startYear, end_year:endYear, precision:precision },
    function(response) {
      blocks = response;
      drawTimeline(startYear, endYear);
    }, 'json'
  );
}

function color_by_count (count) {
  var scale = d3.scale.linear()
    .domain([1, 9])
    .range(['#555555', '#DD7733']);

  if(count == 0) { return 'none'; }
  else { return scale(count); };
}

function drawTimeline(startYear, endYear) {
  var blockData

  $('.timeline .start-date').text(parseYear(startYear))
  $('.timeline .end-date').text(parseYear(endYear))
  $(currentLayer.text(''));

  currentLayer.selectAll('rect')
    .data(blocks.blocks)
    .enter().append("rect")
      .classed("block", true)
      .attr("width", 100 * blockWidth() + "%")
      .attr('height', '27px')
      .html(function(d) {
        var post;
        var html = "";
        d3.select(this)
          .attr('x', (100 * (d.year - MIN_YEAR) / (MAX_YEAR - MIN_YEAR)) + "%")
          .attr('fill', color_by_count(d.count))
          .attr('stroke-width', d.count > 0 ? 1 : 0);

        html += "<h3>" + parseYear(d.year);
        if(precision > 1) {
          html += " - " + parseYear((d.year + precision));
        }
        html += "</h3>";

        for(post in d.posts) {
          blockData = d.posts[post];
          html += "<li><a href='/posts/" + blockData.id + "'>" + blockData.title + "</a></li>";
        }
        return html;
      });
}


function focusCanvas(startYear, endYear, duration) {
  var magnification = (MAX_YEAR - MIN_YEAR) / (endYear - startYear);
  var offset = (startYear - MIN_YEAR) / (MAX_YEAR - MIN_YEAR);
  var width = canvasWidth() * magnification

  d3.select('.canvas')
    .transition()
    .duration(duration || 500)
    .style('width', width)
    .style('left', -offset * width);

  $('.timeline .start-date').text(parseYear(startYear));
  $('.timeline .end-date').text(parseYear(endYear));
}

function resizeCanvas(startYear, endYear) {
  focusCanvas(startYear, endYear, 1);
}

function zoomOut() {
  var range;
  hideDropdown();

  if(precision < 100) {
    precision *= 10;

    stack.pop();
    range = lastStack();
    focusCanvas(range[0], range[1]);

    currentLayer.remove();
    currentLayer = d3.select('g:last-child');

    currentLayer.transition(5000)
      .duration(100)
      .style('opacity', 1);
  }
}

function zoomIn(element) {
  var oldLayer;
  var target = parseInt( $(element).find('h3').text() );
  var startYear = target - 5 * precision;
  var endYear = target + 5 * precision;

  hideDropdown();

  if(precision > 1) {
    precision /= 10;

    focusCanvas(startYear, endYear);
    stack.push([startYear, endYear]);

    oldLayer = currentLayer;
    currentLayer = d3.select('.canvas').append('g');
    getData(startYear, endYear);
    oldLayer.transition(5000)
      .duration(1000)
      .style('opacity', 0.1);
  }
  else {
    window.location.href = "/posts/year/" + target
  }
}

function parseYear(year) {
  var suffix;
  if(year >= 0) {
    suffix = " AD";
  }
  else {
    year *= -1;
    suffix = " BC";
  }
  return(year + suffix);
}


