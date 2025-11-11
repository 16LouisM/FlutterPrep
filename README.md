💼 Project Title:

SmartSpend — Flutter Web Expense Tracker

🧭 Project Overview

SmartSpend is a beginner-friendly Flutter Web app designed to help users track their daily expenses easily from any browser.

It allows users to:

Create an account or log in

Add, view, edit, and delete expenses

See their spending summary

Store data securely in Firebase Firestore

The goal is to help the team learn both frontend design (UI) and backend integration (Firebase) using Flutter Web, while maintaining good collaboration through Git + GitHub.

🧩 Core Functionalities
1. Authentication

User login using Firebase Authentication (email + password)

Optional: User sign-up (registration) page

Logged-in users can only access their own data

Logout functionality

2. Home Page (/)

Purpose: Introduction & navigation entry point

Display:

App name and short tagline (e.g., “Track your expenses, control your spending.”)

A “Get Started” or “Login” button that takes the user to the Login page

Responsive layout that looks clean on desktop and mobile

UI Elements:

App title (e.g., SmartSpend)

App logo (optional)

Login button

Footer with project/team name

Backend Connection:

None directly — only navigation logic to /login.

3. Login Page (/login)

Purpose: Allow users to log in securely

Display:

Email and Password fields

Login button

Error messages for invalid credentials

Optional “Create Account” button

Backend Connection:

Uses Firebase Authentication

On successful login → redirects to /dashboard

Store logged-in user’s UID for later database queries

UI Elements:

Two TextFields (email, password)

“Login” button

Loading spinner while authenticating

4. Dashboard (/dashboard)

Purpose: Display the user’s financial data

Display:

Greeting message (“Welcome back, [User Name]!”)

List or table of recent expenses

“Add Expense” button

Total monthly spending summary

Optional: Category filter or date filter

Backend Connection:

Fetch data from Firestore → users/{uid}/expenses/

Display all expenses ordered by date (descending)

Allow delete/update actions that modify Firestore in real-time

UI Elements:

AppBar with Logout button

ListView or DataTable of expenses

FloatingActionButton (FAB) to add a new expense

Displayed Data:

Field	Example	Description
Date	2025-11-10	Date of expense
Title	Groceries	Short label for what was bought
Category	Food	Expense category
Amount (ZAR)	R150	Expense value
Actions	Edit / Delete	Modify data buttons
5. Add Expense Dialog

Purpose: Allow the user to input a new expense

Display:

Pop-up or dedicated page with input fields

“Save” button to write data to Firestore

Form Fields:

Title (TextField)

Amount (TextField, numeric)

Category (Dropdown: Food, Transport, Rent, etc.)

Date (DatePicker)

Backend Connection:

On “Save”, write a new document under:

users/{uid}/expenses/{expenseId}


Automatically refresh the dashboard list after submission

6. Data Tracking & Analytics

Purpose: Give the user insight into their spending

Features:

Calculate total monthly spending dynamically

Optional: Show pie chart of spending by category

Display total number of expenses and average expense

Data Source:

Firestore queries (e.g., expenses.where('month', isEqualTo: currentMonth))

Displayed Summary Example:

💰 Total this month: R2,450
🛒 Top category: Food
🧾 Total expenses: 28

7. Logout

Purpose: Securely sign out of Firebase and return to the login page

Behavior:

Calls FirebaseAuth.instance.signOut()

Clears navigation history and returns to /login

🗄️ Backend Structure (Firestore)

Collection Structure:

users/
  └── userId/
       └── expenses/
            ├── expenseId1
            ├── expenseId2


Expense Document Fields:

Field	Type	Description
title	String	Name of expense
amount	double	Amount spent
category	String	Expense category
date	Timestamp	Expense date
created_at	Timestamp	When the record was added
⚙️ Tech Stack
Layer	Tool
Frontend	Flutter Web
Backend	Firebase Authentication & Firestore
IDE	Visual Studio Code
Version Control	Git + GitHub
Browser	Chrome
Hosting (optional)	Firebase Hosting
🧑‍🤝‍🧑 Team Structure & Task Assignment
👤 Member A – Frontend & Partial Backend

Focus: UI design, page layout, and basic Firebase linking.

Tasks:

Set up the Flutter project and enable web support (flutter config --enable-web).

Build the Home Page UI and routing.

Design the Login Page layout and handle input validation.

