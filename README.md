# 🩸 BloodBanks - Blood Donation Mobile App

A **Flutter** application designed to streamline blood donation management, connect donors with recipients, and save lives through efficient blood bank coordination.

---

## 📱 Features

### 🏠 **Home Dashboard**
- **User Blood Group Card** - Quick view of blood type and donation eligibility
- **Statistics Panel** - Total donations, donors, and lives saved
- **Blood Availability** - Real-time stock levels across blood centers
- **Urgent Requests** - Critical blood requests with direct contact options

### 🔍 **Find Blood Centers**
- Search and filter blood centers by type
- Animated stock level indicators (red < 25%, green > 25%)
- Distance and location information
- Hospital contact details

### ❤️ **Schedule Donation**
- Intuitive appointment booking
- Date picker with 90-day scheduling window
- Hospital/center selection
- Appointment confirmation with notifications

### 🔔 **Alerts & Notifications**
- **Urgent Blood Needed** - Priority alerts with hospital info
- **Donation Confirmed** - Appointment confirmation updates
- **New Donors Nearby** - Community connection opportunities
- **Eligibility Updates** - Donation readiness notifications
- **Appreciation Messages** - Motivational feedback on impact

### 👤 **User Profile**
- Personal information & blood type
- Donation history with dates and locations
- Achievement statistics & impact metrics
- Settings (Edit, Privacy, Support, App Settings, Logout)

---

## 🎨 **Architecture & Code Quality**

✅ **Constants System** - Centralized colors, spacing, text styles
✅ **Data Models** - Type-safe models for all entities
✅ **Reusable Widgets** - DRY principle
✅ **Smooth Animations** - Entrance, transitions, progress indicators
✅ **Material 3 Design** - Modern UI/UX standards
✅ **Performance Optimized** - Lazy loading, const constructors, efficient rebuilds
✅ **Responsive Design** - Works on all screen sizes

---

## 📂 **Project Structure**

```
lib/
├── main.dart              # App entry point, bottom navigation & all 5 screens
├── constants.dart         # Design system (colors, spacing, typography, durations)
├── models.dart            # Type-safe data models for all entities
├── utils.dart             # Utility functions, extensions & validators
└── [All screens organized inline in main.dart]
```

---

## 🚀 **Getting Started**

### Prerequisites
- Flutter SDK (3.10.4+)
- Dart 3.10.4+

### Installation & Running

```bash
# Get dependencies
flutter pub get

# Run on default device
flutter run

# Build release APK
flutter build apk --release

# Build release iOS
flutter build ios --release
```

---

## 📱 **Screens & Navigation**

| Screen | Purpose | Key Features |
|--------|---------|--------------|
| **Home** | Dashboard | Profile, Stats, Blood Availability, Urgent Requests |
| **Find** | Blood Centers | Search, Filter by type, Stock levels, Distance |
| **Donate** | Appointment | Date picker, Hospital selection, Confirmation |
| **Alerts** | Notifications | Urgent alerts, Confirmations, Nearby donors, Updates |
| **Profile** | Account Mgmt | User info, History, Stats, Settings, Logout |

---

## 🎨 **Design System**

### Colors
- Primary: `#D32F2F` (Red/Urgency)
- Success: `#4CAF50` (Green/Confirmed)
- Warning: `#FFC107` (Amber/Caution)
- Error: `#FF5252` (Critical)

### Spacing & Sizing
- xs: 4px | sm: 8px | md: 12px | lg: 16px | xl: 20px | xxl: 24px

### Animations
- Fast: 150ms | Normal: 300ms | Slow: 450ms | Slower: 600ms

---

## 🛠️ **Utility Functions & Extensions**

### String Extensions
- `capitalize()` - Capitalize first letter
- `isValidBloodType()` - Validate blood type format

### Int Extensions
- `toCompactString()` - Format large numbers (1000 → "1K", 1000000 → "1M")

### DateTime Extensions
- `daysSince()` - Calculate days since date
- `timeAgoString()` - Human-readable time format ("5m ago", "2h ago")
- `toFormattedString()` - Format as DD/MM/YYYY
- `isDonationEligible()` - Check 56-day eligibility rule

### BloodTypeHelper
- `canDonateTo()` - Test blood type compatibility
- `getSafeRecipients()` - Get compatible recipients for donor type

### Validators
- `isValidEmail()` - Email format validation
- `isValidPhone()` - Pakistan phone format validation
- `isValidName()` - Name format validation

### AppLogger
- Simple debug, info, warning, error logging

---

## 🔧 **Technology Stack**

- **Framework**: Flutter 3.10.4+
- **Language**: Dart 3.10.4+
- **Design**: Material 3
- **State Management**: Built-in (StatefulWidget)
- **Architecture**: Clean code principles

---

## 📈 **Future Enhancements**

- 🗺️ Real-time GPS & donor matching
- 🔄 Live API integration with blood banks
- 💬 In-app messaging system
- 🔔 Push notifications (Firebase)
- 📊 Analytics & donation trends
- 🌙 Dark mode support
- 🌍 Multi-language support
- 🧪 Comprehensive testing
- 🔐 Backend authentication
- 💳 Donor rewards program

---

## 📄 **License**

MIT License - Free to use and modify

---

**Made with ❤️ to save lives through blood donation**
# Blood-Link-
