
# Moneybox iOS Technical Challenge

## The Brief

To create a 'light' version of the Moneybox app that will allow existing users to login and check their account balance, as well as viewing their Moneybox savings. 
- To clone this repository into your private repository and implement the solution.
 
### The app should have
- A login screen to allow existing users to sign in
- A screen to show the accounts the user holds, e.g. ISA, GIA
- A screen to show some details of the account, including a simple button to add money to its moneybox.
- The button will add a fixed amount of £10. It should use the `POST /oneoffpayments` endpoint provided, and the account's Moneybox amount would be updated.

A prototype wireframe of all 3 screens is provided as a guideline. You are free to provide additional information if you wish.
![](wireframe.png)

### What we are looking for
 - **Showcase what you can do. It can be a refined UI, or enhanced UX, or use of specific design patterns in the code, or anything that can make the project stand out.**
 - Demonstration of coding style, conventions and patterns.
 - A tidy code organisation.
 - Use of autolayout and UIKit.
 - Implementation of unit tests.
 - Any accessibility feature would be a bonus.
 - The application must run on iOS 15 or later.
 - Any 3rd party library should be integrated using Swift Package Manager.

### API Usage
The Networking methods and Models for requests and responses are ready-made in the Networking module of the project.

#### Base URL & Test User
The base URL for the moneybox sandbox environment is `https://api-test02.moneyboxapp.com/`. </br>
You can log in using the following user:

|  Username          | Password         |
| ------------- | ------------- |
| test+ios@moneyboxapp.com  | P455word12  |

#### Authentication
You should obtain a bearer token from the Login response, and attach it as an Authorization header for the endpoints. Helper methods in the API/Base folder should be used for that.
(Note: The BearerToken has a sliding expiration of 5 mins).

| Key  |  Value  |
| ------------- | ------------- |
| Authorization |  Bearer TsMWRkbrcu3NGrpf84gi2+pg0iOMVymyKklmkY0oI84= |

#### API Call Hint

```
let dataProvider = DataProvider()
dataProvider.login(request: request, completion: completion)
```
request: Initialize your request model </br>
Completion: Handle your API success and failure cases

## Unit Tests
The MoneyBoxTests folder includes stubbed data to easily mock the responses needed for unit testing

#### Usage Hint
You can create a DataProviderMock class via inject DataProviderLogic protocol </br>
You can mock response in Login.json file like this:
```
StubData.read(file: "Login", callback: completion)
```

### How to Submit your solution:
 - To share your Github repository with the user valerio-bettini.
 - (Optional) Provide a readme in markdown which outlines your solution.

## Good luck!



**The Brief:**
-  MVVM
-  A login screen to allow existing users to sign in
-  A screen to show the accounts the user holds, e.g. ISA, GIA
-  A screen to show some details of the account, including a button to add money to its moneybox.
-  The button adds a fixed amount of £10. It uses the POST /oneoffpayments endpoint provided, and the account's Moneybox amount would be updated.

Used MVVM to have a better separation of concerns and make it more modularised than using MVC, as well as avoiding the massive view controllers, and to future proof the app. If the app needs to be expanded and have more screens and more users,  using MVVM allows for more flexibility, and scalability. Used the endpoints provided to post and fetch as requested. 
For an even greater separation of concerns and better modularisation and scalability I would have added a Coordinator to handle navigation etc. I didn't add it, for a larger app would have made a lot of sense having it, but for a three screens app might not have been needed. 

Login: 
- LoginView
- LoginViewModel
- LoginViewController

Accounts: 
- AccountView
- AccountsViewModel
- AccountsViewController

Account Details: 
- AccountDetailView
- AccountDetailViewModel
- AccountDetailViewController


**List of improvements:**

**General and Architectural:** 
- For a larger app use MVVM-C
- Add Coordinators for flows management and navigation. 
- Add more tests.
- Add Regular Expressions (Regex) for sign up and login. 
- Add reset token feature. 
- Add Strings in separate file for safe reuse. 

**Performance improvements:** 
- Minimise network requests
- Caching
- Pagination
- Lazy Loading
- Data persistence
- Use Core Data for local data storage
- UserDefaults: As a lightweight key-value pair approach to store data for the user name, if the user has done onboarding, etc. 
- Keychain: Use Keychain to save sensitive user data, such as passwords or login credentials. For example, to implement the persistent login feature.

**Accessibility Improvements:**
- Make sure that all labels and UI elements scale correctly when the text is scaled up. 
- Make sure colour contrast are valid for Accessibility.
- Make sure elements are readable by VoiceOver. 

**Security improvements:** 
- SSL pinning
- Timely Library Updates
- User education (tell them about safe passwords, etc)
- 2FA (if needed)
- Secure code practices.

**External Libraries:** 
- Lottie for animations.
- Firebase Crashlytics for analytics.
- Swift Lint for style and conventions.  

**Screenshots:** 
![Simulator Screenshot - iPhone 14 Pro - 2024-12-02 at 15 55 46](https://github.com/user-attachments/assets/e21412a0-504c-41b4-927f-0fece7b81c8c)
![Simulator Screenshot - iPhone 14 Pro - 2024-11-29 at 00 40 50](https://github.com/user-attachments/assets/ecd0e2d6-949c-458d-96fa-8ce6d0af6656)
![Simulator Screenshot - iPhone 14 Pro - 2024-11-29 at 00 40 57](https://github.com/user-attachments/assets/f57cdace-ec19-4423-a7f4-3d482b0e1939)
![Simulator Screenshot - iPhone 14 Pro - 2024-11-29 at 00 41 00](https://github.com/user-attachments/assets/90f05cc0-9718-4fb1-b484-4dfb0ebca458)
<img width="990" alt="Screenshot 2024-11-28 at 19 09 30" src="https://github.com/user-attachments/assets/9b05556d-fadf-4ad1-b2eb-22b04e97f6dc">
<img width="1055" alt="Screenshot 2024-11-28 at 19 09 16" src="https://github.com/user-attachments/assets/d1ae45df-0f51-4266-9bad-d78b83846673">
<img width="968" alt="Screenshot 2024-11-28 at 19 09 04" src="https://github.com/user-attachments/assets/53e8ae0d-32f0-402c-bdbf-a52d5edb1865">
<img width="953" alt="Screenshot 2024-11-27 at 22 28 12" src="https://github.com/user-attachments/assets/c951cd76-8293-491f-834b-4726911eae06">


