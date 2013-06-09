//
//  UITableViewCell+SLUITableViewCellSectionLocation.m
//
//  The MIT License (MIT)
//  Copyright (c) 2013 Oliver Letterer, Sparrow-Labs
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UITableViewCell+SLUITableViewCellSectionLocation.h"
#import <objc/message.h>
#import <objc/runtime.h>

static void class_swizzleSelector(Class class, SEL originalSelector, SEL newSelector)
{
    Method origMethod = class_getInstanceMethod(class, originalSelector);
    Method newMethod = class_getInstanceMethod(class, newSelector);
    if(class_addMethod(class, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(class, newSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}



@implementation UITableViewCell (SLUITableViewCellSectionLocation)

- (SLUITableViewCellSectionLocation)forbiddenSectionLocation
{
    SEL selector = NSSelectorFromString([@[@"section", @"Location"] componentsJoinedByString:@""]);
    if ([UITableViewCell instancesRespondToSelector:selector]) {
        return ((SLUITableViewCellSectionLocation(*)(id, SEL))objc_msgSend)(self, selector);
    }
    
    return SLUITableViewCellSectionLocationSingle;
}

- (void)setForbiddenSectionLocation:(SLUITableViewCellSectionLocation)forbiddenSectionLocation
{
    SEL selector = NSSelectorFromString([@[@"set", @"Section", @"Location:"] componentsJoinedByString:@""]);
    if ([UITableViewCell instancesRespondToSelector:selector]) {
        struct objc_super super = {
            .receiver = self,
            .super_class = [UITableViewCell class]
        };
        
        ((void(*)(struct objc_super *, SEL, SLUITableViewCellSectionLocation))objc_msgSendSuper)(&super, selector, forbiddenSectionLocation);
    }
}

- (void)setForbiddenSectionLocation:(SLUITableViewCellSectionLocation)location animated:(BOOL)animated
{
    SEL selector = NSSelectorFromString([@[@"set", @"Section", @"Location:", @"animated:"] componentsJoinedByString:@""]);
    if ([UITableViewCell instancesRespondToSelector:selector]) {
        struct objc_super super = {
            .receiver = self,
            .super_class = [UITableViewCell class]
        };
        
        ((void(*)(struct objc_super *, SEL, SLUITableViewCellSectionLocation, BOOL))objc_msgSendSuper)(&super, selector, location, animated);
    }
}

+ (void)load
{
    class_swizzleSelector(self, @selector(initWithStyle:reuseIdentifier:), @selector(__SLUITableViewCellSectionLocationInitWithStyle:reuseIdentifier:));
}

- (id)__SLUITableViewCellSectionLocationInitWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier __attribute__((objc_method_family(init)))
{
    if ((self = [self __SLUITableViewCellSectionLocationInitWithStyle:style reuseIdentifier:reuseIdentifier]) && self.class != [UITableViewCell class]) {
        SEL selector = NSSelectorFromString([@[@"set", @"Section", @"Location:"] componentsJoinedByString:@""]);
        if ([self.class instanceMethodForSelector:selector] == [UITableViewCell instanceMethodForSelector:selector]) {
            IMP implementation = imp_implementationWithBlock(^(UITableViewCell *_self, SLUITableViewCellSectionLocation location) {
                [_self setForbiddenSectionLocation:location];
            });
            class_addMethod(self.class, selector, implementation, method_getTypeEncoding(class_getInstanceMethod(self.class, @selector(setForbiddenSectionLocation:))));
        }
        
        selector = NSSelectorFromString([@[@"set", @"Section", @"Location:", @"animated:"] componentsJoinedByString:@""]);
        if ([self.class instanceMethodForSelector:selector] == [UITableViewCell instanceMethodForSelector:selector]) {
            IMP implementation = imp_implementationWithBlock(^(UITableViewCell *_self, SLUITableViewCellSectionLocation location, BOOL animated) {
                [_self setForbiddenSectionLocation:location animated:animated];
            });
            class_addMethod(self.class, selector, implementation, method_getTypeEncoding(class_getInstanceMethod(self.class, @selector(setForbiddenSectionLocation:))));
        }
    }
    
    return self;
}

@end
