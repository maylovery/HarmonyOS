import router from '@ohos.router'
@Entry
@Component
struct BaseCompEntry {
  @State message: string = 'Hello World'

  build() {
    List({space: 20}) {
      ListItem() {
        Text("Text")
          .onClick(() => {
            router.pushUrl({ url: "pages/BaseComp/01-BaseCompPage" })
          })
      }

      ListItem() {
        Text("图片")
          .onClick(() => {
            router.pushUrl({ url: "pages/BaseComp/03-ImageCasePage" })
          })
      }

      ListItem() {
        Text("Com-Row-Flex布局")
          .onClick(() => {
            router.pushUrl({ url: "pages/BaseComp/02-FlexComPage" })
          })
      }

      ListItem() {
        Text("倒计时")
          .onClick(() => {
            router.pushUrl({ url: "pages/BaseComp/05-TimerPage" })
          })
      }
    }.padding(20)
  }
}