<?php
	$nom=htmlspecialchars($nom);
	$mdp=htmlspecialchars($mdp);
?>


<!doctype html>
<html lang="fr">
	<head>
		<meta charset="utf-8">
		<title>Connexion</title>
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
				<h1 class="title"> Connexion</h1>
			</div>
		</div>
	</section>
	<div class="field">
		<form action="index.php?controle=utilisateur&action=ident" method="post">
			<label class="label">nom :</label>
			<input name="nom" class="input" placeholder="nom" value="<?php echo $nom ?>" /> 
			<label class="label">identifiant :</label>
			<input name="mdp" class="input" placeholder="mot de passe" value="<?php echo $mdp ?>" />
			<div class="control">
			<input class="button is-primary" type= "submit" value= "Se connecter" /> 
		</div>
		</form>
		<div id ="m"> <?php echo "<p class='msg'>" . $msg . "</p>" ?> </div>
	</div>
	</body>
</html>
