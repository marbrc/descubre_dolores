# Archivos multimedia que necesitas poner

Las rutas se cambian en un solo lugar:
`lib/data/datasources/lugares_local_datasource.dart`

| Lugar | Imagen (assets/images/) | Audio (assets/audio/) | Video (assets/video/) |
| --- | --- | --- | --- |
| Jardin Principal | jardin_principal.jpg | jardin_principal.mp3 | jardin_principal.mp4 |
| Parroquia | parroquia.jpg | parroquia.mp3 | (sin video) |
| Museo Casa de Hidalgo | museo_hidalgo.jpg | museo_hidalgo.mp3 | (sin video) |

Reglas de las rutas en el codigo:
- `imagenAsset` y `videoAsset` -> con `assets/` al inicio (ej. `assets/images/parroquia.jpg`)
- `audioAsset` -> SIN `assets/` (ej. `audio/parroquia.mp3`)
- Si un lugar no tiene video, deja `videoAsset` en null (o borra esa linea).

# Como correrlo

1. Abre esta carpeta en VS Code.
2. En la terminal: `flutter create . --project-name descubre_dolores`
   (genera android/, ios/, etc.). Si aparece `test/widget_test.dart`, borralo.
3. `flutter pub get`
4. `flutter run`
5. `flutter test`
