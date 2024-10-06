# RideSense

RideSense is a location-based Flutter application that utilizes Google Places API to provide users with an autocomplete feature for location input. This project is designed to help users easily search and select locations in real-time.

## Features

- Location autocomplete using Google Places API
- Real-time suggestions as you type
- Location selection using `ListView.builder`
- Clean and modern UI for seamless user experience

## Screenshots

![pic7](https://github.com/user-attachments/assets/4e1690f7-88bd-41c8-b0bd-c619123dfa6a)
![pic6](https://github.com/user-attachments/assets/6505a214-f013-44f9-b21c-f79fcbb34795)
![pic5](https://github.com/user-attachments/assets/d28fa1e4-4aa0-40f8-8e1f-51c1cc9a301a)
![pic3](https://github.com/user-attachments/assets/ae397829-58db-4b61-983f-b415ff61e38f)
![pic4](https://github.com/user-attachments/assets/11693bc5-93a7-431c-986f-c6ae892e80f6)
![pic1](https://github.com/user-attachments/assets/1aa71b63-a935-47c3-bdc8-3c8a4cecd9da)
![pic2](https://github.com/user-attachments/assets/ab09faff-050e-4c05-b3fb-4e2cb6b2b9fc)


## Getting Started

### Prerequisites

- Flutter SDK (v3.0.0 or above)
- Dart SDK (v2.17.0 or above)
- IDE (Visual Studio Code, Android Studio, or IntelliJ IDEA)
- Google Places API Key

### Installation

1. **Clone the repository**:
   - Run the following commands to clone the repository and navigate to the project directory:
     ```bash
     git clone https://github.com/yourusername/ridesense.git
     cd ridesense
     ```

2. **Install dependencies**:
   - Run `flutter pub get` to install all necessary Flutter packages and dependencies.

3. **Set up Google Places API**:
   - Go to [Google Cloud Console](https://console.cloud.google.com/).
   - Create a new project in Google Cloud.
   - Enable the **Places API** for the project.
   - Generate an API key for the Places API.
   - Add your API key to the following files:
     - For **Android**: Add the API key in the `android/app/src/main/AndroidManifest.xml` file:
       ```xml
       <meta-data
           android:name="com.google.android.geo.API_KEY"
           android:value="YOUR_API_KEY" />
       ```
     - For **iOS**: Add the API key in the `ios/Runner/Info.plist` file:
       ```xml
       <key>GMSApiKey</key>
       <string>YOUR_API_KEY</string>
       ```

4. **Run the app**:
   - Connect an Android or iOS device or use an emulator.
   - Run the app using the following command:
     ```bash
     flutter run
     ```
