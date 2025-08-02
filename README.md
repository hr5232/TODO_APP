# TODO App – Flutter 

A simple but complete TODO mobile application built with **Flutter**, using **Clean Architecture**, **BLoC pattern**, and **Hive** for local storage. This project was developed as part of the EB Pearls Traineeship Technical Assignment.

---

## ✅ Features

- ✅ View list of tasks
- ✅ Add new tasks
- ✅ Edit existing tasks
- ✅ Delete tasks via delete icon
- ✅ Mark tasks as complete/incomplete
- ✅ Filter by status: All, Active, Completed
- ✅ Set priority: High, Medium, Low
- ✅ Set due date using a date picker
- ✅ Sort tasks by due date automatically
- ✅ Data is saved locally using Hive

---

## 📁 Project Architecture

The project uses **Clean Architecture** to separate layers clearly:

lib/
├── data/ # Handles local storage using Hive
│ ├── models/ # Task model (TaskModel)
│ └── repositories/ # TaskRepository for data access logic
├── domain/ # (Kept empty for future use cases or services)
├── presentation/
│ ├── bloc/ # BLoC files: TaskBloc, TaskEvent, TaskState
│ └── screens/ # UI: AddTask, EditTask, TaskList
└── main.dart # App entry point and BLoC provider setup

---

## 🚀 How to Run the App

Make sure you have Flutter SDK installed and your environment is set up.

### 1. Clone the Repository

git clone https://github.com/hr5232/todo_app.git
cd todo_app

### 2. Install Dependencies

flutter pub get

### 3. Generate Hive Type Adapter
   
flutter pub run build_runner build

### 4. Run the App

flutter run

---
