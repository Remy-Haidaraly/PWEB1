<?php
	/*Fonctions-modèle réalisant les requètes de gestion des utilisateurs en base de données*/


    /* Permet de vérifier l'identification d'un utilisateur grâce à un booléen
     * @param nom le nom entré par l'utilisateur
	 * @param mdp le mot de passe entré par l'utilisateur
	 * @param profil un pointeur vers la variable session profile
	 * @return true si l'utilisateur existe dans la base, false sinon
	 */
	function verifIdent_BD($nom,$mdp,&$profil) {
		require('modele/connectBD.php');
		$sql="SELECT * FROM `client` WHERE nom=:nom AND mdp=:mdp";
		try {
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':nom', $nom);
			$commande->bindParam(':mdp', $mdp);
			$bool = $commande->execute();
			if ($bool) {
				$resultat = $commande->fetchAll(PDO::FETCH_ASSOC);
			}
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die();
		}
		if (count($resultat) == 0) {
			$profil = array();
			return false; 
		}
		else {
			$profil = $resultat[0];
			return true;
		}
	}

	/* Permet d'ajouter un nouveau client
     * @param nom le nom de l'utilisateur
	 * @param mdp le mot de passe de l'utilisateur
	 * @param email l'email de l'utilisateur
	 */
	function nouvelleInscription($nom,$mdp,$email){
		require("modele/connectBD.php");
		$sql="INSERT INTO `client`
		(`nom`, `mdp`, `email`) 
		VALUES (:nom,:mdp,:email)";
		try{
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':nom', $nom);
			$commande->bindParam(':mdp', $mdp);
			$commande->bindParam(':email', $email);
			$commande->execute();
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die(); // On arrête tout.
		}
	}

	/* Permet de vérifier l'inscription d'un utilisateur
     * @param nom le nom de l'utilisateur
	 * @param mdp le mot de passe de l'utilisateur
	 * @return false si l'utilisateur existe déjà dans la base, true sinon
	 */
	function verifInscription_BD($nom, $mdp) {
		require('modele/connectBD.php'); //$pdo est défini dans ce fichier
		$sql="SELECT * FROM `client` WHERE nom=:nom AND mdp=:mdp";
		try {
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':nom', $nom);
			$commande->bindParam(':mdp', $mdp);
			$bool = $commande->execute();
			if ($commande->rowCount() > 0) {
				echo "Cet utilisateur existe déjà";
				return false;
			}
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die();
		}
		return true;
	}

	
	/* Permet de consulter tous les véhicules du loueur
	 * @return l'ensemble des véhicules du loueur
	 */
	function getAllVehicule(){
		require("modele/connectBD.php");
		$sql="SELECT *
		FROM `vehicule`";
		try{
			$commande = $pdo->prepare($sql);
			$bool = $commande->execute();
			if($bool){
				$vehicules = $commande->fetchAll(PDO::FETCH_ASSOC);
			}
			
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die(); // On arrête tout.
		}
		return $vehicules;
	}
	
?>