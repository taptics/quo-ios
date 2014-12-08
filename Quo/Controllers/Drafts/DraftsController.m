//
//  DraftsController.m
//  Quo
//
//  Created by Ryan Cohen on 11/18/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "DraftsController.h"
#import "ComposeController.h"
#import "DraftCell.h"
#import "Quo.h"

@interface DraftsController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (IBAction)close:(id)sender;

@end

@implementation DraftsController

#pragma mark - Action

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _drafts.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *draft = @{ @"title" : [[_drafts objectAtIndex:indexPath.row] objectForKey:@"title"],
                             @"body"  : [[_drafts objectAtIndex:indexPath.row] objectForKey:@"body"] };
    
    [_drafts removeObject:draft];
    [[NSUserDefaults standardUserDefaults] setObject:_drafts forKey:@"DraftsKey"];
    
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView endUpdates];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    DraftCell *cell = (DraftCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[DraftCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = [[_drafts objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    return cell;
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tableView.bounds.size.width, 1.f)];
    
    NSArray *drafts = [[NSUserDefaults standardUserDefaults] arrayForKey:@"DraftsKey"];
    _drafts = [NSMutableArray arrayWithArray:drafts];
    
    _tableView.backgroundView = nil;
    _tableView.backgroundColor = [UIColor colorWithRed:244/255.f green:241/255.f blue:237/255.f alpha:1.f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ComposeController *compose = (ComposeController *)[segue destinationViewController];
    compose.fromDraft = YES;
    compose.postTitle = [[_drafts objectAtIndex:[_tableView indexPathForSelectedRow].row] objectForKey:@"title"];
    compose.postBody = [[_drafts objectAtIndex:[_tableView indexPathForSelectedRow].row] objectForKey:@"body"];
}

@end
