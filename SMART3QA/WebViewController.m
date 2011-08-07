#import "WebViewController.h"

@implementation WebViewController

- (void)loadWebpageFromUrl:(NSURL *)url
{
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}
- (void)loadWebpageFromString:(NSString *)string
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", string]];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

@end