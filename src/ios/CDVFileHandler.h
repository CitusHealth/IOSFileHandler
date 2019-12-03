//
//  CDVFileHandler.h
//  CordovaLib
//
//  Created by Chinnu M V on 2/22/17.
//
//
#import <Cordova/CDVPlugin.h>

@interface CDVFileHandler : CDVPlugin
- (void)fileCopytoBundle:(CDVInvokedUrlCommand*)command;
@end
