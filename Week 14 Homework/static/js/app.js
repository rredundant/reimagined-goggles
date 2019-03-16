// from data.js
var tableData = data;

// YOUR CODE HERE!



let tBody = d3.select('tbody');


function renderTable(filtData) {
  tBody.selectAll('tr').remove()
  filtData.map(ufo_sighting => {
    let newTr = tBody.append('tr');
    Object.values(ufo_sighting).forEach(x => {
      newTr.append('td').text(x)
    })
  })

}

renderTable(data)
d3.select('#filter-btn').on('click', function (e) {
  d3.event.preventDefault();
  // console.log('clicked');
  let dateVal = d3.select('#datetime').node().value;
  // console.log(dateVal)
  let filteredData = data.filter(ufo => {
    let ufoDate = new Date(ufo.datetime);
    // console.log("ufoDate ", ufoDate)
    let valDate = new Date(dateVal);
    // console.log("valDate ", valDate)
    return ufoDate.getTime() === valDate.getTime();
  });
  renderTable(filteredData)
})

