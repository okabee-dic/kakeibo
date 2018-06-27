# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.draw_graph = -> 
  ctx = document.getElementById("myChart").getContext('2d')
  myChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: gon.labels,
      datasets: [{
        label: 'payment',
        data: gon.data,
        lineTension: 0,
        backgroundColor: "rgba(153,255,51,0.4)"
      }]
    }
  })
