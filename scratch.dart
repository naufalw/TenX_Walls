import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

main() {
  final options = CacheOptions(
    store: HiveCacheStore(),
    policy: CachePolicy
        .request, // Default. Checks cache freshness, requests otherwise and caches response.
    hitCacheOnErrorExcept: [
      401,
      403
    ], // Optional. Returns a cached response on error if available but for statuses 401 & 403.
    priority: CachePriority
        .normal, // Optional. Default. Allows 3 cache sets and ease cleanup.
    maxStale: const Duration(
        days:
            7), // Very optional. Overrides any HTTP directive to delete entry past this duration.
  );
}
