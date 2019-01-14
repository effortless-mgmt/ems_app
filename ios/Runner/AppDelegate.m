#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Property List with private keys, gitignored.
    NSDictionary *keyDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"secret_keys" ofType:@"plist"]];

    //NSDictionary *keyDict = [NSDictionary dictionaryWithContentsOfFile:@"secret_keys.plist"];
    printf("This is a test!");
    
    
    [GMSServices provideAPIKey:keyDict[@"google_maps_api_key"]];
    [GeneratedPluginRegistrant registerWithRegistry:self];
    // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
