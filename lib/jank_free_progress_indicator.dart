library;

export 'src/io/jank_free_linear_progress_indicator.dart'
    if (dart.library.html) 'src/html/jank_free_linear_progress_indicator.dart';
export 'src/io/jank_free_progress_indicator.dart' if (dart.library.html) 'src/html/jank_free_progress_indicator.dart';
