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
  @State rpassword: string = '';
  @State isShowProgress: boolean = false;
  private timeOutId: number = -1;
  @State isRegister: boolean = false;

  @Builder
  imageButton(src: Resource) {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Image(src)
    }
    .height(48)
    .width(48)
    .backgroundColor('#F1F3F')
  }

  Register(): void {
    if (this.account === '' || this.password === '' || this.rpassword === '') {
      prompt.showToast({
        message: '输入不能为空'
      })
    } else {
      if (this.password != this.rpassword) {
        prompt.showToast({
          message: '输入的信息不正确，请核对后重新输入哟！！！'
        })
      } else {
        this.isShowProgress = true;
        if (this.timeOutId === -1) {
          this.timeOutId = setTimeout(() => {
            prompt.showToast({
              message: '注册成功'
            })
            this.isShowProgress = false;
            this.timeOutId = -1;
            router.pushUrl({
              url: 'pages/LoginPage',
              params:{
                account: this.account,
                password: this.password
              }
            });
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
      Text('注册界面')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor('#182431')
      Text('注册以登录哟')
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
      TextInput({ placeholder: '确认密码' })
        .maxLength(8)
        .type(InputType.Password)
        .inputStyle()
        .onChange((value: string) => {
          this.rpassword = value;
        })
      Line().lineStyle()

      Row() {
        Text('发送短信验证码').blueTextStyle()
        Text('重置').blueTextStyle()
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .margin({ top: 8 })

      Button('注册', { type: ButtonType.Capsule })
        .width('90%')
        .height(40)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .backgroundColor('#007DFF')
        .margin({ top: 87, bottom: 12 })
        .onClick(() => {
          this.Register();
        })
      Text('登录')
        .fontColor('#007DFF')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          router.pushUrl({ url: 'pages/LoginPage'})
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