//
//  ManhuaRequestHeader.h
//  Dream
//
//  Created by dch on 2022/11/5.
//

#ifndef ManhuaRequestHeader_h
#define ManhuaRequestHeader_h

#define ManhuaLocalHost @"127.0.0.1"

#define ManhuaPort 8081

#define ManhuaSearchURL [NSString stringWithFormat:@"http://%@:%d/search",ManhuaLocalHost,ManhuaPort]

#define ManhuaChapterURL [NSString stringWithFormat:@"http://%@:%d/chapter",ManhuaLocalHost,ManhuaPort]

#define ManhuaDetailURL [NSString stringWithFormat:@"http://%@:%d/detail",ManhuaLocalHost,ManhuaPort]

#endif /* ManhuaRequestHeader_h */
