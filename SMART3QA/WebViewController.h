#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController {
    IBOutlet UIWebView *webView;
}

- (void)loadWebpageFromUrl:(NSURL *)string;
- (void)loadWebpageFromString:(NSString *)url;

@end