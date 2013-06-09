# SLUITableViewCellSectionLocation
UITableViewCellSectionLocation made public.

SLUITableViewCellSectionLocation exposes the new public interface

``` objc
@interface UITableViewCell (SLUITableViewCellSectionLocation)

@property (nonatomic, assign) SLUITableViewCellSectionLocation forbiddenSectionLocation;
- (void)setForbiddenSectionLocation:(SLUITableViewCellSectionLocation)location animated:(BOOL)animated;

@end
```

which informs you about section location changes.

## License

MIT