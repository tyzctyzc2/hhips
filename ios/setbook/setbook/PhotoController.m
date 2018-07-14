//
//  PhotoController.m
//  setbook
//
//  Created by Steve Wang on 01/04/2018.
//  Copyright © 2018 Steve Wang. All rights reserved.
//

#import "PhotoController.h"
#import "HttpHelper.h"
@interface PhotoController () {
    NSTimer *timer;
    int photoTimeTick;
}

@property (strong, nonatomic) IBOutlet UIButton *photoButton;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UILabel *msgLabel;

@end

@implementation PhotoController
- (void) setProblemID:(NSString *) _problemID {
    self.myProbelmID = _problemID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    // Do any additional setup after loading the view, typically from a nib.
    
    [self iniCaptureSession];
    
    [self setupPreviewLayer];
    
    if (![session isRunning])
        [session startRunning];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(myTicker) userInfo:nil repeats:YES];
    
    self.photoButton.layer.borderWidth =2.0f;
    self.photoButton.layer.borderColor= self.view.tintColor.CGColor;
    self.photoButton.layer.cornerRadius=16.0f;
    
    photoTimeTick = 0;
    
}

-(void)myTicker{
    //increment the timer
    photoTimeTick++;
    //if we wanted to count down we could have done "timeTick--"
    
    int totalTimeTick = _timerTicks + photoTimeTick;
    
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

/*        int usedTime = _timerTicks;
        if (photoTimeTick > 120)
            usedTime = usedTime + photoTimeTick;
        HttpHelper *httpH = [HttpHelper new];
        Boolean suc = [httpH postProblemAnswer:_myProbelmID pID: imageString base64: _myPaperProblemID pPID: usedTime];
        
        if (suc) {
            [self updateLabelMessage:@"Your answer is saved."];
        }
        else {
            [session startRunning];
            [self updateLabelMessage:@"Please try again"];
            self.photoButton.enabled = true;
            return;
        }*/
    }
    else {
        return;
    }
    
/*    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Main"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];*/
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
    
    
    _avCaptureOutput = [[AVCapturePhotoOutput alloc]init];
    [session addOutput:_avCaptureOutput];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return NO;
}

- (void)setupPreviewLayer {
    self.preview_layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [self.preview_layer setVideoGravity: AVLayerVideoGravityResizeAspectFill];
    [self.preview_layer setFrame:self.view.bounds];
    self.preview_layer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeRight;
    
    CGRect bounds=[self.view frame];
    bounds.size.height=628;
    bounds.size.width=984;
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

- (IBAction)takePhotoTouch:(id)sender {
    NSLog(@"touch takeeeeeeeeeeee");
    
    
    
    NSDictionary *setDic = @{AVVideoCodecKey:AVVideoCodecJPEG};
    AVCapturePhotoSettings *_outputSettings = [AVCapturePhotoSettings photoSettingsWithFormat:setDic];
    
    [_avCaptureOutput setPhotoSettingsForSceneMonitoring:_outputSettings];
    
    [_avCaptureOutput capturePhotoWithSettings:_outputSettings delegate:self];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"御笔亲批"message:@"你确定提交你的御笔亲批吗？"preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [session startRunning];
        [self updateLabelMessage:@"Take Photo"];
        self.photoButton.enabled = true;
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"提交" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if(imageString != nil) {
            int usedTime = _timerTicks;
            if (photoTimeTick > 120)
                usedTime = usedTime + photoTimeTick;
            HttpHelper *httpH = [HttpHelper new];
            Boolean suc = [httpH postProblemAnswer:_myProbelmID pID: imageString base64: _myPaperProblemID pPID: usedTime];
            
            if (suc) {
                [self updateLabelMessage:@"Your answer is saved."];
            }
            else {
//                [session startRunning];
                [self updateLabelMessage:@"Please try again"];
                self.photoButton.enabled = true;
                return;
            }
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Main"];
            vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:vc animated:YES completion:NULL];
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

