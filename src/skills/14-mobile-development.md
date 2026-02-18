# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# SKILL 14: MOBILE DEVELOPMENT
# Scope: Mobile Dev | File: 14-mobile-development.md
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## When to Apply
When building mobile apps for iOS, Android, or cross-platform.

## Mobile Commands

| Command | Purpose |
|---------|---------|
| `/KD-role-mobile` | Activate Mobile Dev role |

## Frameworks

| Framework | Language | Platforms |
|-----------|----------|-----------|
| React Native | JavaScript/TypeScript | iOS, Android |
| Flutter | Dart | iOS, Android, Web |
| Swift | Swift | iOS only |
| Kotlin | Kotlin | Android only |
| Expo | JavaScript/TypeScript | iOS, Android |

## React Native Patterns

### Navigation
```typescript
// React Navigation
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

const Stack = createNativeStackNavigator();

function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Details" component={DetailsScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
```

### State Management
```typescript
// Zustand for React Native
import { create } from 'zustand';

const useStore = create((set) => ({
  user: null,
  setUser: (user) => set({ user }),
  logout: () => set({ user: null }),
}));
```

### Platform-Specific Code
```typescript
// Platform detection
import { Platform, StyleSheet } from 'react-native';

const styles = StyleSheet.create({
  container: {
    padding: Platform.select({
      ios: 20,
      android: 16,
    }),
  },
});

// Platform-specific files
// MyComponent.ios.js
// MyComponent.android.js
```

## Flutter Patterns

### Widget Structure
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('My App')),
        body: Center(child: Text('Hello')),
      ),
    );
  }
}
```

### State Management
```dart
// Provider pattern
class Counter extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  
  void increment() {
    _count++;
    notifyListeners();
  }
}
```

## Mobile Best Practices

### Performance
- Lazy load images and components
- Use FlatList/VirtualizedList for long lists
- Optimize images (WebP, proper sizing)
- Minimize re-renders
- Cache API responses

### Storage
```typescript
// AsyncStorage (React Native)
import AsyncStorage from '@react-native-async-storage/async-storage';

// Store
await AsyncStorage.setItem('user', JSON.stringify(user));

// Retrieve
const user = JSON.parse(await AsyncStorage.getItem('user'));

// Remove
await AsyncStorage.removeItem('user');
```

### Push Notifications
```typescript
// Expo Push Notifications
import * as Notifications from 'expo-notifications';

async function scheduleNotification() {
  await Notifications.scheduleNotificationAsync({
    content: {
      title: 'New Message',
      body: 'You have a new message!',
    },
    trigger: { seconds: 5 },
  });
}
```

## Platform Guidelines

### iOS (HIG)
- Safe areas and notches
- Swipe gestures
- Haptic feedback
- SF Symbols for icons

### Android (Material)
- Material Design 3
- Back button behavior
- FAB (Floating Action Button)
- Navigation drawer

## Testing

| Type | Tools |
|------|-------|
| Unit | Jest, XCTest, JUnit |
| Integration | Detox, Appium |
| E2E | Detox, Appium |
| UI | Storybook |

## App Store Deployment

### iOS (App Store)
1. Apple Developer Account
2. App Store Connect
3. Xcode build & archive
4. Submit for review

### Android (Play Store)
1. Google Play Console
2. Signed APK/AAB
3. Store listing
4. Rollout strategy

---
*Mobile first, mobile best*