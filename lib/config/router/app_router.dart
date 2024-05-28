import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [ // Nested routes permite que se pueda navegar a una ruta dentro de otra ruta y devolver a la ruta padre
         GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.params['id'] ?? 'no-id';

            return MovieScreen( movieId: movieId );
          },
        ),
      ]
    ),
    // GoRoute(
    //   path: 'movie/:id',
    //   name: MovieScreen.name,
    //   builder: (context, state) {
    //     final movieId = state.params['id'] ?? 'no-id';
    //     return MovieScreen( movieId: movieId );
    //   },
    // ),



  ]
);