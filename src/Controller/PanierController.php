<?php

namespace App\Controller;

use App\Service\PanierService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PanierController extends AbstractController
{
    /**
     * @Route("/panier", name="panier")
     */
    public function index(PanierService $panierService): Response
    {
        $contenu = $panierService->getContenu();
        $total = $panierService->getTotal();
        $taille = $panierService->getNbProduits();
        return $this->render('panier/index.html.twig', [
            "contenu" => $contenu,
            "total" => $total,
            "taille" => $taille,
        ]);
    }

    public function ajouter(PanierService $panierService, int $idProduit, int $quantite): Response
    {
        $panierService->ajouterProduit($idProduit, $quantite);
        return $this->redirectToRoute('panier');
    }

    public function enlever(PanierService $panierService, int $idProduit, int $quantite = 1): Response
    {
        $panierService->enleverProduit($idProduit, $quantite);
        return $this->redirectToRoute('panier');
    }

    public function supprimer(PanierService $panierService, int $idProduit): Response
    {
        $panierService->supprimerProduit($idProduit);
        return $this->redirectToRoute('panier');
    }

    public function vider(PanierService $panierService): Response
    {
        $panierService->vider();
        return $this->redirectToRoute('panier');
    }
}
