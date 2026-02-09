# ALU Student Academic Platform

## Project Overview

The ALU Student Academic Platform is a Flutter-based mobile application designed to serve as a personal academic assistant for ALU students. The application provides an integrated platform for managing assignments, tracking attendance, monitoring academic schedules, and assessing student performance metrics.

## Project Purpose

The primary objective of this application is to provide ALU students with a centralized digital solution that enables efficient academic planning and tracking. The system addresses key pain points, including:

- Assignment deadline management and prioritization
- Real-time attendance monitoring and risk assessment
- Academic schedule organization and visualization
- Performance metrics tracking and analytics
- Early identification of at-risk students through data-driven insights

## Core Features

### 1. Dashboard
The dashboard serves as the central hub, providing students with a comprehensive overview of their academic status:

- **Performance Metrics**: Real-time display of attendance percentage, assignment completion rate, and average grade
- **Risk Assessment**: Automated identification of at-risk status based on attendance and assignment metrics
- **Today's Schedule**: Dynamic display of the current day's academic sessions with timing and location details
- **Upcoming Assignments**: Filtered view of assignments due within the next seven days
- **Quick Statistics**: Aggregate counts of pending assignments, completed tasks, and total sessions

### 2. Assignment Management
A comprehensive assignment tracking system that enables students to:

- Create new assignments with detailed attributes, including title, course, due date, and priority level
- View all assignments organized by due date in ascending order
- Edit existing assignment details through an intuitive form interface
- Delete assignments with confirmation prompts to prevent accidental removal
- Mark assignments as complete with visual checkbox indicators
- Identify overdue assignments through color-coded visual cues
- Calculate remaining days until deadline for effective time management

Priority levels are categorized as:
- **High Priority**: Critical assignments requiring immediate attention
- **Medium Priority**: Standard coursework with moderate urgency
- **Low Priority**: Tasks with flexible deadlines

### 3. Schedule Management
The schedule module provides comprehensive session tracking capabilities:

- Create and edit academic sessions with title, date, time range, location, and session type
- View all scheduled sessions in a chronological list format
- Differentiate between session types, including classes, study groups, and other academic activities
- Delete obsolete sessions from the schedule
- Filter today's sessions for quick reference on the dashboard

### 4. Attendance Tracking
An attendance monitoring system designed to identify students at risk:

- Display attendance history with date-specific records
- Visual indicators for present and absent status
- Calculate overall attendance percentage
- Generate risk warnings when attendance falls below the 75% threshold
- Provide access to academic support resources for at-risk students
- Display attendance metrics alongside assignment submission rates and average grades

### 5. User Profile Management
User profile functionality, including:

- User registration and authentication flow
- Profile information display
- Sign-out capability with state reset

## System Architecture

### Technology Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **State Management**: StatefulWidget with setState()
- **Date Handling**: intl package for internationalization and date formatting
- **Platform Support**: iOS and Android (with web, Windows, macOS, and Linux configuration files present)

### Project Structure

```
lib/
├── main.dart                              # Application entry point and routing configuration
├── models/                                # Data models and business logic
│   ├── assignment.dart                    # Assignment entity with computed properties
│   ├── assignment_session.dart            # Academic session entity
│   ├── schedule_data.dart                 # Schedule-related data structures
│   └── user_profile.dart                  # User profile entity
├── screens/                               # User interface screens
│   ├── main-screen.dart                   # Main navigation container
│   ├── dashboard.dart                     # Dashboard with analytics
│   ├── assignments_screen.dart            # Assignment list view
│   ├── add_edit_assignment_screen.dart    # Assignment form
│   ├── schedule_screen.dart               # Schedule list view
│   ├── schedule_add_edit_session.dart     # Session form
│   ├── attendance.dart                    # Attendance tracking interface
│   ├── profile.dart                       # User profile display
│   └── signup.dart                        # Registration interface
├── utils/                                 # Utility functions and constants
│   ├── constants.dart                     # Sample data and configuration
│   └── date_time_extension.dart           # DateTime helper methods
└── widgets/                               # Reusable UI components
    ├── app_app_bar.dart                   # Custom application bar
    ├── app_bottom_navigation.dart         # Bottom navigation bar
    ├── assignments_list.dart              # Assignment list widget
    ├── attendance_card.dart               # Attendance metric card
    ├── attendance_entry.dart              # Individual attendance record
    ├── dashboard_empty_list.dart          # Empty state component
    ├── dashboard_quick_stat_card.dart     # Quick statistic display
    ├── dashboard_section_header.dart      # Section header component
    ├── help_card.dart                     # Support resources card
    ├── metrics_card.dart                  # Performance metric display
    ├── risk_banner.dart                   # At-risk warning banner
    └── sessions_list.dart                 # Session list widget
```

