require './config/environment'

begin
  fi_check_migration

  use Rack::MethodOverride
  use ArtistsController
  use GenresController
  use SongsController
  use Rack::Flash
  run ApplicationController
rescue ActiveRecord::PendingMigrationError => err
  STDERR.puts err
  exit 1
end
