<?php
namespace App\Service;
use App\Entity\Commande;
use App\Entity\LigneCommande;
use App\Entity\Produit;
use App\Entity\Usager;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Doctrine\ORM\EntityManagerInterface;
use App\Entity\Categorie;
// Service pour manipuler le panier et le stocker en session
class PanierService {
////////////////////////////////////////////////////////////////////////////
    const PANIER_SESSION = 'panier'; // Le nom de la variable de session du panier
    private $session; // Le service Session
    private $boutique; // Le service Boutique
    private $em;
    private $panier; // Tableau associatif idProduit => quantite
// donc $this->panier[$i] = quantite du produit dont l'id = $i
// constructeur du service
    public function __construct(SessionInterface $session, EntityManagerInterface $em/*, BoutiqueService $boutique*/) {
// Récupération des services session et BoutiqueService
        //$this->boutique = $boutique;
        $this->em = $em;
        $this->session = $session;
// Récupération du panier en session s'il existe, init. à vide sinon
        $this->panier = $session->get(self::PANIER_SESSION, []);// initialisation du Panier : à compléter
}
// getContenu renvoie le contenu du panier
// tableau d'éléments [ "produit" => un produit, "quantite" => quantite ]
    public function getContenu() {
        $produits = $this->em->getRepository(Produit::class);
        $contenu = array();
        foreach ($this->panier as $id => $quantite){
            //$contenu[$id] = ["produit" => $produits->findBy(['id' => $id]), "quantite" => $quantite];
            array_push($contenu, array('produit' => $produits->find($id), 'quantite' => $quantite));
        }
        return $contenu;
    }
// getTotal renvoie le montant total du panier
    public function getTotal() {
        $produit = $this->em->getRepository(Produit::class);
        $prixTotal = 0.00;
        foreach ($this->panier as $id => $quantite){

            $prixTotal += $produit->find($id)->getPrix() * $quantite;
        }
        return $prixTotal;
    }
// getNbProduits renvoie le nombre de produits dans le panier
    public function getNbProduits() {
        $quantiteTotale = 0;
        foreach ($this->panier as $id => $quantite){
            $quantiteTotale += $quantite;
        }
        return $quantiteTotale;
    }
// ajouterProduit ajoute au panier le produit $idProduit en quantite $quantite
    public function ajouterProduit(int $idProduit, int $quantite = 1) {
        if(!isset($this->panier[$idProduit])){
            $this->panier[$idProduit] = $quantite;
        }else{
            $this->panier[$idProduit] += $quantite;
        }

        $this->session->set(self::PANIER_SESSION, $this->panier);
    }
// enleverProduit enlève du panier le produit $idProduit en quantite $quantite
    public function enleverProduit(int $idProduit, int $quantite = 1) {
        if($this->panier[$idProduit] == 1){
            $this->supprimerProduit($idProduit);
        }else{
            $this->panier[$idProduit] -= $quantite;
        }
        $this->session->set(self::PANIER_SESSION, $this->panier);
    }
// supprimerProduit supprime complètement le produit $idProduit du panier
    public function supprimerProduit(int $idProduit) {
        unset($this->panier[$idProduit]);
        $this->session->set(self::PANIER_SESSION, $this->panier);
    }
// vider vide complètement le panier
    public function vider() {
        $this->panier = [];
        $this->session->set(self::PANIER_SESSION, $this->panier);
    }

    public function panierToCommande(Usager $usager){
        if(isset($this->panier)){
            $commande = new Commande();
            $commande->setUsager($usager);

            $commande->setDateCommande(new \DateTime());
            $commande->setStatut("En traitement");

            $this->em->persist($commande);
            $this->em->flush();
            foreach ($this->panier as $idProduit => $quantite){
                $produit = $this->em->getRepository(Produit::class)->find($idProduit);

                $ligneCommande = new LigneCommande();
                $ligneCommande->setArticle($produit);
                $ligneCommande->setQuantite($quantite);
                $ligneCommande->setCommande($commande);
                $ligneCommande->setPrix($produit->getPrix() * $quantite);

                $commande->addLignesCommande($ligneCommande);

                $this->em->persist($ligneCommande);
            }

            $usager->addCommande($commande);

            $this->em->flush();

            $this->vider();

            return $commande;
        }
    }

    /*public function plusVendu(){
        $em
    }*/
}