Implement navigation flow between pages (/ → /login → /dashboard).

Create UI for Dashboard (table, app bar, and “Add Expense” button).

Connect Login Page with Firebase Authentication (sign-in only).

Design the Add Expense Dialog UI (TextFields, Dropdown, DatePicker).

Deliverables:

Functional front-end interface for all pages.

Working navigation and user flow.

Integrated login with Firebase (frontend side).

👤 Member B – Backend & Partial Frontend

Focus: Database structure, CRUD operations, and backend logic.

Tasks:

Set up Firebase Project and Firestore collections.

Implement Firebase Authentication logic (sign-in, sign-out).

Create database_service.dart to handle:

Add expense

Delete expense

Fetch expenses (by user)

Connect Dashboard to live Firestore data.

Implement spending summary logic (total, category counts).

Add functionality to delete and update expenses.

Implement logout functionality.

Deliverables:

Functional backend (Firebase setup + CRUD).

Live Dashboard data connected to Firestore.

Expense statistics displayed in UI.

🧰 Collaboration Workflow (Git + GitHub)

Member A creates the GitHub repo (public or private).

Both clone the repo locally:

git clone <repo-url>


Create separate branches:

frontend-dev → Member A

backend-dev → Member B

Commit frequently with descriptive messages:

git commit -m "Add dashboard UI layout"


Use Pull Requests for merging to main after review.

🧱 Expected Output

By the end of the project, you should have:

A fully working Flutter web app

Login → Dashboard → Add Expense workflow

Data stored and fetched from Firestore

A responsive, beginner-friendly UI

A clean GitHub repository with meaningful commits

🚀 Stretch Goals (Optional if Time Allows)

Add sign-up page for new users

Add category filter or date filter

Add chart visualization (using fl_chart package)

Deploy to Firebase Hosting





FILE STRUCTURE 

smartspend/
├── android/                     # Default Flutter Android folder (for web, mostly unused)
├── ios/                         # Default Flutter iOS folder (for web, mostly unused)
├── web/                         # Web entry files
│   ├── index.html               # Firebase SDK config goes here
│   ├── favicon.png
│   └── manifest.json
├── assets/                      # Static assets like icons, logos, and images
│   ├── icons/
│   │   └── app_logo.png
│   └── illustrations/
│       └── welcome_banner.png
├── lib/                         # MAIN SOURCE CODE (Frontend + Backend services)
│   ├── main.dart                # App entry point
│   │
│   ├── config/                  # App-wide settings, routes, and themes
│   │   ├── app_routes.dart      # Route names & navigation setup
│   │   └── app_theme.dart       # ThemeData, colors, fonts, etc.
│   │
│   ├── models/                  # Data Models (structure of your objects)
│   │   └── expense_model.dart   # Defines Expense fields: title, amount, category, date
│   │
│   ├── services/                # "Backend logic" layer (Firebase interaction)
│   │   ├── auth_service.dart    # Handles login/logout with Firebase Auth
│   │   ├── database_service.dart# Handles CRUD operations with Firestore
│   │   ├── firebase_options.dart# Auto-generated Firebase config file
│   │   └── helpers.dart         # Optional: shared helper functions or formatters
│   │
│   ├── pages/                   # Frontend Pages (UI)
│   │   ├── home_page.dart       # Landing/welcome screen
│   │   ├── login_page.dart      # Login form & logic
│   │   ├── dashboard_page.dart  # Main user dashboard (expense list + summary)
│   │   ├── add_expense_page.dart# Separate add-expense form (or dialog)
│   │   └── not_found_page.dart  # 404 fallback for unknown routes
│   │
│   ├── widgets/                 # Reusable frontend UI components
│   │   ├── expense_tile.dart    # Widget for displaying each expense item
│   │   ├── summary_card.dart    # Widget for showing total/monthly summary
│   │   └── custom_button.dart   # Reusable styled button
│   │
│   └── controllers/             # State management layer (optional, scalable)
│       ├── auth_controller.dart # Manages login state
│       └── expense_controller.dart # Manages expense list, filters, etc.
│
├── test/                        # Flutter test files (optional for later)
│   └── widget_test.dart
│
├── pubspec.yaml                 # Dependencies and assets registration
├── analysis_options.yaml        # Linting and style rules
├── README.md                    # Project overview and setup steps
└── .gitignore                   # Files ignored by Git

