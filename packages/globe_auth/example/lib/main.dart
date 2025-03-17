import 'package:flutter/material.dart';
import 'package:globe_auth/globe_auth.dart';

final auth = GlobeAuth.project(
  'p-local',
  publicKey:
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJnbG9iZS1hdXRoIiwicm9sZSI6InB1YmxpYyIsIm9pZCI6Im8tbG9jYWwiLCJwaWQiOiJwLWxvY2FsIiwibG9jIjoibGhyIiwiaWF0IjoxNzQyMjI0Nzc4fQ.XVRhzLnOVh03HawLfnb3Y7Vk91pljJEbrrd4-dMprh8raJQnVJ2SB2nVXrYRIV_4MdM4jX_KEmGUT5HTjmhvLjliFsyQTPZPV0giRE0xgBuDu2cdCb5e-ILHZhlnrmogWmrLK7idciFkpEgNE8MMG9xVW5HLBn77k3dmLUOoS6eKtWbA8Ks1c8jKwzatqCb7BlPnF8tbU8DPhpXXkhDoqQjmG_4Ls2p-SEE_SaRpn-5itIG-IUTzKYzyvw_Uhk8o8m6NUFJ0doklfWlaT59enFKVxt8r1J1uW4BDYV1UdmHm-e-Me5SOGq9IcDsdOkXL68PnNF9hfEsXMlRcjw-odg',
  baseUrl: 'http://localhost:8787/auth/api',
);

// final auth = GlobeAuth.provider(FirebaseProvider(FirebaseAuth.instance));

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    auth.state.listen((state) {
      // Auth state changed
      print(state);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SignInScreen(
        auth: auth,
      ),
    );
  }
}
