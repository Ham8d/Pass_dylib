// ╔══════════════════════════════════════════════╗
// ║   التراث ستور — TurathGate  (Landscape)      ║
// ║   عدّل السطور أدناه فقط                      ║
// ╚══════════════════════════════════════════════╝

// ── رمز الدخول (غيّره من هنا) ─────────────────
#define PASSCODE  @"123000"

// ── رابط تيليغرام ──────────────────────────────
#define TELEGRAM  @"https://t.me/turath_st"

// ── رابط زر "ادخل هنا للحصول على رمز الدخول" ──
// ▼▼▼ ضع رابطك هنا بين علامتي الاقتباس ▼▼▼
#define CODE_LINK @"https://t.me/Alturathvbot?start=btn_bmr8jiq4ephh"
// ▲▲▲ غيّر الرابط في أي وقت من هنا فقط ▲▲▲

// ── اسم المتجر في الشاشة ──────────────────────
#define STORE_TITLE @"التراث ستور"

// ── مفتاح الحفظ (لا تغيّره) ──────────────────
#define UNLOCK_KEY @"TG_unlocked_v1"

// ══════════════════════════════════════════════
//  لا تعدّل ما بعد هذا السطر
// ══════════════════════════════════════════════

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static UIWindow *_gw;

@interface TGVc : UIViewController
@property (strong) UITextField *f;
@end

@implementation TGVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id ctx) {
        for (UIView *v in self.view.subviews) [v removeFromSuperview];
        for (CALayer *l in self.view.layer.sublayers) [l removeFromSuperlayer];
        self.view.bounds = CGRectMake(0, 0, size.width, size.height);
        [self buildUI];
    } completion:nil];
}

- (void)buildUI {
    CGFloat W = self.view.bounds.size.width;
    CGFloat H = self.view.bounds.size.height;
    BOOL isLandscape = W > H;

    // خلفية متدرجة
    CAGradientLayer *g = [CAGradientLayer layer];
    g.frame = CGRectMake(0, 0, W, H);
    g.colors = @[
        (id)[UIColor colorWithRed:.02 green:.05 blue:.18 alpha:1].CGColor,
        (id)[UIColor colorWithRed:.04 green:.10 blue:.25 alpha:1].CGColor,
        (id)[UIColor colorWithRed:.01 green:.03 blue:.12 alpha:1].CGColor
    ];
    g.locations = @[@0, @.5, @1];
    [self.view.layer insertSublayer:g atIndex:0];

    // نجوم خلفية
    for (int i = 0; i < 70; i++) {
        CGFloat s = (arc4random_uniform(3) + 1) * .6;
        UIView *v = [[UIView alloc] initWithFrame:
            CGRectMake(arc4random_uniform(W), arc4random_uniform(H), s, s)];
        v.layer.cornerRadius = s / 2;
        v.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.35];
        [self.view addSubview:v];
    }

    if (isLandscape) {
        [self buildLandscape:W height:H];
    } else {
        [self buildPortrait:W height:H];
    }
}

