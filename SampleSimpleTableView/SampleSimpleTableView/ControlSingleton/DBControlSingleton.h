#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBControlSingleton : NSObject 

+ (DBControlSingleton *)getInstance;

- (BOOL)saveParkDataJsonFileName:(NSString *)fileName;

- (NSArray *)selectAllParkData;

@end
