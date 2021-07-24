import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class ProductHomePage extends StatefulWidget {
  const ProductHomePage({Key? key}) : super(key: key);

  @override
  State<ProductHomePage> createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {
  final productBloc = Modular.get<ProductBloc>();

  Widget _buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => productBloc,
      child: Column(
        children: <Widget>[
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductInitial) {
                  return const MessageDisplayWidget(
                    message: 'Fetching data...',
                  );
                } else if (state is ProductLoading) {
                  return const LoadingWidget();
                } else if (state is ProductLoaded) {
                  return ProductListWidget(products: state.products);
                } else if (state is ProductError) {
                  return MessageDisplayWidget(message: state.message);
                }
                return const MessageDisplayWidget(
                  message: 'Contact the dev team',
                );
              },
            ),
          ),
          const NewProductForm(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    productBloc.add(GetCachedProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: _buildBody(context),
    );
  }
}
