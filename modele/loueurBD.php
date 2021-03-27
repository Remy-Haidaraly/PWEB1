<?php
	/*Fonctions-modèle réalisant les requètes de gestion des loueurs en base de données*/


    /* Permet d'obtenir les entreprises louantes, leurs factures et la somme
     * des valeurs de leurs locations
     * @return l'ensemble des entreprises louantes
	 */
    function entrepriseLouante(){
        require("modele/connectBD.php");
        $sql = "SELECT *, SUM(valeur) as sommeValeur 
        FROM facturation, client 
        WHERE client.idClient = facturation.idClient 
        GROUP BY facturation.idClient";
        try{
            $commande = $pdo->prepare($sql);
			$bool = $commande->execute();
			if($bool){
				$entreprisesLouantes = $commande->fetchAll(PDO::FETCH_ASSOC);
			}
        }
        catch (PDOException $e) {
            echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
            die();
        }
        return $entreprisesLouantes;
    }

    /* Permet d'obtenir les véhicules indisponibles du loueur
	 * @return les véhicules indisponibles
	 */	
	function getVehiculeIndisponible(){
		require("modele/connectBD.php");
		$sql="SELECT * 
		FROM `vehicule` 
		WHERE location <> 'disponible' AND location <> 'en_revision'
		ORDER BY location, type";
		try{
			$commande = $pdo->prepare($sql);
			$bool = $commande->execute();
			if($bool){
				$véhicules = $commande->fetchAll(PDO::FETCH_ASSOC);
			}
			
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die();
		}
		return $véhicules;
    }
    
    /* Permet d'obtenir les véhicules disponibles et en stock du loueur
	 * @return les véhicules disponible
	 */	
	function getVehiculeDisponible(){
		require("modele/connectBD.php");
		$sql="SELECT * 
		FROM `vehicule` 
		WHERE location='disponible'
		ORDER BY idVehicule, location, type";
		try{
			$commande = $pdo->prepare($sql);
			$bool = $commande->execute();
			if($bool){
				$véhicules = $commande->fetchAll(PDO::FETCH_ASSOC);
			}
			
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die();
		}
		return $véhicules;
    }

	/* Permet d'ajouter un véhicule
	 * @param name_car le nom du véhicule
	 * @param moteur le type de moteur du véhicule
	 * @param vitesse la vitesse du véhicule
	 * @param prix le prix journalier du véhicule
	 * @param url le nom du l'image du véhicule
	 */
    function ajouterVehicule ($name_car, $moteur, $vitesse, $prix, $url){
        $json_ = array('moteur' => $moteur, 'vitesse' => $vitesse);
        $carac="";
        $carac = json_encode($json_);
        require ("connectBD.php") ; 
        $req = "INSERT INTO `vehicule`(`type`, `caracteristique`, `location`, `photo`,`prix`) VALUES ('$name_car','$carac','disponible','$url',$prix)";
        try {
            $commande = $pdo->prepare($req);
            $commande->execute();
            if ($commande->rowCount() > 0) {  
                return true;
            }
            else {
                return false;
            }    
        }
        catch (PDOException $e){
            echo utf8_encode("Echec de insert: " . $e->getMessage() . "\n");
            die();
        }
    }

    /* Permet au loueur de retirer un véhicule de son stock
	 * @param idVehicule l'identifiant du vehicule à retirer
	 */	
	function retirerVehicule($idVehicule){
		require("modele/connectBD.php");
		$sql="DELETE 
		FROM `vehicule` 
		WHERE idVehicule = :idVehicule";
		try{
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':idVehicule', $idVehicule);
			$commande->execute();
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de delete : " . $e->getMessage() . "\n");
			die();
		}
    }
    
    	
	/* Permet d'obtenir toutes les factures du loueur pour le mois courant
	 * @param mois le mois courant
	 * @return l'ensemble des factures sous forme de tableau
	 */
	function getFactureMois($mois, $idClient){
        require("modele/connectBD.php");
        $sql ="SELECT *, SUM(valeur) as sommeValeur 
        FROM facturation, client 
        WHERE client.idClient = facturation.idClient AND client.idClient = :idClient AND
		MONTH(DateF) = :mois 
        GROUP BY facturation.idClient";
        try{
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':mois', $mois);
			$commande->bindParam(':idClient', $idClient);
			$bool = $commande->execute();
			if($bool){
				$facturation = $commande->fetchAll(PDO::FETCH_ASSOC);
			}
        }
        catch (PDOException $e) {
            echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
            die();
        }
        return $facturation;
    }

    /* Permet d'obtenir toutes les factures du loueur
	 * @return l'ensemble des factures sous forme de tableau
	 */
	function getAllFacture(){
        require("modele/connectBD.php");
        $sql ="SELECT *
        FROM facturation
        INNER JOIN vehicule ON facturation.idVehicule = vehicule.idVehicule";
        try{
            $commande = $pdo->prepare($sql);
			$bool = $commande->execute();
			if($bool){
				$facturation = $commande->fetchAll(PDO::FETCH_ASSOC);
			}
        }
        catch (PDOException $e) {
            echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
            die();
        }
        return $facturation;
    }
    
    /* Permet de renouveller une location mensualisée
	 * @param idFacturation l'identifiant de la facturation à modifier
	 * @param dateDeb la nouvelle date de début de la location
	 */
	function renouvellementLocation($idFacturation){
		require("modele/connectBD.php");
		$sql=" UPDATE `facturation`
		SET `etat`= 0
		WHERE idFacturation=:idFacturation ";
		try{
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':idFacturation', $idFacturation);
			$commande->execute();
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de update : " . $e->getMessage() . "\n");
			die();
		}
	}

	/* Permet de rendre un véhicule disponible
	 * @param idVehicule l'identifiant du vehicule
	 */
	function finDeLocation($idVehicule){
		require("modele/connectBD.php");
		$sql="UPDATE `vehicule`
		SET `location`='disponible'
		WHERE idVehicule=:idVehicule ";
		try{
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':idVehicule', $idVehicule);
			$commande->execute();

		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de update: " . $e->getMessage() . "\n");
			die();
		}
	}
?>