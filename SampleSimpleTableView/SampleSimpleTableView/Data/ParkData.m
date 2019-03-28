#import "ParkData.h"
#import "JSON.h"

@implementation ParkData

- (id)init{
    self = [super init];
    if (self) {
		self.ID = @"";
		self.AREA = @"";
		self.NAME = @"";
		self.TYPE = @"";
		self.SUMMARY = @"";
		self.ADDRESS = @"";
		self.TEL = @"";
		self.PAYEX = @"";
		self.SERVICETIME = @"";
		self.TW97X = @"";
		self.TW97Y = @"";
		self.TOTALCAR = @"";
		self.TOTALMOTOR = @"";
		self.TOTALBIKE = @"";
    }
    return self;
}

- (void)dealloc{
	self.ID = nil;
	self.AREA = nil;
	self.NAME = nil;
	self.TYPE = nil;
	self.SUMMARY = nil;
	self.ADDRESS = nil;
	self.TEL = nil;
	self.PAYEX = nil;
	self.SERVICETIME = nil;
	self.TW97X = nil;
	self.TW97Y = nil;
	self.TOTALCAR = nil;
	self.TOTALMOTOR = nil;
	self.TOTALBIKE = nil;
    [super dealloc];
}

+ (ParkData *)getParkDataWithDictionary:(NSDictionary *)dataDic{
    ParkData *data = [[ParkData alloc] init];

    if ([dataDic objectForKey:@"ID"] && [[dataDic objectForKey:@"ID"] isKindOfClass:[NSString class]]) {
        data.ID = [dataDic objectForKey:@"ID"];
    }
    if ([dataDic objectForKey:@"AREA"] && [[dataDic objectForKey:@"AREA"] isKindOfClass:[NSString class]]) {
        data.AREA = [dataDic objectForKey:@"AREA"];
    }
	if ([dataDic objectForKey:@"NAME"] && [[dataDic objectForKey:@"NAME"] isKindOfClass:[NSString class]]) {
        data.NAME = [dataDic objectForKey:@"NAME"];
    }
	if ([dataDic objectForKey:@"TYPE"] && [[dataDic objectForKey:@"TYPE"] isKindOfClass:[NSString class]]) {
        data.TYPE = [dataDic objectForKey:@"TYPE"];
    }
	if ([dataDic objectForKey:@"SUMMARY"] && [[dataDic objectForKey:@"SUMMARY"] isKindOfClass:[NSString class]]) {
        data.SUMMARY = [dataDic objectForKey:@"SUMMARY"];
    }
	if ([dataDic objectForKey:@"ADDRESS"] && [[dataDic objectForKey:@"ADDRESS"] isKindOfClass:[NSString class]]) {
        data.ADDRESS = [dataDic objectForKey:@"ADDRESS"];
    }
	if ([dataDic objectForKey:@"TEL"] && [[dataDic objectForKey:@"TEL"] isKindOfClass:[NSString class]]) {
        data.TEL = [dataDic objectForKey:@"TEL"];
    }
	if ([dataDic objectForKey:@"PAYEX"] && [[dataDic objectForKey:@"PAYEX"] isKindOfClass:[NSString class]]) {
        data.PAYEX = [dataDic objectForKey:@"PAYEX"];
    }
	if ([dataDic objectForKey:@"SERVICETIME"] && [[dataDic objectForKey:@"SERVICETIME"] isKindOfClass:[NSString class]]) {
        data.SERVICETIME = [dataDic objectForKey:@"SERVICETIME"];
    }
	if ([dataDic objectForKey:@"TW97X"] && [[dataDic objectForKey:@"TW97X"] isKindOfClass:[NSString class]]) {
        data.TW97X = [dataDic objectForKey:@"TW97X"];
    }
	if ([dataDic objectForKey:@"TW97Y"] && [[dataDic objectForKey:@"TW97Y"] isKindOfClass:[NSString class]]) {
        data.TW97Y = [dataDic objectForKey:@"TW97Y"];
    }
	if ([dataDic objectForKey:@"TOTALCAR"] && [[dataDic objectForKey:@"TOTALCAR"] isKindOfClass:[NSString class]]) {
        data.TOTALCAR = [dataDic objectForKey:@"TOTALCAR"];
    }
	if ([dataDic objectForKey:@"TOTALMOTOR"] && [[dataDic objectForKey:@"TOTALMOTOR"] isKindOfClass:[NSString class]]) {
        data.TOTALMOTOR = [dataDic objectForKey:@"TOTALMOTOR"];
    }
	if ([dataDic objectForKey:@"TOTALBIKE"] && [[dataDic objectForKey:@"TOTALBIKE"] isKindOfClass:[NSString class]]) {
        data.TOTALBIKE = [dataDic objectForKey:@"TOTALBIKE"];
    }
    return [data autorelease];
}

@end
