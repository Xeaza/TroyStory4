#import "MasterViewController.h"

@interface MasterViewController () <UITableViewDataSource>

@property NSArray *trojans;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [self loadData];
}

- (IBAction)onTrojanConquest:(UITextField *)sender
{
    [sender resignFirstResponder];
}

- (void)loadData
{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Trojan"];
    self.trojans = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];

    if (!error)
    {
        [self.tableView reloadData];
    }
    else
    {
        NSLog(@"Error: %@",error.localizedDescription);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *trojan = [self.trojans objectAtIndex:indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [trojan valueForKey:@"name"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.trojans.count;
}

@end