<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Facturation des véhicules</title>
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
		<h2 class="title is-4 notification is-primary has-text-centered"> Liste des véhicules ayant une facturation en cours </h2>
		<br/><br/>
        <div>
        
			<?php
			date_default_timezone_set('UTC');
			foreach($entreprise as $facture){
				echo("<div> <h2 class=\"title is-6 notification is-info has-text-centered\">Factures de l'entreprise "
					 . $facture['nom'] . 
					 " d'un montant total de "
					 . $facture['sommeValeur']."€</h2>");


				echo("<details><summary>Détails des factures de l'entreprise</summary>");
				require_once("modele/loueurBD.php");
				$currMonth = date("m");
				$affichageMois = date("M");
				$moiscourant = getFactureMois($currMonth,$facture['idClient']);
				foreach($moiscourant as $mois){
					echo("<br/><p class=\"title has-text-centered is-4\"> Valeur total des factures pour le mois de ".$affichageMois. " : " .$mois['sommeValeur']."€</p>");
				}

				require_once("modele/clientBD.php");
				$données_facture = factureClient($facture['idClient']);
				echo("<div class=\"UtiliserFlexBox\">");
					foreach($données_facture as $donnée){
						echo("<div class=\"block\">");
							echo("<div class=\"box\">");
								echo("<article class=\"message\">");
									echo("<div class=\"message-header\">");
										echo("<p class=\"has-text-centered\">".$donnée['type']."</p>");
									echo("</div>");
									echo("<div>");
										echo("<div><img src=\"vue/images/imagesVehicule/".$donnée['photo'].".jpg\" width=\"400\"/><br/><br/>");
										if($donnée['etat']==0){
											echo("<p class=\"title is-6 has-text-centered\">Facture non réglée<br/> il reste ". $donnée['valeur'] ."€ à payer</p>");
										}
										else
											echo("<p class=\"title is-6 has-text-centered\">Facture réglée<br/> un montant de " .$donnée['valeur'] ."€ a été payé</p>");
										echo("</div><br>");
									echo("</div>");
								echo("</article>");
							echo("</div>");
						echo("</div>");
						;
					}
					echo("</details><br><br>");
				echo("</div>");
				}
			?>
        </div>
	</body>
</html>