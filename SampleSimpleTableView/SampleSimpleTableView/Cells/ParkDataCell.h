#import <UIKit/UIKit.h>

@class ParkData;

@interface ParkDataCell : UITableViewCell {
    ParkData *_itemData;
}

@property(nonatomic, retain) ParkData *itemData;

+ (CGFloat)cellHeightWithItemData:(ParkDate *)itemData andTableWidth:(CGFloat)tableWidth

@end
