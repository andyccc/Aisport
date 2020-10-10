//
//  RecourceDownLoadTool.m
//  Aisport
//
//  Created by Apple on 2020/12/11.
//

#import "RecourceDownLoadTool.h"
#import <AFNetworking.h>

@interface RecourceDownLoadTool ()
{
    NSMutableDictionary *sizeDic;
    NSMutableArray *taskArray;
    long long totalSize;
    long long number;
    NSMutableArray *_downLoadModels;
    NSMutableArray *_downLoadDics;
}

/** AFNetworking断点下载（支持离线）需用到的属性 **********/
/** 文件的总长度 */
@property (nonatomic, assign) NSInteger fileLength;
/** 当前下载长度 */
@property (nonatomic, assign) NSInteger currentLength;
/** 文件句柄对象 */
@property (nonatomic, strong) NSFileHandle *fileHandle;

/** 下载任务 */
@property (nonatomic, strong) NSURLSessionDataTask *downloadTask;
/* AFURLSessionManager */
@property (nonatomic, strong) AFURLSessionManager *manager;

@end

@implementation RecourceDownLoadTool

/**
 * manager的懒加载
 */
- (AFURLSessionManager *)manager {
    if (!_manager) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        // 1. 创建会话管理者
        _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return _manager;
}

/**
 * downloadTask的懒加载
 */
- (NSURLSessionDataTask *)downloadTask {
    if (!_downloadTask) {
        // 创建下载URL
        NSURL *url = [NSURL URLWithString:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg"];
        
        // 2.创建request请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        // 设置HTTP请求头中的Range
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-", self.currentLength];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        __weak typeof(self) weakSelf = self;
        _downloadTask = [self.manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
            
        } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
            
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            NSLog(@"dataTaskWithRequest");
            
            // 清空长度
            weakSelf.currentLength = 0;
            weakSelf.fileLength = 0;
            
            // 关闭fileHandle
            [weakSelf.fileHandle closeFile];
            weakSelf.fileHandle = nil;
        }];
        
        [self.manager setDataTaskDidReceiveResponseBlock:^NSURLSessionResponseDisposition(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSURLResponse * _Nonnull response) {
            NSLog(@"NSURLSessionResponseDisposition");
            
            // 获得下载文件的总长度：请求下载的文件长度 + 当前已经下载的文件长度
            weakSelf.fileLength = response.expectedContentLength + self.currentLength;
            
            // 沙盒文件路径
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"QQ_V5.4.0.dmg"];
            
            NSLog(@"File downloaded to: %@",path);
            
            // 创建一个空的文件到沙盒中
            NSFileManager *manager = [NSFileManager defaultManager];
            
            if (![manager fileExistsAtPath:path]) {
                // 如果没有下载文件的话，就创建一个文件。如果有下载文件的话，则不用重新创建(不然会覆盖掉之前的文件)
                [manager createFileAtPath:path contents:nil attributes:nil];
            }
            
            // 创建文件句柄
            weakSelf.fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
            
            // 允许处理服务器的响应，才会继续接收服务器返回的数据
            return NSURLSessionResponseAllow;
        }];
        
        [self.manager setDataTaskDidReceiveDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSData * _Nonnull data) {
            NSLog(@"setDataTaskDidReceiveDataBlock");
            
            // 指定数据的写入位置 -- 文件内容的最后面
            [weakSelf.fileHandle seekToEndOfFile];
            
            // 向沙盒写入数据
            [weakSelf.fileHandle writeData:data];
            
            // 拼接文件总长度
            weakSelf.currentLength += data.length;
            
            // 获取主线程，不然无法正确显示进度。
            NSOperationQueue* mainQueue = [NSOperationQueue mainQueue];
            [mainQueue addOperationWithBlock:^{
                // 下载进度
//                if (weakSelf.fileLength == 0) {
//                    weakSelf.progressView.progress = 0.0;
//                    weakSelf.progressLabel.text = [NSString stringWithFormat:@"当前下载进度:00.00%%"];
//                } else {
//                    weakSelf.progressView.progress =  1.0 * weakSelf.currentLength / weakSelf.fileLength;
//                    weakSelf.progressLabel.text = [NSString stringWithFormat:@"当前下载进度:%.2f%%",100.0 * weakSelf.currentLength / weakSelf.fileLength];
//                }
               
            }];
        }];
    }
    return _downloadTask;
}



