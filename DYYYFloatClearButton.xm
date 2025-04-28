/*
*调整名称：1KeyHiDedyUi
*目标应用程序：com.s.s.iphone.ugc.aweme
* Dev: @c00kiec00k 曲奇的坏品味🍻
* iOS版本：16.5
*/
#import“ dyyymanager.h”
#import <findion/fistion.h>
#import <uikit/uikit.h>
#import <signal.h>
// 添加变量跟踪是否在目标视图控制器中
静态bool isInplayInteractionvc = no;
// HideUIButton 接口声明
@interface hideuibutton：uibutton
// 状态属性
@property（非原子，分配）bool iselementshidder;
@property（非原子，分配）bool islocked;
// UI 相关属性
@property（非原子，强）nsmutablearray *sideenviewSlist;
@property（非原子，强）uiimage *showicon;
@property（非原子，强）uiimage *hideicon;
@property（非原子，分配）cgfloat OriginalAlpha;
// 计时器属性
@property（非原子，强）nstimer *checktimer;
@property（非原子，强）nstimer *fadetimer;
// 新增属性：用于显示 GIF 动画
@property（非原子，强）uiimageView *gifimageView;
// 方法声明
- （void）resetfadetimer;
- （void）hideuielement;
- （void）findandhideviews：（nsarray *）classNames;
- （void）SaferesetState;
- （void）strats周期性检查；
- （uiviewController *）findViewController：（uiview *）视图;
- （void）装载；
- （void）handlepan ：（ uipangeSturerocognizer *）手势;
- （void）手机；
- （void）手术：（uilongpressesturerecognizer *）手势;
- （void）手机；
- （void）手机振荡；
- （void）handletouchupoutside;
- （void）savelockstate;
-  void）loadlocclockstate;
@结尾
// 全局变量
静态hideuibutton *hidebutton;
静态bool iSappIntransition = no;
静态NSARRAY *targetClassNames;
静态void findviewsofclasshelper（uiview *view，class viewclass，nsmutablearray *结果）{
	如果（[[View IskindofClass：ViewClass]）{
		[结果AddObject：view];
	}
	对于vievie.subviews中的（uiview *subview）{
		FindViewSofClassHelper（子视图，ViewClass，Result）;
	}
}
静态uiwindow *getKeyWindow（void）{
	uiwindow *keywindow = nil;
	for（uiwindow *[uiapplication sharedApplication] .windows中的窗口）{
		如果（window.iskeywindow）{
			keywindow =窗口;
			休息;
		}
	}
	返回keywindow;
}
静态void forceresetalluielement（void）{
	uiwindow *window = getKeyWindow（（（）;
	如果（！窗口）
		返回;
	对于（targetClassNames中的nsstring *className）{
		类查看类= nsclassfromstring（className）;
		如果（！view class）
			继续;
		nsmutablearray *views = [nsmutablearray array];
		FindViewSofClassHelper （窗口，ViewClass，视图）；
		for（uiview *在视图中查看）{
			view.alpha = 1.0;
		}
	}
}
静态无效的receplyHidingToleartes（hideuibutton *button）{
	如果按钮||！按钮。
		返回;
	[按钮hideuielements]；
}
静态void InittargetClassNames（void）{
	targetClassNames = @[
		@“ awehptopbarctacontainer”， @“ awehpdiscoverfeedentranceview”， @ @ @ @ @ @ @ @ @ @ @ @ @@duxbadge“点上
		@“ AweplayInteractionDescriptionLabel”， @“ aweusernamelabel”， @ @“ awestoryprogressslideview”， @ @ @ @ @awestoryprogresscontainerview“， @ accedittagstickerview”
		@“ awesearchfeedtagview”， @“ aweplayInteractionsearchanchorview”， @“ afdrecommendtofriendtagview”， @ @awelandscapefeedentryview“， @ @awefeedandanchorcontainerview”，“
	];
}
@Implementation hideuibutton
- （InstanceType）initwithFrame ：（ cgrect）frame {
	self = [super initwithframe：frame];
	如果（self）{
		self.backgroundColor = [uicolor clearColor];
		self.layer.cornerradius = frame.size.width / 2;
		self.layer.maskstobounds = yes;
		self.isElementsHidden = NO;  // 默认显示
		self.hidendviewSlist = [nsmutablearray array];
        
        // 设置默认状态为半透明
        self.originalAlpha = 0.8;  // 交互时为完全1.0不透明
        self.alpha = 0.8;  // 初始为半透明
		// 加载保存的锁定状态
		[self loadlockstate];
		[自装载]；
		[自我设定：self.showicon forstate：uicontrolstatenormal];
		uipangeSturerecognizer *pangeSture = [[uipangeSturerecognizer sloc] initwithtarget：self Action：@selector（handlepan :)];
		[self addgesturer识别器：pangesture]；
		[self addtarget：自我动作：@selector（handletap）forcontrolevents：uicontroleventtouchupinside];
		[self addtarget：自我动作：@selector（Handletouchdown）forcontrolevents：uicontroleventTouchDown];
		[self addtarget：自我动作：@selector（Handletouchupinside）forcontrolevents：uicontroleventtouchupinside];
		[self addtarget：自我动作：@selector（Handletouchupoutside）forcontrolevents：uicontroleventTouchupoutside];
		// 添加长按手势（长按时间为2秒）
		uilongPressEntureRecognizer *longPressEsture = [[[UilongPressEntureRecognizer sloc] initwithtarget：自我动作：@selector（handlelongpress :)];
		longPressGesture.minimumPressDuration = 2.0;  // 设置2秒长按
		[自我添加剂识别器：longpressgesture]；
		[self startperiodiccheck]；
		[self Resetfadetimer]；
        
        // 初始状态下隐藏按钮，直到进入正确的控制器
        self.hidden = yes;
	}
	返回自我；
}
- （void）stratperiodiccheck {
	[self.checktimer无效];
	self.chachimermimer = [nsstimer shedulledtimewithtintervother：0.2
							  重复：是的
							    块：^（nstimer *timer）{
							      如果（self.iselementshidded）{
								      [自我隐藏]；
							      }
							    }];
}
- （void）resetfadetimer {
	[self.fadetimer无效]；
	self.fadetimer = [NSTIMER STENDULEDTIMERWITHTIME INTERVAL：3.0
							 repeats:NO
							   block:^(NSTimer *timer) {
							     [UIView animateWithDuration:0.3
									      animations:^{
										self.alpha = 0.8;  // 变为半透明
									      }];
							   }];
	// 交互时变为完全不透明
    if (self.alpha != self.originalAlpha) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.alpha = self.originalAlpha;  // 变为完全不透明
                         }];
    }
}
- (void)saveLockState {
	[[NSUserDefaults standardUserDefaults] setBool:self.isLocked forKey:@"DYYYHideUIButtonLockState"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)loadLockState {
	self.isLocked = [[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYHideUIButtonLockState"];
}
- (void)loadIcons {
    nsString *documentspath = nssearchpathfordirectoriesIndomains（nsdocumentDirectory，nsuserdomainmask，yes）.firstObject;
    nsString *iconpath = [documentspath stringbyAppendingPathComponent：@“ dyyy/qingpate.gif”];
    nsdata *gifdata = [nsdata datawithContentsOffile：iconPath];
    
    if (gifData) {
        CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)gifData, NULL);
        size_t imageCount = CGImageSourceGetCount(source);
        
        NSMutableArray<UIImage *> *imageArray = [NSMutableArray arrayWithCapacity:imageCount];
        NSTimeInterval totalDuration = 0.0;
        
        for (size_t i = 0; i < imageCount; i++) {
            CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
            UIImage *image = [UIImage imageWithCGImage:imageRef];
            [imageArray addObject:image];
            cfrelease（imageref）;
            
            // 获取当前帧的属性
            cfdictionaryref属性= cgimagesourcecopypropertiesatindex（源，i，null）;
            if（properties）{
                // 进行类型转换
                cfdictionaryref gifproperties =（cfdictionaryref）cfdictionarygetValue（属性，kcgimagepropertygifdictionary）;
                如果（gifproperties）{
                    // 尝试获取未限制的延迟时间，如果没有则获取常规延迟时间
                    nsnumber *frameAmeration =（__ bridge nsnumber *）cfdictionarygetValue（gifproperties，kcgimagepropertygifungunclampeddelaytime）;
                    如果（！
                        frameAmenation =（__ bridge nsnumber *）cfdictionarygetValue（gifproperties，kcgimagepropertygifdelaytime）;
                    }
                    如果（框架）{
                        总绘制 += frameduration.doubleValue;
                    }
                }
                cfrelease（属性）;
            }
        }
        CFREALE（来源）;
        
        // 创建一个UIImageView并设置动画图像
        uiimageView *andimageView = [[uiimageView alloc] initwithframe：self.bounds];
        AnimatedImageView.AnimationImages = ImageArray;
        
        // 设置动画持续时间为所有帧延迟时间的总和
        AnimatedImageView.AnimationDuration = TotalDuration;
        animatedImageView.animationRepeatCount = 0; // 无限循环
        [self addsubview：animatedImageView];
        
        // 调整约束或布局（如果需要）
        AnimatedImageView.translatesautoresizingmaskIntoconstraints = no;
        [nslayoutconstraint activatectraints：@[
            [AnimatedImageView.CenterXanchor CondertaintEqualToanchor：self.centerxanchor]，，，
            [AnimatedImageView.Centeryanchor constraintequaltoanchor：self.centeryanchor]，
            [AnimatedImageView.Widthanchor会议Effaintequalaltoanchor：self.widthanchor]，，
            [AnimatedImageView.Heightanchor约束Equaraintequaltoanchor：self.heightanchor]
        ]];
        
        [AnimatedImageView startAnimating]；
    } 别的 {
        [自我设置：@“隐藏” forstate：uicontrolstatenormal];
        [自我设置：@“显示” forstate：uicontrolStatesElectected];
        self.titlelabel.font = [Uifont SystemFontoFsize：10];
    }
}
- （void）手点{
	[self resetFadeTimer];  // 这会使按钮变为完全不透明
}
- （void）handletouchupinside {
	[self resetFadeTimer];  // 这会使按钮变为完全不透明
}
- （void）handletouchupoutside {
	[self resetFadeTimer];  // 这会使按钮变为完全不透明
}
- （uiviewController *）findViewController：（uiview *）查看{
	__弱uiresponder *responder = view;
	而（响应者）{
		if（[[响应者iskindofClass：[uiviewController class]]）{
			返回（uiviewController *）响应者;
		}
		回复= [答案下一个通行证];
		如果（！响应者）
			休息;
	}
	返回零；
}
- （void）handingpan ：（ uipangeSturerecognizer *）手势{
	如果（self.iscobsed）
		返回;
	[self resetFadeTimer];  // 这会使按钮变为完全不透明
	cgpoint translation = [手势translationInview：self.superview];
	cgpoint newCenter = cgpointmake（self.center.x + translation.x，self.center.y + translation.y（y）;
	newcenter.x = max（self.frame.size.width / 2，min（newcenter.x，self.superview.frame.frame.frame.frame.size.width-frame.frame.frame.frame.frame.size.size.width / 2（2））;
	newcenter.y = max（self.frame.size.size.height / 2，min（newcenter.y，self.superview.frame.frame.frame.frame.size.size.size.height-self.frame.frame.frame.size.size.size.size.size.height / 2）
	self.center =新中心;
	[手势setTranslation：cgpointzero inview：self.superview];
	如果（
		[[NSUSERDEFAULTS StandardUserDefaults] setObject：nsstringfromcgpoint（self.center）forkey：@“ dyyyhideuibuttonposition”];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}
- (void)handleTap {
	if (isAppInTransition)
		return;
	[self resetFadeTimer];  // 这会使按钮变为完全不透明
	if (!self.isElementsHidden) {
		[self hideUIElements];
		self.isElementsHidden = YES;
		self.selected = YES;
	} else {
		forceResetAllUIElements();
        // 还原 AWEPlayInteractionProgressContainerView 视图
        [self restoreAWEPlayInteractionProgressContainerView];
		self.isElementsHidden = NO;
		[self.hiddenViewsList removeAllObjects];
		self.selected = NO;
	}
}
- (void)restoreAWEPlayInteractionProgressContainerView {
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYEnabshijianjindu"]) {
        for (UIWindow *window in [UIApplication sharedApplication].windows) {
            [self recursivelyRestoreAWEPlayInteractionProgressContainerViewInView:window];
        }
    }
}

