import 'package:app_project/constants.dart';
import 'package:app_project/pages/home/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


const List<String> list = <String>['Food', 'Travel', 'Shopping', 'Bills', 'Salary', 'Transfer In', 'Transfer Out','Others'];
const List<String> list2 = <String>['This Month', 'This Week', 'Today'];


class Body extends StatefulWidget {
  final String email;
  const Body({Key? key, required this.email}) : super(key: key);
  
  @override
  State<Body> createState() => _BodyState(this.email);
}

class _BodyState extends State<Body> {
  String email = '';
  _BodyState(this.email);

  String dropdownValue = list2.first;
  int? _value = 0;
  PanelController _panelController = PanelController();

  final querySnapshot = FirebaseFirestore.instance.collection('users').where('email').get();

  final TextEditingController amountController = TextEditingController();

  CollectionReference transactions = FirebaseFirestore.instance.collection('Transactions');


  // get the total spending
  double total_value_in = 0;
  double total_value_out = 0;
  @override
  void initState() {
    super.initState();
    getTotalSpending();
    getLatestTransaction();
    getAllTransactions();
  }

  Future getTotalSpending() async {
    var date = DateTime.now();
    if(dropdownValue == 'This Week'){
      date = date.subtract(const Duration(days: 7));
    } else if(dropdownValue == 'Today'){
      date = DateTime(date.year, date.month, date.day);
    } else{
      date = DateTime(date.year, date.month, 1);
    }
    print("Date: $date");
    var query = await FirebaseFirestore.instance
        .collection('Transactions')
        .where('email', isEqualTo: widget.email)
        .where('date', isGreaterThanOrEqualTo: date)
        .get();
    
    double money_in = 0;
    double money_out = 0;
    for (var i = 0; i < query.docs.length; i++) {
      int category = query.docs[i].get('category');
      if(category ==  4 || category == 5){
        money_in += double.parse(query.docs[i].get('amount'));
      } else {
        money_out += double.parse(query.docs[i].get('amount'));
      }
    }


    // get the firstName from the document in query
    setState(() {
      total_value_in = money_in;
      total_value_out = money_out;
    });    
    
  }
  

  double latest_transaction_amt = 0;
  String latest_category = '';
  // get the latest transaction
  Future getLatestTransaction() async {
    var query = await FirebaseFirestore.instance
        .collection('Transactions')
        .where('email', isEqualTo: widget.email)
        .orderBy('date', descending: true)
        .limit(1)
        .get();

    // get the firstName from the document in query
    setState(() {
      latest_transaction_amt = double.parse(query.docs[0].get('amount'));
      latest_category = list[query.docs[0].get('category')];
    });  
    
  }

  var transactionsQuery;

