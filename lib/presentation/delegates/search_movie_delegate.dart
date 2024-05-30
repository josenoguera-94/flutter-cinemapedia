import 'dart:async';

import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';


typedef SearchMoviesCallback = Future<List<Movie>> Function( String query );

class SearchMovieDelegate extends SearchDelegate<Movie?>{

// SearchDelegate es una clase de Flutter que permite crear un widget de búsqueda
  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;
  
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast(); // .broadcast() permite que varios widgets escuchen el stream
  StreamController<bool> isLoadingStream = StreamController.broadcast();


  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  }):super(
    searchFieldLabel: 'Buscar películas',
    // textInputAction: TextInputAction.done
  );

  void clearStreams() {
    debouncedMovies.close();
  }

  void _onQueryChanged( String query ) {
    isLoadingStream.add(true);

    if ( _debounceTimer?.isActive ?? false ) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration( milliseconds: 500 ), () async {
      // if ( query.isEmpty ) {
      //   debouncedMovies.add([]);
      //   return;
      // }

      final movies = await searchMovies( query );
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoadingStream.add(false);

    });

  }

  Widget buildResultsAndSuggestions() {
    // puede ser un FutureBuilder o un StreamBuilder(future: searchMovies(query))
    return StreamBuilder( // StreamBuilder es un widget de Flutter que permite construir widgets basados en un stream
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: (context, movie) {
              clearStreams();
              close(context, movie);
            },
          ),
        );
      },
    );
  }


  // @override
  // String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) { // buildActions es un método de SearchDelegate que permite construir widgets de acción

    // print('query: $query');
    return [

      StreamBuilder( // StreamBuilder es un widget de Flutter que permite construir widgets basados en un stream
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
            if ( snapshot.data ?? false ) {
              return SpinPerfect(
                  duration: const Duration(seconds: 20),
                  spins: 10,
                  infinite: true,
                  // animate: query.isNotEmpty,
                  child: IconButton(
                    onPressed: () => query = '', 
                    icon: const Icon( Icons.refresh_rounded )
                  ),
                );
            }

             return FadeIn(
                animate: query.isNotEmpty,
                // duration: const Duration( milliseconds: 300 ),
                child: IconButton(
                  onPressed: () => query = '',  // query es una propiedad de SearchDelegate que permite acceder al texto de búsqueda
                  icon: const Icon( Icons.clear )
                ),
              );

        },
      ),
      
       
        



    ];
  }

  @override
  Widget? buildLeading(BuildContext context) { // buildLeading es un método de SearchDelegate que permite construir widgets de navegación
    return IconButton(
      onPressed: () {
          clearStreams();
          close(context, null);
        }, 
        icon: const Icon( Icons.arrow_back_ios_new_rounded)
      );
  }

  @override
  Widget buildResults(BuildContext context) { // buildResults es un método de SearchDelegate que permite construir widgets de resultados
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) { // buildSuggestions es un método de SearchDelegate que permite construir widgets de sugerencias

    _onQueryChanged(query);
    return buildResultsAndSuggestions();

  }

}

class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector( // GestureDetector es un widget de Flutter que permite detectar gestos
      onTap: () { // onTap es una propiedad de GestureDetector que permite detectar un toque
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
    
            // Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network( 
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
            ),
    
            const SizedBox(width: 10),
            
            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( movie.title, style: textStyles.titleMedium ),
    
                  ( movie.overview.length > 100 )
                    ? Text( '${movie.overview.substring(0,100)}...' )
                    : Text( movie.overview ),
    
                  Row(
                    children: [
                      Icon( Icons.star_half_rounded, color: Colors.yellow.shade800 ),
                      const SizedBox(width: 5),
                      Text( 
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900 ),
                      ),
                    ],
                  )
    
                  
                ],
              ),
            ),
    
          ],
        ),
      ),
    );
  }
}