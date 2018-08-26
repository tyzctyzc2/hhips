//
//  PhotoController.h
//  setbook
//
//  Created by Steve Wang on 01/04/2018.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVFoundation;

@interface PhotoController : UIViewController {
    AVCaptureSession *session;
    AVCaptureConnection *connection;
    AVCaptureStillImageOutputInternal *imageOutput;
    AVCaptureStillImageOutput *_stillImageOutput;
    AVCapturePhotoOutput *_avCaptureOutput;
    AVCaptureStillImageOutput *_avStillCaptureOutput;
    
    NSString *_myProbelmID;
    NSString *_myPaperProblemID;
    NSString *imageString;
    
}
@property int timerTicks;
@property NSString *myProbelmID;
@property NSString *myPaperProblemID;
@property (retain, nonatomic) AVCaptureVideoPreviewLayer *preview_layer;    

@property (weak, nonatomic) IBOutlet UIImageView *previewImage;

@end