### Critical Components

#### Models Layer

**Assignment Model** (`models/assignment.dart`)
- Encapsulates assignment data including unique identifier, title, course, due date, priority, and completion status
- Provides computed properties for overdue detection and days remaining calculation
- Implements business logic for assignment state management

**AcademicSession Model** (`models/assignment_session.dart`)
- Represents scheduled academic activities with temporal and spatial attributes
- Includes optional attendance tracking field
- Provides helper method for identifying current day's sessions

**UserProfile Model** (`models/user_profile.dart`)
- Manages user authentication state and profile information

#### Screens Layer

**MainScreen** (`screens/main-screen.dart`)
- Implements the primary navigation container using IndexedStack for state preservation
- Manages bottom navigation interaction and screen switching
- Handles user authentication flow and profile state management
- Coordinates between five primary screens: Dashboard, Assignments, Schedule, Attendance, and Profile

**DashboardScreen** (`screens/dashboard.dart`)
- Aggregates data from multiple sources to provide comprehensive academic overview
- Implements computed properties for real-time metric calculation
- Filters and sorts data based on relevance and temporal proximity
- Provides risk assessment logic based on attendance thresholds

**AssignmentsScreen** (`screens/assignments_screen.dart`)
- Displays comprehensive assignment list with sorting by due date
- Implements CRUD operations for assignment management
- Provides quick actions for completion toggling and item deletion
- Handles empty state presentation

**ScheduleScreen** (`screens/schedule_screen.dart`)
- Manages chronological display of academic sessions
- Facilitates session creation, editing, and deletion
- Supports multiple session types and time ranges

**AttendanceScreen** (`screens/attendance.dart`)
- Presents attendance history with visual status indicators
- Calculates and displays key performance metrics
- Implements risk identification and support resource access

#### Widgets Layer

The widgets layer consists of reusable, composable UI components that maintain visual consistency across the application. Key widgets include:

- **Navigation Components**: Custom app bar and bottom navigation implementing ALU branding
- **List Components**: Specialized list widgets for assignments and sessions with appropriate formatting
- **Card Components**: Metric cards, statistic cards, and information cards following consistent design patterns
- **State Components**: Empty state handlers and conditional displays

### State Management Strategy

We implemented a lightweight state management approach using Flutter's built-in StatefulWidget and setState() mechanism. This decision was based on several factors:

- **Application Scale**: The current feature set does not warrant the complexity of external state management solutions
- **Performance**: Local state updates provide adequate performance for the current data volumes
- **Maintainability**: Built-in state management reduces dependency overhead and simplifies codebase understanding
- **Development Velocity**: Rapid iteration and feature development without additional architectural overhead

Data flows unidirectionally from parent screens to child widgets through constructor parameters. State updates trigger UI rebuilds through setState() calls, ensuring UI consistency with underlying data.

### Design System

#### Color Palette

We implemented ALU's institutional color scheme to maintain brand consistency:

- **Primary Background**: #071A3A (Deep Navy Blue)
- **Accent Color**: #FFC107 (Bright Yellow) - Used for call-to-action buttons and medium priority indicators
- **Success/Low Priority**: #4CAF50 (Green)
- **Warning/High Priority**: #FF3B30 (Red)
- **Text Primary**: White with 90% opacity
- **Text Secondary**: White with 60% opacity
- **Surface**: White with 5% opacity for cards and containers

#### UI Patterns

