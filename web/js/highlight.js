function mapping() {
  var areas = document.getElementsByTagName('area');
  for (var i = 0; i < areas.length; i++) {
    areas[i].addEventListener('mouseover', highlight, false);
  }
}

function highlight() {
  clearHighlights(); 
  targets = document.getElementById('boundList').querySelectorAll('[data-id=' + CSS.escape(this.dataset.id) + "]");
  for (var i = 0; i < targets.length; i++) {
    targets[i].style.backgroundColor = "#d9d4d4";
  }
}

function clearHighlights() { 
  var targets = document.getElementById('boundList').querySelectorAll('[data-id]');
  for (var i = 0; i < targets.length; i++) {
    targets[i].style.backgroundColor = "";
  }
}

window.addEventListener('load', mapping, false);