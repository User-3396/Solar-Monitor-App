## main.dart

```dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const supabaseUrl = 'https://dnhyfsmusrjumyipabxz.supabase.co';
  const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRuaHlmc211c3JqdW15aXBhYnh6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUzODM5NDgsImV4cCI6MjA4MDk1OTk0OH0.svqoO7eJDEtb7iy16yVdrYCZ00MC9KeQpZUx8cVbYTw';

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {...}
```

