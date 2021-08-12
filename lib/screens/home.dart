import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:stripe_payment_flutter_app/services/stripe_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        payViaNewCard(context);
        break;
      case 1:
        Navigator.pushNamed(context, '/existing-cards');
        break;
    }
  }
// 
  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = ProgressDialog(context: context);
     dialog.show(max: 100, msg:'Please wait...');
    var response = await StripeService.payWithNewCard(amount: '15000', currency: 'USD');
    // await dialog.hide();
    dialog.close();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message!),
        duration: Duration(milliseconds: response.success == true ? 1200 : 3000),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  List<Icon> icons=[
    Icon(Icons.add_circle, color: Colors.blue),
    Icon(Icons.credit_card, color: Colors.blue),
  ];
  List<Text> texts=[Text('Pay via new card'),Text('Pay via existing card')];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('SELECT PAYMENT'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
            itemBuilder: (context, index) {  
              return InkWell(
                onTap: () {
                  onItemPress(context, index);
                },
                child: ListTile(
                  title: texts[index],
                  leading: icons[index],
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
                  color: theme.primaryColor,
                ),
            itemCount: 2),
      ),
    );
  }
}