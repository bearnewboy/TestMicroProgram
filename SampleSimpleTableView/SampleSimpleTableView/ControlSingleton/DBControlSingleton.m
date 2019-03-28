#import "DBControlSingleton.h"
#import "ParkData.h"

#pragma mark - SQL

#define TABLE_CREATE_OF_PARK_DATA "CREATE TABLE IF NOT EXISTS 'ParkData' ('ID' TEXT, 'AREA' TEXT, 'NAME' TEXT, 'TYPE' TEXT, 'SUMMARY' TEXT, 'ADDRESS' TEXT, 'TEL' TEXT, 'PAYEX' TEXT, 'SERVICETIME' TEXT, 'TW97X' TEXT, 'TW97Y' TEXT, 'TOTALCAR' TEXT, 'TOTALMOTOR' TEXT, 'TOTALBIKE' TEXT, PRIMARY KEY ('ID'))"

#define INSERT_PARK_DATA "INSERT OR IGNORE INTO ParkData (ID, AREA, NAME, TYPE, SUMMARY, ADDRESS, TEL, PAYEX, SERVICETIME, TW97X, TW97Y, TOTALCAR, TOTALMOTOR, TOTALBIKE) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
#define UPDATE_PARK_DATA "UPDATE ParkData SET AREA = ?, NAME = ?, TYPE = ?, SUMMARY = ?, ADDRESS = ?, TEL = ?, PAYEX = ?, SERVICETIME = ?, TW97X = ?, TW97Y = ?, TOTALCAR = ?, TOTALMOTOR = ?, TOTALBIKE = ? WHERE ID = ?"

#define SELECT_PARK_DATA_ID "SELECT ID FROM ParkData WHERE ID = ?"
#define SELECT_PARK_DATA "SELECT ID, AREA, NAME, TYPE, SUMMARY, ADDRESS, TEL, PAYEX, SERVICETIME, TW97X, TW97Y, TOTALCAR, TOTALMOTOR, TOTALBIKE FROM ParkData"

#pragma mark -

@interface DBControlSingleton () {
    sqlite3 *_database;
}

- (void)openDatabase;
- (NSString *)getDatabaseFullPath;
- (void)closeDatabase;

@end

@implementation DBControlSingleton

+ (DBControlSingleton *)getInstance {
    @synchronized (self) {
        if (instance == nil) {
            instance = [[DBControlSingleton alloc] init];
        }
    }
    return instance;
}

- (id)init{
    self = [super init];
    if (self) {
        sqlite3_initialize();
        [self openDatabase];
    }
    return self;
}

- (void)openDatabase {
    if (!_database) {
        NSString *databaseFullPath = [self getDatabaseFullPath];
        BOOL isExistSqliteFile = [[NSFileManager defaultManager] fileExistsAtPath:databaseFullPath];
        int result = sqlite3_open_v2([databaseFullPath UTF8String], &_database, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL);
        if (result == SQLITE_OK) {
            if (!isExistSqliteFile) {
                [self createTableSchema];
            }
        } else {
            NSAssert(0, @"Failed to open database");
        }
    }
}

- (void)createTableSchema {
    char *err;
    if (sqlite3_exec(_database, TABLE_CREATE_OF_PARK_DATA, NULL, NULL, &err) != SQLITE_OK) {
        NSAssert(0, @"Table of ParkData failed to create");
        NSLog(@"%s", err);
    }
}

- (NSString *)getDatabaseFullPath {
    if (userDBFileName == nil) {
        userDBFileName = [[NSString alloc] initWithString:@"TestDB.sqlite3"];
    }

    NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    stringPath = [stringPath stringByAppendingPathComponent:userDBFileName];
	
    [self addSkipBackupAttributeToItemAtPath:stringPath];  //防止雲端備份（容量太大，上架會被reject)

    return stringPath;
}

