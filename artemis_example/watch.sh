npx apollo client:download-schema --endpoint="https://graphql-pokemon.now.sh" lib/schema.gql
flutter pub get
flutter pub run build_runner watch --delete-conflicting-outputs