/**
 * 获取已下载的文件大小
 */
- (NSInteger)fileLengthForPath:(NSString *)path {
    NSInteger fileLength = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileLength = [fileDict fileSize];
        }
    }
    return fileLength;
}


- (void)goToDownloadResourceWith:(NSMutableArray *)downLoadModels AndSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn andProgress:(serverProgressFn)progressFn
{
    self->number = 0;
    [self cancleDownLoad];
    sizeDic = [NSMutableDictionary dictionaryWithCapacity:0];
    _downLoadModels = downLoadModels;
    _downLoadDics = [NSMutableArray arrayWithCapacity:0];

    long long total = 0;
    for (DownLoadModel *downLoadModel in downLoadModels) {
        //获取Document文件
        NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString * rarFilePath = [docsdir stringByAppendingPathComponent:StringForId(downLoadModel.code)];//将需要创建的串拼接到后面
    //        NSString * dataFilePath = [docsdir stringByAppendingPathComponent:@"AnnouncementData"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = NO;
    //        BOOL dataIsDir = NO;
        // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
        BOOL existed = [fileManager fileExistsAtPath:rarFilePath isDirectory:&isDir];
    //        BOOL dataExisted = [fileManager fileExistsAtPath:dataFilePath isDirectory:&dataIsDir];
        if ( !(isDir == YES && existed == YES) ) {//如果文件夹不存在
            [fileManager createDirectoryAtPath:rarFilePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        total += (long long)[StringForId(downLoadModel.totalSize) doubleValue];
        [GVUserDefaults standardUserDefaults].total = [NSString stringWithFormat:@"%lld",total];
        self->totalSize = total;
        if (![StringForId(downLoadModel.url) isEqual:@""]) {
            [sizeDic setObject:@"0" forKey:StringForId(downLoadModel.name)];
            NSString *vedioUrlStr = StringForId(downLoadModel.url);
            self->number += 1;
            [self downLoadVideoAndAudioWithUrl:vedioUrlStr UrlName:StringForId(downLoadModel.name) andProgress:progressFn IsVideo:YES WithCourseId:StringForId(downLoadModel.code) Password:StringForId(downLoadModel.unzipPassword) andFailure:^(NSURLSessionDownloadTask * _Nullable task, NSError * _Nonnull error) {
                [self cancleDownLoad];
                failerFn(error);
            }];
            
        }
        [sizeDic setObject:@"0" forKey:StringForId(downLoadModel.modelName)];
        NSString *imageUrlStr = StringForId(downLoadModel.modelAddress);
        self->number += 1;
        [self downLoadVideoAndAudioWithUrl:imageUrlStr UrlName:StringForId(downLoadModel.modelName) andProgress:progressFn IsVideo:NO WithCourseId:StringForId(downLoadModel.code) Password:StringForId(downLoadModel.unzipPassword) andFailure:^(NSURLSessionDownloadTask * _Nullable task, NSError * _Nonnull error) {
            [self cancleDownLoad];
            failerFn(error);
        }];
    }
}



- (void)downLoadVideoAndAudioWithUrl:(NSString *)urlStr UrlName:(NSString *)urlName andProgress:(serverProgressFn)progressFn IsVideo:(BOOL)isVideo WithCourseId:(NSString *)courseId Password:(NSString *)password andFailure:(nullable void (^)(NSURLSessionDownloadTask * _Nullable, NSError * _Nonnull))failure
{
//    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:urlName];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:];
    
    // 设置HTTP请求头中的Range
//    NSString *range = [NSString stringWithFormat:@"bytes=%zd-",[sizeDic[urlName] integerValue]];
//    [request setValue:range forHTTPHeaderField:@"Range"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 1. 创建会话管理者
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"totalUnitCount----%lld",downloadProgress.totalUnitCount);
        NSLog(@"completedUnitCount--%lld",downloadProgress.completedUnitCount);
//        NSLog(@"-----completedUnitCount--%lld",[[[NSUserDefaults standardUserDefaults] objectForKey:urlName] longLongValue]);
        
//        long long completedUnitCount = [[[NSUserDefaults standardUserDefaults] objectForKey:urlName] longLongValue];
        long long completedUnitCount = 0;
        
        
        for (NSString *sizeStr in [self->sizeDic allValues]) {
            completedUnitCount += [sizeStr longLongValue];
        }
        NSLog(@"添加的completedUnitCount--%lld",completedUnitCount);
        NSLog(@"总的的completedUnitCount--%lld",self->totalSize);
//        double value = ((double)completedUnitCount)/((double)[[GVUserDefaults standardUserDefaults].total longLongValue]);
        
        double value = ((double)completedUnitCount)/((double)self->totalSize);
        
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lld",downloadProgress.completedUnitCount] forKey:urlName];
        [self->sizeDic setObject:[NSString stringWithFormat:@"%lld",downloadProgress.completedUnitCount] forKey:urlName];

        progressFn(value);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!isVideo) {
//            NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *cachesPath = [paths objectAtIndex:0];
            NSString *pathString = [NSString stringWithFormat:@"%@/%@/ImageResource",cachesPath,courseId];
            NSFileManager *fileManager = [[NSFileManager alloc] init];
            if (![[NSFileManager defaultManager] fileExistsAtPath:pathString]) {
                [fileManager createDirectoryAtPath:pathString withIntermediateDirectories:YES attributes:nil error:nil];
            } else {
                NSLog(@"FileDir is exists.");
            }
            NSString *path = [pathString stringByAppendingPathComponent:response.suggestedFilename];
            return [NSURL fileURLWithPath:path];
        }else{
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *extention = @"mp4";
            NSString *mediaUrl = [NSString stringWithFormat:@"%@.%@",urlName,extention];
            NSString  *fullPath = [NSString stringWithFormat:@"%@/%@/%@", documentsDirectory, courseId, mediaUrl];
            NSLog(@"%@",fullPath);
            return [NSURL fileURLWithPath:fullPath];
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                self->number -= 1;
                failure(task ,error);
                return;
            }
        }
        self->number -= 1;
        NSString *zipFilePath = [filePath path];// 将NSURL转成NSString
        if (![zipFilePath hasSuffix:@".mp4"]) {
//            NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//            NSString *pathString = [NSString stringWithFormat:@"%@/ImageResource",cachesPath];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *cachesPath = [paths objectAtIndex:0];
            NSString *pathString = [NSString stringWithFormat:@"%@/%@/ImageResource",cachesPath,courseId];
            [self releaseZipFileWithZipPath:zipFilePath ReleasePath:pathString Password:password ReleaseResult:^(BOOL release) {
                if (release) {

                }else{
                    [SVProgressHUD showInfoWithStatus:@"解压失败..."];

                }
                
            }];
//            progressFn(1);
        }
        
        for (DownLoadModel *model in self->_downLoadModels) {
            if ([model.code isEqual:courseId] && model.downType != 2) {
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
                [dict setObject:model.name forKey:@"name"];
                [dict setObject:model.url forKey:@"url"];
                [dict setObject:model.code forKey:@"code"];
                [dict setObject:model.modelName forKey:@"modelName"];
                [dict setObject:model.modelMd5 forKey:@"modelMd5"];
                [dict setObject:@"2" forKey:@"downLoadType"];
                model.downType = 2;
                [self->_downLoadDics addObject:dict];
                
            }
        }
        
        if (self->number == 0) {
            for (NSURLSessionDownloadTask *task in self->taskArray) {
                [self->taskArray removeObject:task];
            }
            for (NSDictionary *dict in self->_downLoadDics) {
                [self insertToPlist:dict nickName:StringForId(courseId)];
            }
            progressFn(1);
//            _progressHUD.label.text = @"正在解压...";
            // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
            
        }
        
    }];
    
    [taskArray addObject:task];

    [task resume];
}

