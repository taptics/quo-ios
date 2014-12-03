//
//  DraftsController.m
//  Quo
//
//  Created by Ryan Cohen on 11/18/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "DraftsController.h"
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    DraftCell *cell = (DraftCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[DraftCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    cell.titleLabel.text = [[_drafts objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    return cell;
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *drafts = [[NSUserDefaults standardUserDefaults] arrayForKey:@"DraftsKey"];
    _drafts = [NSArray arrayWithArray:drafts];
    
    _tableView.backgroundView = nil;
    _tableView.backgroundColor = [UIColor colorWithRed:244/255.f green:241/255.f blue:237/255.f alpha:1.f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
