<p align="center" >
  <img src="swifter_logo.png" alt="Swifter" title="Swifter" width="563">
</p>

## Getting Started

###Installation

If you're using Xcode 6, Swifter can be installed by simply dragging the Swifter Xcode project into your own project and adding either the SwifteriOS or SwifterMac framework as an embedded framework.

###Usage

Swifter can be used with the 3 different kinds of authentication protocols Twitter allows. You can specify which protocol to use as show below.

Instantiation with ACAccount:

```swift
let swifter = Swifter(account: twitterAccount)
```

Instantiation with OAuth:

```swift
let swifter = Swifter(consumerKey: "", consumerSecret: "")
```

Instantiation with App Only Auth:

```swift
let swifter = Swifter(consumerKey: "", consumerSecret: "", appOnly: true)
```

##Example Requests

####OAuth Authorization:

```swift
swifter.authorizeWithCallbackURL(callbackURL, success: { accessToken, response in
	// ...

  }, failure: { error in

	// ...

})
```

####Get Home Timeline:

```swift
swifter.getStatusesHomeTimelineWithCount(20, success: { statuses in
	// ...

	}, failure: { error in
    // ...

})
```

####Streaming API:

```swift
swifter.getStatusesSampleDelimited(progress: { status in
	// ...

  }, stallWarnings: { code, message, percentFull in
    // ...

  }, failure: { error in
    // ...

})
```

####Status Update:

```swift
swifter.postStatusUpdate("Hello, world", success: { status in
    // ...

  }, failure: { error in
    // ...

})
```

##JSON Handling

To make accessing data returned by twitter requests, Swifter provides a class for representing JSON which you interact with similarly to a dictionary. The main advantage of using this instead of a Dictionary<String, AnyObject> is that it works better with Swift's strict typing system and doesn't require you to constantly downcast accessed objects. It also removes the need for lots optional chaining, making your code much cleaner and easier to read.

Here's an example of how you would access the text of the first element in list of statuses:

```swift
if let statusText = statuses[0]["text"].string {
    // ...
}
```

##OAuth Consumer Tokens

In Twitter REST API v1.1, each client application must authenticate itself with consumer key and consumer secret tokens. You can request consumer tokens for your app on Twitter's website: https://dev.twitter.com/apps.

#License

Swifter is licensed under the MIT License. See the LICENSE file for more information.
