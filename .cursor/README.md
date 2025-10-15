# Cursor Rules Documentation

This directory contains Cursor Rules that provide automated guidance for development practices in the Pokemon Assignment project.

## Overview

Cursor Rules are markdown files with `.mdc` extension that help the AI assistant understand project structure, coding patterns, and best practices. They are automatically applied based on file patterns and descriptions.

## Available Rules

### 1. Project Structure (`project-structure.mdc`)
- **Scope**: Always applied to all files
- **Purpose**: Provides overall architecture guidance for both iOS and Flutter apps
- **Key Topics**: MVVM pattern, BLoC pattern, file organization, key features

### 2. Flutter BLoC Pattern (`flutter-bloc-pattern.mdc`)
- **Scope**: Flutter Dart files (`flutter_another_pokemon_assignment/lib/**/*.dart`)
- **Purpose**: BLoC state management guidelines and best practices
- **Key Topics**: Events, States, BLoC implementation, Repository pattern, Model generation

### 3. iOS MVVM Pattern (`ios-mvvm-pattern.mdc`)
- **Scope**: iOS Swift files (`AnotherPokemonAssignment/**/*.swift`)
- **Purpose**: MVVM architecture and Swift coding standards
- **Key Topics**: Models, Views, ViewModels, Service layer, Data flow, Testing strategy

### 4. Testing Guidelines (`testing-guidelines.mdc`)
- **Scope**: Test files (`**/*test*.dart`, `**/*Test*.swift`, `**/*Tests.swift`)
- **Purpose**: Testing strategies for both Flutter and iOS platforms
- **Key Topics**: BLoC testing, Repository testing, Mocking strategy, Test organization

### 5. Networking & API Guidelines (`networking-api-guidelines.mdc`)
- **Scope**: All files (manual application)
- **Purpose**: HTTP client patterns and API integration best practices
- **Key Topics**: API endpoints, Error handling, Pagination, Caching, Security

### 6. Error Handling (`error-handling.mdc`)
- **Scope**: All files (manual application)
- **Purpose**: User experience and error recovery strategies
- **Key Topics**: Error types, Recovery strategies, Logging, Testing error scenarios

### 7. Flutter Dependencies (`flutter-dependencies.mdc`)
- **Scope**: Flutter pubspec.yaml and Dart files
- **Purpose**: Package management and code generation guidelines
- **Key Topics**: Dependencies, Code generation, Version management, Import organization

## Rule Application

### Automatic Application
- Rules with `alwaysApply: true` are applied to every request
- Rules with `globs` patterns are applied to matching files
- Rules with `description` can be manually requested

### Manual Application
- Use `@cursor` mentions to reference specific rules
- Rules can be fetched using the `fetch_rules` tool
- Multiple rules can be applied simultaneously

## Benefits

1. **Consistent Architecture**: Enforces MVVM for iOS and BLoC for Flutter
2. **Code Quality**: Promotes best practices and patterns
3. **Testing Strategy**: Guides comprehensive testing approaches
4. **Error Handling**: Ensures robust user experience
5. **Dependency Management**: Maintains clean package organization

## Usage Examples

### For Flutter Development
```dart
// The Flutter BLoC pattern rule will automatically guide:
// - BLoC implementation
// - State management
// - Repository pattern usage
// - Model generation with freezed
```

### For iOS Development
```swift
// The iOS MVVM pattern rule will automatically guide:
// - ViewModel implementation
// - Service layer organization
// - Error handling with Result types
// - Testing strategies
```

### For Testing
```dart
// The testing guidelines rule will automatically guide:
// - BLoC testing with bloc_test
// - Repository testing with mocks
// - Test organization and structure
```

## Maintenance

- Update rules when architectural patterns change
- Add new rules for new features or patterns
- Remove obsolete rules when no longer relevant
- Test rule effectiveness with actual development scenarios

## Integration with Cursor

These rules integrate seamlessly with Cursor's AI assistant to provide:
- Context-aware code suggestions
- Architecture pattern enforcement
- Best practice recommendations
- Automated refactoring guidance
- Testing strategy suggestions
