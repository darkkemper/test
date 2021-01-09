<?php

namespace App\Controller;

use App\Entity\Product;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;

class ProductController extends AbstractController
{
    /**
     * @Route("/{product_url}", name="product", requirements={"product_url"="[^/]+.html"})
     * @param $product_url
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function product($product_url)
    {
        $product = $this->getDoctrine()
            ->getRepository(Product::class)
            ->findOneBy([
                'url' => str_replace('.html', '', $product_url)
            ]);

        return $this->render('shop/product.html.twig', [
            'product' => $product,
            'user' => $this->getUser(),
        ]);
    }
}
