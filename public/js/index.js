function download_csv(csv, filename) {
  var csvFile;
  var downloadLink;

  // CSV FILE
  csvFile = new Blob([csv], {type: "text/csv"});

  // Download link
  downloadLink = document.createElement("a");

  // File name
  downloadLink.download = filename;

  // We have to create a link to the file
  downloadLink.href = window.URL.createObjectURL(csvFile);

  // Make sure that the link is not displayed
  downloadLink.style.display = "none";

  // Add the link to your DOM
  document.body.appendChild(downloadLink);

  // Lanzamos
  downloadLink.click();
}

function export_table_to_csv(html, filename) {
var csv = [];
var rows = document.querySelectorAll("table tr");

  for (var i = 0; i < rows.length; i++) {
  var row = [], cols = rows[i].querySelectorAll("td, th");

      for (var j = 0; j < cols.length; j++)
          row.push(cols[j].innerText);

  csv.push(row.join(","));
}

  // Download CSV
  download_csv(csv.join("\n"), filename);
}

document.getElementById("csvExport").addEventListener("click", function () {
  var html = document.querySelector("table").outerHTML;
export_table_to_csv(html, "Gemara Table.csv");
});

function fnExcelReport() {
  var table = document.getElementById('gemara-table'); // id of table
  var tableHTML = table.outerHTML;
  var fileName = 'Gemara Table.xls';

  var msie = window.navigator.userAgent.indexOf("MSIE ");

  // If Internet Explorer
  if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) {
    dummyFrame.document.open('txt/html', 'replace');
    dummyFrame.document.write(tableHTML);
    dummyFrame.document.close();
    dummyFrame.focus();
    return dummyFrame.document.execCommand('SaveAs', true, fileName);
  }
  //other browsers
  else {
    var a = document.createElement('a');
    tableHTML = tableHTML.replace(/  /g, '').replace(/ /g, '%20'); // replaces spaces
    a.href = 'data:application/vnd.ms-excel,' + tableHTML;
    a.setAttribute('download', fileName);
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
  }
}
