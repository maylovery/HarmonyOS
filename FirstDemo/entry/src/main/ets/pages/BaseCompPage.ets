@Entry
@Component
struct ColumnCase {
  @State message: string = 'Hello World3'

  build() {
    // 它的子组件都会以纵向方式排列
    Column() {
      Header()
      Main()
      Footer()
    }
  }
}
/*
vp 是鸿蒙默认单位，和屏幕像素有关，最终表现视觉大小在任何设备一致
鸿蒙一般以伸缩 layoutWeight、网格、栅格进行布局适配，
* 如要等比例缩放可以设置高宽比 aspectRatio
 */
@Component
struct Header {
  build() {
    Row(){
      Text("Header")
    }
    .width('100%')
    .height(50)
    .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct Main {
  build() {
    Row(){
      Text("Main")
        .fontColor(Color.White)
    }
    .width('100%')
    .height(200)
    .backgroundColor(Color.Blue)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct Footer {
  build() {
    Row(){
      Text("Footer")
        .fontColor(Color.White)
    }
    .width('100%')
    .height(50)
    .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
  }
}