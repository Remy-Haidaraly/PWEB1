<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Arreter une location de véhicule</title>
		<link rel="stylesheet" href="vue/styleCSS/style.Css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.1/css/bulma.min.css">
	</head>
	<body>	
		<nav class="navbar">
			<?php require ("vue/client/menuClient.tpl");?>
		</nav>
		<section class="hero is-primary">
            <div class="hero-body">
                <div class="container">
					<h1 class="title"> Liste des véhicules loués mensuellement </h1>
				</div>
            </div>
        </section>
        <div>
			<div class="container">
            <form action="index.php?controle=client&action=arreterLocation" method="post">
			<?php
            foreach($flotte as $vehicule){
				echo("<div class='block'><div class='box'><article class='message'><div class='message-header'>");
				$nom = $vehicule['type'];
				$id = $vehicule['idVehicule'];
				echo("<div><img src=\"vue/images/imagesVehicule/".$vehicule['photo'].".jpg\" width=\"300\"/>" ."<br/>");
				echo($nom. " ");
				echo($vehicule['prix'].'€
				<input type="checkbox" name="' .$id. '" value="délouer"/>
				</div>
				');
				echo("</div></article></div></div>");
			}
			?>
			<?php echo ("<p class='msg'>" . $msg . "</p>"); ?>
				<input type="submit" value="Arreter la location"/>
			</form>
		</div>
        </div>
	</body>
</html>
