<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Accueil Client</title>
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
				<h1 class="title"> Bienvenue  <?php echo ($_SESSION['profil']['nom']); ?> </h1>
				<h1 class="subtitle"> Vos locations : </h1>
				</div>
			</div>
		</section>
        <div>
			<div class="container">
			<?php
            foreach($flotte as $voitures){
				echo("<div class='block'><div class='box'><article class='message'><div class='message-header'>");
				echo("<div><img src=\"vue/images/imagesVehicule/".$voitures['photo'].".jpg\" width=\"300\"/>" ."<br/>");
				$carac = json_decode($voitures['caracteristique']);
				echo "Le véhicule dispose d'une motorisation " . $carac->{'moteur'};
				echo " et d'une boite de vitesse " . $carac->{'vitesse'} ."<br>";
				require_once("modele/clientBD.php");
				$facture = factureClient($_SESSION['profil']['idClient']);
				foreach($facture as $fac){
					if($fac['idVehicule'] == $voitures['idVehicule']){
						echo "Il est loué du " . $fac['dateD'] . " jusqu'au " . $fac['dateF'] . "<br>";
					}
				}
				echo("</div></article></div></div>");
            }
			?>
		</div>
        </div>
	</body>
</html>
