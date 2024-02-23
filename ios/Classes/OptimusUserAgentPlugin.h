#import <sys/utsname.h>
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
#import <WebKit/WebKit.h>

@interface OptimusUserAgentPlugin : NSObject<FlutterPlugin>
@property (nonatomic) bool isEmulator;
@property (nonatomic) WKWebView* webView API_AVAILABLE(ios(11.0));
@end
