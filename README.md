# World 🌏
This application fetches and displays continents and countries.

## Technical Details
- Applied Clean Artchitecture
- Applied MVVM Design Pattern
- Implemented Coordinator to manage the application flow
- Used Dependency Injection Container to manage dependencies
- Used grapQL using Apollo framework to fetch data from api (https://countries.trevorblades.com/)
- Written some Unit Tests covering ViewModels
- Used RxSwift for ViewModel bindings
- Used Diffable Data Source to provide data source for UITableView
- Supporting both Dark and Light modes
- Used Swift Package Manager for third party frameworks
- Used UIKit

## Flow
- Application starts with HomeScene, which displays all continents in an accordion styled list
- Expanding a continent section shows country list
- Tapping a country opens DetailScene, which displays even more detail

## Screenshots

### Dark Mode
<p align="center">
  <img src="Screenshots/Dark/1.png" width="250">
    <img src="Screenshots/Dark/2.png" width="250">
      <img src="Screenshots/Dark/3.png" width="250">
</p>

### Light Mode
<p align="center">
  <img src="Screenshots/Light/1.png" width="250">
    <img src="Screenshots/Light/2.png" width="250">
      <img src="Screenshots/Light/3.png" width="250">
</p>
