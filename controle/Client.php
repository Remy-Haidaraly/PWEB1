<?php 
	/*Fonctions-contrôle mettant en place des fonctionnalités pour les entreprises clientes*/
	
	/* Permet d'être dirigé vers l'accueil des entreprises clientes
	 */
	function accueilC() {
		require_once("modele/clientBD.php");
		$flotte = consulterVehiculesLoués($_SESSION['profil']['idClient']);
		require_once("vue/client/accueilClient.tpl");
	}

	/* Permet la location d'un nouveau véhicule d'après une date de début et optionnellement
	 * une date de fin : 
	 * si une date de début et de fin sont spécifiées : la location a une durée déterminée
	 * si une date de début mais pas de date de fin : la location est mensualisée
	 */
	function louer(){
		$msg = "";
		require("modele/loueurBD.php");
		$flotte = getVehiculeDisponible();
		$reduc = 1;
		if(count($_POST)==0){
			$msg="Veuillez choisir au moins un véhicule à louer";
			require("vue/client/locationClient.tpl");
		}
		else{
			foreach($flotte as $vehicule){
				date_default_timezone_set('UTC');
				if(count($_POST)>10)$reduc = 0.90; 
				$nom = $vehicule['type'];
				$nom = str_replace(" ", "_", $nom);
				$dateDeb = "DateDeb" . $vehicule['idVehicule'];
				$dateFin = "DateFin" . $vehicule['idVehicule'];
				$idClient = $_SESSION['profil']['idClient'];
				$idVehicule = $vehicule['idVehicule'];
				$valeur = $vehicule['prix'];
				$dateD = $_POST[$dateDeb];
				$dateF = $_POST[$dateFin];
				$diffAnnée = intval(substr($dateF,0,4)) - intval(substr($dateD,0,4));
				$diffMois = intval(substr($dateF,5,7)) - intval(substr($dateD,5,7));;
				$diffJour = intval(substr($dateF,8,10)) - intval(substr($dateD,8,10));
				
				if($diffAnnée < 0 || $diffMois < 0 || $diffJour < 0){
					$msg = "Veuillez entrez une intervalle de date valide";
					require("vue/client/locationClient.tpl");
				}
				else{
					if(isset($_POST[$nom]) && $_POST[$dateDeb] !="" && $_POST[$dateFin] == ""){ //Dans le cas d'une mensualité
						require_once("modele/clientBD.php");
						$valeur *=30;
						nouvelleFacturation($idClient, $idVehicule, $_POST[$dateDeb], NULL, $valeur*$reduc, 0);
						modificationEtatLocation($idClient, $idVehicule);
					
						
					}
					if(isset($_POST[$nom]) && $_POST[$dateDeb] !="" && $_POST[$dateFin] !=""){ //Dans le cas d'une location à durée déterminée
						require_once("modele/clientBD.php");
						$nbJour = $diffJour + ($diffMois*30) + ($diffAnnée*365);
						$valeur *= $nbJour;
						nouvelleFacturation($idClient, $idVehicule, $_POST[$dateDeb], $_POST[$dateFin], $valeur*$reduc, 0);
						modificationEtatLocation($idClient, $idVehicule);
					
						
					}
					$nexturl = "index.php?controle=client&action=accueilC";
					header("Location:" . $nexturl);
				}
			}
		}
	}
	
	/* Permet l'arrêt d'une location mensualisée
	 * Calcul de la date de fin pour compléter le dernier mois de la location
	 */
	function arreterLocation(){
		$msg = "";
		require("modele/clientBD.php");
		$flotte = getVehiculeMensualisé($_SESSION['profil']['idClient']);
		if(count($_POST)==0){
			$msg = "Veuillez choisir au moins un véhicule pour arrêter la location";
			require("vue/client/arreterLocationClient.tpl");
		}
		else{
			foreach($flotte as $facturation){
				if(isset($_POST[$facturation['idVehicule']])){
					date_default_timezone_set('UTC');
					$dateDeb = $facturation['dateD'];
					$today = date("d");
					if(intval(substr($dateDeb,8,2)) > intval($today)){
						$nextmonth = date("Y-m-d",mktime(0,0,0, date("m"),substr($dateDeb,8,2),date("Y")));
					}
					else
						$nextmonth = date("Y-m-d",mktime(0,0,0, date("m")+1,substr($dateDeb,8,2),date("Y")));
					require_once("modele/clientBD.php");
					finMensualisation($facturation['idFacturation'],$nextmonth);
					$nexturl = "index.php?controle=client&action=accueilC";
					header("Location:" . $nexturl);
				}
			}
	
		}
		
	}	
	
	/* Permet le paiement des factures
	 */
	function paiementFactures(){
		$msg = "";
		require("modele/clientBD.php");
		$resultat = factureClient($_SESSION['profil']['idClient']);
		if(count($_POST)==0)require("vue/client/paiementClient.tpl");
		elseif(!isset($_POST['num']) || !isset($_POST['dat']) || !isset($_POST['cryp']) ){
			$msg = "Veuillez remplir les coordonnées bancaires";
			require("vue/client/paiementClient.tpl");
		}
		else{
			foreach($resultat as $facturation){
				if(isset($_POST[$facturation['idVehicule']])){
					require_once("modele/clientBD.php");
					payerFacture($facturation['idFacturation']);
				}
			}
			$nexturl = "index.php?controle=client&action=accueilC";
			header("Location:" . $nexturl);
			
			
		}
	}

	/* Permet au client de se déconnecter et d'être redirigé vers l'accueil des utilisateurs
	 */
	function bye() {
		session_destroy();
		$nexturl = "index.php";
		header("Location:" . $nexturl);
	}
	
?>
	
	