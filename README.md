<p align="center" >
  <img src="swifter_logo.png" alt="Swifter" title="Swifter" width="692" height="210">
</p>

## Getting Started

###Installation

If you're using Xcode 6, Swifter can be installed by simply dragging the Swifter Xcode project into your own project and adding either the SwifteriOS or SwifterMac framework as an embedded framework.

###Usage

Instantiation with ACAccount:

`let swifter = Swifter(account: twitterAccount)`

Instantiation with OAuth:

`let swifter = Swifter(consumerKey: "", consumerSecret: "")`

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
		statuses, response in
		
		// ...

		}, failure: {
		
		// ...
		
		})
		
		
Streaming API:

	swifter.getStatusesSampleDelimited(nil, stallWarnings: nil, progress: {
		statuses, response in
		
		// ...
		
		}, failure: {
		
		// ...
		
		})

Status Update:

	swifter.postStatusUpdate("Hello, world", inReplyToStatusID: nil, lat: nil, long: nil, placeID: nil, displayCoordinates: nil, trimUser: nil, success: {
		json, response in
		
		// ...
		
		}, failure: {
		
		// ...
		
		})
		
#License

Swifter is licensed under the MIT License. See the LICENSE file for more information.