- (void)cancleDownLoad

{
//    if (videoTask) {
//        [videoTask cancel];
//        videoTask = nil;
//    }
//    if (imagesTask) {
//        [imagesTask cancel];
//        imagesTask = nil;
//    }
    for (NSURLSessionDownloadTask *task in taskArray) {
        [task cancel];
        [taskArray removeObject:task];
    }
}

- (void)StopDownLoad

{
    for (NSURLSessionDownloadTask *task in taskArray) {
        [task suspend];
//        [taskArray removeObject:task];
    }
//    if (videoTask) {
//        [videoTask suspend];
////        videoTask = nil;
//    }
//    if (imagesTask) {
//        [imagesTask suspend];
////        imagesTask = nil;
//    }
}

#pragma mark - 解压zip文件
- (void)releaseZipFileWithZipPath:(NSString *)zipPath ReleasePath:(NSString *)releasePath Password:(NSString *)password ReleaseResult:(void (^)(BOOL release))releaseResult
{
    NSError *error = nil;
    if ([SSZipArchive unzipFileAtPath:zipPath toDestination:releasePath overwrite:YES password:password error:&error delegate:self]) {
        NSLog(@"解压成功 -- %@",releasePath);
        
        NSError *error = nil;
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *cachesPath = [paths objectAtIndex:0];
//        NSString *pathString = [NSString stringWithFormat:@"%@/%@/ImageResource/%@",cachesPath,_codeID,StringForId(dict[_codeID][@"modelName"])];
        if ([self isFileExitsAtPath:zipPath]) {
            [[NSFileManager defaultManager] removeItemAtPath:zipPath error:&error];
        }
    
        releaseResult(YES);
        
    }else{
        releaseResult(NO);
        NSLog(@"%@",error);
    }
}

