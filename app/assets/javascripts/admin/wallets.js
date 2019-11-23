function filter_wallet_table(element) {
  var input, filter, table, tr, td, i, txtValue,index = 0;
  // debugger;
  input = element; // document.getElementById("myInput");
  filter = input.selectedOptions[0].innerText.toUpperCase();//input.value.toUpperCase();
  table = document.getElementsByTagName("table")[0];
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[2];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        index = index+1;
        tr[i].getElementsByTagName("td")[0].innerText = index;
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }       
  }
}