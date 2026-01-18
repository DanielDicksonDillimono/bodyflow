# AI Workout Generation Setup

This application uses Google's Gemini AI to generate personalized workouts and training schedules.

## Setup Instructions

1. **Get a Gemini API Key**
   - Visit [Google AI Studio](https://aistudio.google.com/app/apikey)
   - Sign in with your Google account
   - Click "Create API Key"
   - Copy the generated API key

2. **Configure the API Key**
   ```bash
   # Copy the template file
   cp lib/data/services/ai_config.dart.template lib/data/services/ai_config.dart
   ```

3. **Add Your API Key**
   - Open `lib/data/services/ai_config.dart`
   - Replace `'YOUR_API_KEY_HERE'` with your actual API key
   - Save the file

4. **Run the Application**
   ```bash
   flutter pub get
   flutter run
   ```

## Features

### Workout Generation
- Generate single workout sessions based on:
  - Target body parts (full body, upper body, lower body, arms, legs, back, chest, shoulders, core)
  - Session duration (in minutes)
- Receive AI-generated exercises with sets, reps, and instructions

### Schedule Generation
- Create weekly training schedules with:
  - Multiple training days selection
  - Body part split across the week
  - Balanced workout distribution
- Each day includes a complete workout plan

## Security Note

⚠️ **Important**: The `ai_config.dart` file is gitignored to protect your API key from being committed to version control. Never share your API key publicly.

## Troubleshooting

- **"AI Service Not Available" error**: Make sure you've configured your API key correctly
- **Generation fails**: Check your internet connection and verify your API key is valid
- **No exercises generated**: Try selecting different body parts or adjusting the duration

## API Usage

The free tier of Gemini API includes:
- 15 requests per minute
- 1,500 requests per day
- 1 million tokens per minute

This should be more than sufficient for personal use of the app.
