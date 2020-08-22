# Reddit-Code-Challenge


This is my take home challenge for an interview process. 

<p align="center"><img src="https://user-images.githubusercontent.com/42280875/90965687-4a7e6b80-e47f-11ea-9faf-8a9bbfe6e085.png" width ="100" height = "100"></p>


## Objective

Per the objective outlined, my goal is to: 

- Create an iOS application that lists reddit posts in a table view. 
- Contain the post name along with the subreddit category name within each table view cell. 
- Include UI that allows a user to type in a subreddit category (perhaps in a text field or an alert view with plain text input) and display only posts belonging to that subreddit category when they click submit (perhaps the table will get reloaded with new data, or show a new table view).
- The url attached to the post should open in a basic web view (don't worry if content looks funny as not all urls will be responsive in their design) when a user taps on a table view cell.


## Process

Following the guidelines I created a `UITableview` and attached a `UISearchResultsUpdating` and `UISearchBarDelegate` to the view in order to add a search bar and delegate methods for handling text input within the search bar. I attached a function to the searchbar button on the keyboard, to search the specific typed text for  subreddits with the associated typed text.

Within the tableview, I created a `loadData` function that pulls from any string to a url, and added a pull to refresh function to reload the data should the data not pull initially, or the user wishes to update the data for that subreddit. This data is pulled from `www.reddit.com/.json` as recommended via the guidelines, however there is a second URL `https://www.reddit.com/r/\(urlString)/.json` for when a subreddit is searched or updated via the refresh function `searchSubreddit`. The refresh tool is using a `UIRefreshControl` that is placed above the tableview and main view, displaying shortly while the data is reloaded.

I created a "Home" button at the top using an SF Symbol to designate the "reset" back to the core `www.reddit.com/.json` URL so the user can return to the main feed.

The Model for the Reddit data was created by looking at the parsed JSON via a parser website where, with my knowledge of the site, I was able to determine the quantifiable sources for data and create a matching model. The data is nested from `Model` -> `Listing` -> `Post` -> `PostData` with the core of the data being pulled from `PostData` to display the URL, title, vote count and subreddit name in each tableview cell when the data loads.

On tap of each post cell, it pulls the URL from the post and displays it with a `WKWebView` which required me to import `WebKit` into that detail. 

## Design

For the design elements, I decided to use most of the colors associated with Reddit, but in the iOS 13 introduced system colors for dark mode compatibility. I used `systemOrange` for the title, "home" button and vote count. I used `systemBlue` for the subreddit name as well as `label` and `secondaryLabel` for the post title and URL respectively. The app icon I created in Sketch using their iOS app icon template. I also decided to use the `Avenir` family of fonts to create a distictive and minimal style to the wording.

## Images

Below are screenshots of the app running on an iPhone 11 Pro Max:


<p align="center"><img src="https://user-images.githubusercontent.com/42280875/90965541-d2fc0c80-e47d-11ea-99ae-1c3dc1fd36f7.png" width ="200" height = "425"><img src="https://user-images.githubusercontent.com/42280875/90965542-d4c5d000-e47d-11ea-9985-e65095cf0792.png" width ="200" height = "425"><img src="https://user-images.githubusercontent.com/42280875/90965544-d7282a00-e47d-11ea-9f99-dadfcb32f620.png" width ="200" height = "425"></p>







