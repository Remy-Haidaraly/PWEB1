<?php 
	/*Fonctions-contrôle mettant en place des fonctionnalités pour les utilisateurs*/
	
	/* Permet d'être dirigé vers l'accueil des utilisateurs et de voir l'ensemble
	 * des véhicules du loueur (disponible ou non)
	 */
	function accueilU() {
		require('modele/utilisateurBD.php');
		$flotte = getAllVehicule();
		require ('vue/utilisateur/accueilUtilisateur.tpl');
	}	

	/* Permet à l'utilisateur de s'inscrire en renseignant un nom, un
	 * mot de passe et une adresse email conforme
	 */
	function inscription() {	
		$nom=  isset($_POST['nom'])?($_POST['nom']):'';
		$mdp=  isset($_POST['mdp'])?($_POST['mdp']):'';
		$email=  isset($_POST['email'])?($_POST['email']):'';
		$msg='';
		if (count($_POST)==0) require("vue/utilisateur/inscriptionUtilisateur.tpl");
		else{
			require_once("./modele/utilisateurBD.php");
			$mdpCrypté = sha1($mdp);
			if(verifInscription_Champs($nom,$mdp,$email) && verifInscription_BD($nom, $mdpCrypté)){
				nouvelleInscription($nom,$mdpCrypté,$email);
				if (verifIdent_BD($nom, $mdpCrypté, $profil)) {
					$_SESSION['profil'] = $profil;
					$nexturl = "index.php?controle=client&action=accueilC";
					header("Location:" . $nexturl);
				}
			}
			else{
				require("vue/utilisateur/inscriptionUtilisateur.tpl");
			}
		}

	}

	/* Permet de vérifier la syntaxe des champs de l'inscription
	 * il est nécessaire de remplir tous les champs pour procéder à l'inscription
	 */
	function verifInscription_Champs($nom, $mdp, $email){
		if ($nom == "") {
			echo "Veuillez remplir le champ Nom";
			return false;
		}

		if ($email == "") {
			echo "Veuillez remplir le champ Email";
			return false;
		}

		if ($mdp == "") {
			echo "Veuillez remplir le champ Mot de passe";
			return false;
		}

		if (strlen($nom) >= 20) {
			echo "Veuillez entrer un nom de moins de 20 caractères";
			return false;
		}

		if(!strpos($email,'@')){
			echo "Syntaxe de l'email invalide";
			return false;
		}

		if (preg_match('/[^A-Za-z0-9]/', $mdp)) {
			echo "Veuillez entrer un mot de passe composé uniquement de chiffres et de caractères";
			return false;
		}
		return true;
	}
	
	/* Permet l'identification de l'utilisateur
	 * il est nécessaire de remplir tous les champs pour procéder à l'identification
	 */
	function ident () {
		$nom = isset($_POST['nom'])?trim($_POST['nom']):'';
		$mdp = isset($_POST['mdp'])?trim($_POST['mdp']):'';
		$msg = "";
		
		require ("./modele/utilisateurBD.php");

		
		if (count($_POST)==0) require("vue/utilisateur/identUtilisateur.tpl");
		else {
			$mdpCrypté = sha1($mdp);
			if (verifIdent_BD($nom, $mdpCrypté, $profil) && verifChamps_ident($nom,$mdp)) {
				$_SESSION['profil'] = $profil;
				$nexturl = "index.php?controle=client&action=accueilC";
				if($_SESSION['profil']['idClient'] == 2)
					$nexturl = "index.php?controle=loueur&action=accueilL";
				header("Location:" . $nexturl);
			}
			else {
				$msg = "Utilisateur inconnu !";
				require("vue/utilisateur/identUtilisateur.tpl");
			}
		}
	}
	
	/* Vérification de la syntaxe de la saisie
	 * @param nom le nom entré par l'utilisateur
	 * @param mdp le mot de passe entré par l'utilisateur
	 * @return false si la syntaxe des champs est incorrecte, true sinon
	 */
	function verifChamps_ident($nom, $mdp) {
		if (!preg_match("`^[[:alpha:][:digit:]\-]{1,30}$`", $nom)) {
			return false;
		}
		if (!preg_match("`^[[:alpha:][:digit:]]{2,8}$`", $mdp)) {
			return false;
		}
		return true;
	} 
