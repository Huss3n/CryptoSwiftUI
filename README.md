# Crypto App
## Overview
Crypto App is a mobile application built using Swift and SwiftUI. It leverages the CoinGecko API to fetch cryptocurrency data and displays it in a list.
The app utilizes CoreData for local storage, ensuring a seamless experience for users. It follows the MVVM (Model-View-ViewModel) architecture, making the codebase modular and maintainable.

## App Screenshots
<p>
   <img src="https://github.com/Huss3n/CryptoSwiftUI/blob/main/Screenshots/homescreen.png", width="200"/>
   <img src="https://github.com/Huss3n/CryptoSwiftUI/blob/main/Screenshots/portfolioscreen.png", width="200"/>
   <img src="https://github.com/Huss3n/CryptoSwiftUI/blob/main/Screenshots/detailsUp.png", width="200"/>
   <img src="https://github.com/Huss3n/CryptoSwiftUI/blob/main/Screenshots/detailsDown.png", width="200"/>
   <img src="https://github.com/Huss3n/CryptoSwiftUI/blob/main/Screenshots/editportfolio.png", width="200"/>
   <img src="https://github.com/Huss3n/CryptoSwiftUI/blob/main/Screenshots/searchView.png", width="200"/>
   <img src="https://github.com/Huss3n/CryptoSwiftUI/blob/main/Screenshots/settingscreen.png", width="200"/>
</p>

## Features
- <b>CoinGecko API Integration:</b> The app fetches real-time cryptocurrency data from the <a href="https://www.coingecko.com/">CoinGecko API</a>, providing users with up-to-date information on various coins.
- <b>Swift and SwiftUI:</b> Built with Swift, Apple's powerful and intuitive programming language, and SwiftUI, a modern UI framework for building declarative user interfaces.
- <b>CoreData for Storage:</b> CoreData is employed for efficient and reliable local data storage, ensuring a smooth user experience even when offline.
- <b>Combine Framework:</b> The app utilizes the Combine framework to work with asynchronous and event-driven code. Publishers and subscribers are employed to manage and respond to changes in data.
- <b>MVVM Architecture:</b> Following the MVVM architectural pattern enhances code organization and separation of concerns, making the app more scalable and maintainable.
- <b>Portfolio Management:</b> Users can store their portfolio coins within the app. This information is securely saved to CoreData, allowing users to track and manage their cryptocurrency investments.
- <b>External Links:</b> The app includes links to external websites and Reddit pages for each coin, providing users with easy access to additional information.

## Requirements
- iOS 14.0+
- Xcode 12.0+
- Internet connection for real-time data updates

## Getting Started
1. Clone the repository to your local machine.
```
git clone https://github.com/Huss3n/CryptoSwiftUI.git
```
2. Open the Xcode project file (CryptoApp.xcodeproj).
3. Build and run the app on a simulator or a physical device running iOS 14.0 or later.
4. Explore the app's features and functionalities, including external links to coin websites and Reddit pages.

## External Links
- Coin Website: Explore more about the coin on its official website. 
- Reddit Page: Join the community discussions on Reddit.

## Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or create a pull request.
## License
This project is licensed under the <a href = "https://opensource.org/license/mit/"> MIT License.</a>
