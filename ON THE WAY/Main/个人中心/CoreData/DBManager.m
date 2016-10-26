//
//  DBManager.m
//  03_FetchedResultsController
//
//  Created by Apple on 15/12/4.
//  Copyright © 2015年 JayWon. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager


+ (instancetype)shareManager {
    
    static DBManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:nil] init];
    });
    
    return instance;
}

-(id)copy {
    return self;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self shareManager];
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

//返回沙盒路径下的Documents文件夹
- (NSURL *)applicationDocumentsDirectory {
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    //程序包中的模型文件扩展名会自动变成momd。
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"UserModel" withExtension:@"momd"];
    
    //对象模型是通过模型文件来构造的。
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    //PSC是根据模型文件创建的。
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"User.sqlite"];

   
    [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {

    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    //context与PSC对象关联起来，绑定PSC对象的目的是使Context和外部的存储文件联系起来。
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

//对Context保存，即和外部的数据库文件同步。
- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {        
        //save操作表示同步。把context上的MO数据同步到数据库中。
        if ([managedObjectContext hasChanges])
        {
            [managedObjectContext save:nil];
        }
    }
}





@end
