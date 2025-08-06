# 💡 Startup Idea Evaluator App

A Flutter-based mobile application where users can submit their startup ideas, get an AI-generated rating, upvote other ideas, and view a leaderboard of top ideas.

---

## 📜 App Description
The **Startup Idea Evaluator** is designed to allow users to:
- Submit their startup idea with a name, tagline, and description.
- Automatically get an AI-generated score for the idea.
- View a list of all submitted ideas sorted by rating or votes.
- Upvote ideas (with one vote per user).
- See the top 5 ideas in a **Leaderboard**.
- Enjoy Light and Dark themes with customized color schemes (Light: Blue-White, Dark: Purple-White).
- Share ideas easily via social media and messengers.
- Delete ideas with a swipe gesture.

---

## 🛠 Tech Stack Used
- **Flutter** – UI Framework
- **Dart** – Programming Language
- **Provider** – State Management
- **SharedPreferences** – Local Storage
- **share_plus** – Share feature
- **fluttertoast / SnackBar** – Notifications
- **flutter_native_splash** – Splash Screen

---

## 🚀 Features Implemented
- **Idea Submission Screen**
  - Enter startup name, tagline, and description.
  - AI-generated fake rating based on input.
  - Form validation with floating SnackBar alerts.

- **Idea Listing Screen**
  - View all ideas with name, tagline, rating, and vote count.
  - Sort by rating or votes.
  - Upvote button (one vote per user).
  - Read More/Read Less for descriptions.
  - Share idea via `share_plus`.
  - Swipe to delete with confirmation SnackBar.

- **Leaderboard Screen**
  - Displays top 5 ideas.
  - Sort by rating or votes.
  - Dynamic colors based on theme.

- **Theme Support**
  - Light Mode → Blue + White
  - Dark Mode → Purple + White

- **Persistent Data**
  - All ideas and votes are stored locally using SharedPreferences.
  - Data remains after app restarts.

---

## 💻 How to Run Locally / Install APK

### **Run Locally**
1. Clone the repository:
   ```bash
   git clone <your_repo_link>
Navigate to the project directory:
cd idea_envalutor

Install dependencies:
flutter pub get

Run the app:
flutter run

---
🎥 Video Walkthrough
A short demo video showcasing the app features is available here:

https://drive.google.com/file/d/1RkwAjEQGgxCmE_F9Rt9YvUAsOv4GDnMP/view?usp=sharing







