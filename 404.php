<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="description" content="TreasureHunt, um Jogo de Caça ao Tesouro de Segurança Computacional">
	<meta name="keywords" content="Treasure Hunt, Segurança Computacional">
	<meta name="author" content="Ricardo de la Rocha Ladeira">
	<title>TreasureHunt{Security} -- You'll never find me!</title>
	<style type="text/css">
@import url(http://fonts.googleapis.com/css?family=Eczar|Muli);
* {
	padding: 0;
	margin: 0;
}
#placar {
	border: 0;
}
body {
	background: #222;
	font-size: 22px;
	font-family: 'Muli', sans-serif;
	text-align: center;
}
p, span, label{
	color: yellow;
	margin-bottom: 10px;
}

table {
	font-size: 22px;
	border: 3px solid;
	margin: 0 auto;
    -webkit-border-image: 
      -webkit-gradient(linear, 0 0, 0 100%, from(black), to(rgba(0, 0, 0, 0))) 1 100%;
    -webkit-border-image: 
      -webkit-linear-gradient(black, rgba(0, 0, 0, 0)) 1 100%;
    -moz-border-image:
      -moz-linear-gradient(black, rgba(0, 0, 0, 0)) 1 100%;    
    -o-border-image:
      -o-linear-gradient(black, rgba(0, 0, 0, 0)) 1 100%;
    border-image:
      linear-gradient(to bottom, black, rgba(0, 0, 0, 0)) 1 100%;
}
th {
	color: yellow;
	background-color: black;
}
td {
	border: 0;
}
#main, #modal-contato, #modal-regras, #modal-placar, #modal-logout {
	margin-top: 76px;
}
#modal-regras, #modal-contato, #modal-placar, #modal-logout {
	background-color: #222;
	display: none;
	font-size: 16px;
	height: 72%;
	position: absolute;
	top: 80px;
	width: 100%;
}
#modal-regras-content, #modal-placar-content {
	background-color: yellow;
	border-radius: 10px;
	margin: 0 auto;
	padding: 16px;
	width: 65%;
}
#modal-regras-content p {
	color: black;
}
#smile {
	display: inline-block; 
	margin-left: 10px;
	transform: rotate(90deg);
}
#bracket {
	color: black;
}
#whitebracket {
	color: white;
}
#interno input {
	width: 200px;
}
::-webkit-input-placeholder {
   font-family: 'Muli', sans-serif;
   text-align: center;
}
:-moz-placeholder { /* Firefox 18- */
   font-family: 'Muli', sans-serif;
   text-align: center;  
}
::-moz-placeholder {  /* Firefox 19+ */
   font-family: 'Muli', sans-serif;
   text-align: center;
}
:-ms-input-placeholder {
   font-family: 'Muli', sans-serif;
   text-align: center;
}
h1, h2 {
	color: #FFF;
	font-family: 'Eczar', serif;
}
h1 {
	font-size: 60px;
}
h2 {
	font-size: 40px;
}
nav {
	background-color: yellow;
	margin: 20px auto;
}
nav ul {
	list-style: none;
  	margin: 0;
  	padding: 0;
	position: relative;
}
nav ul li {
	display: inline-block;
}
nav a {
	color: black;
	display: block;
	font-size: 20px;
	line-height: 60px;
	padding: 0 10px;	
	text-decoration: none;
	cursor: not-allowed;
}
nav a:hover { 
	background-color: black;
	color: yellow;
}
a:active {
	color: black;
}
input, button {
	background-color: #222;
	border-color: black;	
	font-size: 16px;
}
input {
	min-width:200px!important;
	max-width:99.99%!important;
	transition: width 0.25s;
	height: 25px;
	text-align: center;
	font-family: 'Muli', sans-serif;
	border-radius: 1px;
	margin: 2px;
	color: white;
}
button {
    border-radius: 5px;
	color: yellow;
    cursor: pointer;	
	font-family: 'Eczar', sans-serif;
	font-weight: bold;
    margin: 5px;
	width: 100px;
}
input:focus, button:focus {
	border-color: yellow;
}
address {
	color: yellow;
	font-family: 'Eczar', serif;
	font-size: 30px;
	font-style: normal;
}
address .at {
	visibility: hidden;
}
address .at:after {
	color: black;
	content:'@';
	visibility: visible;	
}
address span {
	font-weight: bold;
}
address .sinal-menor:after {
	content: '<';
}
address .sinal-maior:after {
	content: '>';
}
address .sinal-menor, address .sinal-maior {
	color: white;
}
.nome {
	color: white;
	font-weight: normal;
}
.destaque {
	color:black;
}		
	</style>
	<link rel="icon" type="image/png" href="img/favicon.png">
	<script src="js/script.js"></script>	
</head>
<body>
<div id="container">
    <nav>
        <ul>
            <li><a>Deu ruim!</a></li>
        </ul>
    </nav>
    <div id="main">
	  	<h1>Treasure<span id="bracket">Hunt</span>{<span>404</span>}</h1>
		<p>Você tentou acessar uma página inexistente. Volte para o início! <span id="smile">:)</span></p>
	</div>
</div>
</body>
</html>