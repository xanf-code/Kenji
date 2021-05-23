import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:tothemoon/src/Network/Provider/get_requests.dart';
import 'package:tothemoon/src/pages/entry.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tothemoon/src/adapters/fav_adapter.dart';
import 'package:tothemoon/src/Providers/fav_provider.dart';

Future main() async {
  Provider.debugCheckInvalidValueType = null;
  await Hive.initFlutter();
  Hive.registerAdapter(FavouritesAdapter());
  await Hive.openBox<Favourites>("favourite");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<APIRequests>(
          create: (_) => APIRequests(),
        ),
        Provider<FavProvider>(
          create: (_) => FavProvider(),
        ),
      ],
      child: GetMaterialApp(
        navigatorKey: Get.key,
        debugShowCheckedModeBanner: false,
        home: EntryPage(),
      ),
    );
  }
}
