#!/bin/bash
set -ex
TZ="2025a"

# Remove the dist directory if it exists, then recreate it
rm -rf dist
mkdir -p dist

# Download files into dist directory
curl -L --retry 3 -C - \
  -o "dist/timezones.geojson.zip" \
  -o "dist/ne_10m_urban_areas.shp" \
  -o "dist/ne_10m_urban_areas.shx" \
  "https://github.com/evansiroky/timezone-boundary-builder/releases/download/$TZ/timezones.geojson.zip" \
  "https://github.com/nvkelso/natural-earth-vector/raw/refs/heads/master/10m_cultural/ne_10m_urban_areas.shp" \
  "https://github.com/nvkelso/natural-earth-vector/raw/refs/heads/master/10m_cultural/ne_10m_urban_areas.shx"

# Unzip in dist directory
unzip dist/timezones.geojson.zip -d dist

# Convert shapefile to GeoJSON in dist directory
ogr2ogr -f GeoJSON dist/ne_10m_urban_areas.json dist/ne_10m_urban_areas.shp

# Run the Node.js script, storing the output in dist
node pack.js