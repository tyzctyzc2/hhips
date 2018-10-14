//
//  PhotoController.h
//  setbook
//
//  Created by Steve Wang on 01/04/2018.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseViewController.h"
@import AVFoundation;

@interface PhotoController : MyBaseViewController {
    AVCaptureSession *session;
    AVCaptureConnection *connection;
    AVCaptureStillImageOutputInternal *imageOutput;
    AVCaptureStillImageOutput *_stillImageOutput;
    AVCapturePhotoOutput *_avCaptureOutput;
    AVCaptureStillImageOutput *_avStillCaptureOutput;
    
    NSString *imageString;
    
}
@property (retain, nonatomic) AVCaptureVideoPreviewLayer *preview_layer;    

@property (weak, nonatomic) IBOutlet UIImageView *previewImage;

@end

