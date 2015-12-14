# Change Log

## 1.0.1 (12/14/2015)

Version 1.0.1 is the first bug fix release for the Backchannel SDK. It can be found at tag [`v1.0.1`](https://github.com/backchannel/BackchannelSDK-iOS/releases/tag/1.0.1).

It fixes several bugs: 

* `BAKCache` is now enabled, for faster loading of content
* `BAKChannelPickerViewController` is no longer a view controller, since the view controller wasn't allowing its view to be used as an `inputView` for a `UITextField`.
* If the keychain is storing an invalid token, it will log the user out when Backchannel opens and update the UI accordingly.
* When a user logs in when trying to post a message, the UI is updated accordingly.
* A new singleton getter has been added for Swift compatibility: `sharedBackchannel()`. Previously, Swift was replacing the `-backchannel` method with a traditional constructor.
* `BAKAttachment` only loads attachments of type `image` now.
* A bug with reused avatar images is now fixed.
* A bug where a message attachment would sometimes show up is now fixed.
* Deleting a message now smoothly animates.
* Loading indicators have been added to the attachment preview and the full-size `BAKAttachmentViewController`.

## 1.0 (11/3/2015)

Verison 1.0 contains the initial version of the Backchannel SDK. It can be found at tag [`v1.0`](https://github.com/backchannel/BackchannelSDK-iOS/releases/tag/1.0). It includes

* Messaging functionality
* Attachment uploading and viewing
* Screenshot detection
* Log in, sign up, profile completion