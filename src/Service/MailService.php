<?php

namespace App\Service;
use App\Entity\Commande;
use http\Env\Response;
use Symfony\Component\Mime\Email;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Address;
use Symfony\Component\Security\Core\Security;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;

class MailService
{
    private $mailer;

    public function __construct(MailerInterface $mailer)
    {
        $this->mailer = $mailer;
    }

    public function sendEmail(Commande $commande)
    {
        $email = (new TemplatedEmail())
            ->from('epicerie@mi5.com')
            ->to($commande->getUsager()->getEmail())
            ->subject('Votre commande n°'.$commande->getId())
            ->htmlTemplate('email/recu.html.twig')
            ->context(['commande' => $commande]);

        $this->mailer->send($email);
    }
}