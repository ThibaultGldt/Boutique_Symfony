<?php

namespace App\Controller;

use App\Entity\Categorie;
use App\Entity\Produit;
use App\Service\DeviseService;
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
    public function index(): Response
    {
        //$categories = $boutiqueService->findAllCategories();
        $categories = $this->getDoctrine()->getManager()
            ->getRepository(Categorie::class)
            ->findAll();
        return $this->render('boutique/boutique.html.twig', [
            'controller_name' => 'BoutiqueController',
            'categories' => $categories,
        ]);
    }

    public function rayon(int $idCategorie){
        //$categorie = $boutiqueService->findCategorieById($idCategorie);
        //$produits = $boutiqueService->findProduitsByCategorie($idCategorie);
        $em = $this->getDoctrine()->getManager();
        $categorie = $em->getRepository(Categorie::class)->find($idCategorie);
        $produits = $categorie->getProducts();
        //$produits = $em->getRepository(Produit::class)->findBy(["categorie"=>$categorie]);
        return $this->render('boutique/rayon.html.twig', [
            'controller_name' => 'BoutiqueController',
            'categorie' => $categorie,
            'produits' => $produits,
        ]);
    }

    /**@Route ("/chercher", name="search")
     * @Template
     */
    public function searchAction(Request $request){
        $libelle = $request->query->get('_items');
        $produits = $this->getDoctrine()->getManager()->getRepository(Produit::class)->findBySearch($libelle);

        return $this->render('boutique/recherche.html.twig', [
            'controller_name' => 'BoutiqueController',
            'resultat' => $produits,
            'recherche' => $libelle,
        ]);
    }
}