// 防止雲端備份 （容量太大，上架會被reject）
- (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *)filePathString {
    NSURL *fileURL = [NSURL fileURLWithPath:filePathString];

    NSError *error = nil;

    BOOL success = [fileURL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    return success;
}

- (void)closeDatabase {
    if (_database) {
        sqlite3_close(_database);
        _database = nil;
    }
    sqlite3_shutdown();
}

#pragma mark - SQL method

- (BOOL)saveParkDataJsonFileName:(NSString *)fileName{
    BOOL isSuccess = NO;
	
	NSError *error = nil;
	NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
	NSData *dataFromFile = [NSData dataWithContentsOfFile:filePath];
	NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:dataFromFile options:kNilOptions error:&error];
	if (error == nil) {
		NSArray *dataArray = [[dataDic objectForKey:@"result"] objectForKey:@"records"];
		if (dataArray != nil) {
			isSuccess = [self insertOrUpdateParkDataWithDataArray:dataArray];
		}
	}
	return isSuccess;
}
]
- (BOOL)insertOrUpdateParkDataWithDataArray:(NSArray *)dataArray{
    BOOL isSuccess = NO;
	@synchronized (self) {
		 for (NSUInteger i = 0; i < [dataArray count]; i++) {
			ParkData *parkData = [ParkData getParkDataWithDictionary:[dataArray objectAtIndex:i]];
			if ([self isExistParkDataWithID:parkData.ID]) {
				sqlite3_stmt *updateStmt;
				if (sqlite3_prepare_v2(_database, UPDATE_PARK_DATA, -1, &updateStmt, NULL) == SQLITE_OK) {
					//綁定參數
					sqlite3_bind_text(updateStmt, 1, [parkData.AREA UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(updateStmt, 2, [parkData.NAME UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(updateStmt, 3, [parkData.TYPE UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(updateStmt, 4, [parkData.SUMMARY UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(updateStmt, 5, [parkData.ADDRESS UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(updateStmt, 6, [parkData.TEL UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(updateStmt, 7, [parkData.PAYEX UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(updateStmt, 8, [parkData.SERVICETIME UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(updateStmt, 9, [parkData.TW97X UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(updateStmt, 10, [parkData.TW97Y UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(updateStmt, 11, [parkData.TOTALCAR UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(updateStmt, 12, [parkData.TOTALMOTOR UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(updateStmt, 13, [parkData.TOTALBIKE UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(updateStmt, 14, [parkData.ID UTF8String], -1, SQLITE_TRANSIENT);
					//執行
					if (sqlite3_step(updateStmt) == SQLITE_DONE) {
						isSuccess = YES;
					}
				}
				sqlite3_finalize(updateStmt);
			}else{
				if (sqlite3_prepare_v2(_database, INSERT_PARK_DATA, -1, &insertStmt, NULL) == SQLITE_OK) {
					//綁定參數
					sqlite3_bind_text(updateStmt, 1, [parkData.ID UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(insertStmt, 2, [parkData.AREA UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(insertStmt, 3, [parkData.NAME UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(insertStmt, 4, [parkData.TYPE UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(insertStmt, 5, [parkData.SUMMARY UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(insertStmt, 6, [parkData.ADDRESS UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(insertStmt, 7, [parkData.TEL UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(insertStmt, 8, [parkData.PAYEX UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(insertStmt, 9, [parkData.SERVICETIME UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(insertStmt, 10, [parkData.TW97X UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(insertStmt, 11, [parkData.TW97Y UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(insertStmt, 12, [parkData.TOTALCAR UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(insertStmt, 13, [parkData.TOTALMOTOR UTF8String], -1, SQLITE_TRANSIENT);
					sqlite3_bind_text(insertStmt, 14, [parkData.TOTALBIKE UTF8String], -1, SQLITE_TRANSIENT);
					//執行
					if (sqlite3_step(insertStmt) == SQLITE_DONE) {
						isSuccess = YES;
					}
				}
				sqlite3_finalize(insertStmt);
			}
		}
	}
	return isSuccess;
}

- (BOOL)isExistParkDataWithID:(NSString *)IDString{
    BOOL isExist = NO;
	
	sqlite3_stmt *selectStmt;
    if (sqlite3_prepare_v2(_database, SELECT_PARK_DATA_ID, -1, &selectStmt, NULL) == SQLITE_OK) {
        //綁定參數
        sqlite3_bind_text(selectStmt, 1, [IDString UTF8String], -1, SQLITE_TRANSIENT);
        //執行
        if (sqlite3_step(selectStmt) == SQLITE_ROW) {
            isExist = YES;
        }
    }
    sqlite3_finalize(selectStmt);
	return isExist;
}

- (NSArray *)selectAllParkData{
	NSMutableArray *array = [NSMutableArray new];

    @synchronized (self) {
        sqlite3_stmt *stm;

        if (sqlite3_prepare_v2(_database, SELECT_PARK_DATA, -1, &stm, NULL) == SQLITE_OK) {
            //讀取每一筆資料
            while (sqlite3_step(stm) == SQLITE_ROW) {
                ParkData *parkData = [[ParkData alloc] init];
                parkData.ID = [NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 0)];
                parkData.AREA = [NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 1)];
                parkData.NAME = [NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 2)];
                parkData.TYPE = [NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 3)];
                parkData.SUMMARY = [NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 4)];
                parkData.ADDRESS = [NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 5)];
                parkData.TEL = [NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 6)];
                parkData.PAYEX = [NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 7)];
                parkData.SERVICETIME = [NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 8)];
                parkData.TW97X = [NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 9)];
                parkData.TW97Y = [NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 10)];
                parkData.TOTALCAR = [NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 11)];
                parkData.TOTALMOTOR = [NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 12)];
                parkData.TOTALBIKE = [NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 13)];
                [array addObject:parkData];
                [parkData release];
            }
        }
        //釋放statement
        sqlite3_finalize(stm);
    }
    return [array autorelease];
}

#pragma mark -

- (void)dealloc {
    [userDBFileName release];
    [self closeDatabase];
    [super dealloc];
}

@end
