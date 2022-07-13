<?php

namespace App\Service;

use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class DeviseService
{
    //http://api.currencylayer.com/live?access_key=f9b2a7f42757db9e3643c27084c64385&currencies=EUR,CAD,USD,GBP,PHP,IDR&format=1
    const DEVISE_SESSION = 'devise';
    private $session;
    private $devise;
    private $tableau;
    private $listeDevise;

    public function __construct(SessionInterface $session)
    {
        $this->session = $session;
        $this->devise = $session->get(self::DEVISE_SESSION, 'EUR');
        $this->tableau = $session->get('tableau', json_decode(file_get_contents('http://api.currencylayer.com/live?access_key=f9b2a7f42757db9e3643c27084c64385&currencies=EUR,CAD,USD,GBP,PHP,IDR&format=1')));
        $this->listeDevise = $session->get('listeDevise', ['USD', 'EUR', 'GBP']);
    }

    public function convertionDevise(Float $prixEUR){
        $devise = $this->session->get('devise');
        $prixUSD = $prixEUR / $this->t['USDUSD'];
        $prixDevise = $prixUSD * $this->session->get('tableau')['USD'.$devise];
        return $prixDevise;
    }
}