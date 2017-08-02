## 更多文章:http://blog.csdn.net/feng2qing?viewmode=list
## **前言**
### 1.由于项目需求,需要一个类似QQ/微信的聊天键盘,包括语音,emoji和发送图片,文件,位置,网上找了一番,要不功能不够完善,要不依赖太多,于是干脆自己写一个(在使用过程中如果发现什么问题或有什么建议,还望您提出来,共同进步)
###2.微信的语音发送实现网上已经很多了,在这里打算做一个QQ语音发送的效果,此模块正在开发中....

## **DEMO效果**
![Mou icon](http://g.recordit.co/1g8ZwxvWDn.gif)
##**类的介绍**
![这里写图片描述](http://img.blog.csdn.net/20160825084343802)

```
InputToolbar:键盘工具条
VoiceButtonView:语音模块视图
EmojiButtonView:Emoji模块视图
MoreButtonView:加号模块视图(相册,相机,文件,位置...)
CollectionViewFlowLayout:表情键盘CollectionView布局
EmpjiCollectionViewCell:表情键盘collectionViewCell
UIView+Extension:UIView工具类
```

## **集成用法**

```
加头文件:
    #import "InputToolbar.h"
遵守协议
    <MoreButtonViewDelegate>
添加属性:
    @property (nonatomic,strong)InputToolbar *inputToolbar;
创建inputToolbar
    self.inputToolbar = [InputToolbar shareInstance];
    [self.view addSubview:self.inputToolbar];

输入框最大显示行数    
    self.inputToolbar.textViewMaxVisibleLine = 4;
布局inputToolbar    
    self.inputToolbar.width = self.view.width;
    self.inputToolbar.height = 49;
    self.inputToolbar.y = self.view.height - self.inputToolbar.height;
设定代理
    [self.inputToolbar setMorebuttonViewDelegate:self];
点击发送按钮回调,顺便传回输入内容    
    __weak typeof(self) weakSelf = self;
    self.inputToolbar.sendContent = ^(NSObject *content){
        
        NSLog(@"发射成功☀️:---%@",content);

        if ([content isKindOfClass:[NSTextAttachment class]]) {

            [weakSelf.textView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:(NSTextAttachment *)content] atIndex:weakSelf.textView.selectedRange.location];
            
        } else {
            
            weakSelf.textView.text = ((NSAttributedString *)content).string;
        }
    };
    
    self.inputToolbar.inputToolbarFrameChange = ^(CGFloat height,CGFloat orignY){
        _inputToolbarY = orignY;
    };

//点击MoreButtonView中的按钮会调用此方法(根据实际需求自行增删)
- (void)moreButtonView:(MoreButtonView *)moreButtonView didClickButton:(MoreButtonViewButtonType)buttonType
{
    switch (buttonType) {
        case MoreButtonViewButtonTypeImages:
        {
			//发送相册操作
        } break;
            
        case MoreButtonViewButtonTypeCamera:
        {
			//发送相机操作
        } break;
        case MoreButtonViewButtonTypeFile:
        {
			//发送文件操作
        } break;
		 //.........
        default:
            break;
    }
}
```
