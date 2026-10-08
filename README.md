# LearningDashboard

LearningDashboard is a simple iOS application built using **Swift, SwiftUI, MVVM, and Clean Architecture**.

Users can log in, view courses, open course details, complete lessons, and track their progress. Course progress is saved locally and remains available after the app is closed and reopened.

## Features

- Mock login with basic validation
- Course dashboard
- Course details with lesson list
- Mark lessons as completed
- Automatic progress calculation
- Loading, empty and error states
- Offline/local caching
- Progress persistence after app relaunch
- Unit testing

## Architecture

The project follows **MVVM with Clean Architecture principles**.

```text
SwiftUI View
     ↓
ViewModel
     ↓
Use Case
     ↓
Repository Protocol
     ↓
Repository
   ↙       ↘
Data Source  Cache
```

### Layers

**Presentation**
- Login
- Dashboard
- Course Details
- ViewModels

**Domain**
- Course
- Lesson
- Repository Protocol
- Use Cases

**Data**
- APIClient
- CourseRepository
- CourseCache

## Project Structure

```text
LearningDashboard
├── App
├── Domain
│   ├── Models
│   ├── Repositories
│   └── UseCases
├── Data
│   ├── Network
│   ├── Local
│   └── Repositories
├── Presentation
│   ├── Login
│   ├── Dashboard
│   └── CourseDetails
└── Resources
    └── courses.json
```

## Setup

1. Clone the repository.
2. Open `LearningDashboard.xcodeproj` in Xcode.
3. Select an iOS simulator.
4. Press **⌘ + R** to run.

Example login:

```text
Email: test@gmail.com
Password: 123456
```

Authentication is mocked, so any valid email and password of at least 6 characters can be used.

## Offline Persistence

`courses.json` provides the initial course data.

On the first load, course data is saved locally. After that, cached data is used so completed lessons and course progress are preserved.

Example:

```text
2 / 4 lessons completed = 50%

Complete another lesson

3 / 4 lessons completed = 75%
```

The updated 75% progress remains after closing and reopening the app.

## Testing

The project uses **Swift Testing**.

The unit test verifies that completing a lesson:

- Marks the lesson as completed
- Recalculates course progress
- Saves the updated progress

Run tests using:

```text
⌘ + U
```

## Security

Authentication is mocked for this assignment.

In a production application:

- Authentication tokens would be stored in Keychain.
- API communication would use HTTPS.
- Sensitive information would not be stored in UserDefaults.
- Secrets would not be committed to the repository.

## Assumptions

- Login is mocked.
- `courses.json` acts as the initial data source.
- Course progress is calculated from completed lessons.
- Completed lessons cannot be marked incomplete.
- Cached data stores the user's progress.

## Limitations

- No real backend API.
- No real authentication.
- No cloud synchronization.
- JSON file-based caching is used instead of a database.
- Limited unit test coverage.

## Future Improvements

- Connect to a real REST API.
- Add Keychain-based authentication.
- Use SwiftData/Core Data for larger datasets.
- Sync course progress with a backend.
- Add more unit and UI tests.
- Improve accessibility and error handling.

## Tech Stack

- Swift
- SwiftUI
- MVVM
- Clean Architecture
- async/await
- Codable
- Swift Testing
