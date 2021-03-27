<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Accueil Loueur</title>
		<link rel="stylesheet" href="vue/styleCSS/style.Css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.1/css/bulma.min.css">
	</head>
	<body>
		
		<style>
			div.UtiliserFlexBox {
				display: flex;
				flex-wrap: wrap;
				margin: auto;
				justify-content: space-around;

			}
		</style>

		<nav>
			<?php require ("vue/loueur/menuLoueur.tpl");?>
		</nav>
		<h2 class="title is-4 notification is-primary has-text-centered"> Mes voitures en stock </h2>
        <div class="UtiliserFlexBox">
			<?php
            foreach($dispo as $vehicule){
				echo("<div class=\"block\">");
					echo("<div class=\"box\">");
						echo("<article class=\"message\">");
							echo("<div class=\"message-header\">");
								echo("<p class=\"has-text-centered\">".$vehicule['type']."</p>");
							echo("</div>");
							echo("<div>");
								echo("<br/>"."<img src=\"vue/images/imagesVehicule/".$vehicule['photo'].".jpg\" width=\"400\"/>" ."<br/><br/>");
								echo("<p class=\"title is-6 has-text-centered\">Identifiant du vehicule : " . $vehicule['idVehicule'] . " </p>");
								echo("<p class=\"title is-6 has-text-centered\">".$vehicule['prix']."€/jour </p>");
								$carac = json_decode($vehicule['caracteristique']);
								echo "<p class=\"title is-6 has-text-centered\">Le véhicule dispose d'une motorisation " . $carac->{'moteur'};
								echo ("<br/>"." et d'une boite de vitesse " . $carac->{'vitesse'} ."</p><br>");
							echo("</div>");
						echo("</article>");
					echo("</div>");
				echo("</div>");
            }
			?>
		</div>
		<br/>
		<br/>
		
		<h2 class="title is-4 notification is-primary has-text-centered"> Mes voitures en cours de location </h2>
        <div class="UtiliserFlexBox">
			<?php
            foreach($indispo as $vehicule){
				echo("<div class=\"block\">");
					echo("<div class=\"box\">");
						echo("<article class=\"message\">");
							echo("<div class=\"message-header\">");
								echo("<p class=\"has-text-centered\">".$vehicule['type']."</p>");
							echo("</div>");
							echo("<div>");
								echo("<br/>"."<img src=\"vue/images/imagesVehicule/".$vehicule['photo'].".jpg\" width=\"400\"/>" ."<br/><br/>");
								echo("<p class=\"title is-6 has-text-centered\">Identifiant du vehicule : " . $vehicule['idVehicule'] . " </p>");
								echo("<p class=\"title is-6 has-text-centered\">".$vehicule['prix']."€/jour </p>");
								$carac = json_decode($vehicule['caracteristique']);
								echo "<p class=\"title is-6 has-text-centered\">Le véhicule dispose d'une motorisation " . $carac->{'moteur'};
								echo ("<br/>"." et d'une boite de vitesse " . $carac->{'vitesse'} ."</p><br>");
							echo("</div>");
						echo("</article>");
					echo("</div>");
				echo("</div>");
            }
			?>
        </div>
	</body>
</html>
