import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'repositories/movie_repository_impl.dart';
import 'services/http_manager'; // Importando o pacote Provider

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider( // Envolve o MyApp com o MultiProvider
      providers: [
        Provider(create: (context) => Dio()),
        Provider(create: (context) => HttpManager(dio: context.read())),
        Provider(
          create: (context) => MovieRepositoryImpl(httpManager: context.read())
        )
      ],
      child: const App(),
    ),
  );
}