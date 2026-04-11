# Smart Utility Toolkit App

The Smart Utility Toolkit is a comprehensive and aesthetically pleasing Flutter application that serves as your everyday utility companion. It natively offers four distinct utility conversions.

## Features

- **Length Converter**: Quickly accurately convert between `mm`, `cm`, `m`, `km`, `in`, `ft`, and `mi`.
- **Weight Converter**: Accurate localized weights with support for `mg`, `g`, `kg`, `lb`, and `oz`.
- **Temperature Converter**: Simple swaps determining `°C`, `°F`, and `Kelvin`.
- **Currency Converter**: Convert between major world currencies (USD, NGN, EUR, GBP, CNY) using statically provided rates, accompanied by intuitive drop-downs and a swap mechanism.

## App Themes & Aesthetics

This app places a heavy emphasis on visual excellence, utilizing a sophisticated custom dark theme designed to be sleek and premium. 

### Global Theme Structure
The theme is strictly configured in `lib/utils/app_themes.dart` via `AppTheme.dark`. We bypass standard out-of-the-box Material defaults by providing explicit custom overrides for:
- **Scaffold Background**: Clean `#0F1117` base
- **AppBar**: Zero elevation, translucent/matching background colors without shadows
- **Cards**: All custom input/result sections are painted onto `#1A1D2E` surfaces with strict `16px` border radii and removed native elevations.
- **Inputs**: Text fields utilize a filled `surfaceVariant` (`#252840`) layout lacking heavy borders unless focused.
- **Typography**: Utilizing a custom font stack (`PlusJakartaSans`) organized by clear hierarchical scale (e.g. `displayLarge` for result values, `labelLarge` for input hints).

### The Exact Color Palette (`AppColors`)

| Definition | Hex Code | Purpose |
| ---------- | -------- | ------- |
| **Primary** | `#4C6EF5` | Global accent, main active buttons, selected states, and highlighted icons. |
| **Accent / Success** | `#69DB7C` | Positive growth states, secondary interactive nodes. |
| **Background** | `#0F1117` | The deepest canvas layer; scaffold backgrounds and AppBars. |
| **Surface** | `#1A1D2E` | Container backgrounds for any floating elements like the Input Cards. |
| **Surface Variant** | `#252840` | Backgrounds for text inputs and dropdown wrappers sitting on top of Surfaces. |
| **On Surface** | `#F1F3F9` | Primary text color. |
| **On Surface Muted**| `#9094B0` | Subtitles, hints, and placeholder text. |
| **Warning / Alert** | `#FFD43B` / `#FF6B6B` | Distinctive indicators and various error warnings. |
| **Divider** | `#2A2D45` | Subtle separation lines between list components and statutory rows. |

## Code Architecture

Built with standard Flutter state-management (`ChangeNotifier` and `StatefulWidget` combinations), keeping files structured cleanly by feature.

```text
lib/
├── features/
│   ├── currency_converter/
│   ├── length_converter/
│   ├── temperature_converter/
│   └── weight_converter/
├── models/
├── utils/
│   ├── app_themes.dart
│   ├── text_formatter.dart
│   └── thousands_formatter.dart
└── widgets/
    ├── input_card.dart
    ├── primary_action_button.dart
    ├── result_card.dart
    ├── swap_button.dart
    └── tool_scaffold.dart
```

## Getting Started

1. Ensure you have the [Flutter SDK](https://flutter.dev/docs/get-started/install) installed (minimum `^3.11.4`).
2. Clone the repository and navigate into the `smart_utility_toolkit_app` folder.
3. Run `flutter pub get` from your terminal to fetch dependencies.
4. Execute `flutter run` on your connected iOS/Android device or emulator.
