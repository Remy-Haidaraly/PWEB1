<!doctype html>
<html lang="fr">
    <head>
        <title>Ajouter un véhicule</title>
        <meta charset="UTF-8"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.1/css/bulma.min.css">
    </head>
    <body>

        <style>
            div.divFormulaire{
                margin: 0 auto;
                width: 500px;
            }
        </style>
        <nav>
			<?php require ("vue/loueur/menuLoueur.tpl");?>
		</nav>
        <h2 class="title is-4 notification is-primary has-text-centered">Uploader votre véhicule </h2><br/><br/>
        <div class=" box divFormulaire">
                
            <form action ="index.php?controle=Loueur&action=ajouterVoiture" method="post" enctype="multipart/form-data">
                <input type ="file" name="image" /> <br/>
                <div class="field">
                    <label class="label">Moteur</label>
                    <div class="control">
                    <input class="input" type="text" name="moteur"/>
                    </div>
                </div>
                
                <div class="field">
                    <label class="label">Vitesse</label>
                    <div class="control">
                    <input class="input" type="text" name="vitesse"/>
                    </div>
                </div>
                <div class="field">
                    <label class="label">Nom du vehicule</label>
                    <div class="control">
                    <input class="input" type="text" name="nom_de_voiture"/>
                    </div>
                </div>
                
                <div class="field">
                    <label class="label">Prix</label>
                    <div class="control">
                    <input class="input" type="text" name="prix">
                    </div>
                </div>
                
                <br/>
                <?php echo "<p class='msg'>" . $msg . "</p>" ?>
                <div class="control has-text-centered">
                    <button class=" button is-primary" >Ajouter le véhicule</button>
                </div>
            </form>
        </div>

    </body>
</html>
