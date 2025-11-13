# 💰 Expense Tracker Web App (Alpha Version)

A simple **Flutter Web application** that helps users **track and visualize their daily expenses**.  
This project uses **Firebase** for authentication and data storage.  
It is currently in its **Alpha stage**, meaning core features are implemented but refinements and UI improvements are still ongoing.

---

## 🚀 Overview

The Expense Tracker Web App allows users to:

- Create an account and log in securely using **Firebase Authentication**.
- Add, view, and manage expenses in real time using **Cloud Firestore**.
- View a **dashboard** that summarizes all recorded expenses.
- Access and sync data across devices securely via the cloud.

This alpha version focuses on core functionality — authentication, CRUD operations, and a basic dashboard view.

---

## 🧠 Key Features (Alpha)

| Feature | Description |
|----------|--------------|
| 🔐 **User Authentication** | Register, log in, and log out via Firebase Auth. |
| 💵 **Expense Management** | Add, edit, and delete expenses (title, amount, category, date). |
| 📊 **Dashboard Overview** | View all expenses in real time. |
| ☁️ **Firestore Integration** | Persistent cloud-based storage for user data. |
| 🔄 **Real-Time Updates** | Auto-refresh expense list via Firestore streams. |
| 💻 **Flutter Web UI** | Responsive design that works directly in a web browser. |

---

## 🧩 Tech Stack

| Layer | Technology |
|--------|-------------|
| **Frontend** | Flutter Web |
| **Backend** | Firebase Authentication + Cloud Firestore |
| **Language** | Dart |
| **IDE** | Visual Studio Code |
| **Version Control** | Git & GitHub |
| **State Management** | Provider |

---

## 🧱 Project Structure

lib/
│
├── main.dart # App entry point & Firebase initialization
├── firebase_options.dart # Auto-generated Firebase config
│
├── models/
│ └── expense_model.dart # Data model for expenses
│
├── services/
│ ├── auth_service.dart # Firebase authentication logic
│ └── database_service.dart # Firestore CRUD operations
│
├── pages/
│ ├── login_page.dart # User login screen
│ ├── signup_page.dart # User registration screen
│ ├── dashboard_page.dart # Dashboard showing all expenses
│ ├── add_expense_page.dart # Form for adding a new expense
│ └── home_page.dart # Landing page
│
└── widgets/
└── expense_tile.dart # Widget to display expense items


---

## 👥 Team Roles

| Member | Role | Responsibilities |
|---------|------|------------------|
| **Member A** | Frontend Focus | UI/UX design, page layouts, navigation, form validation, dashboard display |
| **Member B** | Backend Integration | Firebase setup, authentication, database CRUD, linking UI to backend |

Both members share responsibilities in:
- Testing and debugging  
- Git & GitHub collaboration  
- Feature refinement for the beta release  

---

## ⚙️ Setup & Installation

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/<your-repo>/expense_tracker_alpha.git
cd expense_tracker_alpha

2️⃣ Install Dependencies

flutter pub get

3️⃣ Configure Firebase

Run the FlutterFire CLI to connect your Firebase project:

3️⃣ Configure Firebase

Run the FlutterFire CLI to connect your Firebase project:

dart pub global activate flutterfire_cli
flutterfire configure

This command will generate:

lib/firebase_options.dart

4️⃣ Run the App on Web

flutter run -d chrome

🔧 Firebase Setup

Ensure the following are enabled in your Firebase Console:

Authentication → Email/Password Sign-In

Cloud Firestore → Start in test mode (for alpha)

(Optional) Hosting if you plan to deploy the app publicly.

🧮 Data Model

Collection: users/{uid}/expenses

Example Document:

{
  "title": "Groceries",
  "amount": 120.50,
  "category": "Food",
  "date": "2025-11-13T10:00:00Z",
  "createdAt": "2025-11-13T10:01:00Z"
}

🧠 Known Limitations (Alpha)

This alpha version prioritizes functionality.
Some features and polish are intentionally deferred:

Limited UI styling and animations.

No charts, filters, or analytics yet.

Minimal validation and error handling.

No user profile or settings page.

Firestore security rules not fully hardened.

These will be addressed in the upcoming Beta release.

🔮 Planned Enhancements

📊 Expense charts (Pie/Bar visualization by category)

📆 Monthly summaries and reports

👤 User profile page

🌗 Light/Dark mode toggle

💾 Data export (CSV/JSON)

🔐 Secure Firestore rules

🧠 Smart budget suggestions (future feature)

🌐 Deployment (Optional)

To deploy on Firebase Hosting:

flutter build web
firebase deploy --only hosting

🤝 Contribution Workflow

1. Branching: Create feature branches

git checkout -b feature/<feature-name>

2. Commiting: Use clear, descriptive commit messages

git commit -m "feat: add user signup functionality"

3. Pull Requests: Submit PRs for review before merging into main.

📄 License

This project is open for educational and demonstration purposes.
You may reuse or adapt the code with attribution.

🧭 Project Status

Version: Alpha 0.1

Goal: Functional prototype for testing and refinement

Next Milestone: Beta release with charts, filters, and visual improvements

✨ Authors

Member A – UI/UX, Frontend Development

Member B – Firebase Integration, Backend Development

This project represents the Alpha stage of the Expense Tracker App — a foundational prototype designed to evolve into a fully featured personal finance tool.


---
