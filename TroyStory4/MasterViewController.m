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
    NSError *error;
    NSManagedObject *trojan = [NSEntityDescription insertNewObjectForEntityForName:@"Trojan" inManagedObjectContext:self.managedObjectContext];
    [trojan setValue:sender.text forKey:@"name"];
    [trojan setValue:@(arc4random_uniform(10)+1) forKey:@"prowess"];
    [self.managedObjectContext save:&error];
    if (!error)
    {
        [self loadData];
    }
    else
    {
        NSLog(@"Error: %@",error.localizedDescription);
    }
    sender.text = @"";
    [sender resignFirstResponder];
}

- (void)loadData
{
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Trojan"];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"prowess" ascending:YES];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"prowess > %d", 5];
    request.predicate = predicate;
    request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil];

    self.trojans = [self.managedObjectContext executeFetchRequest:request error:nil];

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
    cell.detailTextLabel.text = [[trojan valueForKey:@"prowess"] description];
    // Line 57 is also the same as this line
    //cell.detailTextLabel.text = [[trojan valueForKey:@"prowess"] stringValue];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.trojans.count;
}

@end