# FetchDessertRecipes - README

## Project Overview

**FetchDessertRecipes** is a native iOS application built using SwiftUI. The app allows users to browse dessert recipes by fetching data from the provided API endpoints. The application fetches a list of meals in the dessert category and provides detailed information for each meal, including meal name, instructions, ingredients, and measurements.

This project is developed as a take-home assignment to demonstrate proficiency in SwiftUI, asynchronous programming with async/await, and best practices for writing clean, maintainable code.

## Features

- Fetches a list of dessert recipes from an API.
- Displays detailed information about each dessert, including ingredients and instructions.
- Uses caching to reduce unnecessary network calls.
- Follows clean architecture principles, separating concerns between the data layer, view models, and views.

## Architecture

The project follows the MVVM (Model-View-ViewModel) pattern to ensure a clear separation of concerns and maintainability.

### Models

- **Dessert**: Represents the data model for a dessert recipe, conforming to Codable for easy parsing from JSON.
- **DessertListResponse**: Represents the response from the API containing a list of dessert meals.

### ViewModels

- **DessertViewModel**: Manages the fetching of dessert data, handles loading states, and prepares data for the views. It uses `DessertService` for network calls and provides an interface for the views to bind to.

### Views

- **ContentView**: The main view displaying a list of desserts. It uses a NavigationView to navigate to the detail view of each dessert.
- **DessertRow**: A subview used to display individual dessert items in the list.
- **DessertDetailView**: Displays detailed information about a selected dessert, including the image, name, instructions, and ingredients.

## How It Works

### Fetching Data

- When the app launches, `ContentView` initializes `DessertViewModel`, which immediately starts fetching the list of desserts by calling `fetchDesserts()`.
- `DessertService` handles network requests to fetch the list of desserts and their detailed information. It uses URLSession to make asynchronous network calls and decodes the JSON response into `Dessert` models.
- The fetched data is cached using UserDefaults to avoid repeated network calls when the app is relaunched.

### Displaying Data

- `ContentView` binds to the `DessertViewModel` to display the list of desserts. Each dessert is represented by a `DessertRow` in a List.
- When a user selects a dessert, `ContentView` navigates to `DessertDetailView`, which displays detailed information about the selected dessert, including the image, name, instructions, and ingredient-measurement pairs.

## Important Notes

- **Error Handling**: The app handles errors gracefully by displaying an error message when data fetching fails.
- **Loading State**: A ProgressView is displayed while the data is being fetched to provide feedback to the user.
- **Caching**: The app caches the fetched dessert data to improve performance and reduce unnecessary network calls.

### Unit Tests
    - **testFetchDessertsSuccess**: Verifies that the `DessertViewModel` correctly fetches and processes the dessert data when the network request is successful.
    - **testFetchDessertsFailure**: Ensures that the `DessertViewModel` handles errors gracefully when the network request fails.

## What I Would Add Given A Few More Hours
- **Search Feature**: Allow the user to search for a specific dessert item they know exists, without having to scroll down to it.
- **UI Testing**: I would have enjoyed adding the required code to test scrolling, tapping of a `DessertRow`, and ensuring all content exists.
- **Favorite Recipes Feature**: It would have been fun to use more data persistence, to allow user's to store recipes to quickly find in the future.

## Conclusion
**FetchDessertRecipes** showcases my ability to build a SwiftUI application that interacts with a remote API, handles asynchronous data fetching with async/await, and implement unit tests to ensure core functionality. Feel free to explore the code and tests to understand the implementation details. This project serves as a strong example of my practices in SwiftUI development.




