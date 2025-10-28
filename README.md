# Shadow Space 🚀👻

Shadow Space is a cross-platform mobile application built with Flutter where users can share their thoughts and stories anonymously. It also features sections for trending topics and news.

## ✨ Features

* **Anonymous Posting**: Share topics and comments without revealing your identity in the "For You" space.
* **Trending Space**: Discover and discuss current trending topics scraped from the web.
* **News Space**: Stay updated with the latest news articles fetched from NewsAPI.
* **User Authentication**: Secure login and registration using Email/Password or Google Sign-In via Firebase Authentication.
* **Profile Management**: View basic user profile information.
* **Cross-Platform**: Built to run on Android, iOS, Web, Windows, macOS, and Linux.

## 💻 Technologies Used

* **Flutter**: UI toolkit for building natively compiled applications.
* **Dart**: Programming language for Flutter.
* **Firebase**:
    * **Authentication**: For user login and registration.
    * **Cloud Firestore**: NoSQL database for storing user data, topics, and comments.
* **http**: Dart package for making HTTP requests (News API, Trends Scraping).
* **html**: Dart package for parsing HTML (Trends Scraping).
* **NewsAPI**: External API for fetching news articles.
* **Trends24.in**: Website scraped for trending topics.

## 🔧 Prerequisites

* **Flutter SDK**: Ensure you have Flutter installed. Follow the [official Flutter installation guide](https://flutter.dev/docs/get-started/install).
* **Firebase Project**:
    * Set up a Firebase project.
    * Configure Firebase for each platform you intend to build for (Android, iOS, Web, etc.).
    * Place the `google-services.json` file in `android/app/` for Android setup.
    * Follow FlutterFire documentation for other platforms.
* **NewsAPI Key**: Obtain an API key from [NewsAPI](https://newsapi.org/) and replace the placeholder key in `lib/pages/home_page/tab_news/tab_news.dart`.

## ⚙️ Installation & Setup

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/joseeul/shadow-space.git](https://github.com/joseeul/shadow-space.git)
    cd shadow-space
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Configure Firebase:** Follow the prerequisite steps to set up Firebase for your project.
4.  **Add NewsAPI Key:** Insert your NewsAPI key in `lib/pages/home_page/tab_news/tab_news.dart`.
5.  **Run the app:**
    ```bash
    flutter run
    ```

## 📂 Project Structure

```
shadow-space/
├── android/          # Android specific code
├── ios/              # iOS specific code
├── lib/              # Main application code (Dart)
│   ├── assets/       # Fonts and images
│   ├── helper/       # Helper classes (Auth, Firestore, Services)
│   ├── main.dart     # App entry point
│   ├── models/       # Data models
│   └── pages/        # UI Screens/Pages
├── linux/            # Linux specific code
├── macos/            # macOS specific code
├── test/             # Test files
├── web/              # Web specific code
├── windows/          # Windows specific code
├── firebase.json     # Firebase CLI configuration
└── pubspec.yaml      # Project dependencies and metadata
```

## 🚀 Usage Example

1.  Launch the application.
2.  You will be directed to the **Login Page**.
3.  Choose to **Log in** with existing credentials (Email/Password or Google) or **Sign up** for a new account.
4.  After successful login, you'll land on the **Home Page** with three tabs: "For You Space", "Trending Space", and "News Space".
5.  **For You Space**: Tap the '+' button to create and post anonymous topics. View topics posted by others and tap on them to read comments.
6.  **Trending Space**: Browse the list of trending topics. Tap on a topic to view and add comments.
7.  **News Space**: Scroll through the list of news articles. Tap an article to view its details.
8.  Access the **Profile Page** from the top-left icon on the Home Page to view user info or log out.
