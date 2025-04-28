/*
*调整名称：一键嗨，迪迪，您
目标应用程序：com.s.s.iphone.ugc.aweme
* Dev: @c00kiec00k 曲奇的坏品味🍻
* iOS版本：16.5
输入：*
#import“ dyyymanager.h”
#导入
#导入
#导入
// 添加变量跟踪是否在目标视图控制器中
静态bool isInplayInteractionvc = 否;
// 隐藏UIButton接口声明
@接口 隐藏UIButton：UIButton
// 状态属性
@属性（非原子，分配）布尔值是否是元素遮罩;
@属性（非原子，分配）布尔值是否锁定;
// UI 相关属性
@属性（非原子，强）nsmutablearray *sideenviewSlist;
@属性（非原子，强）uiimage *显示图标;
@属性（非原子，强）uiimage *隐藏图标;
@属性（非原子，分配）cgfloat 原始不透明度;
// 计时器属性
@属性（非原子，强）nstimer *checktimer;
@属性（非原子，强）nstimer *fadetimer;
// 新增属性：用于显示 GIF 动画
@属性（非原子，强）uiimageView *gifimageView;
// 方法声明
- （void）重置淡入淡出定时器;
- （void）hideuielement;
- （void）findandhideviews：（nsarray *）classNames;
- （void）安全重置状态;
- （void）strats周期性检查；
- （UIViewController *）查找视图控制器：（UIView *）视图;
- （void）装载；
- （void）handlepan ：（uipangeSturerocognizer *）手势;
- （void）手机；
- （void）手术：（uilongpressesturerecognizer *）手势;
- （void）手机；
- （void）手机振荡；
- （void）处理触摸结束事件;
- （void）保存锁状态;
-  void）loadlocclockstate;
@结尾
// 全局变量
静态隐藏按钮 *隐藏按钮;
静态bool iSappIntransition = 否;
静态 NSArray *targetClassNames;
静态 void findviewsofclasshelper（uiiew *view，class viewclass，NSMutable
	如果（[[视图是类的子类：视图类]）{
		[结果添加对象：视图]
	}
	对于vievie.subviews中的（uiview *subview）{
		FindViewSofClassHelper（子视图，ViewClass，结果）;
	}
输入：}
静态uiwindow *getKeyWindow（void）{
	uiwindow *keywindow = nil;
	for（uiwindow *[uiapplication sharedApplication] .windows中的窗口）{
		如果（window.iskeywindow）{
			keywindow =窗口;
			休息;
		}
	}
	返回主窗口;
输入：}
静态 void forceresetalluielement（void）{
	uiwindow *window = getKeyWindow((()));

	如果（！窗口）
		返回;
	对于（targetClassNames中的nsstring *className）{
		类查看类= nsclassfromstring（className）;
		如果（！view class）
			继续;
		/nsmutablearray *views = [nsmutablearray array];
		FindViewSofClassHelper（窗口，视图类，视图）；
		for（uiview *在视图中查看）{
			view.alpha = 1.0;
		}
	}
输入：}
静态无效的接收隐藏到oleartes（隐藏用户界面按钮 *按钮）{
	如果按钮||！按钮。
		返回;
	[按钮hideuielements]；
输入：}
静态 void InittargetClassNames（void）{
	targetClassNames = @
		@“ awehptopbarctacontainer”， @“ awehpdiscoverfeedentranceview”， @ @ @ @ @ @ @ @ @ @ @@duxbadge“点上
		@“ AweplayInteractionDescriptionLabel”， @“ aweusernamelabel”， @ @“ awestoryprogressslideview”， @ @ @ @awestoryprogresscontainerview”， @ accedittagstickerview”
		@“ awesearchfeedtagview”， @“ aweplayInteractionsearchanchorview”， @“ afdrecommendtofriendtagview”， @ @awelandscapefeedentryview”， @ @awefeedandanchorcontainerview”，
	]
输入：}
@实现 隐藏用户界面按钮
- （实例类型）initWithFrame ：（CGRect）frame

	self = [super initwithframe:frame];
	如果（self）
		self.backgroundColor = [uicolor clearColor];
		self.layer.cornerradius = frame.size.width / 2;
		self.layer.maskstobounds = 是;
		self.isElementsHidden = NO;  // 默认显示
		self.hidendviewSlist = [NSMutableArray array];
        
        // 设置默认状态为半透明
        self.originalAlpha = 0.8;  // 交互时为完全1.0不透明
        self.alpha = 0.8;  // 初始为半透明
		// 加载保存的锁定状态
		[self loadlockstate];
		[自装载]
		[自我设定：self.showicon 对于状态：uicontrolstatenormal]
		/uipangeSturerecognizer *pangeSture = [[uipangeSturerecognizer sloc] initwithtarget：self Action：@selector（handlepan :)];
		[self addgesturer识别器：pangesture]；
		[self addtarget：自我动作：@selector（handletap）forcontrolevents：uicontroleventtouchupinside];
		[self addtarget：自我动作：@selector（Handletouchdown）forcontrolevents：uicontroleventTouchDown];
		[self addtarget：自我动作：@selector（Handletouchupinside）forcontrolevents：uicontroleventtouchupinside];
		[self addtarget：自我动作：@selector（Handletouchupoutside）forcontrolevents：uicontroleventTouchupoutside];
		// 添加长按手势（长按时间为2秒）
		uilongPressEntureRecognizer *longPressEsture = [[[UilongPressEntureRecognizer sloc] initwithtarget:自我动作:@selector(handlelongpress :)];
		longPressGesture.minimumPressDuration = 2.0;  // 设置2秒长按
		[自我添加剂识别器：长按手势]
		[self startperiodiccheck]；
		[自我重置倒计时器][自我重置倒计时器]
        
        // 初始状态下隐藏按钮，直到进入正确的控制器
        self.hidden = 是;
	}
	返回自我；
输入：}
- （void）stratperiodiccheck {
	[self.checktimer无效];
	self.chachimermimer = [nsstimer 舍伍德定时器与间隔时间：0.2
							  重复：是的
							    块：^（nstimer *timer）{
							      如果（self.iselementshidded）{
								      [自我隐藏]
							      }
							    }];
输入：}
- （void）重置淡入淡出定时器 {
	[self.fadetimer无效]
	self.fadetimer = [NSTIMER 停止计时器带时间间隔：3.0
							 重复：否
							   block:^(NSTimer *timer) {
							     [UIView animateWithDuration:0.3
									      动画:^{
										self.alpha = 0.8;  // 变为半透明
									      }];
							   }];
	// 交互时变为完全不透明
    if (self.alpha != self.originalAlpha) {
        [UIView animateWithDuration:0.2
                         动画:^{
                             self.alpha = self.originalAlpha;  // 变为完全不透明
                         }];
    }
输入：}
- (void)saveLockState {
	[[NSUserDefaults standardUserDefaults] setBool:self.isLocked forKey:@"DYYYHideUIButtonLockState"];
	[[NSUserDefaults standardUserDefaults] 同步];
输入：}
- (void)loadLockState {
	self.isLocked = [[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideUIButtonLockState"];
输入：}
- (void)loadIcons {
    nsString *documentspath = nssearchpathfordirectoriesIndomains(nsdocumentDirectory, nsuserdomainmask, yes).firstObject;
    nsString *iconpath = [documentspath stringbyAppendingPathComponent:@" dyyy/qingpate.gif"];
    nsdata *gifdata = [nsdata datawithContentsOffile：iconPath];
    
    if (gifData) {
        CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)gifData, NULL);
        size_t imageCount = CGImageSourceGetCount(source);
        
        NSMutableArray
        NSTimeInterval totalDuration = 0.0;
        
        for (size_t i = 0; i < imageCount; i++) {
            CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
            UIImage *image = [UIImage imageWithCGImage:imageRef];
            [imageArray addObject:image];
            cfrelease（imageref）;
            
            // 获取当前帧的属性
            cfdictionaryref属性= cgimagesourcecopypropertiesatindex（源，i，null）;
            if（属性）{
                // 进行类型转换
                cfdictionaryref gifproperties =（cfdictionaryref）cfdictionarygetValue（属性，kcgimagepropertygifdictionary）;
                如果（gifproperties）{
                    // 尝试获取未限制的延迟时间，如果没有则获取常规延迟时间
                    nsnumber *frameAmeration =（__ bridge nsnumber *）cfdictionarygetValue（gifproperties，kcgimagepropertygifungunclampeddelaytime）;
                    如果（！
                        frameAmenation =（__ bridge nsnumber *）cfdictionarygetValue（gifproperties，kcgimagepropertygifdelaytime）;
                    }
                    如果（框架）
                        总绘制 += 帧时间doubleValue;
                    }
                }
                cfrelease（属性）;
            }
        }
        CFREALE（来源）;
        
        // 创建一个UIImageView并设置动画图像
        UIImageView *andimageView = [[UIImageView alloc] initWithFrame:self.bounds];
        AnimatedImageView.动画图像 = 图像数组;
        
        // 设置动画持续时间为所有帧延迟时间的总和
        AnimatedImageView.动画时长 = 总时长;
        animatedImageView.animationRepeatCount = 0; // 无限循环
        [self addsubview：animatedImageView];
        
        // 调整约束或布局（如果需要）
        AnimatedImageView.translatesautoresizingmaskIntoconstraints = 否;
        [nslayoutconstraint activatectraints：@][nslayoutconstraint activatectraints：@]
            [AnimatedImageView.中心X锚点 偏移等于锚点：self.中心X锚点]，，，
            [AnimatedImageView.Centeryanchor 约束等于 anchor：self.centeryanchor]
            [AnimatedImageView.Widthanchor会议Effaintequalaltoanchor：self.widthanchor]，，
            [AnimatedImageView.Heightanchor约束Equaraintequaltoanchor：self.heightanchor]
        ]];
        
        [AnimatedImageView startAnimating]；
    } 别的 {
        [自我设置：@“隐藏” forstate：uicontrolstatenormal];
        [自我设置：@“显示” forstate：uicontrolStatesElectected];
        self.titlelabel.font = [Uifont SystemFontoFsize:10];
    }
输入：}
- （void）手点
	[self resetFadeTimer];  // 这会使按钮变为完全不透明
输入：}
- （void）handletouchupinside {
	[self resetFadeTimer];  // 这会使按钮变为完全不透明
输入：}
- （void）handletouchupoutside {
	[self resetFadeTimer];  // 这会使按钮变为完全不透明
输入：}
- （UIViewController *）查找视图控制器：（UIView *）查看{
	__弱uiresponder *responder = view;
	而（响应者）
		if（[[响应者 isKindOfClassofClass：[UIViewController class]]）{
			返回（uiviewController *）响应者;
		}
		回复= [答案下一个通行证]
		如果（！响应者）
			休息;
	}
	返回零；
输入：输入：}
- （void）handingpan ：（ uipangeSturerecognizer *）手势{
	如果（self.iscobsed）
		返回;
	[self resetFadeTimer];  // 这会使按钮变为完全不透明
	cgpoint translation = [手势translationInview：self.superview];
	cgpoint newCenter = cgpointmake（self.center.x + translation.x，self.center.y + translation.y（y）;
	newcenter.x = max（self.frame.size.width / 2，min（newcenter.x，self.superview.frame.size.width-frame.frame.size.width / 2（2））;
	newcenter.y = max（self.frame.size.size.height / 2，min（newcenter.y，self.superview.frame.frame.size.size - self.frame.frame.frame.size.size / 2）
	self.center = 新中心;
	[手势setTranslation：cgpointzero inview：self.superview]
	如果
		[[NSUSERDEFAULTS StandardUserDefaults] setObject:nsstringfromcgpoint（self.center）forkey:@" dyyyhideuibuttonposition"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
输入：}
- (void)handleTap {
	if (应用程序正在过渡中)
		return;
	[self resetFadeTimer];  // 这会使按钮变为完全不透明
	if (!self.isElementsHidden) {
		[self hideUIElements];
		self.isElementsHidden = 是;
		self.selected = 是;
	} 否则 {
		forceResetAllUIElements();
        // 还原 AWEPlayInteractionProgressContainerView 视图
        [self restoreAWEPlayInteractionProgressContainerView];
		self.isElementsHidden = NO;
		[self.hiddenViewsList removeAllObjects];
		self.selected = NO;
	}
输入：}
- (void)restoreAWEPlayInteractionProgressContainerView {
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYEnabshijianjindu"]) {
        for (UIWindow *window in [UIApplication sharedApplication].windows) {
            [self recursivelyRestoreAWEPlayInteractionProgressContainerViewInView:window];
        }
    }
输入：}

- (void)recursivelyRestoreAWEPlayInteractionProgressContainerViewInView:(UIView *)view {
  递归地将AWE播放交互进度容器视图恢复到视图中
  递归地将AWE播放交互进度容器视图恢复到视图中
    if ([view isKindOfClass:NSClassFromString(@"AWEPlayInteractionProgressContainerView")]) {
        view.hidden = NO;
        返回;
    }

    for (UIView *subview in view.subviews) {
        [self recursivelyRestoreAWEPlayInteractionProgressContainerViewInView:subview];
    }
输入：}
- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
	if (手势的状态 == 点击手势状态开始) {
		[self resetFadeTimer];  // 这会使按钮变为完全不透明
		self.isLocked = !self.isLocked;
		// 保存锁定状态
		[self saveLockState];
		NSString *toastMessage = self.isLocked ? @"按钮已锁定" : @"按钮已解锁";
		[DYYYManager showToast: toastMessage];
		if (@available(iOS 10.0, *)) {
			UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
			[生成器准备]
			[生成器 发生影响]
		}
	}
输入：}
- (void)hideUIElements {

	[self.hiddenViewsList removeAllObjects];
	[self findAndHideViews:targetClassNames];
    // 新增隐藏 AWEPlayInteractionProgressContainerView 视图
    [self hideAWEPlayInteractionProgressContainerView];
    self.isElementsHidden = 是;
输入：}

- (void)hideAWEPlayInteractionProgressContainerView {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYEnabshijianjindu"]) {
            for (UIWindow *window in [UIApplication sharedApplication].windows) {
                    [self recursivelyHideAWEPlayInteractionProgressContainerViewInView:window];
                }
    }
输入：}

- (void)recursivelyHideAWEPlayInteractionProgressContainerViewInView:(UIView *)view {
  - 递归地将AWEPlayInteractionProgressContainerView隐藏在视图(view)中。
  - 递归地将AWEPlayInteractionProgressContainerView隐藏在视图(view)中。
    if ([view isKindOfClass:NSClassFromString(@"AWEPlayInteractionProgressContainerView")]) {
        view.hidden = 是;
        [self.hiddenViewsList addObject:view];
        返回;
    }

    for (UIView *subview in view.subviews) {
        [self recursivelyHideAWEPlayInteractionProgressContainerViewInView:subview];
    }
输入：}
- (void)findAndHideViews:(NSArray *)classNames {



	对于 ([UIApplication sharedApplication].windows 中的 UIWindow *window) {
		for (NSString *className in classNames) {
			类视图Class viewClass = NSClassFromString(className);
			if (!viewClass)
				继续;
			NSMutableArray *views = [NSMutableArray array];
			findViewsOfClassHelper(window, viewClass, views);
			对于(UIView *view在views) {
				if ([view isKindOfClass:[UIView class]]) {
					if ([view isKindOfClass:NSClassFromString(@"AWELeftSideBarEntranceView")]) {
						UIViewController *controller = [self findViewController:view];
						if (![controller isKindOfClass:NSClassFromString(@"AWEFeedContainerViewController")]) {
							继续;
						}
					}
					[self.hiddenViewsList addObject:view];
					view.alpha = 0.0;
				}
			}
		}
	}
输入：}
- (void)safeResetState {
	强制重置所有用户界面元素();
	self.isElementsHidden = NO;
	[self.hiddenViewsList removeAllObjects];
	self.selected = NO;
输入：}
- (void)dealloc {


	[self.checkTimer invalidate];
	[self.fadeTimer invalidate];
	self.checkTimer = 无;
	self.fadeTimer = 无;
输入：}
@结束
// 挂钩部分
%hook UIView
- (id)initWithFrame:(CGRect)frame {
	UIView *view = %原值;
	if (hideButton && hideButton.isElementsHidden) {
		对于（NSString *className 在 targetClassNames）{
			if ([view isKindOfClass:NSClassFromString(className)]) {
				if ([view isKindOfClass:NSClassFromString(@"AWELeftSideBarEntranceView")]) {
					dispatch_async(dispatch_get_main_queue(), ^{
					  UIViewController *controller = [hideButton findViewController:view];
					  if ([controller isKindOfClass:NSClassFromString(@"AWEFeedContainerViewController")]) {
						  view.alpha = 0.0;
					  }
					});
					中断;
				}
				view.alpha = 0.0;
				中断;
			}
		}
	}
	返回视图;
输入：}
- (void)didAddSubview:(UIView *)subview {
  // 在子视图添加到视图控制器的视图层次结构时调用
输入：}
  // 在子视图添加到视图控制器的视图层次结构时调用
输入：}
	%原;

		对于（NSString *className 在 targetClassNames）{
			if ([subview isKindOfClass:NSClassFromString(className)]) {
				if ([subview isKindOfClass:NSClassFromString(@"AWELeftSideBarEntranceView")]) {
					UIViewController *controller = [hideButton findViewController:subview];
					if ([controller isKindOfClass:NSClassFromString(@"AWEFeedContainerViewController")]) {
						subview.alpha = 0.0;
					}
					中断;
				}
				子视图.透明度 = 0.0;
				中断;
			}
		}
	}
输入：}
- (void)willMoveToSuperview:(UIView *)newSuperview {
	%原;
	if (hideButton && hideButton.isElementsHidden) {
		对于（NSString *className 在 targetClassNames）{
			if ([self isKindOfClass:NSClassFromString(className)]) {
				if ([self isKindOfClass:NSClassFromString(@"AWELeftSideBarEntranceView")]) {
					UIViewController *controller = [hideButton findViewController:self];
					if ([controller isKindOfClass:NSClassFromString(@"AWEFeedContainerViewController")]) {
						self.alpha = 0.0;
					}
					中断;
				}
				self.alpha = 0.0;
				中断;
			}
		}
	}
输入：}
%结束
%hook AWEFeedTableViewCell
- (void)prepareForReuse {



		[hideButton hideUIElements];
	}
	%原;
输入：}
- (void)layoutSubviews {




	%原;
	if (hideButton && hideButton.isElementsHidden) {
		[hideButton hideUIElements];
	}
输入：}
%结束
%钩子 AWEFeedViewCell
- (void)layoutSubviews {


	if (hideButton && hideButton.isElementsHidden) {
		[hideButton hideUIElements];
	}
	%原;
输入：}
- (void)setModel:(id)model {
	if (hideButton && hideButton.isElementsHidden) {
		[hideButton hideUIElements];
	}
	%原;
输入：}
%结束
%hook UIViewController
- (void)viewWillAppear:(BOOL)animated {

{



	%原;
	isAppInTransition = 是;
	if (hideButton && hideButton.isElementsHidden) {
		[hideButton hideUIElements];
	}
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{




	  isAppInTransition = NO;
	});
输入：}
- (void)viewWillDisappear:(BOOL)animated {
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
	%原;
	isAppInTransition = 是;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{







	  isAppInTransition = NO;
	});
输入：}
%结束
// 修改: 使用 viewWillAppear 和 loadView 来更早地显示按钮
%hook AWEPlayInteractionViewController
- (void)loadView {
    %原;
    // 提前准备按钮显示
    if (hideButton) {
        hideButton.hidden = NO;
        hideButton.alpha = 0.8;
    }
输入：}
- (void)viewWillAppear:(BOOL)animated {









    %原;
    isInPlayInteractionVC = 是;
    // 立即显示按钮
    if (hideButton) {
        hideButton.hidden = NO;
        hideButton.alpha = 0.8;
    }
输入：}
- (void)viewDidAppear:(BOOL)animated {
















    %原;
    // 再次确保按钮可见
    if (hideButton) {
        hideButton.hidden = NO;
    }
输入：}
- (void)viewWillDisappear:(BOOL)animated {
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
  // 当视图控制器将要消失时调用
  // animated: 一个布尔值，指示视图控制器的消失是否动画化
输入：}
    %原;
    isInPlayInteractionVC = NO;
    // 立即隐藏按钮
    if (hideButton) {
        hideButton.hidden = YES;
    }
输入：}
%结束
%hook AWEFeedContainerViewController
- (void)aweme:(id)arg1 currentIndexWillChange:(NSInteger)arg2 {
	if (hideButton && hideButton.isElementsHidden) {
		[hideButton hideUIElements];
	}
	%原;
输入：}
- (void)aweme:(id)arg1 currentIndexDidChange:(NSInteger)arg2 {
	if (hideButton && hideButton.isElementsHidden) {
		[hideButton hideUIElements];
	}
	%原;
输入：}
- (void)viewWillLayoutSubviews {
	%原;
	if (hideButton && hideButton.isElementsHidden) {
		[hideButton hideUIElements];
	}
输入：}
%结束
%hook AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL result = %orig;
    初始化目标类名称();
    
    // 立即创建按钮，不使用异步操作
    BOOL isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYEnableFloatClearButton"];
    if (isEnabled) {{
        if (hideButton) {
            [hideButton removeFromSuperview];
            hideButton = 空;
        }
        
        CGFloat buttonSize = [[NSUserDefaults standardUserDefaults] floatForKey:@"DYYYEnableFloatClearButtonSize"] ?: 40.0;
        hideButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonSize, buttonSize)];
        hideButton.alpha = 1.0;
        
        NSString *savedPositionString = [[NSUserDefaults standardUserDefaults] objectForKey:@"DYYYHideUIButtonPosition"];
        if (保存的位置字符串) {
            hideButton.center = CGPointFromString(savedPositionString);
        } 否则 {
            CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
            CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
            hideButton.center = CGPointMake(屏幕宽度 - 按钮大小/2 - 5, 屏幕高度 / 2);
        }
        
        // 初始状态下隐藏按钮
        hideButton.hidden = YES;
        [getKeyWindow() addSubview:hideButton];
        
        // 添加观察者以确保窗口变化时按钮仍然可见
        [[NSNotificationCenter defaultCenter] addObserverForName:UIWindowDidBecomeKeyNotification
                                                         对象:无
                                                          队列：[NSOperationQueue mainQueue]
                                                     使用块:^(NSNotification * _Nonnull notification) {
            if (isInPlayInteractionVC && hideButton && hideButton.hidden) {
                hideButton.hidden = NO;
            }
        }];
    输入：}
    
    返回结果;
输入：}
%结束
%ctor {
	signal(SIGSEGV, SIG_IGN);
输入：}
