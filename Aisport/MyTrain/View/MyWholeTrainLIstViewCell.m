//
//  MyWholeTrainLIstViewCell.m
//  Aisport
//
//  Created by Apple on 2020/11/11.
//

#import "MyWholeTrainLIstViewCell.h"
#import "MyTrainVideoViewCell.h"

@interface MyWholeTrainLIstViewCell ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *mainListBgView;
@property (nonatomic, strong) UITableView *mainListView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *hejiTitleLabel;
@property (nonatomic, strong) UIView *lastTimeView;
@property (nonatomic, strong) UILabel *lastTimeLab;

@property (nonatomic, strong) UIButton *trainButton;

@property (nonatomic, strong) NSMutableArray *videoList;

@end

@implementation MyWholeTrainLIstViewCell

- (NSMutableArray *)videoList
{
    if (!_videoList) {
        _videoList = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _videoList;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        UIView *mainListBgView = [[UIView alloc] initWithFrame:CGRectMake(16*2*Screen_Scale, 12, SCR_WIDTH-16*2*Screen_Scale*2, (79*2*Screen_Scale+36)*1+88-18+115-18)];
        [self addSubview:mainListBgView];
        mainListBgView.backgroundColor = [UIColor whiteColor];
        mainListBgView.layer.cornerRadius = 7;
        mainListBgView.layer.shadowColor = [UIColor colorWithHex:@"#282828" alpha:0.09].CGColor;
        mainListBgView.layer.shadowOffset = CGSizeMake(0,0);
        mainListBgView.layer.shadowRadius = 5;
        mainListBgView.layer.shadowOpacity = 1;
        _mainListBgView = mainListBgView;
        
        _mainListView = [[UITableView alloc] initWithFrame:CGRectMake(16*2*Screen_Scale, 12+115-18, SCR_WIDTH-16*2*Screen_Scale*2, (79*2*Screen_Scale+36)*1+88-18) style:UITableViewStylePlain];
        [self addSubview:_mainListView];
        _mainListView.delegate = self;
        _mainListView.dataSource = self;
//        _mainListView.tableFooterView = [[UIView alloc] init];
        _mainListView.estimatedRowHeight = 0;
        _mainListView.estimatedSectionFooterHeight = 0;
        _mainListView.estimatedSectionHeaderHeight = 0;
        _mainListView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _mainListView.backgroundColor = [UIColor whiteColor];
//        _mainListView.layer.cornerRadius = 7;
//        _mainListView.layer.shadowColor = [UIColor colorWithHex:@"#282828" alpha:0.09].CGColor;
//        _mainListView.layer.shadowOffset = CGSizeMake(0,0);
//        _mainListView.layer.shadowRadius = 5;
//        _mainListView.layer.shadowOpacity = 1;
        
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(16*2*Screen_Scale, 12, SCR_WIDTH-16*2*2*Screen_Scale, 115-18)];
        [self addSubview:headView];
        _headView = headView;
        
        UILabel *hejiTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 22, headView.width-30, 18)];
        [headView addSubview:hejiTitleLabel];
        hejiTitleLabel.textColor = [UIColor colorWithHex:@"#333333"];
        hejiTitleLabel.font = fontBold(19);
        hejiTitleLabel.text = @"合集1";
        _hejiTitleLabel = hejiTitleLabel;
        
        UIView *lastTimeView = [[UIView alloc] initWithFrame:CGRectMake(13, hejiTitleLabel.bottom+22, headView.width-12*2, 30)];
        [headView addSubview:lastTimeView];
        lastTimeView.backgroundColor = [UIColor colorWithHex:@"#F2FFFE"];
        lastTimeView.layer.cornerRadius = 15;
        lastTimeView.clipsToBounds = YES;
        _lastTimeView = lastTimeView;
        
        UILabel *lastTimeTiLab = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 82-16, 30)];
        [lastTimeView addSubview:lastTimeTiLab];
        lastTimeTiLab.textColor = [UIColor colorWithHex:@"#333333"];
        lastTimeTiLab.font = fontApp(12);
        lastTimeTiLab.text = @"上次播放：";
        
        UILabel *lastTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(lastTimeTiLab.right, 0, lastTimeView.width-lastTimeTiLab.right, 30)];
        [lastTimeView addSubview:lastTimeLab];
        lastTimeLab.textColor = [UIColor colorWithHex:@"#4CCABC"];
        lastTimeLab.font = fontApp(12);
        lastTimeLab.text = @"帕梅拉有氧操";
        _lastTimeLab = lastTimeLab;
        
