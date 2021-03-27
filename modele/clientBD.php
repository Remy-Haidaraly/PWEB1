<?php
	/*Fonctions-modèle réalisant les requètes de gestion des clients en base de données*/

	/* Permet de consulter les véhicules loués d'un client
	 * @param idClient l'identifiant du client
	 * @return les voitures loués par le client, sous forme de tableau
	 */
	function consulterVehiculesLoués($idClient){
		require("modele/connectBD.php");
		$sql="SELECT *
		FROM vehicule 
		WHERE location = :idClient";
		try{
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':idClient', $idClient);
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

    /* Permet d'obtenir les véhicules dont la location est mensualisée pour un client donné
	 * @param idClient l'identifiant du client
	 * @return les véhicules soumis à une location mensualisée
	 */	
	function getVehiculeMensualisé($idClient){
		require("modele/connectBD.php");
		$sql="SELECT *
        FROM facturation
        INNER JOIN vehicule ON facturation.idVehicule = vehicule.idVehicule
        WHERE idClient = :idClient AND dateF IS NULL";
		try{
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':idClient', $idClient);
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

    /* Permet de mettre fin à la mensualisation d'une location
	 * @param idFacturation l'identifiant de la facturation à modifier
	 * @param dateFin la nouvelle date de fin de la location
	 */
	function finMensualisation($idFacturation,$dateFin){
		require("modele/connectBD.php");
		$sql=" UPDATE `facturation`
		SET `dateF`=:dateFin
		WHERE idFacturation=:idFacturation ";
		try{
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':idFacturation', $idFacturation);
			$commande->bindParam(':dateFin', $dateFin);
			$commande->execute();
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de update : " . $e->getMessage() . "\n");
			die();
		}
    }

    /* Permet de louer un véhicule
	 * @param idClient l'identifiant du client louant
	 * @param idVehicule l'identifiant du vehicule loué
	 */	
	function modificationEtatLocation($idClient, $idVehicule){
		require("modele/connectBD.php");
		$sql="UPDATE `vehicule`
		SET `location`=:idClient
		WHERE idVehicule=:idVehicule";
		try{
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':idClient', $idClient);
			$commande->bindParam(':idVehicule', $idVehicule);
			$commande->execute();

		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de update: " . $e->getMessage() . "\n");
			die();
		}
	}
    

    /* Permet de créer une nouvelle facture
	 * @param idClient l'identifiant du client louant
	 * @param idVehicule l'identifiant du vehicule loué
	 * @param dateD date de début de la location
	 * @param dateF date de fin de la location
	 * @param valeur le montant total de la location
	 * @param etat l'état du paiement de la facturation
	 */
	function nouvelleFacturation($idClient, $idVehicule, $dateD, $dateF, $valeur, $etat){
		require("modele/connectBD.php");
		$sql="INSERT INTO `facturation`
		(`idClient`, `idVehicule`, `dateD`, `dateF`, `valeur`, `etat`) 
		VALUES (:idClient,:idVehicule,:dateD,:dateF,:valeur,:etat)";
		try{
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':idClient', $idClient);
			$commande->bindParam(':idVehicule', $idVehicule);
			$commande->bindParam(':dateD', $dateD);
			$commande->bindParam(':dateF', $dateF);
			$commande->bindParam(':valeur', $valeur);
			$commande->bindParam(':etat', $etat);
			$commande->execute();

		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de insert : " . $e->getMessage() . "\n");
			die();
		}
    }

    /* Permet de sélectionner les factures d'un client
	 * @param idClient l'identifiant du client
	 * @return l'ensemble des factures du client sous forme de tableau
	 */
	function factureClient($idClient){
        require("modele/connectBD.php");
        $sql ="SELECT *
        FROM facturation
        INNER JOIN vehicule ON facturation.idVehicule = vehicule.idVehicule
        WHERE idClient = :idClient";
        try{
            $commande = $pdo->prepare($sql);
            $commande->bindParam(':idClient', $idClient);
			$bool = $commande->execute();
			if($bool){
				$factures = $commande->fetchAll(PDO::FETCH_ASSOC);
			}
        }
        catch (PDOException $e) {
            echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
            die();
        }
        return $factures;
	}
	
	/* Permet de payer une facture
	 * @param idFacturation l'identifiant de la facturation à payer
	 */
	function payerFacture($idFacturation){
		require("modele/connectBD.php");
		$sql=" UPDATE `facturation`
		SET `etat` = 1
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

    
?>