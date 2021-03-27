<html>
    <head>
        <meta charset="utf-8">
        <title>Page d'Accueil</title>
        <link rel="stylesheet" href="vue/styleCSS/style.Css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.1/css/bulma.min.css">
    </head>
    <body>
        <!--Permet de rendre disponibles les véhicules avec une date de fin > à 
        la date d'aujourd'hui, et de réitérer les factures des véhicules mensualisés-->
        <?php
		
		date_default_timezone_set('UTC');
		require("modele/loueurBD.php");
		$facturation = getAllFacture();
		foreach($facturation as $facture){
			
			$today = date("Y-m-d");
            $dateF = $facture['dateF'];
            $dateD = $facture['dateD'];
			
			$diffAnnée = intval(substr($dateF,0,4)) - intval(substr($today,0,4));
			$diffMois = intval(substr($dateF,5,7)) - intval(substr($today,5,7));;
			$diffJour = intval(substr($dateF,8,10)) - intval(substr($today,8,10));
			
			if($diffMois==0 && $diffAnnée == 0 && $diffJour<0){
				finDeLocation($facture['idVehicule']);
			}
			elseif($diffAnnée<0){
				finDeLocation($facture['idVehicule']);
			}
	
			elseif($diffMois<0){
				finDeLocation($facture['idVehicule']);
            }

            $ReMois = intval(substr($dateD,5,7)) - intval(substr($today,5,7));;
			$ReJour = intval(substr($dateD,8,10)) - intval(substr($today,8,10));
            if($dateF == NULL){
                if($ReMois<0 && $ReJour==0){
                    renouvellementLocation($facture['idFacturation']);
                }
            }
		}
		
        ?>
		<nav class="navbar">
			<?php require ("vue/utilisateur/menuUtilisateur.tpl");?>
        </nav>
        <section class="hero is-primary">
            <div class="hero-body">
                <div class="container">
                    <h1 class="title"> Liste des véhicules</h1>
                    <h1 class="subtitle"> Pas encore inscrit ? dépêchez-vous avant de rater le véhicule de votre vie ! </h2>
                </div>
            </div>
        </section>
        <div class="container">
                
            <?php
            foreach($flotte as $field){
                echo("<div class='block'><div class='box'><article class='message'><div class='message-header'>");
                echo("<img src=\"vue/images/imagesVehicule/".$field['photo'].".jpg\" width=\"300\"/>" ."");
                echo("".$field['type']."<br>");
                $carac = json_decode($field['caracteristique']);
                echo "Le véhicule dispose d'une motorisation " . $carac->{'moteur'};
                echo " et d'une boite de vitesse " . $carac->{'vitesse'} ."<br>";

                if($field['location'] == "disponible")
                {
                    echo("<strong><font color=\"green\">".$field['location']."</font></strong><br/><br/>");
                }
                else
                {
                    echo("<strong><font color=\"red\">Indisponible</font></strong> <br/><br/>");
                }
                echo("</div></article></div></div>");
            }

            
            ?>
        </div>
        </div>
    </div>


    </body>
    </html>