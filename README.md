# Backchannel iOS SDK

Backchannel is a quick, convenient way for your beta testers to report their feedback — right from within your app itself. With the tap of a button, they can report a bug, offer feedback on a new feature, or simply ask a question. Backchannel can also detect when users take screenshots of your app, and guide them to the correct feedback channel, with the screenshot already attached.

## Quality

Backchannel is a great citizen in your app.

* Backchannel is open-source, so it's easy to see how things work.
* Backchannel's classes are all under 250 lines of code.
* Backchannel is standalone; it has no dependencies.
* Backchannel has a three-letter class prefix, `BAK`, to prevent collisions.
* Backchannel doesn't do any swizzling.
* Backchannel has zero categories. Your app's Foundation classes are safe.
* Backchannel unit tests coverage is the probably more real mesure of it's quality :sadpanda:

## Requirements

* iOS 7.0+
* Xcode 6.3

## Installation

You can use CocoaPods to install Backchannel.

## Usage

The simplest way to present Backchannel is to use `Backchannel` class. Wire up a button like so:

	- (IBAction)buttonTapped:(id)sender {
	    [[Backchannel setAPIKey:@"your_api_key"] presentModallyOverViewController:self];
	}

Once the API key is set, you can use the `+backchannel` class method to access Backchannel.

### Screenshot detection

To use Backchannel's screenshot detection features, Backchannel needs to know your app's `rootViewController`. To configure it, set up Backchannel with an API key and a root view controller during your app's initialization:

	//...
	[Backchannel setAPIKey:@"your_api_key" rootViewController:rootViewController];
	//...

After this API key is set, you can use the `+backchannel` class method to present Backchannel:

	- (IBAction)buttonTapped:(id)sender {
	    [[Backchannel backchannel] presentModallyOverViewController:self];
	}
		
## Contributing

Pull requests are always welcome!

## License

Backchannel is available under the MIT license. See the LICENSE file for more info.