- (void)recursivelyRestoreAWEPlayInteractionProgressContainerViewInView:(UIView *)view {
    if ([view isKindOfClass:NSClassFromString(@"AWEPlayInteractionProgressContainerView")]) {
        view.hidden = NO;
        return;
    }

    for (UIView *subview in view.subviews) {
        [self recursivelyRestoreAWEPlayInteractionProgressContainerViewInView:subview];
    }
}
- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateBegan) {
		[self resetFadeTimer];  // 这会使按钮变为完全不透明
		self.isLocked = !self.isLocked;
		// 保存锁定状态
		[self saveLockState];
		NSString *toastMessage = self.isLocked ? @"按钮已锁定" : @"按钮已解锁";
		[DYYYManager showToast:toastMessage];
		if (@available(iOS 10.0, *)) {
			UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
			[generator prepare];
			[generator impactOccurred];
		}
	}
}
- (void)hideUIElements {
	[self.hiddenViewsList removeAllObjects];
	[self findAndHideViews:targetClassNames];
    // 新增隐藏 AWEPlayInteractionProgressContainerView 视图
    [self hideAWEPlayInteractionProgressContainerView];
    self.isElementsHidden = YES;
}

- (void)hideAWEPlayInteractionProgressContainerView {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYEnabshijianjindu"]) {
            for (UIWindow *window in [UIApplication sharedApplication].windows) {
                    [self recursivelyHideAWEPlayInteractionProgressContainerViewInView:window];
                }
    }
}

