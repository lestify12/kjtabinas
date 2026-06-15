# Krystler John Tabinas — Flutter Portfolio

A stunning single-page animated portfolio built with Flutter Web.

## Setup

### 1. Install Flutter
Download and install Flutter SDK: https://docs.flutter.dev/get-started/install/windows

After installing, add Flutter to your PATH and run:
```
flutter doctor
```

### 2. Add your profile photo
Copy your photo (named `profile.jpg`) to:
```
assets/images/profile.jpg
```
The avatar in the Hero and About sections will automatically use it.
If not provided, a gradient "KJT" placeholder is shown.

### 3. Install dependencies
```
flutter pub get
```

### 4. Run in Chrome
```
flutter run -d chrome
```

### 5. Build for production (deploy to hosting)
```
flutter build web --release
```
Then upload the `build/web/` folder to any static host (Netlify, Vercel, GitHub Pages, Firebase Hosting).

## Sections
- **Hero** — Typewriter name, animated role cycling, orbiting avatar with particle background
- **About** — Bio, stats counter cards, contact info
- **Skills** — Tech skill chips + expertise list with scroll-trigger stagger animations
- **Experience** — Alternating left/right timeline cards, 7 roles across Philippines & UAE
- **Education** — Flip-in education cards + training/achievement cards
- **Contact** — CTA footer with email, phone, location cards

## Customize
All content lives in `lib/data/portfolio_data.dart` — edit names, roles, experience, etc. there.
Colors and fonts are in `lib/theme/app_theme.dart`.