- (void)zipArchiveProgressEvent:(unsigned long long)loaded total:(unsigned long long)total
{
    float totalSize = total;
//    _progressHUD.progress = (float)loaded/totalSize;
    NSLog(@"loaded -- %lld  total -- %lld",loaded,total);
}



- (BOOL)isFileExitsAtPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath isDirectory:NULL]) {
        return YES;
    }
    
    return NO;
}

#pragma mark - plist本地存储资源信息
- (void)insertToPlist:(NSDictionary *)dictionary nickName:(NSString *)nickName {
//    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"chatRoom.plist"];
    
    //获取Document文件
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * rarFilePath = [docsdir stringByAppendingPathComponent:nickName];//将需要创建的串拼接到后面
//        NSString * dataFilePath = [docsdir stringByAppendingPathComponent:@"AnnouncementData"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
//        BOOL dataIsDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:rarFilePath isDirectory:&isDir];
//        BOOL dataExisted = [fileManager fileExistsAtPath:dataFilePath isDirectory:&dataIsDir];
    if ( !(isDir == YES && existed == YES) ) {//如果文件夹不存在
        [fileManager createDirectoryAtPath:rarFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *extention = @"mp4";
//    NSString *mediaUrl = [NSString stringWithFormat:@"%@.%@",urlName,extention];
    NSString  *plistPath = [NSString stringWithFormat:@"%@/%@/%@.plist", documentsDirectory, nickName, @"videoResource"];
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    //下边if判断很重要，不然会写入失败.
    if (!userDict) {
        userDict = [[NSMutableDictionary alloc] init];
    }
    //设置属性值
    [userDict setObject:dictionary forKey:nickName];
    //写入文件
    [userDict writeToFile:plistPath atomically:YES];
}


@end
