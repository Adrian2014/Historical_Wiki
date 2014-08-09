var startYear=-6000, endYear=2100, precision=100;
var blocks = [];
var layer = 0;

window.onload = function() {
  var timeline

  // Create the framework for the timeline
  timeline = d3.select("body")
    .insert('div', '.container')
    .attr('class','timeline');
  timeline.append("span").attr('class', 'start-date').text(startYear);
  timeline.append("span").attr('class', 'end-date').text(endYear);
  $('.timeline').append("<center><a style='margin: 0 auto'>Zoom Out</a></center>")
  timeline.append("svg").attr('class', 'canvas');

  timeline.append("div").attr('class', 'dropdown')
  d3.select('body').append("div").attr('class', 'clear')

  hideDropdown();

  // Create the blocks on the timeline
  getData();

  // add onhover methods for the class
  $('.timeline').on('mouseenter', 'rect', function() { showDropdown(this); });
  $('.timeline').on('mouseleave', function() { hideDropdown(); });

  $('.timeline').on('click', 'rect', function() { zoomIn(this); });
  $('.timeline a').click(function(){ zoomOut() });

  $(window).resize(drawTimeline);
}





function showDropdown(element) {
  offset = $(element).attr('x');
  dropdown = $('.timeline .dropdown')

  if($(element).find('li').length > 0) {
    dropdown.html($(element).html());
    dropdown.css('width', '200px')
    dropdown.css('left', (offset - dropdown.width()/2 + blockWidth()/2) + "px");
    if(parseInt(dropdown.css('left')) > $(window).width() - 260) {
      dropdown.css('left', ($(window).width() - 260) + "px")
    }
    dropdown.slideDown('fast');
  }
}

function hideDropdown() {
  $('.timeline .dropdown').slideUp('fast');
}

function getData() {
  $.get(
    '/posts/getdata', 
    { start_year:startYear, end_year:endYear, precision:precision },
    function(response) {
      blocks = response;
      drawTimeline();
    }, 'json'
  )
}

function drawTimeline() {
  var blockData

  $('.timeline .start-date').text(parseYear(startYear))
  $('.timeline .end-date').text(parseYear(endYear))
  $('.timeline .canvas').text('');

  d3.select('.timeline .canvas').selectAll('rect')
      .data(blocks.blocks)
    .enter().append("rect")
      .html(function(d) {
        var post
        var html = ""
        d3.select(this)
          .attr('x', blockWidth() * d.index)
          .classed('q' + quantize(d.count), true)

        html += "<h3>" + d.year
        if(precision > 1) {
          html += " - " + (d.year + precision)
        }
        html += "</h3>"

        for(post in d.posts) {
          blockData = d.posts[post]
          html += "<li><a href='/posts/" + blockData.id + "'>" + blockData.title + "</a></li>"
        }
        return html
      })
      .classed("block", true)
      .attr("width", 100/nBlocks() + "%")
      .attr('height', '27px')

}

function canvasWidth() {
  return $('.timeline .canvas').width();
}

function blockWidth() {
  return canvasWidth() / nBlocks();
}

function nBlocks() {
  return Math.floor((endYear - startYear) / precision);
}

function quantize(count) {
  return Math.floor(count)
}

function zoomOut() {
  if(precision < 100) {
    precision *= 10;

    if(precision == 100) {
      startYear = -6000
    }
    else {
      startYear -= 45 * precision
    }

    endYear += 45*precision
    if(endYear > 2000 + precision) {
      endYear = 2000 + precision
    }
    getData();
  }
}

function zoomIn(element) {
  year = startYear + (endYear - startYear) * d3.select(element).attr('x')/canvasWidth()
  console.log(year)

  if(precision > 1) {
    precision /= 10;
    startYear = Math.floor(year / (10*precision)) * 10*precision - 50 * precision
    endYear = startYear + 100*precision

    d3.select(".timeline .canvas").append('rect')
      .attr('x', d3.select(element).attr('x'))
      .attr('height', d3.select(element).attr('height'))
      .attr('width', d3.select(element).attr('width'))
      .style('fill', d3.select(element).style('fill'))
      .style('stroke', d3.select(element).style('stroke'))
      .style('stroke-width', d3.select(element).style('stroke-width'))
      .transition()
      .duration(500)
      .attr('x', 0)
      .attr('width', '100%')
      .style('fill', '#DDDDEE')
      .each("end", getData)
  }
}

function parseYear(year) {
  var suffix
  if(year >= 0) {
    suffix = " AD"
  }
  else {
    year *= -1
    suffix = " BC"
  }
  return(year + suffix)
}