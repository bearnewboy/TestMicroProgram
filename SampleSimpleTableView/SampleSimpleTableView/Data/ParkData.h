#import <Foundation/Foundation.h>

@interface ParkData : NSObject

@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *AREA;
@property (nonatomic, retain) NSString *NAME;
@property (nonatomic, retain) NSString *TYPE;
@property (nonatomic, retain) NSString *SUMMARY;
@property (nonatomic, retain) NSString *ADDRESS;
@property (nonatomic, retain) NSString *TEL;
@property (nonatomic, retain) NSString *PAYEX;
@property (nonatomic, retain) NSString *SERVICETIME;
@property (nonatomic, retain) NSString *TW97X;
@property (nonatomic, retain) NSString *TW97Y;
@property (nonatomic, retain) NSString *TOTALCAR;
@property (nonatomic, retain) NSString *TOTALMOTOR;
@property (nonatomic, retain) NSString *TOTALBIKE;

+ (ParkData *)getParkDataWithDictionary:(NSDictionary *)dataDic;

@end
