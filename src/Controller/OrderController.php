<?php

namespace App\Controller;

use App\Entity\Order;
use App\Entity\Product;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class OrderController extends AbstractController
{
    /**
     * @Route("/order", name="order")
     * @param Request $request
     * @return RedirectResponse|\Symfony\Component\HttpFoundation\Response
     * @throws \Exception
     */
    public function order(Request $request)
    {
        if ($this->getUser() == null) return new RedirectResponse('/');
        $proceed = false;
        if ('order' === $request->attributes->get('_route') && $request->isMethod('POST')) {
            $entityManager = $this->getDoctrine()->getManager();

            $amount = 0;
            $products = json_decode($request->request->get('products'));
            if ($products != null || !empty($products)) {
                foreach ($products as $product) {
                    $amount += $product->price * $product->quantityInCart;

                    $current = $this->getDoctrine()
                        ->getRepository(Product::class)
                        ->findOneBy(['vendor_code' => $product->vendorCode]);

                    $current->setQuantity($current->getQuantity() - $product->quantityInCart);
                    $entityManager->flush();
                }
            }

            $order = new Order();
            $order->setCreateTime(new \DateTime());
            $order->setUser($this->getUser());
            $order->setProducts(json_decode($request->request->get('products')));
            $order->setAddress($request->request->get('address'));
            $order->setDescription($request->request->get('description'));
            $order->setAmount($amount);

            $entityManager->persist($order);
            $entityManager->flush();
            $proceed = true;
        }

        return $this->render('shop/order.html.twig', [
            'user' => $this->getUser(),
            'proceed' =>  $proceed
        ]);
    }
}
