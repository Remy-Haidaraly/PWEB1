<?php
	$nom=htmlspecialchars($nom);
	$mdp=htmlspecialchars($mdp);
	$email=htmlspecialchars($email);
?>

<!doctype html>
<html lang="fr">
    <head>
    <title>Inscription</title>
        <link rel="stylesheet" href="vue/styleCSS/style.Css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.1/css/bulma.min.css">
    </head>

    <body>
    <nav class="navbar">
		<?php require ("vue/utilisateur/menuUtilisateur.tpl");?>
    </nav>
    <section class="hero is-primary">
        <div class="hero-body">
            <div class="container">
                <h1 class="title"> Inscription</h1>
            </div>
        </div>
    </section>
    <div class="field">
        <h2 class="title">Création d'un compte</h2>
        <form action="index.php?controle=utilisateur&action=inscription" method="post">

        <label class="label">Nom</label>
        <input class="input" placeholder="Nom" name="nom" 	type="text" value= "<?php echo($nom); ?>" />

        <label class="label">Mot de passe</label>
        <input class="input" placeholder="Mot de passe"  name="mdp"  type="mdp" value= "<?php echo($mdp) ?>" />
    
        <label class="label">Email</label>
        <input class="input" placeholder="Email" name="email"  type="text" value= "<?php echo($email) ?>" />

            <div class="msg">
                <?php echo "<p class='msg'>" . $msg . "</p>"?>
            </div>
        <input class="button is-primary" type= "submit"  value="S'inscrire">
        </form>
    </div>
</body>
</html>