- **Card-Based Layout**: Content organization using elevated cards with consistent border radius (16px) and subtle borders
- **Bottom Navigation**: Five-tab navigation pattern for primary feature access
- **Floating Action Buttons**: Yellow circular buttons positioned at the bottom-right for primary actions
- **List Items**: Interactive list tiles with trailing action menus
- **Empty States**: Centered icon and message combinations for null data scenarios

### Data Management

#### Current Implementation

The application currently utilizes in-memory data storage with sample data defined in `utils/constants.dart`. This approach is suitable for demonstration and development purposes, but results in data loss upon application termination.

Sample data includes:
- Four predefined assignments with varying due dates and priorities
- Five academic sessions spanning multiple days with attendance records

## Setup and Installation

### Prerequisites

- Flutter SDK version 3.0.0 or higher
- Dart SDK version 3.0.0 or higher
- Android Studio or VS Code with Flutter extensions
- iOS development: Xcode 14+ (macOS only)
- Android development: Android SDK with API level 21 or higher

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd formative_assignment_1
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter Installation**
   ```bash
   flutter doctor
   ```
   Resolve any issues identified by Flutter Doctor before proceeding.

4. **Run the Application**
   
   For development on a connected device or emulator:
   ```bash
   flutter run
   ```
   
   For a specific platform:
   ```bash
   flutter run -d <device-id>
   ```
   
   List available devices:
   ```bash
   flutter devices
   ```

5. **Build Release Version**
   
   Android APK:
   ```bash
   flutter build apk --release
   ```
   
   iOS:
   ```bash
   flutter build ios --release
   ```

### Configuration

The application uses the default Flutter configuration. No additional environment variables or API keys are required for the current implementation.

## Development Guidelines

### Code Style

We adhere to the official Dart style guide with the following conventions:

- Use trailing commas for function arguments and collection literals to improve automatic formatting
- Prefer const constructors when widget parameters are compile-time constants
- Utilize named parameters for improved readability in widget constructors
- Implement proper null safety with non-nullable types where appropriate
- Follow the single responsibility principle for widgets and classes

### Widget Development

When creating new widgets:

1. Extend StatelessWidget for presentational components without internal state
2. Extend StatefulWidget only when internal state management is required
3. Extract reusable components into the widgets directory
4. Implement proper const constructors for performance optimization
5. Document complex widgets with inline comments explaining business logic

### State Management

For consistency across the codebase:

1. Manage state at the appropriate level in the widget tree
2. Use setState() for local component state
3. Pass data down through the constructor parameters
4. Implement callback functions for child-to-parent communication
5. Consider lifting the state when multiple widgets need access to the same data

### Testing Guidelines

While tests are not currently implemented, we recommend the following testing strategy for future development:

1. **Unit Tests**: Test model logic, computed properties, and utility functions
2. **Widget Tests**: Verify individual widget rendering and interaction behavior
3. **Integration Tests**: Validate complete user flows across multiple screens
4. **Golden Tests**: Ensure visual consistency across UI updates

## Contribution Guidelines

We welcome contributions from team members and the broader developer community. Please follow these guidelines:

### Getting Started

1. Fork the repository and create a feature branch from `main`
2. Ensure your development environment is properly configured
3. Review existing code to understand current patterns and conventions
4. Check the issue tracker for open tasks or create a new issue for significant changes

### Making Changes

1. **Branch Naming**: Use descriptive branch names following the pattern `feature/description` or `fix/description`
2. **Commit Messages**: Write clear, concise commit messages describing the change and its purpose
3. **Code Quality**: Ensure code follows the established style guidelines and passes linting
4. **Testing**: Add appropriate tests for new functionality
5. **Documentation**: Update relevant documentation, including code comments and README sections

### Pull Request Process

1. Update the README.md with details of significant changes to features or architecture
2. Ensure the application builds successfully without errors or warnings
3. Run `flutter analyze` to verify code quality
4. Format code using `dart format .` before committing
5. Create a pull request with a clear description of changes and their motivation
6. Link related issues in the pull request description
7. Request review from at least one team member
8. Address review feedback and make necessary adjustments

## Support and Contact

For technical support, bug reports, or feature requests, please create an issue in the project repository with detailed information about the problem or suggestion.
