<?php

namespace App\Controller;

use App\Entity\Usager;
use App\Form\UsagerType;
use App\Repository\UsagerRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;

class   UsagerController extends AbstractController
{
    public function index(UsagerRepository $usagerRepository): Response
    {   //TODO formulaire modification attributs user
        if($this->getUser()){
            return $this->render('usager/index.html.twig', [
                'usager' => $this->getUser(),
            ]);
        }else{
            return $this->redirectToRoute('app_login');
        }

    }

    public function new(Request $request, EntityManagerInterface $entityManager, UserPasswordHasherInterface $hasher): Response
    {

        $usager = new Usager();
        $form = $this->createForm(UsagerType::class, $usager);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $hashedPassword = $hasher->hashPassword($usager, $usager->getPassword());
            $usager->setPassword($hashedPassword);
            $usager->setRoles(['ROLE_CLIENT']);
            $entityManager->persist($usager);
            $entityManager->flush();

            return $this->redirectToRoute('app_login', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('usager/new.html.twig', [
            'usager' => $usager,
            'form' => $form,
        ]);
    }


}
