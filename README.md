1. GEnerate GEOJSON
-

2. Upload GeoJSON to Mapbox:
- Endpoint: POST / uploads / v1 /: owner
- Description: Use the Mapbox Uploads API to upload your GeoJSON file.

2. Create a Tileset Source:
- Endpoint: POST / tilesets / v1 /: owner / sources
- Description: Create a Tileset Source from the uploaded GeoJSON data.

3. Define a Recipe:
- Manual Step: Create a JSON file(e.g., recipe.json) that defines how to extract properties and styles from the GeoJSON features.

4. Apply Recipe to Tileset Source:
- Endpoint: POST / tilesets / v1 /: owner /: source_id / recipes
- Description: Apply the recipe to the Tileset Source.

5. Publish the Tileset:
- Endpoint: POST / tilesets / v1 /: owner /: tileset_id / publish
- Description: Publish the Tileset to make it available for use.
```zsh
 curl -X POST "https://api.mapbox.com/tilesets/v1/sources/dedemenezes/hello-world?access_token=YOUR_MAPBOX_ACCESS_TOKEN" \
    -F file=@/Users/username/data/mts/countries.geojson.ld \
    --header "Content-Type: multipart/form-data"
```
