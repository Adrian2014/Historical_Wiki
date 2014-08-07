var startYear=1900, endYear=2000, precision=10;
var animating = false;
var blocks = [];

window.onload = function() {
  var data, timeline

  // Create the framework for the timeline
  timeline = d3.select("body")
    .insert('div', '.container')
    .attr('class','timeline');
  timeline.append("div").attr('class', 'canvas');
  timeline.append("span").attr('class', 'start-date').text(startYear);
  timeline.append("span").attr('class', 'end-date').text(endYear);
  timeline.append("div").attr('class', 'dropdown')
  d3.select('body').append("div").attr('class', 'clear')

  hideDropdown();

  // Create the blocks on the timeline
  getData();

  // add onhover methods for the class
  $('.timeline').on('mouseenter', 'svg', function() {
    showDropdown(this);
  })

  $('.timeline').on('click', 'svg', function() {
    if(precision > 1) {
      precision = precision / 10
      getData();
    }
  })

  $('.timeline').on('mouseleave', function() {
    hideDropdown();
  })
}

function showDropdown(element) {
  offset = $(element).css('left');
  $('.timeline .dropdown').html($(element).find('div').html());;
  $('.timeline .dropdown').css('left', offset);
  $('.timeline .dropdown').show();
}

function hideDropdown() {
  $('.timeline .dropdown').hide();
}

function getData() {
  var data;
  $.get(
    '/posts/getdata', 
    { start_year:startYear, end_year:endYear, precision:precision },
    function(response) {
      blocks = response;
      updateCanvas();
    }, 'json'
  )
}

function updateCanvas() {
  var baseIndex = Math.floor(startYear/precision);
  var index = 0
  var nBlocks = Math.floor((endYear - startYear) / precision);
  var canvasWidth = $('.timeline .canvas').width();
  var blockWidth = canvasWidth / nBlocks
  var block, div, blockData

  $('.timeline .canvas').text('');

  while((baseIndex + index)*precision < endYear) {
    if(blocks[index+baseIndex]){
      block = d3.select('.timeline .canvas').append("svg")
        .classed("block", true)
        .style("width", blockWidth)
        .style("left", index*blockWidth);
      div = block.append("div");
      blockData = blocks[index+baseIndex]
      for(post in blockData) {
        div.append("li")
          .text(blockData[post].post_title)
      };
    }
    index += 1;
  }
}