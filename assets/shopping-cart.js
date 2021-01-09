import $ from "jquery";

const ShoppingCart = (function() {

  const quantityAction = (e) => {
    let targetClass = $(e.target).parent().attr('class');
    let vendorCode = targetClass.replace(/quantity-action-(down|up)-/, '');
    let action = targetClass.replace(/quantity-action-(down|up)-\w+/, '$1');
    let shoppingCart = JSON.parse(localStorage.getItem('shopping-cart'));
    for (let key in shoppingCart['products']) {
      if (shoppingCart['products'].hasOwnProperty(key)) {
        let product = shoppingCart['products'][key];
        if (product.vendorCode === vendorCode) {
          if (action === 'up' && product.quantityInCart < product.quantity) {
            product.quantityInCart += 1;
            $(e.target).parent().prev().html(product.quantityInCart + ' шт')
          } else if (action === 'down') {
            product.quantityInCart -= 1;
            $(e.target).parent().next().html(product.quantityInCart + ' шт')
          }

          let upIcon = $(`.quantity-action-up-${vendorCode} > i`);
          if (product.quantityInCart === product.quantity) {
            upIcon.addClass('text-muted')
          } else {
            upIcon.removeClass('text-muted')
          }
          if (product.quantityInCart < 1) {
            $('.shopping-cart-item-' + vendorCode).remove();
            ShoppingCart.deleteItemFromShoppingCart(vendorCode)
          } else {
            shoppingCart['products'][key] = product;
            localStorage.setItem('shopping-cart', JSON.stringify(shoppingCart));
          }
        }
      }
    }
    ShoppingCart.updateOrderPageProducts();
    ShoppingCart.countTotalPrice();
  };

  const cartAction = (e) => {
    let product = {
      vendorCode: e.currentTarget.dataset.vendorCode,
      thumbnail: e.currentTarget.dataset.thumbnail,
      title: e.currentTarget.dataset.title,
      url: e.currentTarget.dataset.url,
      price: Number(e.currentTarget.dataset.price),
      quantity: Number(e.currentTarget.dataset.quantity),
      quantityInCart: 1
    };

    if (localStorage.getItem('shopping-cart') == null) {
      let products = {'products' : [product]};

      localStorage.setItem('shopping-cart', JSON.stringify(products))
    }
    let shoppingCart = JSON.parse(localStorage.getItem('shopping-cart'));

    let exists = false;
    for (let key in shoppingCart['products']) {
      if (shoppingCart['products'].hasOwnProperty(key)) {
        if (shoppingCart['products'][key].vendorCode === product.vendorCode) {
          exists = true;
        }
      }
    }

    if (!exists) {
      shoppingCart['products'].push(product);
      if (e !== null) $(e.currentTarget).html('<i class="fas fa-check"></i>');
      localStorage.setItem('shopping-cart', JSON.stringify(shoppingCart));
      ShoppingCart.updateProductsInShoppingCart();
      ShoppingCart.setCheckIconToProducts();
      ShoppingCart.countTotalPrice();
    } else {
      ShoppingCart.deleteItemFromShoppingCart(product.vendorCode, true);
    }
  };

  const deleteItemFromShoppingCart = (vendorCode, direct = false) => {
    let shoppingCart = JSON.parse(localStorage.getItem('shopping-cart'));
    let products = {'products' : []};
    let mainButton = $(`div[data-vendor-code="${vendorCode}"].shopping-cart-button-main`);
    $('div[data-vendor-code="' + vendorCode + '"]').html('<i class="fas fa-shopping-cart"></i>');
    if (mainButton.length !== 0) {
      mainButton.html('в корзину <i class="fas fa-shopping-cart"></i>');
    }

    for (let key in shoppingCart['products']) {
      if (shoppingCart['products'].hasOwnProperty(key)) {
        if (shoppingCart['products'][key].vendorCode !== vendorCode) {
          products['products'].push(shoppingCart['products'][key]);
        }
      }
    }
    localStorage.setItem('shopping-cart', JSON.stringify(products));
    ShoppingCart.updateProductsInShoppingCart();
    ShoppingCart.updateOrderPageProducts();
    ShoppingCart.countTotalPrice();

    if (!direct) {
      shoppingCart = JSON.parse(localStorage.getItem('shopping-cart'));
      let test = false;
      for (let key in shoppingCart['products']) {
        if (shoppingCart['products'].hasOwnProperty(key)) {
          test = true;
          break;
        }
      }
      if (!test) {
        if (window.location.pathname === '/order') {
          window.location = '/';
        }
      }
    }
  };

  const setCheckIconToProducts = () => {
    let shoppingCart = JSON.parse(localStorage.getItem('shopping-cart'));
    for (let key in shoppingCart['products']) {
      if (shoppingCart['products'].hasOwnProperty(key)) {
        let product = shoppingCart['products'][key];
        let mainButton = $(`div[data-vendor-code="${product.vendorCode}"].shopping-cart-button-main`);
        $('div[data-vendor-code="' + product.vendorCode + '"]').html('<i class="fas fa-check"></i>');
        if (mainButton.length !== 0) {
          mainButton.html('в корзине <i class="fas fa-check"></i>');
        }
      }
    }
  };

  const updateProductsInShoppingCart = () => {
    let shoppingCart = JSON.parse(localStorage.getItem('shopping-cart'));
    let shoppingCartList = $('.shopping-cart-list');
    let _currencyFormat = new Intl.NumberFormat('ru-RU', { style: 'currency', currency: 'RUB' });
    shoppingCartList.html('');
    for (let key in shoppingCart['products']) {
      if (shoppingCart['products'].hasOwnProperty(key)) {
        let product = shoppingCart['products'][key];

        shoppingCartList.append(`
          <div class="media mb-3 shopping-cart-item-${product.vendorCode}">
            <img src="${product.thumbnail}" class="mr-3" alt="${product.title}" width="80">
            <div class="media-body">
              <div class="row align-items-center">
                <div class="col">
                    <a href="/${product.url}.html">${product.title}</a><br>
                    <span class="text-muted">${_currencyFormat.format(product.price / 100)} за 1 шт</span><br>
                    ${(product.quantity > 0) ? `
                      <span class="quantity-action-down-${product.vendorCode}"><i class="fas fa-minus"></i></span>
                      <span class="quantity-value-${product.vendorCode} mx-3">${product.quantityInCart} шт</span>
                      <span class="quantity-action-up-${product.vendorCode}">
                          <i class="fas fa-plus ${(product.quantityInCart === product.quantity) ? 'text-muted' : ''}"></i>
                      </span>
                    ` : `<span class="small text-danger">Товар закончился</span>`}
                </div>
                <div class="col-auto">
                    <span class="float-right" style="font-size: 1.1em" data-value="${product.vendorCode}" data-action="delete-item-from-shopping-cart-${product.vendorCode}">
                        <a href="#"><i class="fas fa-times"></i></a>
                    </span>
                </div>
              </div>
            </div>
          </div>
        `);

        $('.quantity-action-down-' + product.vendorCode).click((e) => {
          ShoppingCart.quantityAction(e)
        });
        $('.quantity-action-up-' + product.vendorCode).click((e) => {
          ShoppingCart.quantityAction(e)
        });
        $('span[data-action="delete-item-from-shopping-cart-' + product.vendorCode + '"]').click(() => {
          $('.shopping-cart-item-' + product.vendorCode).remove();
          ShoppingCart.deleteItemFromShoppingCart(product.vendorCode);
        });

        ShoppingCart.countTotalPrice();
      }
    }
  };

  const countTotalPrice = () => {
    let shoppingCart = JSON.parse(localStorage.getItem('shopping-cart'));
    let totalPriceSelector = $('span.cart-total-price');
    let totalDeliverySelector = $('span.total-delivery-price');
    let totalPriceInput = $('input.cart-total-price');
    let shoppingCartSubmit = $('#shopping-cart-submit');
    let currencyFormat = new Intl.NumberFormat('ru-RU', { style: 'currency', currency: 'RUB' });
    let totalPrice = 0;
    let deliveryPrice = 100;
    for (let key in shoppingCart['products']) {
      if (shoppingCart['products'].hasOwnProperty(key)) {
        let product = shoppingCart['products'][key];
        totalPrice += (product.price / 100) * product.quantityInCart;
      }
    }
    let totalPriceResult = Math.round((totalPrice + Number.EPSILON) * 100) / 100;
    totalPriceSelector.html(currencyFormat.format(totalPrice));
    totalDeliverySelector.html(currencyFormat.format(totalPrice + deliveryPrice));
    totalPriceInput.val(totalPriceResult);
    if (0 >= totalPrice) {
      shoppingCartSubmit.addClass(['disabled', 'btn-danger']);
      shoppingCartSubmit.prop('disabled', true);
      shoppingCartSubmit.html('В корзине нет товаров');
    } else {
      shoppingCartSubmit.removeClass(['disabled', 'btn-danger']);
      shoppingCartSubmit.prop('disabled', false);
      shoppingCartSubmit.html('Оформить заказ');
    }
  };

  const updateOrderPageProducts = () => {
    if (localStorage.getItem('shopping-cart') !== null) {
      let productsToOrder = [];
      let shoppingCart = JSON.parse(localStorage.getItem('shopping-cart'));
      for (let key in shoppingCart['products']) {
        if (shoppingCart['products'].hasOwnProperty(key)) {
          let product = shoppingCart['products'][key];
          productsToOrder.push(product)
        }
      }
      $('form#order > input[name="products"]').val(JSON.stringify(productsToOrder));
    }
  };

  return {
    quantityAction,
    cartAction,
    deleteItemFromShoppingCart,
    setCheckIconToProducts,
    updateProductsInShoppingCart,
    countTotalPrice,
    updateOrderPageProducts
  }
})();

export {
  ShoppingCart
}