//
//  BAKAttachmentsViewController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/5/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAttachmentsViewController.h"
#import "BAKAttachmentsDataSource.h"
#import "BAKAttachmentCell.h"
#import "BAKAttachment.h"
#import "BAKAttachmentButtonCell.h"
#import "BAKAttachmentContainer.h"

NSString *const BAKAttachmentCellIdentifier = @"AttachmentCellIdentifier";
NSString *const BAKAttachmentButtonIdentifier = @"AttachmentButtonIdentifier";

@interface BAKAttachmentsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) BAKAttachmentsDataSource *dataSource;

@end

@implementation BAKAttachmentsViewController

@dynamic view;

+ (CGFloat)minimumInterItemSpacing {
    return 10;
}

- (instancetype)initAsEditable:(BOOL)editable totalWidth:(CGFloat)totalWidth {
    CGFloat totalCellWidths = totalWidth - 4 * [self.class minimumInterItemSpacing];
    CGFloat individualCellWidth = totalCellWidths / 5;
    return [self initAsEditable:editable itemSize:individualCellWidth];
}

- (instancetype)initAsEditable:(BOOL)editable itemSize:(CGFloat)itemSize {
    self = [super init];
    if (!self) return nil;
    
    _editable = editable;
    _itemSize = itemSize;
    
    return self;
}

- (UICollectionViewLayout *)newLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.itemSize, self.itemSize);
    layout.minimumInteritemSpacing = [self.class minimumInterItemSpacing];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, [self.class minimumInterItemSpacing]);
    return layout;
}

- (void)loadView {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self newLayout]];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.view = collectionView;
}

- (UICollectionView *)collectionView {
    return (UICollectionView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[BAKAttachmentCell class] forCellWithReuseIdentifier:BAKAttachmentCellIdentifier];
    [self.collectionView registerClass:[BAKAttachmentButtonCell class] forCellWithReuseIdentifier:BAKAttachmentButtonIdentifier];
    self.dataSource = [[BAKAttachmentsDataSource alloc] initWithAttachmentContainers:nil editable:self.editable];
}

- (void)setAttachmentContainers:(NSArray *)attachmentContainers {
    self.dataSource = [[BAKAttachmentsDataSource alloc] initWithAttachmentContainers:attachmentContainers editable:self.editable];
    [self.collectionView reloadData];
    [self ensureAllAttachmentsAreLoaded];
}

- (NSArray *)attachmentContainers {
    return self.dataSource.attachmentContainers;
}

- (void)ensureAllAttachmentsAreLoaded {
    [self.attachmentContainers enumerateObjectsUsingBlock:^(BAKAttachmentContainer *container, NSUInteger idx, BOOL *stop) {
        BAKAttachment *attachment = container.attachment;
        if (!attachment.imageLoaded) {
            [attachment fetchImageWithSuccessBlock:^{
                [self.collectionView reloadData];
            } failureBlock:nil];
        }
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.dataSource.attachmentsSectionIndex) {
        BAKAttachmentContainer *container = [self.dataSource objectAtIndexPath:indexPath];
        BAKAttachmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BAKAttachmentCellIdentifier forIndexPath:indexPath];
        [cell updateWithImage:container.image];
        cell.loadingIndicatorAnimating = container.shouldShowLoadingIndicator;
        cell.errorViewVisible = container.hadError;
        if (!container.attachmentSuccessfullyUploaded) {
            cell.imageTranslucent = YES;
        } else if (cell.imageTranslucent && container.attachmentSuccessfullyUploaded) {
            [cell fadeImageToOpaque];
        } else {
            cell.imageTranslucent = NO;
        }
        return cell;
    }
    if (indexPath.section == self.dataSource.buttonSectionIndex) {
        BAKAttachmentButtonCell *newAttachmentCell = [collectionView dequeueReusableCellWithReuseIdentifier:BAKAttachmentButtonIdentifier forIndexPath:indexPath];
        return newAttachmentCell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.dataSource.buttonSectionIndex) {
        if ([self.delegate respondsToSelector:@selector(attachmentsViewControllerDidTapAttachmentButton:)]) {
            [self.delegate attachmentsViewControllerDidTapAttachmentButton:self];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(attachmentsViewController:didTapAttachmentInContainer:)]) {
            BAKAttachmentContainer *container = [self.dataSource objectAtIndexPath:indexPath];
            [self.delegate attachmentsViewController:self didTapAttachmentInContainer:container];
        }
    }
}

@end
