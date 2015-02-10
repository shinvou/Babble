//
//  Tweak.xm
//  Babble
//
//  Created by Timm Kandziora on 10.02.15.
//  Copyright (c) 2015 Timm Kandziora. All rights reserved.
//

#define kNewLanguage @"de"

static NSString *currentBundleIdentifier = nil;

%hook NSUserDefaults

- (id)objectForKey:(NSString *)key
{
	id object = %orig();

	if ([key isEqualToString:@"AppleLanguages"]) {
		NSMutableArray *modifiedObject_m = [NSMutableArray arrayWithArray:object];
		[modifiedObject_m replaceObjectAtIndex:0 withObject:kNewLanguage];
		NSArray *modifiedObject = [NSArray arrayWithArray:modifiedObject_m];

		NSLog(@"[Babble] Successfully changed language for %@ from '%@' to '%@'.", currentBundleIdentifier, object[0], kNewLanguage);

		return modifiedObject;
	}

	return object;
}

%end

%ctor {
	@autoreleasepool {
		currentBundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
		NSLog(@"[Babble] Injected into %@.", currentBundleIdentifier);
	}
}
