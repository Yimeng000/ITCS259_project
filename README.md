Readify – Personal Reading Companion App

A Flutter + SQLite mobile application

🚀 Overview

Readify is a lightweight mobile reading companion app designed to help users track their reading progress, manage book categories, write personal notes, and store all data locally using SQLite.
The project follows clean architecture and Provider-based state management, ensuring smooth and responsive user experience.

📌 Key Features
✅ Home Page
Displays books across three categories:
Want to Read
Currently Reading
Already Read
Tap any book to open the Detail Page
Add new books through the Add Book Page

✅ Add Book Page
Input:
Title
Author
Description
Cover Image URL
Total pages
Category
Preview cover image instantly
Save book to SQLite database

✅ Detail Page
Displays:
Cover image
Author
Description
Reviews section

Buttons:
Continue Reading
Write Notes

✅ Notes Page
Write and save reading notes
Data stored in SQLite for persistent access

✅ Book Management Page
Move books between categories
Delete books
Fully synced with SQLite and Provider

🗂️ Project Structure
![Uploading image.png…]()


🛠 Installation & Setup Instructions
1. Clone the repository
git clone https://github.com/yourusername/readify.git
cd readify

2. Install Flutter dependencies
flutter pub get

3. Run on Android Studio / Emulator
flutter run

4. Required Dependencies (Already in pubspec.yaml)

Your project should include:

dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5
  sqflite: ^2.0.0+4
  path_provider: ^2.0.12


If missing, add them and re-run:
flutter pub get

5. iOS devices: Enable network images

Add this to ios/Runner/Info.plist:

<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>


This enables loading images through Image.network().

💾 Database (SQLite)

The SQLite table stores all book fields:

CREATE TABLE books (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  author TEXT,
  coverUrl TEXT,
  description TEXT,
  totalPages INTEGER,
  currentPage INTEGER,
  category TEXT,
  rating REAL,
  notes TEXT
);

🌟 Future Improvements
Cloud sync
User accounts
Dark mode
AI reading summary
Book recommendations

🙌 Team Members 
Yimeg Chen 6688176
Zirui Zhu 6688183

