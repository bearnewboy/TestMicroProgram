#import "TestViewController.h"
#import "DetailViewController.h"
#import "DBControlSingleton.h"
#import "ParkData.h"
#import "ParkDataCell.h"

@interface TestViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain) UITableView *tableView;
@property(nonatomic, retain) NSArray *dataArray;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"Table View"];
    navBar.items = [NSArray arrayWithObject:navItem];
    [self.view addSubview:navBar];
    [navBar release];
    [navItem release];
	
	self.dataArray = [[DBControlSingleton getInstance] selectAllParkData];
	
    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];
    self.tableView.frame = CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 50);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
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
	if(self.dataArray.count > indexPath.row){
		ParkData *itemData = [self.dataArray objectAtIndex:indexPath.row]
		return [ParkData cellHeightWithItemData:itemData andTableWidth:tableView.frame.size.width];
	}
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if(self.dataArray.count > indexPath.row){
		ParkData *itemData = [self.dataArray objectAtIndex:indexPath.row]
		
		DetailViewController *vc = [[DetailViewController alloc] init];
        vc.itemData = itemData;
		
		[self.navigationController pushViewController:vc animated:YES];  
        [vc release];
	}
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    ParkDataCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[ParkDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
	if(self.dataArray.count > indexPath.row){
		cell.itemData = [self.dataArray objectAtIndex:indexPath.row];
	}
	
    return cell;
}

@end
