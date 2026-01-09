# Wallpaper App

A Flutter application that fetches and displays wallpapers from the Pexels API with the ability to set them as device wallpapers.

## Features

- **Wallpaper Discovery & Search**: Browse curated wallpapers and search by categories (Nature, Women, Animals, Architecture, Food)
- **3-Column Grid Display**: View wallpapers in a responsive 3-column grid with 2/3 aspect ratio
- **Pagination**: Load more wallpapers using the "Load More" button
- **Full-Screen Preview**: View full-resolution images in full-screen mode
- **Set as Wallpaper**: Set any wallpaper as your device's home screen background
- **Dark Theme**: Modern dark UI for comfortable viewing

## Technical Stack

- **Framework**: Flutter
- **API**: Pexels API
- **Dependencies**:
  - `http` - For API requests
  - `cached_network_image` - For optimized image loading
  - `wallpaper` - For setting device wallpapers

## Setup Instructions

### 1. Prerequisites
- Flutter SDK installed (v3.0.0 or higher)
- Pexels API Key (register at https://www.pexels.com/api/)

### 2. Get Pexels API Key
1. Go to https://www.pexels.com/api/
2. Create a new application
3. Copy your API key

### 3. Update API Key
Open `lib/services/pexels_service.dart` and replace:
```dart
static const String apiKey = 'YOUR_PEXELS_API_KEY_HERE';
```
with your actual API key.

### 4. Install Dependencies
```bash
flutter pub get
```

### 5. Run the App
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                          # App entry point with dark theme
├── models/
│   └── wallpaper_model.dart          # Data models (Photo, ImageSources, WallpaperResponse)
├── services/
│   └── pexels_service.dart           # API service for Pexels integration
└── screens/
    ├── home_screen.dart              # Main grid and search interface
    └── wallpaper_detail_screen.dart  # Full-screen preview and set wallpaper
```

## API Integration Details

### Endpoints Used
- **Curated Wallpapers**: `https://api.pexels.com/v1/curated`
- **Search**: `https://api.pexels.com/v1/search?query={category}`

### Request Parameters
- `per_page`: 80 (maximum images per request)
- `Authorization`: API key in header

### Image Resolutions
- **Grid View**: Uses "Medium" resolution for fast loading
- **Full-Screen**: Uses "Original" resolution for best quality
- **Set Wallpaper**: Uses "Large2x" resolution for sharp background

## Key Features Implementation

### 1. State Management
Uses `StatefulWidget` with `initState()` to load initial wallpapers:
```dart
@override
void initState() {
  super.initState();
  _loadCuratedWallpapers();
}
```

### 2. JSON Parsing
Uses `jsonDecode()` to parse API responses:
```dart
final Map<String, dynamic> jsonData = jsonDecode(response.body);
return WallpaperResponse.fromJson(jsonData);
```

### 3. Pagination
Implements pagination using `next_page` URL from API response:
```dart
Future<void> _loadMore() async {
  if (_nextPageUrl == null) return;
  final response = await PexelsService.fetchNextPage(
    nextPageUrl: _nextPageUrl!,
  );
  setState(() {
    _photos.addAll(response.photos);
    _nextPageUrl = response.nextPage;
  });
}
```

### 4. Image Optimization
- Grid uses cached network images with 400x600 resolution
- Full-screen uses original resolution
- Set wallpaper uses Large2x resolution (2x size)

## Usage

1. **Browse Wallpapers**: Scroll through the main grid
2. **Search by Category**: Tap the search icon to see category options
3. **Custom Search**: Type in the search bar for custom queries
4. **View Full-Screen**: Tap any wallpaper to view in full-screen
5. **Set Wallpaper**: Tap "Set as Wallpaper" button to apply as device background

## Permissions (Android)

For setting wallpapers on Android, the app requires:
- `SET_WALLPAPER` permission (automatically handled by wallpaper package)

## API Rate Limits

- Pexels API provides 200 requests per hour
- Each request can fetch up to 80 images

## Troubleshooting

### API Key Error
Ensure your API key is correctly set in `pexels_service.dart`

### Images Not Loading
- Check internet connection
- Verify API key is valid
- Check Pexels API status

### Wallpaper Not Setting
- Ensure app has SET_WALLPAPER permission
- Try restarting the app
- Check available device storage

## Future Enhancements

- Add favorite/bookmark functionality
- Implement local caching
- Add more search filters (color, size, etc.)
- Support for live wallpapers
- Sharing functionality
