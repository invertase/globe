/// Helper functions for GraphQL scalar types

/// Identity function for JSON scalar type.
///
/// This function simply returns the input value without any transformation.
/// It's used for the JSON scalar type in GraphQL.
T _identity<T>(T value) => value;
