# SLUITableViewCellSectionLocation
UITableViewCellSectionLocation made public.

SLUITableViewCellSectionLocation exposes the new public interface

``` objc
@interface UITableViewCell (SLUITableViewCellSectionLocation)

@property (nonatomic, assign) SLUITableViewCellSectionLocation forbiddenSectionLocation;
- (void)setForbiddenSectionLocation:(SLUITableViewCellSectionLocation)location animated:(BOOL)animated;

@end
```

which informs you about section location changes. Check our [this blog post](http://sparrow-labs.github.io/2013/06/09/some_private_goodness.html) for more.

## License

MIT
