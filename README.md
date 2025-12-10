# GIF Search App

A Flutter mobile application for searching and viewing GIFs using the Giphy API. Built as a test task for the Junior Mobile Developer position at Chili Labs.

## About

This app allows users to search for GIFs from Giphy's extensive library with an intuitive and responsive interface. The app features automatic search with debouncing, infinite scroll pagination, and works seamlessly in both portrait and landscape orientations.

## Technical Details

**Flutter Version**: 3.38.4
**Dart Version**: 3.10.3
**Channel**: Stable

## Features Implemented

### Core Requirements
- **Auto-search with debouncing**: Search requests are made automatically 500ms after the user stops typing
- **Grid display**: GIFs are displayed in a responsive grid layout (2 columns in portrait, 4 in landscape)
- **Pagination**: Automatic loading of more results when scrolling to the bottom
- **Detail view**: Tap any GIF to view it in full screen with title information
- **Orientation support**: Fully responsive layout that adapts to portrait and landscape modes
- **Error handling**: User-friendly error messages for network failures and API errors
- **Loading indicators**: Visual feedback during search and pagination
- **Unit tests**: Tests for data models and JSON parsing

### Bonus Features
- **Network availability checking**: Uses connectivity_plus to detect and handle no internet scenarios
- **Modern UI design**: Material Design with elevation, rounded corners, and consistent theming
- **Clean architecture**: Organized code structure with separate models, services, screens, and widgets

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── gif_model.dart       # GIF data model
├── services/
│   └── giphy_service.dart   # Giphy API integration
├── screens/
│   ├── search_screen.dart   # Main search screen
│   └── detail_screen.dart   # GIF detail screen


test/
└── gif_model_test.dart      # Unit tests
```

## Getting Started

### Prerequisites

- Flutter SDK 3.38.4 or higher
- Dart SDK 3.10.3 or higher
- Android Studio / Xcode (for emulators)
- A Giphy API key (free from https://developers.giphy.com/)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/edijsl/GIF_SEARCH_APP_FLUTTER.git
   cd gif_search_app
   ```

2. **Install dependencies**
   bash
   flutter pub get
   ```

3. **Set up Giphy API Key**

   Create a `.env` file in the project root:
   ```
   GIPHY_API_KEY=your_api_key_here
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Running Tests

```bash
flutter test
```

## Dependencies

- **http** (^1.1.0): For making API requests to Giphy
- **flutter_dotenv** (^5.1.0): For managing API keys securely
- **connectivity_plus** (^6.0.0): For checking network availability

## How It Works

1. **Search**: Type in the search bar - the app automatically searches after you stop typing (500ms delay)
2. **Browse**: Scroll through the grid of GIF results
3. **Load More**: Scroll to the bottom to automatically load more GIFs
4. **View Details**: Tap any GIF to see it larger with its title
5. **Navigate**: Use the back button to return to search results

## Testing Coverage

- GIF model JSON parsing
- Handling of empty/null data
- List creation from JSON arrays

## Design Decisions

- **Debouncing**: Implemented with a 500ms delay to reduce unnecessary API calls and improve performance
- **Card elevation**: Used Material Design cards with shadows to create visual depth
- **Color scheme**: Deep purple theme for a modern, professional appearance
- **Centered layout**: Detail screen centers content for better viewing experience in landscape mode
- **Simple state management**: Used setState() for straightforward state management suitable for the app's scope

## Challenges & Solutions

1. **Network connectivity**: Integrated connectivity_plus package to handle offline scenarios gracefully
2. **Responsive design**: Used MediaQuery and GridView to adapt layout for different orientations
3. **Pagination UX**: Implemented separate loading states (initial load vs. loading more) for better user experience
4. **Image display**: Used BoxFit.contain to ensure GIFs display properly without distortion

## Notes

- The app uses Giphy's free API tier which has rate limits
- API key is stored in .env file and should never be committed to version control
- The app is optimized for Android and iOS platforms
- All code was written with learning and understanding as the primary goal

## Contact

For any questions about this project, please contact via the email provided with the application.