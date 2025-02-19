# Green Guard 🌿

A Flutter-based mobile application that helps users identify plant diseases through image recognition and provides expert plant care guidance through an integrated chatbot.

## Features 🚀

### Disease Detection
- Capture or upload images of plant leaves
- Real-time disease detection and analysis
- Comprehensive disease identification
- Health status assessment (Healthy/Diseased)
- Detailed disease information

### Smart Chatbot
- Integrated plant care assistant powered by Google Gemini API
- Get instant answers to plant-related queries
- Receive disease management recommendations
- Access general plant care tips and guidance
- Interactive and context-aware responses
- Chat history persistence using Firebase Firestore

### User Management
- Secure user authentication
- Personal chat history storage
- Cloud-based data synchronization
- Cross-device access to chat history

## Technology Stack 💻

- **Frontend**: Flutter
- **AI/ML**: Custom trained plant disease classification model
- **API Integration**: Google Gemini API for chatbot functionality
- **Model Deployment**: ngrok for model hosting
- **Model Training**: Jupyter Notebook (Available in separate repository)
- **Backend & Authentication**: Firebase Firestore
- **Database**: Cloud Firestore for user data and chat storage

## Installation 🔧

1. Clone the repository:
```bash
git clone https://github.com/rohan-4761/green-guard-flutter-app.git
```

2. Navigate to the project directory:
```bash
cd green-guard-flutter-app
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Model Information 🤖

The plant disease classification model is hosted separately using ngrok. The model training notebook and related files can be found in this repository:
[Plant Disease Classifier Repository](https://github.com/rohan-4761/plant-disease-classifier.git)

## Configuration ⚙️

1. Set up your Google Gemini API key in the appropriate configuration file
2. Update the ngrok endpoint for the disease classification model in the app configuration
3. Configure Firebase:
    - Create a new Firebase project
    - Add your Flutter app to Firebase
    - Download and add google-services.json to the appropriate directory
    - Enable Firebase Authentication and Firestore in Firebase Console
4. Ensure all required permissions are granted (camera, storage)

## Usage 📱

1. **Disease Detection**:
    - Launch the app
    - Select "Camera" or "Upload From Gallery" option
    - Take a picture or choose from gallery
    - Wait for analysis results
    - View detailed disease information if detected

2. **Chatbot Interaction**:
    - Navigate to chat section
    - Type your plant-related query
    - Receive expert guidance and recommendations
    - Ask follow-up questions for clarification
    - Access your chat history across devices

3. **User Account**:
    - Create an account or sign in
    - View and manage your chat history


## Contributing 🤝

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## Acknowledgments 👏

- Google Gemini API for powering the chatbot
- Flutter community for excellent documentation and support

---
Made with ❤️ for plant lovers and gardening enthusiasts