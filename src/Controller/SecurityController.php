<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class SecurityController extends AbstractController
{
    /**
     * @Route("/login", name="app_login")
     * @return Response
     */
    public function login(): Response
    {
         if ($this->getUser()) {
             return $this->redirectToRoute('index');
         }

        return new RedirectResponse("/");
    }

    /**
     * @Route("/logout", name="app_logout")
     */
    public function logout()
    {
        return new RedirectResponse("/");
    }
}
