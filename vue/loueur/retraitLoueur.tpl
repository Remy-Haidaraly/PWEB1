<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Retrait de véhicule</title>
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
		<h2 class="title is-4 notification is-primary has-text-centered">Liste des véhicules à retirer </h2><br/>
        <div>
            <form action="index.php?controle=loueur&action=supprimerVehicule" method="post">
			<div class="UtiliserFlexBox">
				<?php
				foreach($flotte as $vehicule){
					$nom = $vehicule['type'];
					$id = $vehicule['idVehicule'];
					echo("<div class=\"block\">");
						echo("<div class=\"box\">");
							echo("<article class=\"message\">");
								echo("<div class=\"message-header\">");
									echo("<p class=\"has-text-centered\">".$nom."</p>");
								echo("</div>");
								echo("<div>");
									echo("<div><img src=\"vue/images/imagesVehicule/".$vehicule['photo'].".jpg\" width=\"400\"/>" ."<br/><br/>");
									echo("<p class=\"title is-6 has-text-centered\">identifiant du véhicule : " . $id . "</p>");
									echo('<div class="has-text-centered"><input type="checkbox" name="' .$nom. '" value="louer"/></div></div>');
								echo("</div>");
							echo("</article>");
						echo("</div>");
					echo("</div>");
				}
				?>
			</div>
			<br/><br/>
			<?php echo "<p class='msg title is-3 has-text-centered'>" . $msg . "</p>" ?>
			<div class="control has-text-centered">
				<br/><br/><button class=" button is-danger is-large" >Supprimer les véhicules séléctionnés</button><br/><br/><br/><br/><br/><br/>
			</div>
            </form>
        </div>
	</body>
</html>
