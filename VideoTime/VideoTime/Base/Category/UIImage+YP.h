//
//  UIImage+YP.h
//  VideoTime
//
//  Created by 吴园平 on 25/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YP)

/*
 *加载一个不要被渲染的图片
 */
+ (UIImage *)imageNamedWithOriginal:(NSString *)name;

/**
 * 绘制纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor*)color;
/**
 * ？
 */
+ (NSString *)imageToDataURL:(UIImage *)image;
/**
 * 返回指定大小的图片
 */
- (UIImage *)scaleToSize:(CGSize)size;

@end
