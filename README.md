<p align="center" >
  <img src="swifter_logo.png" alt="Swifter" title="Swifter" width="692">
</p>

## Getting Started

###Installation

If you're using Xcode 6, Swifter can be installed by simply dragging the Swifter Xcode project into your own project and adding either the SwifteriOS or SwifterMac framework as an embedded framework.

###Usage

Swifter can be used with the 3 different kinds of authentication protocols Twitter allows. You can specify which protocol to use as show below. 

Instantiation with ACAccount:

`let swifter = Swifter(account: twitterAccount)`

Instantiation with OAuth:

`let swifter = Swifter(consumerKey: "", consumerSecret: "")`

Instantiation with App Only Auth:

`let swifter = Swifter(consumerKey: "", consumerSecret: "", appOnly: true)`

###Example Requests

OAuth Authorization:

	swifter.authorizeWithCallbackURL(callbackURL, success: {
		accessToken, response in

		// ...

		},
		failure: {

		// ...

		})

Get Home Timeline:

	swifter.getStatusesHomeTimelineWithCount(20, sinceID: nil, maxID: nil, trimUser: true, contributorDetails: false, includeEntities: true, success: {
        (statuses: Dictionary<String, AnyObject>[]?) in

		// ...

		}, failure: {
            (error: NSError) in

            // ...

		})


Streaming API:

	swifter.getStatusesSampleDelimited(nil, stallWarnings: nil, progress: {
		(status: Dictionary<String, AnyObject>?) in

		// ...

		}, stallWarnings: {
            (code: String?, message: String?, percentFull: Int?) in

            // ...

        }, failure: {
            (error: NSError) in

            // ...

		})

Status Update:

	swifter.postStatusUpdate("Hello, world", inReplyToStatusID: nil, lat: nil, long: nil, placeID: nil, displayCoordinates: nil, trimUser: nil, success: {
		(status: Dictionary<String, AnyObject>?) in

        // ...

        }, failure: {
            (error: NSError) in

            // ...

        })

##OAuth Consumer Tokens

In Twitter REST API v1.1, each client application must authenticate itself with consumer key and consumer secret tokens. You can request consumer tokens for your app on Twitter's website: https://dev.twitter.com/apps.

#License

Swifter is licensed under the MIT License. See the LICENSE file for more information.
