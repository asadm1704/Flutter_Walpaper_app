class Photo {
  final int id;
  final String photographer;
  final String photographerUrl;
  final String photographerId;
  final String avgColor;
  final String url;
  final ImageSources src;
  final bool liked;

  Photo({
    required this.id,
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.avgColor,
    required this.url,
    required this.src,
    required this.liked,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] ?? 0,
      photographer: json['photographer'] ?? 'Unknown',
      photographerUrl: json['photographer_url'] ?? '',
      photographerId: json['photographer_id']?.toString() ?? '0',
      avgColor: json['avg_color'] ?? '#000000',
      url: json['url'] ?? '',
      src: ImageSources.fromJson(json['src'] ?? {}),
      liked: json['liked'] ?? false,
    );
  }
}

class ImageSources {
  final String original;
  final String large2x;
  final String large;
  final String medium;
  final String small;
  final String portrait;
  final String landscape;
  final String tiny;

  ImageSources({
    required this.original,
    required this.large2x,
    required this.large,
    required this.medium,
    required this.small,
    required this.portrait,
    required this.landscape,
    required this.tiny,
  });

  factory ImageSources.fromJson(Map<String, dynamic> json) {
    return ImageSources(
      original: json['original'] ?? '',
      large2x: json['large2x'] ?? '',
      large: json['large'] ?? '',
      medium: json['medium'] ?? '',
      small: json['small'] ?? '',
      portrait: json['portrait'] ?? '',
      landscape: json['landscape'] ?? '',
      tiny: json['tiny'] ?? '',
    );
  }
}

class WallpaperResponse {
  final int page;
  final int perPage;
  final List<Photo> photos;
  final String? nextPage;

  WallpaperResponse({
    required this.page,
    required this.perPage,
    required this.photos,
    this.nextPage,
  });

  factory WallpaperResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> photosJson = json['photos'] ?? [];
    return WallpaperResponse(
      page: json['page'] ?? 1,
      perPage: json['per_page'] ?? 15,
      photos: photosJson.map((p) => Photo.fromJson(p as Map<String, dynamic>)).toList(),
      nextPage: json['next_page'],
    );
  }
}
