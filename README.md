# 🎥 CoolMovies - Flutter Movie App

Welcome to **CoolMovies**, a Flutter app designed to showcase my skills in mobile development, featuring the BLoC architecture, GraphQL API integration, offline functionality, and more. This project simulates a movie application where users can browse movies, view details, and leave reviews.

## 🚀 Features

- **Movie Listings**: Display a comprehensive list of available movies.
- **Movie Details**: Tap on a movie to open a detailed view that includes all available information about the movie and user reviews.
- **User Reviews**: Each movie page shows all reviews and the average user rating.
- **Create Reviews**: Users can write and submit reviews by entering a rating (0-5 stars), a title, and a description.
- **Offline Support**: Cached data allows users to see movies and reviews when offline. Users can also create reviews while offline, which are synced when back online.
- **Error Handling**: Displays a user-friendly "Something went wrong" screen with a retry option when there's no internet connection.

## 🛠️ Technologies Used

- **Flutter**: For building the user interface and ensuring a smooth, cross-platform experience.
- **BLoC Architecture**: To manage state efficiently and separate the app into well-structured layers:
  - **Presentation**: UI components and user interactions.
  - **Business Logic**: Handles the application logic, powered by BLoC.
  - **Data**: Manages repositories and GraphQL API interactions.
- **GraphQL API**: For fetching data about movies and reviews from the backend.
- **Local Caching**: Ensures data is available when the user is offline and allows for review submissions to be synced once the device is back online.

## 💾 Important Notes

One of the key highlights of this project is the use of **conventional commits**. The commit messages follow best practices to ensure clarity and consistency throughout the development process, making it easier to track changes and improvements in the codebase.

## 📸 Screenshots

1. **Loading Screen**  
   The app starts with a loading screen that displays the CoolMovies logo and a loader.

![1](https://github.com/user-attachments/assets/0e6bbee1-1578-4ddf-ab62-28f8dacd4ab6)

2. **Main Page**  
   A scrollable list of movie cards, showcasing available movies with titles and posters.

![2](https://github.com/user-attachments/assets/4f988e36-6701-41b0-a14e-efdc9ac96af6)

3. **Movie Detail Page**  
   Displays detailed information about a specific movie, including reviews and ratings. Users can also create new reviews directly from this page.

![3](https://github.com/user-attachments/assets/6695ad3e-8c92-45ec-ac84-c7096dfe2b70)

4. **Review Modal**  
   When creating a review, users are presented with a modal where they can rate the movie (0-5 stars), add a title, and write a description.

![4](https://github.com/user-attachments/assets/36ce0a79-97ce-4ae5-b735-feae5c2929cc)

5. **Error Screen**  
   In case of connectivity issues, a black screen with a "No Wi-Fi" icon and a "Something went wrong" message appears, along with a retry button to reload the content.

![5](https://github.com/user-attachments/assets/348c5c4b-1333-4346-af4b-bb74a75f6ff5)


