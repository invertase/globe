# Globe Auth

Drop in auth for Flutter.

## Usage

Create a new `GlobeAuth` instance using your project ID and public key:

```dart
final auth = GlobeAuth.project(
  '...',
  publicKey: '...',
);
```

Next, use one of the pre-built sign in screens:

```dart
home: SignInScreen(
  auth: auth,
  onSignIn: (user) {
    // navigate, snack-bar etc
  },
),
```

Subscribe to the users auth state:

```dart
auth.state.listen((state) {
  switch (state) {
    case GlobeAuthStateLoading():
      // Loading the users auth state
      break;
    case GlobeAuthStateUnauthenticated():
      // Loaded, but not authenticated
      break;
    case GlobeAuthStateAuthenticated():
      // User is authenticated
      print(state.user);
      print(state.session);
      break;
    case GlobeAuthStateLoaded():
      // Not loading - but may or may not be authenticated
      throw UnimplementedError();
  }
});
```