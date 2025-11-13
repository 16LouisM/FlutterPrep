💰 Expense Tracker Web App (Alpha Version)

A simple Flutter Web application that helps users track and visualize their daily expenses.
Built as a collaborative project using Firebase for authentication and data storage.
This version is an alpha release — functional but still under refinement.

🚀 Overview

The Expense Tracker Web App allows users to:

Create an account or sign in using Firebase Authentication.

Add, view, and manage expenses in real time using Firebase Firestore.

View a dashboard summarizing total spending.

Access data across devices via secure cloud storage.

This alpha version establishes a full-stack foundation with real-time backend connections and a basic, responsive frontend. Future versions will focus on UI improvements, analytics, and advanced features.

🧠 Key Features (Alpha)

| Feature                   | Description                                                   |
| ------------------------- | ------------------------------------------------------------- |
| **User Authentication**   | Firebase-powered sign up, sign in, and sign out.              |
| **Expense Management**    | Add and list expenses with title, amount, category, and date. |
| **Dashboard Overview**    | Displays all expenses in real time with total spent.          |
| **Firestore Integration** | Persistent cloud-based storage for all user data.             |
| **Real-Time Updates**     | Uses Firestore streams to auto-refresh dashboard data.        |
| **Responsive Web UI**     | Runs seamlessly in the browser with Flutter Web.              |

🧩 Tech Stack

| Area                 | Technology                      |
| -------------------- | ------------------------------- |
| **Frontend**         | Flutter (Web)                   |
| **Backend**          | Firebase (Auth, Firestore)      |
| **Language**         | Dart                            |
| **IDE**              | Visual Studio Code              |
| **Version Control**  | Git + GitHub                    |
| **State Management** | Provider (basic implementation) |

🧱 Project Structure

lib/
│
├── main.dart                      # App entry point + Firebase initialization
│
├── firebase_options.dart           # Auto-generated Firebase configuration
│
├── models/
│   └── expense_model.dart          # Expense data model
│
├── services/
│   ├── auth_service.dart           # Handles Firebase authentication logic
│   └── database_service.dart       # Handles Firestore CRUD operations
│
├── pages/
│   ├── login_page.dart             # Login and sign-up screen
│   ├── dashboard_page.dart         # Expense dashboard
│   └── add_expense_page.dart       # Add new expense form
│
└── widgets/
    └── expense_tile.dart           # UI component to display each expense

🧑‍💻 Team & Task Assignments

| Member       | Responsibilities                                                                                   |
| ------------ | -------------------------------------------------------------------------------------------------- |
| **Member A** | UI/UX design, page navigation, frontend layouts, visual polish, and user interactions.             |
| **Member B** | Firebase integration, authentication, database CRUD operations, and frontend–backend data linking. |

Both members collaborated on testing, debugging, and version control using GitHub.

⚙️ Setup Instructions
1️⃣ Clone the Repository

git clone https://github.com/<your-repo>/expense_tracker_alpha.git
cd expense_tracker_alpha

2️⃣ Install Dependencies

flutter pub get

3️⃣ Configure Firebase

Run the FlutterFire CLI to link your Firebase project:

dart pub global activate flutterfire_cli
flutterfire configure

This will generate:

lib/firebase_options.dart

4️⃣ Run the App (Web)

flutter run -d chrome

📦 Firebase Configuration

Make sure you’ve enabled the following in your Firebase Console:

Authentication → Email/Password Sign-in

Cloud Firestore → Start in test mode (for alpha)

Hosting (optional) if deploying the web app

🧮 Data Model

Collection: expenses
Document fields:

{
  "title": "Lunch",
  "amount": 12.50,
  "category": "Food",
  "date": "2025-11-13T10:00:00Z",
  "userId": "firebaseUserUid"
}

🧠 Known Limitations (Alpha)

This is an early-stage release focused on functionality over polish.
Current limitations include:

Minimal UI styling (default Flutter components).

No data filtering or category breakdowns yet.

Limited error handling and form validation.

No analytics or charts.

No profile page or settings.

These issues will be addressed in the Beta release.

🔮 Planned Enhancements

📊 Category filtering and chart visualization (Pie/Bar charts).

📆 Monthly summary reports.

👤 User profile and settings page.

🌗 Light/Dark theme toggle.

🔒 Firestore security rules refinement.

💾 Data export (CSV/JSON).

🧠 AI-based spending insights (future exploration).

🌐 Deployment (Optional)

To deploy on Firebase Hosting:

flutter build web
firebase deploy --only hosting

🤝 Collaboration Guidelines

Use GitHub branches for feature development.

Follow pull request reviews before merging to main.

Maintain clear commit messages (e.g., feat: add dashboard charts).

Keep code modular and readable using OOP principles.

📄 License

This project is open for educational and demonstration purposes.
You may reuse or adapt the code with attribution.

🧭 Project Status

Stage: Alpha
Goal: Functional prototype for testing and refinement
Next Milestone: Beta version with UI improvements and analytics