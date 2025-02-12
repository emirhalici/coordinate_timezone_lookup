# Coordinate Timezone Lookup

A lightweight timezone lookup library for Dart. Applies lossy compression, accuracy is naturally lower than other other implementations. 

This is mostly a Dart port of currently archived [tz-lookup-oss](https://github.com/darkskyapp/tz-lookup-oss). 

Usage
-------

```dart
final String timezone = timezoneLookup(lat: 49.7176, -120.652110);
print(timezone) # America/Vancouver
```

Sources
-------
Timezone data is sourced from Evan Siroky's [timezone-boundary-builder][tbb]. Urban areas data is sourced from [Natural Earth Vector][nev].


To regenerate the library's data yourself, you will need to install GDAL:

```
$ brew install gdal # on Mac OS X
$ sudo apt install gdal-bin # on Ubuntu
```

Then, simply execute `rebuild.sh` under `tool` directory. Expect it to take 2-15 minutes, depending on your network connection and CPU. 

[tbb]: https://github.com/evansiroky/timezone-boundary-builder/
[nev]: https://github.com/nvkelso/natural-earth-vector/