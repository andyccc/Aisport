//
//  WholePartVideoView.m
//  Aisport
//
//  Created by Apple on 2020/11/10.
//

#import "WholePartVideoView.h"
#import "WholePartVideoViewCell.h"

@interface WholePartVideoView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation WholePartVideoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *hejiTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15*2*Screen_Scale, 0, SCR_WIDTH-30*2*Screen_Scale, 48*2*Screen_Scale_height)];
        [self addSubview:hejiTitleLabel];
        hejiTitleLabel.font = fontBold(17);
        hejiTitleLabel.textColor = [UIColor colorWithHex:@"#333333"];
        hejiTitleLabel.text = @"合集推荐";
        
        UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH-15*2*Screen_Scale-65, 0, 65, 48*2*Screen_Scale)];
        [self addSubview:moreButton];
        [moreButton setTitle:@"查看全部" forState:UIControlStateNormal];
        [moreButton setTitleColor:[UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];
        moreButton.titleLabel.font = fontApp(11);
        [moreButton setImage:[UIImage imageNamed:@"arror_right"] forState:UIControlStateNormal];
        [moreButton layoutButtonWithEdgeInsetsStyle:MWButtonEdgeInsetsStyleRight imageTitleSpace:4];
        moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        moreButton.hidden = YES;
//        [moreButton addTarget:self action:@selector(clickPlaceOKButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(183*2*Screen_Scale, 125*2*Screen_Scale);
        flowLayout.minimumInteritemSpacing = 15;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15*2*Screen_Scale, 0, 0);
        
        
        UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 48*2*Screen_Scale, SCR_WIDTH, 125*2*Screen_Scale) collectionViewLayout:flowLayout];
        [self addSubview:mainView];
        mainView.backgroundColor = [UIColor whiteColor];
        mainView.delegate = self;
        mainView.dataSource = self;
        mainView.showsHorizontalScrollIndicator = NO;
        [mainView registerClass:[WholePartVideoViewCell class] forCellWithReuseIdentifier:@"WholePartVideoViewCell"];
        _mainView = mainView;
    }
    return self;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSoure.count;
//    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WholePartVideoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WholePartVideoViewCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithHex:@"#ffffff" alpha:0.6];
    cell.model = self.dataSoure[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickWholePartVideoBlock) {
        self.clickWholePartVideoBlock(self.dataSoure[indexPath.row]);
    }
}

- (void)setDataSoure:(NSMutableArray *)dataSoure
{
    _dataSoure = dataSoure;
    [self.mainView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
