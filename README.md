# cache_box

an observable box to be used as a persistent proxy

## Usage

A simple usage example:

```dart
import 'package:cache_box/cache_box.dart';

main() async{
  var cache = await CacheBox.opem('api_data');
  
  // get data stream
  var data = cache.get(); 
  
  // use data from stream...
  
  // ...
  cahce.put('key','data');
}
```