// ══════════════════════════════════════════════
//  تخطيط أفقي Landscape
// ══════════════════════════════════════════════
- (void)buildLandscape:(CGFloat)W height:(CGFloat)H {
    CGFloat leftW  = W * 0.44;
    CGFloat rightX = leftW;
    CGFloat rightW = W - leftW;
    CGFloat pad    = 20;

    // لوغو يسار
    CGFloat logoSize = MIN(H * .58, leftW * .6);
    CGFloat logoX = (leftW - logoSize) / 2;
    CGFloat logoY = (H - logoSize) / 2;

    UIView *glow = [[UIView alloc] initWithFrame:
        CGRectMake(logoX - 20, logoY - 20, logoSize + 40, logoSize + 40)];
    glow.layer.cornerRadius = (logoSize + 40) / 2;
    glow.layer.shadowColor  = [UIColor colorWithRed:.2 green:.5 blue:1 alpha:1].CGColor;
    glow.layer.shadowRadius = 35; glow.layer.shadowOpacity = .6;
    glow.layer.shadowOffset = CGSizeZero;
    [self.view addSubview:glow];

    UIView *logo = [[UIView alloc] initWithFrame:CGRectMake(logoX, logoY, logoSize, logoSize)];
    logo.layer.cornerRadius = logoSize / 2;
    logo.layer.borderWidth  = 2.5;
    logo.layer.borderColor  = [UIColor colorWithRed:.3 green:.6 blue:1 alpha:.9].CGColor;
    logo.backgroundColor    = [UIColor colorWithRed:.05 green:.10 blue:.30 alpha:.95];
    logo.layer.shadowColor  = [UIColor colorWithRed:.2 green:.5 blue:1 alpha:1].CGColor;
    logo.layer.shadowRadius = 20; logo.layer.shadowOpacity = .8;
    logo.layer.shadowOffset = CGSizeZero;
    [self.view addSubview:logo];

    UILabel *star = [UILabel new];
    star.text = @"★"; star.font = [UIFont systemFontOfSize:logoSize * .55];
    star.textColor = [UIColor colorWithRed:.4 green:.75 blue:1 alpha:1];
    star.textAlignment = NSTextAlignmentCenter;
    star.frame = CGRectMake(0, 0, logoSize, logoSize);
    star.layer.shadowColor  = [UIColor colorWithRed:.3 green:.6 blue:1 alpha:1].CGColor;
    star.layer.shadowRadius = 10; star.layer.shadowOpacity = .9;
    star.layer.shadowOffset = CGSizeZero;
    [logo addSubview:star];

    // فاصل عمودي
    UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(leftW - .5, H*.1, 1, H*.8)];
    sep.backgroundColor = [[UIColor colorWithRed:.3 green:.55 blue:1 alpha:.3] colorWithAlphaComponent:.3];
    [self.view addSubview:sep];

    // كونترولات يمين
    CGFloat cx  = rightX + rightW / 2;
    CGFloat fw  = rightW - pad * 2;
    CGFloat rx  = rightX + pad;
    CGFloat ry  = H * .07;
    CGFloat btnH = H * .13;

    UILabel *title = [UILabel new];
    title.text = STORE_TITLE;
    title.font = [UIFont boldSystemFontOfSize:H * .075];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [title sizeToFit];
    title.center = CGPointMake(cx, ry + title.bounds.size.height / 2);
    title.layer.shadowColor = [UIColor colorWithRed:.3 green:.6 blue:1 alpha:1].CGColor;
    title.layer.shadowRadius = 6; title.layer.shadowOpacity = .5;
    title.layer.shadowOffset = CGSizeZero;
    [self.view addSubview:title];
    ry += title.bounds.size.height + 4;

    UILabel *sub = [UILabel new];
    sub.text = @"— TURATH STORE —";
    sub.font = [UIFont systemFontOfSize:H * .032];
    sub.textColor = [UIColor colorWithRed:.4 green:.7 blue:1 alpha:.8];
    sub.textAlignment = NSTextAlignmentCenter;
    [sub sizeToFit];
    sub.center = CGPointMake(cx, ry + sub.bounds.size.height / 2);
    [self.view addSubview:sub];
    ry += sub.bounds.size.height + H * .035;

    // حقل الرمز
    UIView *box = [[UIView alloc] initWithFrame:CGRectMake(rx, ry, fw, btnH)];
    box.backgroundColor = [UIColor colorWithRed:.06 green:.12 blue:.30 alpha:.85];
    box.layer.cornerRadius = 12; box.layer.borderWidth = 1.2;
    box.layer.borderColor = [UIColor colorWithRed:.3 green:.55 blue:1 alpha:.5].CGColor;
    [self.view addSubview:box];

    UILabel *lk = [UILabel new];
    lk.text = @"🔒"; lk.font = [UIFont systemFontOfSize:btnH * .4];
    lk.frame = CGRectMake(12, 0, btnH, btnH);
    lk.textAlignment = NSTextAlignmentCenter;
    [box addSubview:lk];

    self.f = [[UITextField alloc] initWithFrame:
        CGRectMake(btnH + 4, 0, fw - btnH - 16, btnH)];
    self.f.textColor = [UIColor whiteColor];
    self.f.tintColor = [UIColor colorWithRed:.4 green:.7 blue:1 alpha:1];
    self.f.textAlignment = NSTextAlignmentRight;
    self.f.secureTextEntry = YES;
    self.f.keyboardType = UIKeyboardTypeNumberPad;
    self.f.font = [UIFont systemFontOfSize:btnH * .38];
    self.f.attributedPlaceholder = [[NSAttributedString alloc]
        initWithString:@"الرمـز"
        attributes:@{NSForegroundColorAttributeName:
            [UIColor colorWithWhite:1 alpha:.3]}];
    [box addSubview:self.f];
    ry += btnH + H * .025;

    // زر تأكيد
    UIButton *ok = [UIButton buttonWithType:UIButtonTypeCustom];
    ok.frame = CGRectMake(rx, ry, fw, btnH);
    ok.layer.cornerRadius = 12;
    ok.backgroundColor = [UIColor colorWithRed:.1 green:.32 blue:.9 alpha:1];
    ok.layer.shadowColor = [UIColor colorWithRed:.1 green:.3 blue:1 alpha:1].CGColor;
    ok.layer.shadowRadius = 12; ok.layer.shadowOpacity = .6;
    ok.layer.shadowOffset = CGSizeZero;
    [ok setTitle:@"✓  تأكيد الدخول" forState:0];
    ok.titleLabel.font = [UIFont boldSystemFontOfSize:btnH * .36];
    [ok addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ok];
    ry += btnH + H * .02;

    UILabel *hint = [UILabel new];
    hint.text = @"للحصول على الرمز الرجاء الدخول الى :";
    hint.font = [UIFont systemFontOfSize:H * .03];
    hint.textColor = [UIColor colorWithWhite:1 alpha:.45];
    hint.textAlignment = NSTextAlignmentCenter;
    [hint sizeToFit];
    hint.center = CGPointMake(cx, ry + hint.bounds.size.height / 2);
    [self.view addSubview:hint];
    ry += hint.bounds.size.height + H * .015;

    [self outBtn:CGRectMake(rx, ry, fw, btnH)
           title:@"  ✈  اولا - الانضمام في القناة"
             sel:@selector(tg) fontSize:btnH * .33];
    ry += btnH + H * .02;

    [self outBtn:CGRectMake(rx, ry, fw, btnH)
           title:@"  🔗  ثانيا - ادخل هنا للحصول على رمز الدخول"
             sel:@selector(lnk) fontSize:btnH * .3];
}

