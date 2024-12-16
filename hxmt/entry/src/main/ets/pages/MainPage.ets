
import prompt from '@ohos.prompt';
import Prompt from '@system.prompt';
import router from '@ohos.router';
/**
 * Main page
 */
@Entry
@Component
struct MainPage {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();
  private swiperController: SwiperController = new SwiperController();
  @State pictures: any[] = [
    { Simg:$r('app.media.fig1')},
    { Simg:$r('app.media.fig2')},
    { Simg:$r('app.media.fig3')},
    { Simg:$r('app.media.fig4')}
  ]
  @State othersItems: any[] = [
    {title:'我的最爱', img:$r('app.media.love')},
    {title:'历史记录', img:$r('app.media.record')},
    {title:'消息', img:$r('app.media.message')},
    {title:'购物车', img:$r('app.media.shopping')},
    {title:'我的目标', img:$r('app.media.target')},
    {title:'圈子', img:$r('app.media.circle')},
    {title:'收藏', img:$r('app.media.favorite')},
    {title:'回收站', img:$r('app.media.recycle')}
  ]
  @State listItems: any[] = [
    {title:'排行榜', img:$r('app.media.top'), text: '厦门站，我们不见不散'},
    {title:'新品首发', img:$r('app.media.new'), text: '厦门站，我们不见不散'},
    {title:'大牌闪购', img:$r('app.media.brand'), text: '大牌闪购'},
    {title:'发现好物', img:$r('app.media.found'), text: '厦门站，我们不见不散'}
  ]
  @State setItems: any[] = [
    {title:'推送通知', img:$r('app.media.news'), textF:'开关'},
    {title:'数据管理', img:$r('app.media.data')},
    {title:'菜单设置', img:$r('app.media.menu')},
    {title:'关于', img:$r('app.media.about')},
    {title:'清除缓存', img:$r('app.media.storage')},
    {title:'隐私协议', img:$r('app.media.privacy')}
  ]

  @Builder TabBuilder(title: string, index: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === index ? selectedImg : normalImg)
        .width(25)
        .height(25)
      Text(title)
        .margin({ top: 4 })
        .fontSize(10)
        .fontColor(this.currentIndex === index ? '#1698CE' : '#6B6B6B')
    }
    .justifyContent(FlexAlign.Center)
    .height(56)
    .width('100%')
    .onClick(() => {
      this.currentIndex = index;
      this.tabsController.changeIndex(this.currentIndex);
    })
  }
  @Builder settingCell(sI) {
    Row() {
      Row({ space: 12 }) {
        Image(sI.img)
          .width(22)
          .height(22)
        Text(sI.title)
          .fontSize(16)
      }

      if (sI.textF === null) {
        Image($r('app.media.right_grey'))
          .width(12)
          .height(24)
      } else {
        Toggle({ type: ToggleType.Switch, isOn: false })
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .padding({
      left: 8,
      right: 22
    })
  }

  build() {
    Tabs({
      barPosition: BarPosition.End,
      controller: this.tabsController
    }) {
      TabContent() {
        Scroll() {
          Column({ space: 12 }) {
            Column() {
              Text('首页')
                .fontWeight(FontWeight.Medium)
                .fontSize(24)
                .margin({ top: 12 })
                .padding({ left: 12 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Swiper(this.swiperController) {
              ForEach(this.pictures, (img) => {
                Image(img.Simg).borderRadius(16)
              }, (img: Resource) => JSON.stringify(img.id))
            }
            .margin({ top: 24 })
            .autoPlay(true)

            Grid() {
              ForEach(this.othersItems, (oI) => {
                GridItem() {
                  Column() {
                    Image(oI.img)
                      .width(24)
                      .height(24)
                    Text(oI.title)
                      .fontSize(12)
                      .margin({ top: 4 })
                  }
                }
              })
            }
            .columnsTemplate('1fr 1fr 1fr 1fr')
            .rowsTemplate('1fr 1fr')
            .columnsGap(8)
            .rowsGap(12)
            .padding({ top: 12, bottom: 12 })
            .height(124)
            .backgroundColor(Color.White)
            .borderRadius(24)

            Text('列表')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .width('100%')
              .margin({ top: 12 })

            Grid() {
              ForEach(this.listItems, (lI) => {
                GridItem() {
                  Column() {
                    Text(lI.title)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                    Text(lI.text)
                      .margin({ top: 4 })
                      .fontSize(12)
                      .fontColor('"#99182431"')
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                .padding({ top: 8, left: 8 })
                .borderRadius(12)
                .align(Alignment.TopStart)
                .backgroundImage(lI.img)
                .backgroundImageSize(ImageSize.Cover)
                .width('100%')
                .height('100%')
              })
            }
            .width('100%')
            .height(260)
            .columnsTemplate('1fr 1fr')
            .rowsTemplate('1fr 1fr')
            .columnsGap(8)
            .rowsGap(12)
            .margin({ bottom: 55 })
          }
        }
        .height('100%')
      }
      .padding({ left: 12, right: 12 })
      .backgroundColor('#F1F3F5')
      .tabBar(this.TabBuilder('首页', 0,
        $r('app.media.home_selected'), $r('app.media.home_normal')))

      TabContent() {
        Scroll() {
          Column({ space: 12 }) {
            Column(){
              Text('我的')
                .fontWeight(FontWeight.Medium)
                .fontSize(24)
                .margin({ top: 12 })
                .padding({ left: 12 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Row() {
              Image($r('app.media.account'))
                .width(48)
                .height(48)
              Column() {
                Text('Mr.Xie')
                  .fontSize(20)
                Text('2521885390@qq.com')
                  .fontSize(12)
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ left: 24 })
            }
            .margin({ top: 24 })
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .height(96)
            .backgroundColor(Color.White)
            .padding({ left: 24 })
            .borderRadius(16)

            List() {
              ForEach(this.setItems, (sI) => {
                ListItem() {
                  this.settingCell(sI)
                }
                .height(48)
              })
            }
            .backgroundColor(Color.White)
            .width('100%')
            .height('42%')
            .divider({
              strokeWidth: 0.25,
              color: Color.Grey,
              startMargin: 42,
              endMargin: 24
            })
            .borderRadius(16)
            .padding({ top: 4, bottom: 4 })

            Blank()

            Button('退出登录', { type: ButtonType.Capsule })
              .width('90%')
              .height(40)
              .fontSize(16)
              .fontColor('#FA2A2D')
              .fontWeight(FontWeight.Medium)
              .backgroundColor('#E5E8EA')
              .margin({ bottom: 55})
              .onClick(() => {
                AlertDialog.show({
                  title:'提示消息',
                  message: '确定退出登录吗？',
                  offset:{ dx:0, dy: -20},
                  alignment: DialogAlignment.Bottom,
                  gridCount:4,
                  autoCancel:true,
                  primaryButton:{
                    value:'取消',
                    action:() => {
                      //取消操作
                    }
                  },
                  secondaryButton:{
                    value:'确定',
                    action:() => {
                      router.back({ url: 'pages/LoginPage'})
                    }
                  },
                  cancel:() => {
                    //取消操作
                  }
                })
              })
          }
          .height('100%')
        }
      }
      .padding({ left: 12, right: 12 })
      .backgroundColor('#F1F3F5')
      .tabBar(this.TabBuilder('我的', 1,
        $r('app.media.mine_selected'), $r('app.media.mine_normal')))
    }
    .width('100%')
    .backgroundColor(Color.White)
    .barHeight(56)
    .barMode(BarMode.Fixed)
    .onChange((index: number) => {
      this.currentIndex = index;
    })
  }
}