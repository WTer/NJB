//
//  FuWuTableViewCell.m
//  农帮乐
//
//  Created by hpz on 15/12/11.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "FuWuTableViewCell.h"

@implementation FuWuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
       
        
        [self createUI];
    }
    return self;
}
- (void)createUI {
    
    CGSize size = [NSLocalizedString(@"SERVE", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
    UILabel *fuwu = [[UILabel alloc]initWithFrame:CGRectMake(24 * scaleWidth, 40 * scaleHeight, size.width, size.height)];
    fuwu.text = NSLocalizedString(@"SERVE", @"");
    [self.contentView addSubview:fuwu];
    
    _server = [[UILabel alloc] init];
    [self.contentView addSubview:_server];
    
    _telLabel = [[UILabel alloc] init];
    _telLabel.textColor = BaseColor(105, 105, 105, 1);
    [self.contentView addSubview:_telLabel];
    

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 80 * scaleHeight + size.height * 2 - 1, Screen_Width, 1)];
    label.backgroundColor = BaseColor(242, 242, 242, 1);
    [self.contentView addSubview:label];
    
}
- (void)configWithDictionary:(NSDictionary *)dict {

    NSDictionary* priceStyle = @{@"fuhao" :@[[UIFont systemFontOfSize:18.0],BaseColor(105, 105, 105, 1)],
                                 @"serve" :@[[UIFont systemFontOfSize:18.0],BaseColor(14, 184, 58, 1)]};
    _server.text = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"The goods provided by", @"") ,dict[@"displayname"], NSLocalizedString(@"Provide services", @"")];
    _server.attributedText = [[NSString stringWithFormat:@"<fuhao>%@</fuhao><serve>%@</serve><fuhao>%@</fuhao>",NSLocalizedString(@"The goods provided by", @""), dict[@"displayname"], NSLocalizedString(@"Provide services", @"")] attributedStringWithStyleBook:priceStyle];
    CGSize size = [NSLocalizedString(@"SERVE", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(990, 100)];
    CGSize serveSize = [_server.text sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(990, 100)];
    _server.frame = CGRectMake(44 * scaleWidth + size.width, 40 * scaleHeight, serveSize.width, serveSize.height);
    
    _telLabel.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"Contact phone number", @""), dict[@"telephone"]];
    CGSize telSize = [_telLabel.text sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(990, 100)];
    _telLabel.frame = CGRectMake(44 * scaleWidth + size.width, 40 * scaleHeight + serveSize.height, telSize.width, telSize.height);
    

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
