import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupees', 'Dollars', 'Pounds'];

  var _currentItemSelected = 'Rupees';

  TextEditingController principalController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: [
              getImage(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 60.0,bottom: 5.0),
                  child: TextFormField(
                    controller: principalController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter a amount';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Principal',
                      hintText: 'Enter Principal e.g.100, 250,700',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: TextFormField(
                  controller: interestController,
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Rate of interest';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Rate of Interest',
                    hintText: 'In percent',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: termController,
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter a period of years ';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'Time in years',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 25.0,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currentItemSelected,
                        onChanged: (String? newValueSelected) {
                          _onDropDownItemSelected(newValueSelected!);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              this.displayResult = _calculateItemSelected();
                            }
                          });
                        },
                        child: Text(
                          'Calculate',
                          textScaleFactor: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black38),
                        onPressed: () {
                          setState(() {
                            reset();
                          });
                        },
                        child: Text(
                          'Reset',
                          textScaleFactor: 1.5,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(this.displayResult),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImage() {
    AssetImage assetImage = AssetImage('images/images2.jpg');
    Image image = Image(
      image: assetImage,
      width: 200,
      height: 200,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(30.0),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateItemSelected() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(interestController.text);
    double term = double.parse(termController.text);

    double totalAmount = principal + (principal * roi * term) / 100;

    String result =
        'After $term years, your investment will be worth of $totalAmount $_currentItemSelected';
    return result;
  }

  void reset() {
    principalController.text = '';
    interestController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
