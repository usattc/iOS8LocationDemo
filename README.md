# iOS8LocationDemo


由于从iOS 8开始在App里开启定位服务需要在Info.plist里加入2个key才会调用CLLocationManagerDelegate, 写了一个Demo希望对大家有帮助.


这2个Key分别是NSLocationWhenInUseUsageDescription和NSLocationAlwaysUsageDescription, Value填写你需要定位的描述.
