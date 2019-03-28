#import "DetailViewController.h"
#import "ParkData.h"
#import <MapKit/MapKit.h>

@interface PositionAnnotation : NSObject <MKAnnotation> 

@property (nonatomic, assign)CLLocationCoordinate2D coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString *)title andSubtitle:(NSString *)subtitle;

@end

@implementation PositionAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString *)title andSubtitle:(NSString *)subtitle {
    self = [super init];
    if (self) {
        self.coordinate = coordinate;
    }
    return self;
}

- (void)dealloc {
	self.coordinate = nil;
    [super dealloc];
}
@end

@interface DetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
	
    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];
    self.tableView.frame = CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 50 - 60*4);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
	
	MKMapView *mapView = [[MKMapView alloc] init];
	mapView.showsUserLocation = NO;
	mapView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.view.bounds.size.width, self.view.frame.size.height - CGRectGetMaxY(self.tableView.frame));
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:mapView];
	
	CLLocationCoordinate2D theCoordinate;
	theCoordinate.latitude = [self.itemData.TW97X floatValue];
	theCoordinate.longitude = [self.itemData.TW97Y floatValue];
	
	MKCoordinateRegion theRegion;
    theRegion.center = theCoordinate;
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta = 0.005;
    theSpan.longitudeDelta = 0.005;
    theRegion.span = theSpan;
    [mapView setRegion:theRegion animated:YES];
	
    PositionAnnotation *anno = [[PositionAnnotation alloc] initWithCoordinate:theCoordinate andTitle:@"" andSubtitle:@""];
    [mapView addAnnotation:anno];
    [mapView setSelectedAnnotations:[NSArray arrayWithObjects:anno, nil]];
	
    [anno release];
	[mapView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.tableView = nil;
    self.dataArray = nil;
    [super dealloc];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
	switch ((NSInteger)str) {
		case 0:{
			cell.textLabel.text = @"停車場名稱"; 
			cell.detailTextLabel.text = self.itemData.NAME; 
			break;
		}
		case 1:{
			cell.textLabel.text = @"區域"; 
			cell.detailTextLabel.text = self.itemData.AREA; 
			break;
		}
		case 2:{
			cell.textLabel.text = @"營業時間"; 
			cell.detailTextLabel.text = self.itemData.SERVICETIME; 
			break;
		}
		default:{
			cell.textLabel.text = @"地址"; 
			cell.detailTextLabel.text = self.itemData.ADDRESS; 
			break;
		}
	}
	
    return cell;
}

@end
