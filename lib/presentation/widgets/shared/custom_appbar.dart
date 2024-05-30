import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';


// flutter recomienda no utilizar buildContext en una funcion asíncrona

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 10 ),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon( Icons.movie_outlined, color: colors.primary ),
              const SizedBox( width: 5 ),
              Text('Cinemapedia', style: titleStyle ),
      
              const Spacer(),
      
              IconButton(onPressed: () {

                // final movieRepository = ref.read( movieRepositoryProvider );
                final searchedMovies = ref.read( searchedMoviesProvider );
                final searchQuery = ref.read(searchQueryProvider);
                
                showSearch<Movie?>( // showSearch es una función de Flutter que muestra un widget de búsqueda
                  query: searchQuery,
                  context: context, 
                  delegate: SearchMovieDelegate( // SearchMovieDelegate es una clase que extiende SearchDelegate
                    initialMovies: searchedMovies, // movieRepository.searchMovies
                    searchMovies: ref.read( searchedMoviesProvider.notifier ).searchMoviesByQuery
                    // searchMovies: (query) {
                    //   ref.read( searchedMoviesProvider.notifier ).update((state) => query);
                    //   return ref.read( movieRepositoryProvider ).searchMovies(query);
                    // }
                  )
                ).then((movie) {
                  if ( movie == null ) return;

                  context.push('/movie/${ movie.id }');
                });

              }, 
              icon: const Icon(Icons.search)
              )
            ],
          ),
        ),
      )
    );
  }
}