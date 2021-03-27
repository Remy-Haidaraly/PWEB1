<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Location de véhicules</title>
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
					<h1 class="title"> Liste des véhicules à louer </h1>
				</div>
			</div>
		</section>
        <div>
			<div class="container">
            <form action="index.php?controle=client&action=louer" method="post">
			<?php
            foreach($flotte as $vehicule){
				echo("<div class='block'><div class='box'><article class='message'><div class='message-header'>");
				$nom = $vehicule['type'];
				$id = $vehicule['idVehicule'];
				echo("<div><img src=\"vue/images/imagesVehicule/".$vehicule['photo'].".jpg\" width=\"300\"/>" ."<br/>");
				echo($nom. " ");
				echo($vehicule['prix']."€/jour <br>");
				$carac = json_decode($vehicule['caracteristique']);
                echo "Le véhicule dispose d'une motorisation " . $carac->{'moteur'};
                echo " et d'une boite de vitesse " . $carac->{'vitesse'} ."<br>";
				echo('
				
				
				<input type="checkbox" name="' .$nom. '" value="louer"/>
                <input type="date" name="DateDeb' .$id. '"/>
                <input type="date" name="DateFin' .$id. '"/> 
				</div>
				');
				echo("</div></article></div></div>");
			}
			echo ("<p class='msg'>" . $msg . "</p>");
			?>
				<input class="button is-primary" type="submit" value="Louer"/>
			</form>
			</div>
        </div>
	</body>
</html>
