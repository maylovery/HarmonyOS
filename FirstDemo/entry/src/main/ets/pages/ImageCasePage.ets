@Entry
@Component
struct ImageCasePage {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      // 使用本地图片-拖一张图片放置到ets目录下-比如assets文件下
      Image('/assets/a.png').width(80).height(80)
      // 使用Resource下的图片-media
      Image($r('app.media.github')).width(80).height(80)
      // 使用Resource下的图片-rawfile
      Image($rawfile("b.png")).width(80).height(80)

      // 使用网络图片
      Image("https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F2bf1b169-d217-44c3-a5b3-dd00813bc20d%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1704614176&t=e15a2fd5193aeeb24fc95b5dbe395907").width(80).height(80)

    }
    .height('100%')
  }
}