// ══════════════════════════════════════════════
//  تخطيط عمودي Portrait
// ══════════════════════════════════════════════
- (void)buildPortrait:(CGFloat)W height:(CGFloat)H {
    CGFloat cx = W / 2, fw = W - 48, rx = 24;

    [self lb:STORE_TITLE font:[UIFont boldSystemFontOfSize:26]
      color:[UIColor whiteColor] y:80 cx:cx];
    [self lb:@"— TURATH STORE —" font:[UIFont systemFontOfSize:11]
      color:[UIColor colorWithRed:.4 green:.7 blue:1 alpha:.8] y:106 cx:cx];

    UIView *lo = [[UIView alloc] initWithFrame:CGRectMake(cx-65, 125, 130, 130)];
    lo.layer.cornerRadius = 65; lo.layer.borderWidth = 2.5;
    lo.layer.borderColor = [UIColor colorWithRed:.25 green:.5 blue:1 alpha:.8].CGColor;
    lo.backgroundColor = [UIColor colorWithRed:.06 green:.12 blue:.35 alpha:.9];
    lo.layer.shadowColor = [UIColor colorWithRed:.2 green:.5 blue:1 alpha:1].CGColor;
    lo.layer.shadowRadius = 18; lo.layer.shadowOpacity = .8;
    lo.layer.shadowOffset = CGSizeZero;
    [self.view addSubview:lo];
    [self lb:@"★" font:[UIFont systemFontOfSize:62]
      color:[UIColor colorWithRed:.4 green:.7 blue:1 alpha:1] y:65 cx:65 in:lo];

    CGFloat y = 300;

    UIView *box = [[UIView alloc] initWithFrame:CGRectMake(rx, y, fw, 50)];
    box.backgroundColor = [UIColor colorWithRed:.07 green:.13 blue:.32 alpha:.85];
    box.layer.cornerRadius = 12; box.layer.borderWidth = 1.2;
    box.layer.borderColor = [UIColor colorWithRed:.3 green:.55 blue:1 alpha:.5].CGColor;
    [self.view addSubview:box];
    [self lb:@"🔒" font:[UIFont systemFontOfSize:18] color:nil y:14 cx:14 in:box];
    self.f = [[UITextField alloc] initWithFrame:CGRectMake(44, 4, fw-54, 42)];
    self.f.textColor = [UIColor whiteColor];
    self.f.tintColor = [UIColor colorWithRed:.4 green:.7 blue:1 alpha:1];
    self.f.textAlignment = NSTextAlignmentRight;
    self.f.secureTextEntry = YES;
    self.f.keyboardType = UIKeyboardTypeNumberPad;
    self.f.font = [UIFont systemFontOfSize:17];
    self.f.attributedPlaceholder = [[NSAttributedString alloc]
        initWithString:@"الرمـز"
        attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:.3]}];
    [box addSubview:self.f]; y += 58;

    UIButton *ok = [UIButton buttonWithType:UIButtonTypeCustom];
    ok.frame = CGRectMake(rx, y, fw, 50); ok.layer.cornerRadius = 12;
    ok.backgroundColor = [UIColor colorWithRed:.1 green:.34 blue:.9 alpha:1];
    ok.layer.shadowColor = [UIColor colorWithRed:.1 green:.3 blue:1 alpha:1].CGColor;
    ok.layer.shadowRadius = 10; ok.layer.shadowOpacity = .6; ok.layer.shadowOffset = CGSizeZero;
    [ok setTitle:@"✓  تأكيد الدخول" forState:0];
    ok.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [ok addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ok]; y += 65;

    [self lb:@"للحصول على الرمز الرجاء الذهاب الى :" font:[UIFont systemFontOfSize:11]
      color:[UIColor colorWithWhite:1 alpha:.45] y:y cx:cx]; y += 26;

    [self outBtn:CGRectMake(rx,y,fw,50) title:@"   ✈  اولا - الانضمام في القناة"
             sel:@selector(tg) fontSize:13]; y += 58;
    [self outBtn:CGRectMake(rx,y,fw,50)
           title:@"   🔗  ثانيا - ادخل هنا للحصول على رمز الدخول"
             sel:@selector(lnk) fontSize:13];
}