//        _mainListView.tableHeaderView = headView;
        
        
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH-16*2*Screen_Scale*2, 44+22+22-18)];
        
        UIButton *trainButton = [[UIButton alloc] initWithFrame:CGRectMake(9*2*Screen_Scale, 22-18, footView.width-9*2*2*Screen_Scale, 44)];
        [footView addSubview:trainButton];
        [trainButton setTitle:@"继续训练" forState:UIControlStateNormal];
        [trainButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [trainButton setBackgroundColor:[UIColor colorWithHex:@"#1BC2B1"]];
        trainButton.titleLabel.font = fontBold(16);
        trainButton.layer.cornerRadius = 44.0/2;
        trainButton.clipsToBounds = YES;
        [trainButton addTarget:self action:@selector(clicktrainButton) forControlEvents:UIControlEventTouchUpInside];
        _trainButton = trainButton;
        
        _mainListView.tableFooterView = footView;
        
    }
    
    return self;
}

- (void)clicktrainButton
{
    NSInteger index = 0;
    for (int i = 0; i < self.videoList.count; i++) {
        TrainVideoModel *model = self.videoList[i];
        if ([StringForId(model.code) isEqual:StringForId(_listModel.lastPlayInfo[@"code"])]) {
            index = i+1;
            if (i == self.videoList.count -1) {
                index = 0;
            }
            
        }
    }
    if (self.clickTrainVideoBlock) {
        self.clickTrainVideoBlock(self.videoList[index]);
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 79*2*Screen_Scale+36;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTrainVideoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTrainVideoViewCell"];
    if (cell == nil) {
        cell = [[MyTrainVideoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyTrainVideoViewCell"];
    }
    cell.videoModel = self.videoList[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrainVideoModel *model = self.videoList[indexPath.row];
    if (self.clickSelectedVideoBlock) {
        self.clickSelectedVideoBlock(model);
    }
}

- (void)setListModel:(MyWholeVideoListModel *)listModel
{
    _listModel = listModel;
    [self.videoList removeAllObjects];
    _hejiTitleLabel.text = StringForId(listModel.cname);
    for (NSDictionary *dict in listModel.videoList) {
        TrainVideoModel *model = [[TrainVideoModel alloc] initWithDictionary:dict error:nil];
        [self.videoList addObject:model];
    }
    
    if (listModel.videoList.count < 3 && listModel.videoList.count > 0) {
        _mainListBgView.height = (79*2*Screen_Scale+36)*listModel.videoList.count+88-18+115-18;
        _mainListView.height = (79*2*Screen_Scale+36)*listModel.videoList.count+88-18;
    }else if (listModel.videoList.count <= 0){
        _mainListBgView.height = 115-18+15;
        _mainListView.height = 0;
    }else{
        _mainListBgView.height = (79*2*Screen_Scale+36)*3+88-18+115-18;
        _mainListView.height = (79*2*Screen_Scale+36)*3+88-18;
    }
    
    if (!listModel.lastPlayInfo || [listModel.lastPlayInfo isKindOfClass:[NSNull class]]) {
        _headView.height = 115-18-48;
        _mainListView.top = 12+115-18-48;
        _mainListBgView.height = _mainListBgView.height-48;
        _lastTimeView.hidden = YES;
    }else
    {
        _headView.height = 115-18;
        _mainListView.top = 12+115-18;
        _mainListBgView.height = _mainListBgView.height;
        _lastTimeView.hidden = NO;
        _lastTimeLab.text = StringForId(listModel.lastPlayInfo[@"name"]);
    }
    
    _mainListBgView.layer.cornerRadius = 7;
    _mainListBgView.layer.shadowColor = [UIColor colorWithHex:@"#282828" alpha:0.09].CGColor;
    _mainListBgView.layer.shadowOffset = CGSizeMake(0,0);
    _mainListBgView.layer.shadowRadius = 5;
    _mainListBgView.layer.shadowOpacity = 1;
    
    [self.mainListView reloadData];
}


@end
