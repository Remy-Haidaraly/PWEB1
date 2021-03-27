<?php 
	/*Fonctions-contrôle mettant en place des fonctionnalités pour le loueur*/
	
	/* Permet d'être dirigé vers l'accueil du loueur et d'afficher les véhicules
	 * disponibles et non disponibles
	 */
	function accueilL() {
		require_once("modele/loueurBD.php");
		$dispo = getVehiculeDisponible();
		$indispo = getVehiculeIndisponible();
		require_once("vue/loueur/accueilLoueur.tpl");
	}

	/* Permet d'être dirigé vers la page des facturations des entreprises clientes
	 * et de consulter les détails des factures
	 */
	function facturation(){
		require_once("modele/loueurBD.php");
		$entreprise = entrepriseLouante();
		require("vue/loueur/facturationLoueur.tpl");
	}

	/* Permet de supprimer un véhicule du stock seulement s'il est disponible
	 * (donc ni loué ni en révision)
	 */
	function supprimerVehicule(){
		$msg = "";
		require_once("modele/loueurBD.php");
		$flotte = getVehiculeDisponible();
		if(count($_POST)==0){
			$msg = "Veuillez choisir au moins un véhicule à retirer";
			require("vue/loueur/retraitLoueur.tpl");
		}
		else{
			foreach($flotte as $vehicule){
				$nom = $vehicule['type'];
				$nom = str_replace(" ", "_", $nom);
				if(isset($_POST[$nom])){
					require_once("modele/loueurBD.php");
					retirerVehicule($vehicule['idVehicule']);
				}
			}
			$nexturl = "index.php?controle=loueur&action=accueilL";
			header("Location:" . $nexturl);
		}
	}

	/* Permet d'ajouter un nouvea véhicule au stock et d'ajouter l'image qui
	 * lui correspond dans les fichiers du projet
	 */
	function ajouterVoiture(){
		$msg = '';
		if(count($_POST)==0){
			require("vue/loueur/uploadLoueur.tpl");
		}
		elseif(count($_POST)<4 && !is_numeric($_POST['prix'])){
			require("vue/loueur/uploadLoueur.tpl");
			$msg = "Veuillez remplir tous les champs correctement pour ajouter le véhicule";
		}
        else {
            if(!empty($_FILES)){
				$filen = $_FILES['image']['name']; // je recupere le nom de mon image
                $file_extension = strrchr($filen, "."); // permet de récuperer l'extension du fichier ce qu'il y a après "."
				$file_tmp_name = $_FILES['image']['tmp_name'];
				$file_dest= 'vue\images\imagesVehicule\\'. $filen;
				$tmp = (explode(".", $filen));
				$filename_extension = ($tmp);
            	$extension_autorisees = array('.jpg','.JPG');
            if(in_array($file_extension, $extension_autorisees)){ //  vérifie si l'extension fait parti des extension autorisee
                if(move_uploaded_file($file_tmp_name, $file_dest)){
					echo ('Véhicules ajouter avec succès');
                    require_once("modele/loueurBD.php");
					ajouterVehicule($_POST["nom_de_voiture"],$_POST["moteur"],$_POST["vitesse"],$_POST["prix"],$tmp[0]);
					$nexturl = "index.php?controle=loueur&action=accueilL";
					header("Location:" . $nexturl);
                
                    
                }
                    else{
                		$msg = "Une erreur est survenue lors de l'envoie du fichier";
                    } 
                }
                else
                {
                    $msg =  'Seul les fichiers de type jpg sont autorisés';
                }
            }
        }
	}
	
	
	
	/* Permet au loueur de se déconnecter et d'être redirigé vers l'accueil des utilisateurs
	 */
	function bye() {
		session_destroy();
		$nexturl = "index.php";
		header("Location:" . $nexturl);
	}
	
?>
	
	