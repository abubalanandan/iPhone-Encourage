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
    
    [self addBarButtons];
    
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
    
    if (APP_DELEGATE.dataManager.chosenContactEmails.count > 0 && APP_DELEGATE.dataManager.chosenContactNames.count > 0) {
     
        if ([APP_DELEGATE.dataManager.chosenContactNames containsObject:[[self.contactsArray objectAtIndex:indexPath.row] objectForKey:@"name"]]) {
            cell.checkBoxButton.selected = YES;
        }
        else {
            cell.checkBoxButton.selected = NO;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JHTableViewCell *cell = (JHTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.checkBoxButton.selected == NO) {
     
        [APP_DELEGATE.dataManager.chosenContactNames addObject:cell.nameLabel.text];
        [APP_DELEGATE.dataManager.chosenContactEmails addObject:cell.emailLabel.text];
        [cell.checkBoxButton setSelected:YES];
    }
    else {
        
        [APP_DELEGATE.dataManager.chosenContactEmails removeObject:cell.emailLabel.text];
        [APP_DELEGATE.dataManager.chosenContactNames removeObject:cell.nameLabel.text];
        [cell.checkBoxButton setSelected:NO];
    }
}

- (void)markContactsAsSelected {
    
    if (APP_DELEGATE.dataManager.chosenContactEmails.count > 0 && APP_DELEGATE.dataManager.chosenContactNames.count > 0) {
        
    }
}


#pragma mark -
#pragma mark - Private Methods

- (void)saveAction {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectContacts:andContacts:)]) {
        [self.delegate didSelectContacts:APP_DELEGATE.dataManager.chosenContactNames
                             andContacts:APP_DELEGATE.dataManager.chosenContactEmails];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addBarButtons {
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonAction)];
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = item;
}

- (void)backButtonAction {
    
    if (APP_DELEGATE.dataManager.chosenContactNames.count > 0 || APP_DELEGATE.dataManager.chosenContactEmails.count > 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Are you sure you want to remove the selected contacts?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

#pragma mark -
#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        [APP_DELEGATE.dataManager clearContacts];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