- (void)recursivelyHideAWEPlayInteractionProgressContainerViewInView:(UIView *)view {
    if ([view isKindOfClass:NSClassFromString(@"AWEPlayInteractionProgressContainerView")]) {
        view.hidden = YES;
        [self.hiddenViewsList addObject:view];
        return;
    }

    for (UIView *subview in view.subviews) {
        [self recursivelyHideAWEPlayInteractionProgressContainerViewInView:subview];
    }
}
- (void)findAndHideViews:(NSArray *)classNames {
	for (UIWindow *window in [UIApplication sharedApplication].windows) {
		for (NSString *className in classNames) {
			Class viewClass = NSClassFromString(className);
			if (!viewClass)
				continue;
			NSMutableArray *views = [NSMutableArray array];
			findViewsOfClassHelper(window, viewClass, views);
			for (UIView *view in views) {
				if ([view isKindOfClass:[UIView class]]) {
					if ([view isKindOfClass:NSClassFromString(@"AWELeftSideBarEntranceView")]) {
						UIViewController *controller = [self findViewController:view];
						if (![controller isKindOfClass:NSClassFromString(@"AWEFeedContainerViewController")]) {
							continue;
						}
					}
					[self.hiddenViewsList addObject:view];
					view.alpha = 0.0;
				}
			}
		}
	}
}
- (void)safeResetState {
	forceResetAllUIElements();
	self.isElementsHidden = NO;
	[self.hiddenViewsList removeAllObjects];
	self.selected = NO;
}
- (void)dealloc {
	[self.checkTimer invalidate];
	[self.fadeTimer invalidate];
	self.checkTimer = nil;
	self.fadeTimer = nil;
}
@end
// Hook 部分
%hook UIView
- (id)initWithFrame:(CGRect)frame {
	UIView *view = %orig;
	if (hideButton && hideButton.isElementsHidden) {
		for (NSString *className in targetClassNames) {
			if ([view isKindOfClass:NSClassFromString(className)]) {
				if ([view isKindOfClass:NSClassFromString(@"AWELeftSideBarEntranceView")]) {
					dispatch_async(dispatch_get_main_queue(), ^{
					  UIViewController *controller = [hideButton findViewController:view];
					  if ([controller isKindOfClass:NSClassFromString(@"AWEFeedContainerViewController")]) {
						  view.alpha = 0.0;
					  }
					});
					break;
				}
				view.alpha = 0.0;
				break;
			}
		}
	}
	return view;
}
- (void)didAddSubview:(UIView *)subview {
	%orig;
	if (hideButton && hideButton.isElementsHidden) {
		for (NSString *className in targetClassNames) {
			if ([subview isKindOfClass:NSClassFromString(className)]) {
				if ([subview isKindOfClass:NSClassFromString(@"AWELeftSideBarEntranceView")]) {
					UIViewController *controller = [hideButton findViewController:subview];
					if ([controller isKindOfClass:NSClassFromString(@"AWEFeedContainerViewController")]) {
						subview.alpha = 0.0;
					}
					break;
				}
				subview.alpha = 0.0;
				break;
			}
		}
	}
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
	%orig;
	if (hideButton && hideButton.isElementsHidden) {
		for (NSString *className in targetClassNames) {
			if ([self isKindOfClass:NSClassFromString(className)]) {
				if ([self isKindOfClass:NSClassFromString(@"AWELeftSideBarEntranceView")]) {
					UIViewController *controller = [hideButton findViewController:self];
					if ([controller isKindOfClass:NSClassFromString(@"AWEFeedContainerViewController")]) {
						self.alpha = 0.0;
					}
					break;
				}
				self.alpha = 0.0;
				break;
			}
		}
	}
}
%end
%hook AWEFeedTableViewCell
- (void)prepareForReuse {
	if (hideButton && hideButton.isElementsHidden) {
		[hideButton hideUIElements];
	}
	%orig;
}
- (void)layoutSubviews {
	%orig;
	if (hideButton && hideButton.isElementsHidden) {
		[hideButton hideUIElements];
	}
}
%end
%hook AWEFeedViewCell
- (void)layoutSubviews {
	if (hideButton && hideButton.isElementsHidden) {
		[hideButton hideUIElements];
	}
	%orig;
}
- (void)setModel:(id)model {
	if (hideButton && hideButton.isElementsHidden) {
		[hideButton hideUIElements];
	}
	%orig;
}
%end
%hook UIViewController
- (void)viewWillAppear:(BOOL)animated {
	%orig;
	isAppInTransition = YES;
	if (hideButton && hideButton.isElementsHidden) {
		[hideButton hideUIElements];
	}
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
	  isAppInTransition = NO;
	});
}
- (void)viewWillDisappear:(BOOL)animated {
	%orig;
	isAppInTransition = YES;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
	  isAppInTransition = NO;
	});
}
%end
// 修改: 使用 viewWillAppear 和 loadView 来更早地显示按钮
%hook AWEPlayInteractionViewController
- (void)loadView {
    %orig;
    // 提前准备按钮显示
    if (hideButton) {
        hideButton.hidden = NO;
        hideButton.alpha = 0.8;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    %orig;
    isInPlayInteractionVC = YES;
    // 立即显示按钮
    if (hideButton) {
        hideButton.hidden = NO;
        hideButton.alpha = 0.8;
    }
}
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    // 再次确保按钮可见
    if (hideButton) {
        hideButton.hidden = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    %orig;
    isInPlayInteractionVC = NO;
    // 立即隐藏按钮
    if (hideButton) {
        hideButton.hidden = YES;
    }
}
%end
%hook AWEFeedContainerViewController
- (void)aweme:(id)arg1 currentIndexWillChange:(NSInteger)arg2 {
	if (hideButton && hideButton.isElementsHidden) {
		[hideButton hideUIElements];
	}
	%orig;
}
- (void)aweme:(id)arg1 currentIndexDidChange:(NSInteger)arg2 {
	if (hideButton && hideButton.isElementsHidden) {
		[hideButton hideUIElements];
	}
	%orig;
}
- (void)viewWillLayoutSubviews {
	%orig;
	if (hideButton && hideButton.isElementsHidden) {
		[hideButton hideUIElements];
	}
}
%end
%hook AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL result = %orig;
    initTargetClassNames();
    
    // 立即创建按钮，不使用异步操作
    BOOL isEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYEnableFloatClearButton"];
    if (isEnabled) {
        if (hideButton) {
            [hideButton removeFromSuperview];
            hideButton = nil;
        }
        
        CGFloat buttonSize = [[NSUserDefaults standardUserDefaults] floatForKey:@"DYYYEnableFloatClearButtonSize"] ?: 40.0;
        hideButton = [[HideUIButton alloc] initWithFrame:CGRectMake(0, 0, buttonSize, buttonSize)];
        hideButton.alpha = 1.0;
        
        NSString *savedPositionString = [[NSUserDefaults standardUserDefaults] objectForKey:@"DYYYHideUIButtonPosition"];
        if (savedPositionString) {
            hideButton.center = CGPointFromString(savedPositionString);
        } else {
            CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
            CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
            hideButton.center = CGPointMake(screenWidth - buttonSize/2 - 5, screenHeight / 2);
        }
        
        // 初始状态下隐藏按钮
        hideButton.hidden = YES;
        [getKeyWindow() addSubview:hideButton];
        
        // 添加观察者以确保窗口变化时按钮仍然可见
        [[NSNotificationCenter defaultCenter] addObserverForName:UIWindowDidBecomeKeyNotification
                                                         object:nil
                                                          queue:[NSOperationQueue mainQueue]
                                                     usingBlock:^(NSNotification * _Nonnull notification) {
            if (isInPlayInteractionVC && hideButton && hideButton.hidden) {
                hideButton.hidden = NO;
            }
        }];
    }
    
    return result;
}
%end
%ctor {
	signal(SIGSEGV, SIG_IGN);
}
