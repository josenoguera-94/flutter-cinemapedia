import 'package:cinemapedia/domain/entities/movie.dart';


abstract class MoviesDatasource {

  Future<List<Movie>> getNowPlaying({ int page = 1 });
  // va a regresar un future de una lista de movies

}