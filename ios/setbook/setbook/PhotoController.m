//
//  PhotoController.m
//  setbook
//
//  Created by Steve Wang on 01/04/2018.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "PhotoController.h"
#import "paper/PaperFileHelper.h"
@interface PhotoController () {
    NSTimer *timer;
    int photoTimeTick;
    PaperFileHelper *myPaperHelper;
}

@property (strong, nonatomic) IBOutlet UIButton *photoButton;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UILabel *msgLabel;

@end

@implementation PhotoController

- (BOOL)shouldAutorotate {
    NSLog(@"PhotoController shouldAutorotate!!!!!!!!");// portrait
    return YES;
}

- (void)updateLayoutsForCurrentOrientation:(UIInterfaceOrientation)toInterfaceOrientation view:(UIView *)view {
    CGAffineTransform transform = CGAffineTransformIdentity;
    view.transform = transform;
    
    NSLog(@"PhotoController ------------- updateLayoutsForCurrentOrientation");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    [self iniCaptureSession];
    
    [self setupPreviewLayer];
    
    if (![session isRunning])
        [session startRunning];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(myTicker) userInfo:nil repeats:YES];
    
    [self beautyButton:self.photoButton];
    
    photoTimeTick = 0;
    
    myPaperHelper = [[PaperFileHelper alloc] init];
    
}

-(void)myTicker{
    //increment the timer
    photoTimeTick++;
    //if we wanted to count down we could have done "timeTick--"
    
    int totalTimeTick = [super getPassTicks] + photoTimeTick;
    
    //set a text label to display the time
    int mins,secs;
    mins=totalTimeTick/60;
    secs=totalTimeTick%60;
    NSString *timeString =[NSString stringWithFormat:@"%02d:%02d",mins,secs];
    self.timerLabel.text = timeString;
}

-(void)showMessage:(NSString *)message{
    
    UIAlertController *toast =[UIAlertController alertControllerWithTitle:nil
                                                                  message:message
                                                           preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:toast animated:YES completion:nil];
    
    int duration = 3; // in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [toast dismissViewControllerAnimated:YES completion:nil];
    });
}

-(void)updateLabelMessage:(NSString *)message {
    self.msgLabel.text = message;
}

-(void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishProcessingPhotoSampleBuffer:(CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(AVCaptureBracketedStillImageSettings *)bracketSettings error:(NSError *)error
{
    NSLog(@"capture called");
    if (error) {
        NSLog(@"error : %@", error.localizedDescription);
    }

    imageString = nil;
    if (photoSampleBuffer) {
        self.photoButton.enabled = false;
        [session stopRunning];
        [self updateLabelMessage:@"Sending photp..."];
        NSData *data = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
        imageString = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

    }
    else {
        return;
    }
}

-(void) shoToastMessage:(NSString *)message {
    UILabel *lbMessage = [[UILabel alloc] init];
    lbMessage.text = message;
    lbMessage.textAlignment = NSTextAlignmentCenter;
    lbMessage.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    lbMessage.font = [UIFont systemFontOfSize:12.0];
    
    
    
}

- (void) iniCaptureSession {
    session = [[AVCaptureSession alloc] init];
    if ([session canSetSessionPreset: AVCaptureSessionPresetHigh])
        [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    AVCaptureDevice *device = nil;
    AVCaptureDeviceInput *device_input = nil;
    NSArray *devices = [AVCaptureDevice devicesWithMediaType: AVMediaTypeVideo];
    for (AVCaptureDevice *dev in devices) {
        if ([dev position] == AVCaptureDevicePositionBack)
            device = dev;
        
    }
    
    device_input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    
    if ([session canAddInput:device_input])
        [session addInput:device_input];
    
    double systemVersion = [UIDevice currentDevice].systemVersion.doubleValue;
    
    if (systemVersion >= 10.0) {
        //IOS 11.4
        _avCaptureOutput = [[AVCapturePhotoOutput alloc]init];
        [session addOutput:_avCaptureOutput];
    } else {
        //IOS 9.3
        _avStillCaptureOutput = [[AVCaptureStillImageOutput alloc]init];
        [session addOutput:_avStillCaptureOutput];
    }
}

- (void)setupPortraitPreviewLayer {
    self.preview_layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [self.preview_layer setVideoGravity: AVLayerVideoGravityResizeAspectFill];
    [self.preview_layer setFrame:self.view.bounds];
    self.preview_layer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    
    CGRect bounds=[self.view frame];
    bounds.size.height=884;
    bounds.size.width=728;
    bounds.origin.x=20;
    bounds.origin.y=20;
    self.preview_layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview_layer.bounds=bounds;
    self.preview_layer.position=CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    
    [self.view.layer addSublayer:self.preview_layer];
}

- (void)setupPreviewLayer {
    self.preview_layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [self.preview_layer setVideoGravity: AVLayerVideoGravityResizeAspectFill];
    [self.preview_layer setFrame:self.view.bounds];
    self.preview_layer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeRight;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    CGRect bounds=[self.view frame];
    bounds.size.height=screenHeight - 100;//628;
    bounds.size.width=screenWidth - 40;//984;
    bounds.origin.x=20;
    bounds.origin.y=20;
    self.preview_layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview_layer.bounds=bounds;
    self.preview_layer.position=CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    
    [self.view.layer addSublayer:self.preview_layer];
}

- (IBAction)buttonTouch:(id)sender {
    NSLog(@"touch uppppp");
    
}

- (void)setupCaptureOnIOS9 {
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in _avStillCaptureOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) { break; }
    }
    
    [_avStillCaptureOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
        self->imageString = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        
        self.photoButton.enabled = false;
        [self->session stopRunning];
    }];
}

- (void) setupCaptureOnIOS11 {
    NSDictionary *setDic = @{AVVideoCodecKey:AVVideoCodecJPEG};
    AVCapturePhotoSettings *_outputSettings = [AVCapturePhotoSettings photoSettingsWithFormat:setDic];
    
    [_avCaptureOutput setPhotoSettingsForSceneMonitoring:_outputSettings];
    [_avCaptureOutput capturePhotoWithSettings:_outputSettings delegate:self];
}

- (IBAction)takePhotoTouch:(id)sender {
    NSLog(@"touch takeeeeeeeeeeee");
    
    
    double systemVersion = [UIDevice currentDevice].systemVersion.doubleValue;
    
    if( systemVersion >= 10.0 ) {
        [self setupCaptureOnIOS11];
    } else {
        [self setupCaptureOnIOS9];
    }
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"御笔亲批"message:@"你确定提交你的御笔亲批吗？"preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self->session startRunning];
        [self updateLabelMessage:@"Take Photo"];
        self.photoButton.enabled = true;
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"提交" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if(self->imageString != nil) {
            int usedTime = [super getPassTicks];
            if (self->photoTimeTick > 120) {
                usedTime = usedTime + self->photoTimeTick;
            }
            Boolean suc = [self->myPaperHelper postProblemAnswer:[super getProblemId] pID:self->imageString base64:[super getPaperProblemId] pPID:usedTime];
            
            if (suc) {
                [self updateLabelMessage:@"Your answer is saved."];
            }
            else {
//                [session startRunning];
                [self updateLabelMessage:@"Please try again"];
                self.photoButton.enabled = true;
                return;
            }
            
            [self.navigationController popToRootViewControllerAnimated:false];
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

