var start=1900, end=2000

d3.select("body").append("h1").text('Timeline')
var timeline = d3.select("body").append("div").attr('class','timeline')

timeline.append("div").attr('class', 'canvas')
timeline.append("span").attr('class', 'start-date').text(start);
timeline.append("span").attr('class', 'end-date').text(end);
d3.select('body').append("div").attr('class', 'clear')