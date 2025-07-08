# Movie App 🎬

A modern iOS movie application built with Swift that displays popular movies using The Movie Database (TMDb) API. The app features a clean, user-friendly interface with movie discovery, detailed movie information, and favorite functionality.

## Screenshots

<div align="center">
  <img src="Simulator Screenshot - iPhone 16 Pro Max - 2025-07-09 at 00.32.15.png" width="300" alt="Popular Movies Screen">
  <img src="Simulator Screenshot - iPhone 16 Pro Max - 2025-07-09 at 00.32.58.png" width="300" alt="Movie Details Screen">
</div>

## Features

- 🎭 **Popular Movies**: Browse through a curated list of popular movies
- ⭐ **Movie Ratings**: View IMDb ratings and user scores
- ❤️ **Favorites**: Mark movies as favorites with a heart icon
- 📱 **Responsive Design**: Optimized for iPhone with modern UI/UX
- 🖼️ **High-Quality Images**: Display movie posters and backdrops
- 📋 **Movie Details**: Comprehensive movie information including synopsis, release date, and ratings

## Architecture

The app follows a clean architecture pattern with the following layers:

```
📁 Core/
├── AppRouter.swift          # Navigation and routing
├── BaseViewController.swift # Base view controller class
├── LocalHelper/            # Local data persistence
├── NetworkHelper/          # API communication
└── Utils/                  # Utility classes and endpoints

📁 Models/
└── MovieNowPlayingResponseModel.swift  # Data models

📁 ViewModels/
└── MoviesViewModel.swift    # Business logic and data management

📁 Views/
├── Main/                   # Main movie listing screen
└── Details/                # Movie details screen

📁 UIComponents/
└── MovieCardView/          # Reusable movie card component

📁 Repositories/
└── MovieRepository.swift   # Data layer abstraction

📁 Datasources/
├── Local/                  # Local data management
└── Remote/                 # API data management
```

## Requirements

### System Requirements

- **iOS**: 15.6 or later
- **Xcode**: 14.0 or later
- **Swift**: 5.0 or later

### Dependencies

- [SDWebImage](https://github.com/SDWebImage/SDWebImage) (5.21.1) - For efficient image loading and caching

## Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/omar0141/Tea-Computes-Movie-App.git
   cd movie-app
   ```

2. **Open the project in Xcode**

   ```bash
   open movie-app.xcodeproj
   ```

3. **Install dependencies**
   The project uses Swift Package Manager. Dependencies should be automatically resolved when you open the project. If not, go to:

   - File → Add Package Dependencies
   - Add: `https://github.com/SDWebImage/SDWebImage.git`

4. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run the app

## Project Structure

### Key Files

- **`AppDelegate.swift`** - App lifecycle management
- **`SceneDelegate.swift`** - Scene-based app lifecycle (iOS 13+)
- **`MainViewController.swift`** - Main screen displaying popular movies
- **`DetailsViewController.swift`** - Movie details screen
- **`MoviesViewModel.swift`** - Handles business logic and data management
- **`MovieRepository.swift`** - Data layer abstraction
- **`ApiEndPoints.swift`** - API endpoints and configuration

### Data Flow

1. **ViewModel** requests data from **Repository**
2. **Repository** coordinates between **Remote** and **Local** data sources
3. **Remote DataSource** fetches data from TMDb API
4. **Local DataSource** handles favorites and offline storage
5. **View Controllers** observe ViewModel updates via Combine

## API Integration

The app integrates with The Movie Database (TMDb) API:

- **Base URL**: `https://api.themoviedb.org/3`
- **Endpoints Used**:
  - `/movie/now_playing` - Popular movies
  - **Image Base URL**: `https://image.tmdb.org/t/p/w500`

## Features in Detail

### Movie Cards

- High-quality movie posters
- Movie titles and ratings
- Favorite toggle functionality
- Smooth scrolling with collection view

### Movie Details

- Full movie backdrop images
- Detailed synopsis
- Release date information
- User ratings and scores
- Favorite functionality

### Favorites System

- Local storage of favorite movies
- Persistent across app launches
- Toggle favorites from both main and detail screens

## Development

### Building from Source

1. Ensure you have Xcode 14.0 or later installed
2. Clone the repository
3. Open `movie-app.xcodeproj`
4. Build and run on your preferred simulator or device

### Testing

The app includes comprehensive testing for:

- Network layer functionality
- Data persistence
- ViewModel business logic
- UI components

Run tests with `Cmd + U` in Xcode.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [The Movie Database (TMDb)](https://www.themoviedb.org/) for providing the movie data API
- [SDWebImage](https://github.com/SDWebImage/SDWebImage) for efficient image loading
- Design inspiration from modern movie streaming applications


Project Link: [https://github.com/yourusername/movie-app](https://github.com/yourusername/movie-app)

---

⭐ If you found this project helpful, please give it a star!
