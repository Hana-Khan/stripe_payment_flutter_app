import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:stripe_payment_flutter_app/services/stripe_services.dart';

class ExistingCardsScreen extends StatefulWidget {
  const ExistingCardsScreen({ Key? key }) : super(key: key);

  @override
  _ExistingCardsScreenState createState() => _ExistingCardsScreenState();
}

class _ExistingCardsScreenState extends State<ExistingCardsScreen> {
     List cards = [
    {
      'cardNumber': '4242424242424242',
      'expiryDate': '04/24',
      'cardHolderName': 'Hanna Khan',
      'cvvCode': '424',
      'showBackView': false,
    },
    {
      'cardNumber': '5555555566554444',
      'expiryDate': '04/23',
      'cardHolderName': 'Joey',
      'cvvCode': '123',
      'showBackView': false,
    },
    {
      'cardNumber': '3755555566554444',
      'expiryDate': '04/27',
      'cardHolderName': 'Jannifier',
      'cvvCode': '123',
      'showBackView': false,
    }
  ];

  payViaExistingCard(BuildContext context, card) async {
    ProgressDialog dialog = ProgressDialog(context: context);
    dialog.show(msg:'Please wait...', max: 5);
    var expiryArr = card['expiryDate'].split('/');
    CreditCard stripeCard = CreditCard(
      number: card['cardNumber'],
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1]),
    );
    var response =await StripeService.payViaExistingCard(amount: '2500', currency: 'USD', card: stripeCard);
    dialog.close();
    ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message!),
            duration: Duration(milliseconds: 1200),
          ),
        ) .closed
        .then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHOOSE CARD'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int index) {
            var card = cards[index];
            return InkWell(
              onTap: () {
                payViaExistingCard(context, card);
              },
              child: CreditCardWidget(
                cardNumber: card['cardNumber'],
                expiryDate: card['expiryDate'],
                cardHolderName: card['cardHolderName'],
                cvvCode: card['cvvCode'],
                showBackView: false,
              ),
            );
          },
        ),
      ),
    );
  }
}