// ── مساعدات ──────────────────────────────────────────────────────────────
- (void)lb:(NSString*)t font:(UIFont*)f color:(UIColor*)c y:(CGFloat)y cx:(CGFloat)cx {
    UILabel *l = [UILabel new]; l.text = t; l.font = f;
    l.textColor = c ?: [UIColor clearColor]; l.textAlignment = NSTextAlignmentCenter;
    [l sizeToFit]; l.center = CGPointMake(cx, y); [self.view addSubview:l];
}
- (void)lb:(NSString*)t font:(UIFont*)f color:(UIColor*)c y:(CGFloat)y cx:(CGFloat)cx in:(UIView*)p {
    UILabel *l = [UILabel new]; l.text = t; l.font = f;
    l.textColor = c ?: [UIColor clearColor]; l.textAlignment = NSTextAlignmentCenter;
    [l sizeToFit]; l.center = CGPointMake(cx, y); [p addSubview:l];
}
- (void)outBtn:(CGRect)r title:(NSString*)t sel:(SEL)s fontSize:(CGFloat)fs {
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom]; b.frame = r;
    b.backgroundColor = [UIColor colorWithRed:.06 green:.11 blue:.28 alpha:.9];
    b.layer.cornerRadius = 12; b.layer.borderWidth = 1;
    b.layer.borderColor = [UIColor colorWithRed:.2 green:.45 blue:.9 alpha:.4].CGColor;
    [b setTitle:t forState:0];
    b.titleLabel.font = [UIFont systemFontOfSize:fs];
    b.titleLabel.numberOfLines = 1;
    [b addTarget:self action:s forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
}

// ── أحداث ─────────────────────────────────────────────────────────────────
- (void)confirm {
    if ([self.f.text isEqualToString:PASSCODE]) {
        // ✅ رمز صحيح — احفظ وأخفِ الشاشة نهائياً
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:UNLOCK_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [UIView animateWithDuration:.35 animations:^{ self.view.alpha = 0; }
                         completion:^(BOOL d){ _gw.hidden = YES; _gw = nil; }];
    } else {
        // ❌ رمز خاطئ — اهزّ الحقل ولا تختفي
        self.f.text = @"";
        CAKeyframeAnimation *a = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        a.values = @[@(-12), @(12), @(-8), @(8), @(-4), @(4), @0];
        a.duration = .4;
        [self.f.superview.layer addAnimation:a forKey:nil];
    }
}
- (void)tg  {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:TELEGRAM]
                                       options:@{} completionHandler:nil];
}
- (void)lnk {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:CODE_LINK]
                                       options:@{} completionHandler:nil];
}
- (UIStatusBarStyle)preferredStatusBarStyle { return UIStatusBarStyleLightContent; }
- (BOOL)shouldAutorotate { return YES; }
- (UIInterfaceOrientationMask)supportedInterfaceOrientations { return UIInterfaceOrientationMaskAll; }
@end

// ── Constructor ────────────────────────────────────────────────────────────
__attribute__((constructor)) static void TGInit(void) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.15 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{

        // ✅ إذا أدخل الرمز الصحيح من قبل — لا تظهر الشاشة
        if ([[NSUserDefaults standardUserDefaults] boolForKey:UNLOCK_KEY]) return;

        // ❌ لم يُدخل الرمز بعد — أظهر الشاشة ولا تسمح بإغلاقها
        if (_gw) return;
        UIWindowScene *sc = nil;
        for (UIScene *s in UIApplication.sharedApplication.connectedScenes)
            if ([s isKindOfClass:UIWindowScene.class]) { sc = (UIWindowScene*)s; break; }
        _gw = sc ? [[UIWindow alloc] initWithWindowScene:sc]
                 : [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _gw.windowLevel = UIWindowLevelAlert + 999;
        _gw.rootViewController = [TGVc new];
        _gw.hidden = NO;
        [_gw makeKeyAndVisible];
    });
}
