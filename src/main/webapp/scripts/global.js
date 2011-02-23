function highlightTableRows(tableId) {
    var previousClass = null;
    var table = document.getElementById(tableId);
    var startRow = 0;
    // workaround for Tapestry not using thead
    if (!table.getElementsByTagName("thead")[0]) {
	    startRow = 1;
    }
    var tbody = table.getElementsByTagName("tbody")[0];
    var rows = tbody.getElementsByTagName("tr");
    // add event handlers so rows light up and are clickable
    for (i=startRow; i < rows.length; i++) {
        rows[i].onmouseover = function() { previousClass=this.className;this.className+=' over' };
        rows[i].onmouseout = function() { this.className=previousClass };
        rows[i].onclick = function() {
            var cell = this.getElementsByTagName("td")[0];
            var link = cell.getElementsByTagName("a")[0];
            if (link.hasAttribute("onclick")) {
                call = link.getAttribute("onclick");
                if (call.indexOf("return ") == 0) {
                    call = call.substring(7);
                }
                // this will not work for links with onclick handlers that return false
                eval(call);
            } else {
                get(link.getAttribute("href"));
            }
            this.style.cursor="wait";
            return false;
        }
    }
}

// Show the document's title on the status bar
window.defaultStatus=document.title;