//
//  CustomCell.m
//  Todo
//
//  Created by maha on 4/21/24.
//  Copyright © 2024 maha. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        CGFloat imageSize = 60.0;
//        self.circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (50 - imageSize) / 2, imageSize, imageSize)];
//        self.circleImageView.layer.cornerRadius = imageSize / 2;
//        self.circleImageView.clipsToBounds = YES;
//        [self.contentView addSubview:self.circleImageView];
//
//        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, self.contentView.frame.size.width - 70, 50)];
//         self.titleLabel.font = [UIFont systemFontOfSize:30.0];
//        [self.contentView addSubview:self.titleLabel];
//    }
//    return self;
//}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat cellHeight = 80.0;
        CGFloat imageSize = cellHeight - 20.0; // Adjusted image size based on cell height
        CGFloat verticalPadding = (cellHeight - imageSize) / 2; // Vertical padding to center the image vertically
        
        // Circle Image View
        self.circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, verticalPadding, imageSize, imageSize)];
        self.circleImageView.layer.cornerRadius = imageSize / 2;
        self.circleImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.circleImageView];
        
        // Title Label
        CGFloat labelX = CGRectGetMaxX(self.circleImageView.frame) + 10.0;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 0, self.contentView.frame.size.width - labelX - 10.0, cellHeight)];
        self.titleLabel.font = [UIFont systemFontOfSize:20.0]; // Set the font size
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

@end
