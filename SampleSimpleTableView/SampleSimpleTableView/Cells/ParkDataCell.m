#import "ParkDataCell.h"
#import "ParkDate.h"

@interface E8DChatDateItemCell ()

@property(nonatomic, retain) UILabel *nameLabel;
@property(nonatomic, retain) UILabel *areaLabel;
@property(nonatomic, retain) UILabel *serviceTimeLabel;
@property(nonatomic, retain) UILabel *addressLabel;

@property(nonatomic, retain) UIView *bottomLineView;

@end

@implementation E8DChatDateItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.nameLabel = [[[UILabel alloc] init] autorelease];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.textColor = [UIColor blackColor];
        self.nameLabel.text = @"";
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        self.nameLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.nameLabel];
		
        self.areaLabel = [[[UILabel alloc] init] autorelease];
        self.areaLabel.backgroundColor = [UIColor clearColor];
        self.areaLabel.textColor = [UIColor blackColor];
        self.areaLabel.text = @"";
        self.areaLabel.font = [UIFont systemFontOfSize:16];
        self.areaLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.areaLabel];
		
		self.serviceTimeLabel = [[[UILabel alloc] init] autorelease];
        self.serviceTimeLabel.backgroundColor = [UIColor clearColor];
        self.serviceTimeLabel.textColor = [UIColor blackColor];
        self.serviceTimeLabel.text = @"";
        self.serviceTimeLabel.font = [UIFont systemFontOfSize:16];
        self.serviceTimeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.serviceTimeLabel];
		
		self.addressLabel = [[[UILabel alloc] init] autorelease];
        self.addressLabel.backgroundColor = [UIColor clearColor];
        self.addressLabel.textColor = [UIColor blackColor];
        self.addressLabel.text = @"";
        self.addressLabel.font = [UIFont systemFontOfSize:16];
        self.addressLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.addressLabel];
		
		self.bottomLineView = [[UIView new] autorelease];
		self.bottomLineView.backgroundColor = [UIColor blackColor];
		self.bottomLineView.frame = CGRectMake(0, 0, 0, 1);
        [self.contentView addSubview:self.bottomLineView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
	
    if (self.itemData) {
        self.nameLabel.text = self.itemData.NAME;
		self.areaLabel.text = self.itemData.AREA;
        self.serviceTimeLabel.text = self.itemData.SERVICETIME;
        self.addressLabel.text = self.itemData.ADDRESS;
    }else{
	    self.nameLabel.text = @"";
		self.areaLabel.text = @"";
        self.serviceTimeLabel.text = @"";
        self.addressLabel.text = @"";
	}
    
	[self.nameLabel sizeToFit];
	[self.areaLabel sizeToFit];
	[self.serviceTimeLabel sizeToFit];
	[self.addressLabel sizeToFit];
	
	self.nameLabel.frame = CGRectMake(10, 10, self.contentView.frame.size.width - 20, self.areaLabel.frame.size.height);
	self.areaLabel.frame = CGRectMake(10, 10, self.contentView.frame.size.width - 20, self.areaLabel.frame.size.height);
	self.serviceTimeLabel.frame = CGRectMake(10, CGRectGetMaxY(self.areaLabel.frame), self.contentView.frame.size.width - 20, self.areaLabel.frame.size.height);
	self.addressLabel.frame = CGRectMake(10, CGRectGetMaxY(self.serviceTimeLabel.frame), self.contentView.frame.size.width - 20, self.areaLabel.frame.size.height);
	self.bottomLineView.frame = CGRectMake(10, self.contentView.frame.size.height - 1, self.contentView.frame.size.width - 10, 1);
}

- (void)setItemData:(E8DChatDateItemData *)itemData {
    if (_itemData != itemData) {
        [_itemData release];
        _itemData = [itemData retain];
        [self setNeedsLayout];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 計算cell高度

+ (CGFloat)cellHeightWithItemData:(ParkDate *)itemData andTableWidth:(CGFloat)tableWidth {
	// 自動適應高度沒寫 
   return 20.0f + 3*[UIFont systemFontOfSize:16].lineHeight;
}

#pragma mark -

- (void)dealloc {
    self.nameLabel = nil;
    self.areaLabel = nil;
	self.serviceTimeLabel = nil;
    self.addressLabel = nil;
	self.bottomLineView = nil;
    self.itemData = nil;
    [super dealloc];
}

@end
