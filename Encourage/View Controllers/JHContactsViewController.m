//
//  JHContactsViewController.m
//  Encourage
//
//  Created by kiran vs on 15/12/14.
//  Copyright (c) 2014 Journey Health Labs. All rights reserved.
//

#import "JHContactsViewController.h"
#import "JHTableViewCell.h"

@interface JHContactsViewController ()

@property (nonatomic, strong) NSMutableArray *emailArray;
@property (nonatomic, strong) NSMutableArray *nameArray;
@end

@implementation JHContactsViewController

- (id)initWithDelegate:(id <JHContactDataDelegate>) delegate {
    
    self = [super initWithNibName:nil  bundle:nil];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    self.emailArray = [NSMutableArray array];
    self.nameArray = [NSMutableArray array];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contactsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SLReservationCell";
    
    JHTableViewCell *cell = (JHTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"JHTableViewCell" owner: self options: Nil];
        cell = [nib objectAtIndex: 0];
    }
    
    cell.nameLabel.text = [[self.contactsArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.emailLabel.text = [[self.contactsArray objectAtIndex:indexPath.row] objectForKey:@"email"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JHTableViewCell *cell = (JHTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.checkBoxButton.selected == NO) {
     
        [self.nameArray addObject:cell.nameLabel.text];
        [self.emailArray addObject:cell.emailLabel.text];
        [cell.checkBoxButton setSelected:YES];
    }
    else {
        
        [self.emailArray removeObject:cell.emailLabel.text];
        [self.nameArray removeObject:cell.nameLabel.text];
        [cell.checkBoxButton setSelected:NO];
    }
}

#pragma mark -
#pragma mark - Private Methods

- (void)saveAction {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectContacts:andContacts:)]) {
        [self.delegate didSelectContacts:self.nameArray andContacts:self.emailArray];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
