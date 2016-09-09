<p align="center" >
  <img src="swifter_logo.png" alt="Swifter" title="Swifter" width="563">
</p>

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
## Getting Started

### Installation

If you're using Xcode 6 and above, Swifter can be installed by simply dragging the Swifter Xcode project into your own project and adding either the SwifteriOS or SwifterMac framework as an embedded framework.

### Swifter 2.0

With the introduction of Swift 3, the naming convention of the language was changed. As a result, Swifter was updated to match the updated naming conventions of Swift. Additionally, we've slimmed down the framework and simplified a lot of the processes with the introduction of the `ListTag`, `UserTag`, and `UsersTag` enums for methods that allow for either id/slug for Lists, or id/screenName for Users.

### Usage

Swifter can be used with the 3 different kinds of authentication protocols Twitter allows. You can specify which protocol to use as show below. For more information on each of the authentication protocols, please check [Twitter OAuth Help](https://dev.twitter.com/oauth).

Instantiation with ACAccount:

```swift

// Instantiation using ACAccount
var swifter = Swifter(account: twitterAccount)

// Instantiation using Twitter's OAuth Consumer Key and secret
swifter = Swifter(consumerKey: TWITTER_CONSUMER_KEY, consumerSecret: TWITTER_CONSUMER_SECRET)

// Instantiation using App-Only authentication
swifter = Swifter(consumerKey: TWITTER_CONSUMER_KEY, consumerSecret: TWITTER_CONSUMER_SECRET, appOnly: true)

```

## Example Requests

#### OAuth Authorization:

```swift
swifter.authorize(with: callbackURL, success: { accessToken, response in
  // ...
}, failure: { error in
  // ...
})
```

#### Get Home Timeline:

```swift
swifter.getHomeTimeline(count: 50, success: { json in
  // ...
}, failure: { error in
  // ...
})
```

#### ListTag, UserTag, and UsersTag
Certain  Twitter API allows you to use either the `user_id` or `screen_name` to get user related objects (and `list_id`/`slug` for lists). Swifter offers a solution so that the user won't accidentally use the wrong method, and have nothing returned. For more information, check the `SwifterTag.swift` file.

```swift
swifter.getUserFollowersIDs(for: .id(userId), success: { json, prev, next in
    // alternatively, you can use .screenName(userName)
    // ...
}, failure: { error in
    // ...
})

```

```swift

swifter.getListSubscribers(for: .slug(listSlug, owner: .screenName(userName)), success: { json, prev, next in
    // alternatively, you can use .id(listId)
    // ...
}, failure: { error in
    // ...
})

```
Additionally, there is also `.screenName(arrayOfUserNames)` and `.id(arrayOfIds)` for methods that take arrays of screen names, or userIDs

#### Streaming API:

```swift
swifter.streamRandomSampleTweets(progress: { status in
  // ...
}, stallWarnings: { code, message, percentFull in
  // ...
}, failure: { error in
  // ...
})
```

#### Status Update:

```swift
swifter.postTweet(status: "Hello, world.", success: { status in
  // ...
}, failure: { error in
  // ...
})
```

## JSON Handling

To make accessing data returned by twitter requests, Swifter provides a class for representing JSON which you interact with similarly to a dictionary. The main advantage of using this instead of a Dictionary<String, AnyObject> is that it works better with Swift's strict typing system and doesn't require you to constantly downcast accessed objects. It also removes the need for lots optional chaining, making your code much cleaner and easier to read.

Here's an example of how you would access the text of the first element in list of statuses:

```swift
if let statusText = statuses[0]["text"].string {
    // ...
}
```

## OAuth Consumer Tokens

In Twitter REST API v1.1, each client application must authenticate itself with consumer key and consumer secret tokens. You can request consumer tokens for your app on [Twitter's dev website](https://dev.twitter.com/apps)

# License

Swifter is licensed under the MIT License. See the LICENSE file for more information.
