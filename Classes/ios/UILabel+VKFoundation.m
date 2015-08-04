//
//  Created by Viki.
//  Copyright (c) 2014 Viki Inc. All rights reserved.
//

#import "UILabel+VKFoundation.h"

@implementation UILabel (VKFoundation)

- (void)alignTop {
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    CGSize theStringSize = [self.text boundingRectWithSize:CGSizeMake(finalWidth, finalHeight)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:self.font}
                                                   context:nil].size;
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text = [self.text stringByAppendingString:@"\n "];
}

- (void)alignBottom {
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    CGSize theStringSize = [self.text boundingRectWithSize:CGSizeMake(finalWidth, finalHeight)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:self.font}
                                                   context:nil].size;

    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text = [NSString stringWithFormat:@" \n%@",self.text];
}

- (void)sizeToFitMaxSize:(CGSize)size {
    CGSize targetSize = [self.text boundingRectWithSize:CGSizeMake(size.width, size.height)
                                                options:NSStringDrawingTruncatesLastVisibleLine
                                             attributes:@{NSFontAttributeName:self.font}
                                                context:nil].size;

  self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, targetSize.width, targetSize.height);
}

- (void)sizeToFitMaxHeight:(CGFloat)maxHeight {
  [self sizeToFitMaxSize:CGSizeMake(self.frame.size.width, maxHeight)];
}

- (void)sizeToFitMaxLines:(NSInteger)lines {
  [self sizeToFitMaxHeight:lines * self.font.lineHeight];
}
@end
