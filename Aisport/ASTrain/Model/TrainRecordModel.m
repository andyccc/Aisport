//
//  TrainRecordModel.m
//  Aisport
//
//  Created by Apple on 2020/10/30.
//

#import "TrainRecordModel.h"

@implementation TrainRecordModel

- (NSDictionary *)getModelDictionary
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithCapacity:0];
    [dictM setObject:[NSString stringWithFormat:@"%ld",_score] forKey:@"score"];
    [dictM setObject:[NSString stringWithFormat:@"%ld",_hidoTotal] forKey:@"hidoTotal"];
    [dictM setObject:[NSString stringWithFormat:@"%ld",_perfectNumber] forKey:@"perfectNumber"];
    [dictM setObject:[NSString stringWithFormat:@"%ld",_superTotal] forKey:@"superTotal"];
    [dictM setObject:[NSString stringWithFormat:@"%ld",_goodTotal] forKey:@"goodTotal"];
    [dictM setObject:[NSString stringWithFormat:@"%ld",_okTotal] forKey:@"okTotal"];
    [dictM setObject:[NSString stringWithFormat:@"%ld",_missTotal] forKey:@"missTotal"];
    [dictM setObject:[NSString stringWithFormat:@"%ld",_batter] forKey:@"batter"];
    [dictM setObject:[NSString stringWithFormat:@"%ld",_batterMax] forKey:@"batterMax"];
    [dictM setObject:[NSString stringWithFormat:@"%ld",_batterMin] forKey:@"batterMin"];
    [dictM setObject:[NSString stringWithFormat:@"%ld",_breakTotal] forKey:@"breakTotal"];
    [dictM setObject:[NSString stringWithFormat:@"%ld",_breakTime] forKey:@"breakTime"];
    [dictM setObject:StringForId(_exitWay) forKey:@"exitWay"];
    [dictM setObject:[NSString stringWithFormat:@"%ld",_starNum] forKey:@"starNum"];
    [dictM setObject:[NSString stringWithFormat:@"%lld",_startTime] forKey:@"startTime"];
    [dictM setObject:[NSString stringWithFormat:@"%lld",_endTime] forKey:@"endTime"];
    [dictM setObject:StringForId(_videoCode) forKey:@"videoCode"];
    [dictM setObject:[NSString stringWithFormat:@"%ld",_frameTotal] forKey:@"frameTotal"];
    [dictM setObject:StringForId(_completed) forKey:@"completed"];
    
    NSMutableArray *actionScoreLogs = [NSMutableArray arrayWithCapacity:0];
    for (TrainSmallActionModel *smalModel in _actionScoreLogs) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
//        [dic setObject:[NSString stringWithFormat:@"%lld",smalModel.createTime] forKey:@"createTime"];
        [dic setObject:[NSString stringWithFormat:@"%ld",(long)(smalModel.time*1000)] forKey:@"time"];
        [dic setObject:[NSString stringWithFormat:@"%@",smalModel.createTime] forKey:@"createTime"];
        [dic setObject:StringForId(smalModel.keyFrameId) forKey:@"keyFrameId"];
        [dic setObject:StringForId(smalModel.result) forKey:@"result"];
        [dic setObject:[NSString stringWithFormat:@"%ld",smalModel.score] forKey:@"score"];
        [dic setObject:StringForId(smalModel.uid) forKey:@"uid"];
        [actionScoreLogs addObject:dic];
    }
    [dictM setObject:actionScoreLogs forKey:@"actionScoreLogs"];
    
    return dictM.copy;
}

@end
