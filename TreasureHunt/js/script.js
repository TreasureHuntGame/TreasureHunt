window.onload = function(){ 

var modalcontato = document.getElementById("modal-contato");
var linkContato = document.getElementById("contato");

linkContato.onmouseover = function() {
    modalcontato.style.display = "block";
}

linkContato.onmouseout = function() {
    modalcontato.style.display = "none";
}

var modalregras = document.getElementById("modal-regras");
var linkRegras = document.getElementById("regras");

linkRegras.onmouseover = function() {
    modalregras.style.display = "block";
}

linkRegras.onmouseout = function() {
    modalregras.style.display = "none";
}

var modalplacar = document.getElementById("modal-placar");
var linkPlacar = document.getElementById("placar");

linkPlacar.onmouseover = function() {
    modalplacar.style.display = "block";
}

linkPlacar.onmouseout = function() {
    modalplacar.style.display = "none";
}

var modallogout = document.getElementById("modal-logout");
var linkLogout = document.getElementById("logout");

linkLogout.onmouseover = function() {
    modallogout.style.display = "block";
}

linkLogout.onmouseout = function() {
    modallogout.style.display = "none";
}

function resizable (el, factor) {
  var int = Number(factor) || 7.7;
  function resize() {el.style.width = ((el.value.length + 1) * int) + 'px'}
  var e = 'keyup, keypress, focus, blur, change'.split(',');
  for (var i in e) el.addEventListener(e[i], resize, false);
  resize();
}

resizable(document.getElementById('flag-interno'), 9.1);
};