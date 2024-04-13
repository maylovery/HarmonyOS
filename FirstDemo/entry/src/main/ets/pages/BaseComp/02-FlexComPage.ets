@Entry
@Component
struct FlexCase {
  @State message: string = 'Hello World'
  build() {
    Scroll() {
      Row() {
        Column() {
          Text("老高你讲的真烂")
          Text(){
            Span("¥")
              .fontSize(12)
            Span("50.45")
              .fontSize(20)
          }
          // css 支持调整布局
          Row({ space:15 }) {
            Column()
              .width(100)
              .height(200)
              .backgroundColor(Color.Pink)
            Column()
              .width(100)
              .height(200)
              .backgroundColor(Color.Red)
            Column()
              .width(100)
              .height(200)
              .backgroundColor(Color.Blue)
          }
          .width('100%')
          // .justifyContent(FlexAlign.Start)
          .justifyContent(FlexAlign.Center)
          // .justifyContent(FlexAlign.End)
          // .justifyContent(FlexAlign.SpaceBetween)
          // .justifyContent(FlexAlign.SpaceAround)
          // .justifyContent(FlexAlign.SpaceEvenly)

          Column({ space: 20 }) {
            Column()
              .width(200)
              .height(100)
              .backgroundColor(Color.Pink)
            Column()
              .width(200)
              .height(100)
              .backgroundColor(Color.Red)
            Column()
              .width(200)
              .height(100)
              .backgroundColor(Color.Blue)
          }.margin({
            top: 20
          })

          Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceAround }) {
            Column()
              .width(100)
              .height(200)
              .backgroundColor(Color.Pink)
            Column()
              .width(100)
              .height(200)
              .backgroundColor(Color.Red)
            Column()
              .width(100)
              .height(200)
              .backgroundColor(Color.Blue)
          }
          .margin({
            top: 200
          })

        }
        .width('100%')
      }
    }

  }
}