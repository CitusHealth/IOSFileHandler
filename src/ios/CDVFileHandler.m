//
//  CDVFileHandler.m
//  CordovaLib
//
//  Created by Chinnu M V on 2/22/17.
//
//

#import "CDVFileHandler.h"

@implementation CDVFileHandler

NSString  *fileName = @"sound.caff";
NSString *documentPath;

- (void)fileCopytoBundle:(CDVInvokedUrlCommand*)command{
    
    

    bool result = NO;
    CDVPluginResult* pluginResult = nil;
    NSString* myarg = [command.arguments objectAtIndex:0];
    fileName = myarg;
    

    /* Path for documents Folder
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentPath = [NSString stringWithFormat:@"%@/%@",documentsDirectory,fileName];
    */
    
    // Bundle Path
    documentPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"caf"];
    NSLog(@"Path-%@",documentPath);
    NSLog(@"filename -%@",fileName);
    //NSURL *url = [NSURL fileURLWithPath:path];
   
    // Directory Creation
    
    NSString *libraryDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * folderPath = [NSString stringWithFormat:@"%@/Sounds",libraryDir];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    
    ///Moving from document directory to Sounds directory
    
    NSString *destinationPath = [NSString stringWithFormat:@"%@/%@",folderPath,@"custom.caf"];
    NSLog(@"Path-%@",destinationPath);
     if ( [fileManager fileExistsAtPath:destinationPath]) {
          NSError *error = nil;
         [fileManager removeItemAtPath:destinationPath error:&error];
     }
     if (![fileManager fileExistsAtPath:destinationPath]) {
        NSError *error = nil;
        //[fileManager moveItemAtPath:documentPath toPath:destinationPath error:&error];
         [fileManager copyItemAtPath:documentPath toPath:destinationPath error:&error];
        if (error) {
            ;
            NSLog(@"There is an Error: %@", error);
        }
        else{
            result=YES;
        }
    } else {
        ;
        NSLog(@"File %@ doesn't exists", fileName);
    }
    
    
    if (result) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Error"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}


@end