  Future getAllTransactions() async {
    var query = await FirebaseFirestore.instance
        .collection('Transactions')
        .where('email', isEqualTo: widget.email)
        .orderBy('date', descending: true)
        .get();
      
    setState(() {
      transactionsQuery = query;
    });
  }

  
  Widget _buildDropdown(List<String> list) {    
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
      dropdownColor: kSecondaryColor,
      style: const TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Poppins'),
      underline: Container(
        height: 1,
        color: Colors.white,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void togglePanel() => _panelController.isPanelOpen 
      ? _panelController.close() : _panelController.open();

  @override


  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SlidingUpPanel(
      maxHeight: size.height * 0.8,
      minHeight: size.height * 0.15,
      controller: _panelController,
      parallaxEnabled: true,

      collapsed: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: togglePanel,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            
            const SizedBox(
              height: 20,
            ),

            const Text('Latest Transaction', style: TextStyle(color: Colors.grey, fontFamily: 'Poppins', fontSize: 12),),
            
            const SizedBox(
              height: 10,
            ),

            Row(              
              children: [
              if (latest_category == 'Salary' || latest_category == 'Transfer In')
                const Icon(Icons.arrow_circle_up, color: Colors.green, size: 25,),
              if (latest_category == 'Salary' || latest_category == 'Transfer In')
                Text('  \$ ${latest_transaction_amt}', style: TextStyle(color: Colors.green, fontFamily: 'Poppins', fontSize: 25, fontWeight: FontWeight.bold),),
              
              if (latest_category != 'Salary' && latest_category != 'Transfer In')
                const Icon(Icons.arrow_circle_down, color: Colors.red, size: 25,),
              if (latest_category != 'Salary' && latest_category != 'Transfer In')
                Text('  \$ ${latest_transaction_amt}', style: TextStyle(color: Colors.red, fontFamily: 'Poppins', fontSize: 25, fontWeight: FontWeight.bold),),
              
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text('${latest_category}', style: TextStyle(color: kPrimaryColor, fontFamily: 'Poppins', fontSize: 12),)
                ),
            ]),
          ],
        ),
      ),


      body: LandingPageBody(context, email),
      panelBuilder: (controller){
        return SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: togglePanel,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              
              // create container for transactions using loop
              if (transactionsQuery != null)
                for(var i = 0; i < transactionsQuery.docs.length; i++)
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(kDefaultPadding),
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          
                          //color: Color.fromARGB(97, 206, 206, 206),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(DateFormat.yMMMd().add_jm().format(transactionsQuery.docs[i].get('date').toDate()), style: TextStyle(color: Color.fromARGB(255, 182, 182, 182), fontFamily: 'Poppins', fontSize: 12),),
                                
                                Row(
                                  children: [  
                                    if(transactionsQuery.docs[i].get('category') != 4 &&  transactionsQuery.docs[i].get('category') != 5)
                                      Icon(Icons.arrow_circle_down, color: Colors.red, size: 20,),
                                    if(transactionsQuery.docs[i].get('category') != 4 &&  transactionsQuery.docs[i].get('category') != 5)
                                      Text('  \$ ${transactionsQuery.docs[i].get('amount')}', style: TextStyle(color: Colors.red, fontFamily: 'Poppins', fontSize: 25, fontWeight: FontWeight.bold),),
                                    
                                    if(transactionsQuery.docs[i].get('category') == 4 ||  transactionsQuery.docs[i].get('category') == 5)
                                      Icon(Icons.arrow_circle_up, color: Colors.green, size: 20,),
                                    if(transactionsQuery.docs[i].get('category') == 4 ||  transactionsQuery.docs[i].get('category') == 5)
                                      Text('  \$ ${transactionsQuery.docs[i].get('amount')}', style: TextStyle(color: Colors.green, fontFamily: 'Poppins', fontSize: 25, fontWeight: FontWeight.bold),),
                                    
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: kSecondaryColor,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text('${list[transactionsQuery.docs[i].get('category')]}', style: TextStyle(color: kPrimaryColor, fontFamily: 'Poppins', fontSize: 12),)
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2,
                        color: Color.fromARGB(97, 206, 206, 206),
                      )
                    ],
                  ),
                
                            
              
            ],
          ),
        );
      },
 



      borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),    
    );
  }

  SingleChildScrollView LandingPageBody(BuildContext context, String email) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          DisplayNamePart(email: email,),

          // add a container to display spendings
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(kDefaultPadding),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(131, 139, 87, 224),
                  spreadRadius: 7,
                  blurRadius: 10,
                  offset: Offset(7, 3), // changes position of shadow
                ),
              ],
              color: kSecondaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Your Money',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Poppins'),
                    ),
                    const SizedBox(
                      height: 5,
                    ),


                    // create a row with money in and money out
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.arrow_circle_down,
                          color: Colors.red,
                          size: 35,
                        ),
                        Text(
                          ' \$ ${total_value_out.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white, fontSize: 35, fontFamily: 'Poppins'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.arrow_circle_up,
                          color: Colors.green,
                          size: 35,
                        ),
                        Text(
                          ' \$ ${total_value_in.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white, fontSize: 35, fontFamily: 'Poppins'),
                        ),
                      ],
                    ),


                  ],
                ),
                _buildDropdown(list2)

              ],
            ),
          ),

          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(kDefaultPadding),
              margin: const EdgeInsets.all(20),


              decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10),
            ),

              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      controller: amountController,
                      textAlign: TextAlign.right,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(color: kTextColor, fontSize: 30, fontFamily: 'Poppins'),


                      decoration: const InputDecoration(
                        //prefixIcon: Text("\$", style: TextStyle(color: kTextColor, fontSize: 12, fontFamily: 'Poppins'),),
                        border: UnderlineInputBorder(borderSide: BorderSide(color: kTextColor)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Color(0xFF716CE6), width: 2),
                        ),
                        labelText: "Money Spent/Received",
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(color: kTextColor, fontSize: 13, fontFamily: 'Poppins'),
                        hintText: "\$ 0.00",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 30, fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                    Wrap(
                      // add alignment
                      alignment: WrapAlignment.center,
                      // add spacing
                      spacing: 10.0,
                      // add run spacing
                      runSpacing: 5.0,
                      children: List<Widget>.generate(
                        list.length,
                        (int index) {
                          return ChoiceChip(
                            selectedColor: const Color.fromARGB(82, 139, 87, 224),
                            pressElevation: 1,
                            label: Text(list[index], style: const TextStyle(color: kTextColor, fontSize: 12, fontFamily: 'Poppins')),
                            avatar: CircleAvatar(
                              backgroundColor: kSecondaryColor,
                              child : Text(list[index][0], style: const TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Poppins')),
                            ),
                            selected: _value == index,


                            onSelected: (bool selected) {
                              setState(() {
                                _value = selected ? index : null;
                              });
                            },
                          );
                        },
                      ).toList(),
                    ),

                  // add a button with Add icon
                  Container(
                    alignment: Alignment.center,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),

                      ),
                      child: const Text(
                        '+',
                        style: TextStyle(fontSize: 24, fontFamily: 'Poppins', color: kTextColor),
                      ),
                      onPressed: () async {
                        getTotalSpending();
                        getLatestTransaction();
                        getAllTransactions();

                        return transactions.add({
                            'email': widget.email,
                            'amount': amountController.text,
                            'category': _value,
                            'date': DateTime.now(),
                          })
                          .then((value) => amountController.clear())
                          .catchError((error) => print('Failed to add transaction: $error'));
                      },
                    ),

                  ),

                ]
                  ),
              ),
            ),

          ],
        ),
    );
  }
}




// Adding display name to the home page
class DisplayNamePart extends StatefulWidget {
  final String email;

  const DisplayNamePart({
    Key? key, required this.email,
  }) : super(key: key);

  @override
  State<DisplayNamePart> createState() => _DisplayNamePartState();
}

class _DisplayNamePartState extends State<DisplayNamePart> {
  String firstName = '';

  @override
  void initState() {
    super.initState();
    getFirstName();
  }

  Future getFirstName() async {
    var query = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: widget.email)
        .get();

    // get the firstName from the document in query
    setState(() {
      firstName = query.docs[0].get('firstName');
    });    
    
  }

  @override
  Widget build(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: Row(
        children: <Widget>[
          const Text(
            'Hey,\n',
            style: TextStyle(color: kTextColor, fontSize: 25, fontFamily: 'Poppins'),
          ),
          const SizedBox(width: 10),
           Text(
            firstName,
            style: TextStyle(color: kTextColor, fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }
}