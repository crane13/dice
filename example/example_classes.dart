// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed
// by a Apache license that can be found in the LICENSE file.

part of dice_example;

class BillingServiceImpl implements BillingService {
  @inject
  CreditProcessor _processor;

  Receipt chargeOrder(Order order, CreditCard creditCard) {
    if(!(_processor.validate(creditCard))) {
      throw new ArgumentError("payment method not accepted");
    }
    // :
    print("charge order for ${order.item}");
    // :
    return new Receipt(order);
  }
}

class CreditProcessorImpl implements CreditProcessor {
  bool validate(CreditCard card) => card.type.toUpperCase() == "VISA";
}

abstract class BillingService {
  Receipt chargeOrder(Order order, CreditCard creditCard);
}

abstract class CreditProcessor {
  bool validate(CreditCard creditCard);
}

class CreditCard {
  CreditCard(this.type);
  final String type;
}

class Order {
  Order(this.item);
  final String item;
}

class Receipt {
  final Order order;

  Receipt(this.order);
}
