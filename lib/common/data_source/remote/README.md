# How to use

## Default stale time --> 7 days

    final dio = await ref.read(dioClientProvider.future);

    final response = await dio.get(
        your URL,
    );

## Custom time

    final dio = await ref.read(dioClientProvider.future);

    final response = await dio.get(
        your URL,
        options: (await getCacheOptions()).copyWith(maxStale: const Duration(hours: 3)).toOptions(),
    );
