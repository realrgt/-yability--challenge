import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/adapters.dart';

import 'modules/product/product_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    //! External
    Bind.factory<HiveInterface>((i) => Hive),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: ProductModule()),
  ];
}
