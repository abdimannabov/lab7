## 📱 Flutter HTTP & API Tasks

This repository contains two Flutter tasks demonstrating how to work with APIs using the **http** package in Flutter.

---

### 🧩 Task 1 — Sending a POST Request

**Files:**

* `main.dart`
* `details.dart`
* `post.dart`

**Description:**
This task demonstrates how to send data to an API endpoint using the **POST** method with the `http` package.
It uses the fake API service [ReqRes](https://reqres.in) for testing.

**Usage:**

1. Run the Flutter app.
2. Navigate to the **Post** page.
3. Enter title and body text.
4. Tap **“Submit Post”**.
5. The data will be sent to:
   `https://reqres.in/api/posts`

---

### 💱 Task 11 — Fetch Currency Exchange Rates

**File:**

* `task11.dart`

**Description:**
This task fetches and displays currency exchange rates from the **Central Bank of Uzbekistan’s JSON API**.
It supports both:

* Fetching all currencies for a specific date.
* Fetching a single currency by code (e.g., USD, RUB, EUR).

**Usage:**

1. Open `task11.dart` in your Flutter project.
2. Run the app.
3. Enter:

   * A date (format: `YYYY-MM-DD`)
   * A currency code (like `USD`, `RUB`, or `all`)
4. Tap **“Fetch Rates”**.
5. The app will display currency name, code, and rate in UZS.

---

### ⚙️ Setup Guide

1. Make sure Flutter is installed and configured:

   ```bash
   flutter doctor
   ```
2. Clone this repository:

   ```bash
   git clone https://github.com/<your-username>/<repo-name>.git
   ```
3. Navigate to the project:

   ```bash
   cd <repo-name>
   ```
4. Install dependencies:

   ```bash
   flutter pub get
   ```
5. Run the app:

   ```bash
   flutter run
   ```

---

### 📦 Dependencies

* [http](https://pub.dev/packages/http)
* [flutter](https://flutter.dev)

---

### 👨‍💻 Author

**Sohib** — Flutter Developer
---
