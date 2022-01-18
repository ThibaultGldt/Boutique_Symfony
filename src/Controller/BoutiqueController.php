<?php

namespace App\Controller;

use App\Service\BoutiqueService;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class BoutiqueController extends AbstractController
{
    /**
     * @Route("/boutique", requirements={"_locale":"%app.supported_locales%"})
     */
    public function index(BoutiqueService $boutiqueService): Response
    {
        $categories = $boutiqueService->findAllCategories();
        return $this->render('boutique/boutique.html.twig', [
            'controller_name' => 'BoutiqueController',
            'categories' => $categories,
        ]);
    }

    public function rayon(BoutiqueService $boutiqueService, int $idCategorie){
        $categorie = $boutiqueService->findCategorieById($idCategorie);
        $produits = $boutiqueService->findProduitsByCategorie($idCategorie);
        return $this->render('boutique/rayon.html.twig', [
            'controller_name' => 'BoutiqueController',
            'categorie' => $categorie,
            'produits' => $produits,
        ]);
    }

    /**@Route ("/chercher", name="search")
     * @Template
     */
    public function searchAction(BoutiqueService $boutiqueService, Request $request){
        $libelle = $request->query->get('_items');
        $produits = $boutiqueService->findProduitsByLibelleOrTexte($libelle);

        return $this->render('boutique/recherche.html.twig', [
            'controller_name' => 'BoutiqueController',
            'produits' => $produits,
        ]);
    }
}
