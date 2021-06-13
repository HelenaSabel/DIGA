window.addEventListener('DOMContentLoaded', function () {
  var areas = document.getElementsByTagName('area');
  for (var i = 0; i < areas.length; i++) {
    areas[i].addEventListener('mouseover', highlight, false);
  }
}, false);

function highlight() {
  clearHighlights(); 
  targets = document.getElementsByClassName(this.id);
  for (var i = 0; i < targets.length; i++) {
    targets[i].style.backgroundColor = "yellow";
  }
}

function clearHighlights() {
  for (var i = 0; i < targets.length; i++) {
    targets[i].style.backgroundColor = "";
  }
}