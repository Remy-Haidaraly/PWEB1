<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
        <title>Paiement des factures</title>
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
                    <h1 class="title"> Liste des véhicules impayés </h1>
                </div>
            </div>
        </section>
        <div>
            <div class="container">
            <form action="index.php?controle=client&action=paiementFactures" method="post">
            <?php
            foreach($resultat as $vehicule){
                if($vehicule['etat']==0){
                    echo("<div class='block'><div class='box'><article class='message'><div class='message-header'>");
                    $nom = $vehicule['type'];
                    $id = $vehicule['idVehicule'];
                    echo("<div><img src=\"vue/images/imagesVehicule/".$vehicule['photo'].".jpg\" width=\"300\"/>" ."<br/>");
                    echo($nom. " ");
                    echo($vehicule['valeur'].'€
                    <input type="checkbox" name="' .$id. '"/>
                    </div>
                    ');
                    echo("</div></article></div></div>");
                }
            }
            ?>
            <p>Numéro de carte</p>
            <input type ="text" name="Num"/><br/>
            <p>Date d'expiration</p>
            <input type ="month" name="Dat" /> <br/>
            <p>Cryptogramme Visuel</p>
            <input type ="text" name="Cryp" /> <br/>
            <?php echo "<p class='msg'>" . $msg . "</p>"?>
            <input type="submit" value="Payer"/>
        </form>
    </div>
        </div>
	</body>
</html>
