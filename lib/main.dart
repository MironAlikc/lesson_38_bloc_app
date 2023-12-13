import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_38/repositoires/dio_settings.dart';
import 'package:lesson_38/repositoires/movie_repo.dart';

import 'bloc/movie_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DioSettings(),
        ),
        RepositoryProvider(
          create: (context) =>
              MoviRepo(dio: RepositoryProvider.of<DioSettings>(context).dio),
        ),
      ],
      child: BlocProvider(
        create: (context) => MovieBloc(
          repo: RepositoryProvider.of<MoviRepo>(context),
        ),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<MovieBloc>(context).add(
                  SerchMevieEvent(
                    name: controller.text,
                  ),
                );
              },
              child: const Icon(Icons.search),
            ),
            const SizedBox(height: 20),
            // BlocBuilder отрисовка
            //              отправлеяет
            BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const CircularProgressIndicator(
                    color: Colors.amber,
                    strokeWidth: 10,
                  );
                }
                if (state is MovieSucces) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.model.search?.length ?? 0,
                      itemBuilder: (context, index) => Image.network(
                        state.model.search?[index].poster ?? '',
                      ),
                    ),
                  );
                }

                if (state is MovieError) {
                  return Text(state.errorText);
                }
                return Image.network(
                    'https://m.media-amazon.com/images/M/MV5BM2I2NmVlNjctZmIxZS00NWYyLWEzNmEtODYzZGVkNWYyNDcwXkEyXkFqcGdeQXVyMTUyNjc3NDQ4._V1_SX300.jpg');
              },
            )
          ],
        ),
      ),
    );
  }
}
