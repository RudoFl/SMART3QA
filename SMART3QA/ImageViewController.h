#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController {
    IBOutlet UIImageView *imageView;
}

- (void)loadImage:(UIImage *)image;

@end