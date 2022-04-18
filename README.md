# WeatherLookup
WeatherLookup iOS application in Swift presenting access of Location weather with the usage of MVVM-C pattern.

## Application Features
- Locate any city by typing in searchBar
- Select city from list of options 
- User will be able to see hourly weather details of selected location

## Implementation features
- MVVM-C Design pattern

## Architecture
This project is to lookup weather for MVVM-C pattern where:
- View is represented by `UIViewController` designed in Storyboard
- Model represents state objects
- ViewModel interacts with Model and prepares data to be displayed. View uses ViewModel's data either directly or through bindings to configure itself. View also notifies ViewModel about user actions like button tap.
- Coordinator is responsible for handling application flow, decides when and where to go based on events from ViewModel.

`View` <- `ViewController` <- bindings -> (`ViewModel` -> `Model`) <- bindings -> `Coordinator`
