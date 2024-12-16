
import prompt from '@ohos.promptAction';
import router from '@ohos.router';
@Extend(TextInput)
function inputStyle() {
  .placeholderColor('#99182431')
  .height(48)
  .fontSize(45)
  .backgroundColor('#F1F3F5')
  .width('100%')
  .padding({ left: 0 })
  .margin({ top: 12 })
}

@Extend(Line)
function lineStyle() {
  .width('100%')
  .height(1)
  .backgroundColor('#33182431')
}

@Extend(Text)
function blueTextStyle() {
  .fontColor('#007DFF')
  .fontSize(14)
  .fontWeight(FontWeight.Medium)
}

/**
 * Login page
 */
@Entry
@Component
struct LoginPage {
  @State account: string = '';
  @State password: string = '';
  @State isShowProgress: boolean = false;
  private timeOutId: number = -1;
  @State isRegister: boolean = false;
  @State paccount: string = (router.getParams() as Record<string, string>)['account'];
  @State ppassword: string = (router.getParams() as Record<string, string>)['password'];

  @Builder
  imageButton(src: Resource) {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Image(src)
    }
    .height(48)
    .width(48)
    .backgroundColor('#F1F3F')
  }

  login(): void {
    if (this.account === '' || this.password === '') {
      prompt.showToast({
        message: '输入不能为空'
      })
    } else {
      if ((this.account != this.paccount) || (this.password != this.ppassword)) {
        prompt.showToast({
          message: '用户名或密码不正确，请重新核对后输入'
        })
      } else {
        this.isShowProgress = true;
        if (this.timeOutId === -1) {
          this.timeOutId = setTimeout(() => {
            this.isShowProgress = false;
            this.timeOutId = -1;
            prompt.showToast({
              message: '登录成功！！！欢迎您' + this.account
            })
            router.pushUrl({ url: 'pages/MainPage' });
          }, 2000);
        }
      }
    }
  }

  aboutToDisappear() {
    clearTimeout(this.timeOutId);
    this.timeOutId = -1;
  }

  build() {
    Column() {
      Image($r('app.media.logo'))
        .width(78)
        .height(78)
        .margin({ top: 100, bottom: 8 })
      Text('登录界面')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor('#182431')
      Text('登录以获取更多服务')
        .fontSize(16)
        .fontColor('#99182431')
        .margin({ bottom: 30, top: 8 })

      TextInput({ placeholder: '账号' })
        .maxLength(11)
        .type(InputType.Number)
        .inputStyle()
        .onChange((value: string) => {
          this.account = value;
        })
      Line().lineStyle()

      TextInput({ placeholder: '密码' })
        .maxLength(8)
        .type(InputType.Password)
        .inputStyle()
        .onChange((value: string) => {
          this.password = value;
        })
      Line().lineStyle()

      Row() {
        Text('短信验证码登录').blueTextStyle()
        Text('忘记密码').blueTextStyle()
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .margin({ top: 8 })

      Button('登录', { type: ButtonType.Capsule })
        .width('90%')
        .height(40)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .backgroundColor('#007DFF')
        .margin({ top: 87, bottom: 12 })
        .onClick(() => {
          this.login();
        })
      Text('注册账号')
        .fontColor('#007DFF')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          router.pushUrl({ url: 'pages/RegisterPage'})
        })

      if (this.isShowProgress) {
        LoadingProgress()
          .color('#182431')
          .width(30)
          .height(30)
          .margin({ top: 20 })
      }

      Blank()
      Text('其他登录方式')
        .fontColor('#838D97')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 50, bottom: 12 })
      Row({ space: 44 }) {
        this.imageButton($r('app.media.login_method1'))
        this.imageButton($r('app.media.login_method2'))
        this.imageButton($r('app.media.login_method3'))
      }
    }
    .backgroundColor('#F1F3F5')
    .height('100%')
    .width('100%')
    .padding({
      left: 12,
      right: 12,
      bottom: 24
    })
  }
}