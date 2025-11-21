📚 Readify – Personal Reading Companion App

A Flutter + SQLite mobile application

🚀 Overview

Readify is a lightweight mobile reading companion app that helps users track reading progress, manage book categories, write personal notes, and store all data locally using SQLite.
The project follows clean architecture and uses the Provider package for state management to ensure smooth performance and maintainable code structure.

📌 Key Features
✅ Home Page

Displays books across three categories:

Want to Read

Currently Reading

Already Read

Tap any book to open its Detail Page

Add new books through the Add Book Page

✅ Add Book Page

Input fields:

Title

Author

Description

Cover Image URL

Total Pages

Category

Instant preview of the book cover

Save the book directly into the SQLite database

✅ Detail Page

Shows:

Cover image

Author

Description

Reviews section

Buttons:

Continue Reading

Write Notes

✅ Notes Page

Write and save personalized reading notes

Notes are stored in SQLite for persistent access

Easily view or edit notes anytime

✅ Book Management Page

Move books between categories

Delete books

All updates sync with SQLite and the Provider state manager

🛠 Installation & Setup
1. Install Flutter SDK

Download Flutter from:
👉 https://flutter.dev/docs/get-started/install

Add Flutter to your PATH (example for macOS):

export PATH="$PATH:/Users/yourname/flutter/bin"


Check installation:

flutter doctor

2. Install VS Code Extensions

In VS Code → Extensions (Ctrl + Shift + X)
Install:

Flutter

Dart

These provide:
✔ Flutter commands
✔ Code completion
✔ Device selection
✔ Hot reload

3. Create a New Flutter Project
Option A — Using VS Code

Press Ctrl + Shift + P

Search Flutter: New Project

Select Application

Choose a folder

Enter project name

Option B — Using Terminal
flutter create readify_app
cd readify_app
code .

4. Run the Project

VS Code: Press F5

Or terminal:

flutter run

📦 Clone This Repository
git clone https://github.com/yourusername/readify.git
cd readify
flutter pub get
flutter run

📚 Required Dependencies

Make sure your pubspec.yaml includes:

dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5
  sqflite: ^2.0.0+4
  path_provider: ^2.0.12


Install dependencies:

flutter pub get

🍎 iOS Configuration (for network images)

Add this to ios/Runner/Info.plist:

<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>

💾 Database (SQLite Schema)

SQLite table structure:

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

AI-powered reading summaries

Book recommendations

👥 Team Members

Yimeg Chen — 6688176

Zirui Zhu — 6688183
