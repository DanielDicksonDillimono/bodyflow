# bodyflow
<img width="393" height="862" alt="BodFlow - Workout page" src="https://github.com/user-attachments/assets/c50e0345-c91b-42fc-a0b2-315dd2138db8" /><img width="393" height="862" alt="BodFlow - Generator" src="https://github.com/user-attachments/assets/8a267573-9592-4b2b-8fd5-352c351dc415" /><img width="393" height="862" alt="BodFlow - workout Schedule" src="https://github.com/user-attachments/assets/9e987b2c-91c9-4604-8414-42c17bb827a2" />



Create time-efficient workout plans with AI-powered generation.

## Features

- **AI-Powered Workout Generation**: Generate personalized workout sessions based on target body parts and duration
- **Weekly Schedule Creation**: Create balanced training schedules across multiple days
- **Firebase Integration**: User authentication and data persistence
- **Modern UI**: Clean, intuitive interface for workout planning

## Getting Started

### Prerequisites

- Flutter SDK (^3.8.1)
- Firebase account for authentication

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/DanielDicksonDillimono/bodyflow.git
   cd bodyflow
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure AI Workout Generation**
   
   See [AI_SETUP.md](AI_SETUP.md) for detailed instructions on setting up the Gemini AI integration.
   
   Quick steps:
   ```bash
   cp lib/data/services/ai_config.dart.template lib/data/services/ai_config.dart
   # Edit ai_config.dart and add your Gemini API key
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

## Project Structure

- `lib/data/` - Data layer (services, database)
- `lib/domain/` - Domain models and business logic
- `lib/ui/` - User interface components
- `lib/navigation/` - App routing and navigation

## AI Workout Generation

The app uses Google's Gemini AI model to generate:
- Custom workout sessions with exercises, sets, and reps
- Weekly training schedules with balanced splits
- Personalized exercise instructions

For more information, see [AI_SETUP.md](AI_SETUP.md).

## Resources

For help getting started with Flutter development:

- [Flutter online documentation](https://docs.flutter.dev/)
