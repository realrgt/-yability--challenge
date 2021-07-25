import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../data/models/product_model.dart';
import '../bloc/bloc.dart';
import 'widgets.dart';

class NewProductForm extends StatefulWidget {
  const NewProductForm({Key? key}) : super(key: key);

  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewProductForm> {
  final _formKey = GlobalKey<FormState>();
  final productBloc = Modular.get<ProductBloc>();

  late String _name;
  late String _price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: CustomTextFieldWidget(
                    label: 'Name',
                    onSaved: (newValue) => _name = newValue!,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextFieldWidget(
                    keyboardType: TextInputType.number,
                    label: 'Price',
                    onSaved: (newValue) => _price = newValue!,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () async {
                _formKey.currentState!.save();

                final newProduct = ProductModel(
                  name: _name,
                  price: double.parse(_price),
                );
                productBloc.add(CacheProduct(newProduct));

                Modular.to.popAndPushNamed('/');
              },
              child: const Text('Add New Product'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 18.0,
                ),
                textStyle: const TextStyle(fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
