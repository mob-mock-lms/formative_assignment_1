# ALU Academic Assistant - Assignment Management System

## About This Project
This is a Flutter mobile application built for ALU students to help manage their academic assignments. The app lets students track their coursework, set priorities, and never miss a deadline.

I built this as part of a group project where I was responsible for the assignment management features.

## Features

### What the App Does
The assignment manager helps students:
- Create new assignments with all the important details
- See everything in one organized list
- Know exactly how many days they have left
- Mark assignments as complete when done
- Edit assignments if anything changes
- Delete old assignments they don't need anymore

### Main Screen
When you open the assignments tab, you see all your assignments listed by due date (closest deadline first). Each assignment shows:
- The title and course name
- When it's due
- How many days are left
- A colored badge showing if it's high, medium, or low priority
- A checkbox to mark it done
- A menu to edit or delete it

If you don't have any assignments yet, there's a helpful message telling you to tap the plus button.

### Adding Assignments
Tap the yellow plus button and fill in:
- Assignment title (required)
- Course name (required) 
- Due date using the calendar picker
- Priority level - choose between High, Medium, or Low

The form won't let you save unless you've filled in the required stuff, which prevents mistakes.

### Editing and Deleting
Every assignment has a three-dot menu where you can:
- Edit it if details change (opens the same form with everything already filled in)
- Delete it (asks you to confirm first so you don't accidentally delete something)

## Design Choices

### Colors
I used ALU's official colors:
- Dark blue (#0A1E3C) for the background
- Yellow (#FFC107) for buttons and medium priority items
- Red (#FF3B30) for high priority and overdue warnings
- Green (#4CAF50) for low priority

### Why Cards?
I went with a card-based design because it makes each assignment easy to see at a glance and looks modern without being complicated.

### Priority System
The three priority levels help students focus on what matters most:
- **High** (red badge) - urgent stuff
- **Medium** (yellow badge) - normal assignments  
- **Low** (green badge) - things that can wait

## How It Works

### File Structure
```
lib/
├── main.dart                    # Sets up the app and navigation
├── models/
│   └── assignment.dart          # Defines what an assignment looks like
└── screens/
    ├── assignments_screen.dart       # The main list view
    └── add_edit_assignment_screen.dart   # The form for creating/editing
```

### State Management
I kept it simple with Flutter's built-in `setState()`. The assignments are stored in a list, and whenever something changes (add, edit, delete, mark complete), I update the list and the UI refreshes automatically.

### Data Model
Each assignment has:
- A unique ID
- Title
- Course name
- Due date
- Priority level
- Whether it's completed or not

I added some helper methods to calculate things like whether an assignment is overdue and how many days are left.

### Sorting
Assignments automatically sort by due date whenever you add or edit one. The sorting uses Dart's built-in date comparison, so assignments with the closest deadlines always appear at the top.

### Overdue Detection
The app checks if today's date is past the due date and the assignment isn't marked complete. If both are true, it shows the assignment with a red border and an "Overdue" label.

## Running the App

You need Flutter installed on your computer. If you have it:

```bash
flutter pub get
flutter run
```

The first command downloads the dependencies (just the `intl` package for date formatting). The second command builds and runs the app on your connected device or emulator.

## Technical Decisions

### Why I Used setState Instead of Other State Management
For an app this size, setState is perfect. It's built into Flutter, easy to understand, and does everything we need. Using something like Provider or Bloc would be overkill and make the code harder to follow.

### Why One Form for Both Add and Edit
Instead of making two separate forms, I made one that checks if you're editing an existing assignment. If you are, it pre-fills the fields. This saved a lot of code duplication and makes updates easier since there's only one place to change things.

### Data Storage
Right now the assignments live in memory, so they reset when you close the app. This works fine for the assignment requirements. If we wanted permanent storage, we could add shared_preferences or a local database pretty easily.

## Challenges I Solved

### Date Formatting
Flutter's DateTime objects aren't very readable, so I used the intl package to format them nicely (like "Feb 08, 2026" instead of "2026-02-08 00:00:00.000").

### Form Validation  
I had to make sure people can't create assignments without the required information. Flutter's form validators made this straightforward - they check the input before allowing the form to submit.

### Deleting Safely
I added a confirmation dialog before deleting because it's way too easy to accidentally tap delete. This prevents frustrating mistakes.

## What I Learned

Building this taught me a lot about Flutter's state management, form handling, and creating reusable widgets. I also got better at thinking through user experience - like making sure overdue assignments stand out, or showing how many days are left so students can prioritize.

The trickiest part was getting the edit functionality to work smoothly with the same form used for creating new assignments. Once I figured out how to conditionally load data, it all clicked.

## Future Improvements

-My team mate to add there works, so we can have fully working mobile app.


The app is ready to use as-is for demonstration purposes.
