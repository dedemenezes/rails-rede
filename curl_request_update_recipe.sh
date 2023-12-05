#!/bin/bash

# Define an array of strings
strings=("dedemenezes.araruama_final")

# Function to make GET and POST requests for a given string
make_requests() {
  local value="$1"

  # Make GET request
  echo "Making POST request for $value [UPDATE RECIPE]"
  curl -X PATCH "https://api.mapbox.com/tilesets/v1/$value/recipe?access_token=sk.eyJ1IjoiZGVkZW1lbmV6ZXMiLCJhIjoiY2xvNm83dWFnMGt2NTJ0bXk3c3Jhc3h1aiJ9.YaoZwa01ybMBDhD3TbX9sQ" \
  -d @/home/dedefla/code/dedemenezes/projects/rails-rede/recipe.json \
  --header "Content-Type:application/json"

  # Make POST request
  echo "Making POST request for $value [PUBLISH RECIPE]"
  curl -X POST "https://api.mapbox.com/tilesets/v1/$value/publish?access_token=sk.eyJ1IjoiZGVkZW1lbmV6ZXMiLCJhIjoiY2xvNm83dWFnMGt2NTJ0bXk3c3Jhc3h1aiJ9.YaoZwa01ybMBDhD3TbX9sQ"
}

# Iterate over the array and make requests
for string in "${strings[@]}"; do
  make_requests "$string"
done
