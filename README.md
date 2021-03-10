## Build Tools & Versions Used.
Xcode 12.4. App supports iOS 13+, however I mainly tested on iOS 14.4. You may need to `cd` into the project structure and run `pod install` in order to download the CocoaPod dependency.

## Your Focus Areas.
1. MVVM
- This allows for a highly testable and scalable app which can be tested. All UI code is kept to the View Controllers, and data is held and managed in the ViewModel or elsewhere.
2. Clean / Minimalistic code with comments where necessary
3. Extremely high code coverage (>90%)
4. Dependency Injection, Mocked JSON files to properly write unit tests without relying on a network
- A good example of this is in the `Networking` class and associated test file. By doing this, we avoid relying on an active network - and a result having flaky tests.
5. UI created programmatically
- I adopted a non-storyboard approach since I find it is much better for PR reviews and readability.
6. Support for portrait and landscape modes
7. Accessibility - readouts are clear and localized
- Accessibility bugs can have legal repercussions, so it is extremely important to the app is ADA complaint and has clear readouts
- Supports dynamic font sizes! (Check screenshots below)
8. Localization (english / spanish support for now)
9. Automatic image caching with UIImageView subclass
- I subclassed `UIImageView` and have our subclassed image view interact with our Networking and Caching layer. This will prevent multiple networking calls from firing off for the same asset.
10. Code layering (Networking, Caching, Employees Service, UI) all within its own distinct areas and easy to maintain / scale for more functionality
- Every class has a distinct and direct purpose. If multiple areas of functionality are required, then an object reference will be passed accordingly where needed.
11. Low Memory Handling - the caching layer will wipe data in this case
12. TDD - smaller commits targeting certain "layers" with associated tests

## Copied-in code or copied-in dependencies.
None, other than `SwiftProtobuf` 1.0 via CocoaPods. UI inspired (but heavily adapted for this project) by previous personal projects and tutorials.

## Tablet / phone focus.
Phone focus - tested both notched and non-notched devices.

## How long you spent on the project.
About 5 hours over the course of a day.

## Anything else you want us to know.
1. While I did not have to use Protocol Buffers, I was aware the company uses them extensively - so I implemented it for the `Employee` / `Employees` model (also to improve performance)
2. Since there are no UI tests now, accessibility specific ones have not been created

## Possible Future Improvements
1. Building upon networking layer, implementing POST, PATCH, DELETE, etc..
2. Abstracting out caching later to support more than <NSString, NSData> types
3. Core Data if persistent storage was a requirement in the future
4. Integration / Snapshot tests
5. Analytics
6. Support for more locales (right now only english/spanish)
7. SwiftUI
8. Better UI support for slow connectivity edge case (i.e "Still Loading..." alert/pop-up after a few seconds)
9. More testing mocks (i.e for EmployeeListViewModel in CachedImageViewTests) - this would allow for greater scalability/flexibility in the future
10. Better UITableViewCell constraints for edge cases
- If dynamic font size text is super big the employee cell should not waste any space at the top or bottom
- Profile image view should scale up/down slightly while maintaining 1:1 aspect ratio

## Architecture Diagram
![Architecture Diagram](https://i.ibb.co/YPT6BTT/Employee-Directory.png)

## App Screenshots
Normal Dynamic Font Size

![Normal Dynamic Font Size](https://i.ibb.co/hVsnh3p/Simulator-Screen-Shot-i-Pod-touch-7th-generation-2021-03-10-at-17-52-32.png)

Large Dynamic Font Size

![Large Dynamic Font Size](https://i.ibb.co/JqYwvg7/Simulator-Screen-Shot-i-Pod-touch-7th-generation-2021-03-10-at-17-52-46.png)
