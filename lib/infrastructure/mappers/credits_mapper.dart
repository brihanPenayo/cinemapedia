import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/movieDB/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
            : 'https://imgs.search.brave.com/ADljsP2Fack7p69iGXMSu2MEKyyuDVp6B3cnSb57-Tc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tbS53/aWR5YXRhbWEuYWMu/aWQvd3AtY29udGVu/dC91cGxvYWRzLzIw/MjAvMDgvZHVtbXkt/cHJvZmlsZS1waWMt/bWFsZTEtMzAweDMw/MC5qcGc',
        character: cast.character,
      );
}
