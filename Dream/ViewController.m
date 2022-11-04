//
//  ViewController.m
//  Dream
//
//  Created by duanxiancai on 2022/11/1.
//

#import "ViewController.h"
#import "dream.h"
#import "DreamFileUtil.h"

@interface ViewController ()

@end

void logFunc(const char *msg)
{
    NSLog(@"%@",[[NSString alloc]initWithUTF8String:msg]);
}

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DreamFileUtil shareInstance] createDreamFolder];
    
    setLogger((GoUintptr)logFunc);
    NSString *path = [DreamFileUtil shareInstance].dreamFolderPath;
    NSLog(@"iOS Path:%@",path);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        startFileServer(8080, (GoString){path.UTF8String,strlen(path.UTF8String)});
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        startManhuaServer(8081);
    });
    
    // Do any additional setup after loading the view.
}


@end
