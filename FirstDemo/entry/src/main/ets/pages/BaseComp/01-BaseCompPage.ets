import { Log } from '../../common/Log'
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
      Text("基础组件-Text-Button-TextInput")
    }
    .width('100%')
    .height(50)
    .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct Main {
  @State inputtext: string = ""

  build() {
    Column({space: 20}){
      Text("文本")
        .fontColor(Color.Red)
      Button("按钮点击")
        .onClick(() => {
          Log.info("text", "base 按钮点击")
        })

      TextInput({placeholder: "输入姓名", text: this.inputtext})
        .backgroundColor('#f4f5f6')
        .border({width: 2, color: Color.Red, radius: 8})
        .onChange((txt) => {
          this.inputtext = txt
        })
    }
    .width('100%')
    .backgroundColor(Color.White)
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
/*
● 一个UI描述必须使用struct来声明，不能继承
● struct必须被Component或者CustomDialog修饰
● struct必须实现build方法，build方法可以没有元素，但是有的话有且只有一个可容纳子组件的容器组件(entry修饰的组件)
● entry修饰符表示该组件是页面级组件，一个文件中只允许修饰一个struct组件
● 采用分拆组件的形式可以有效解解耦我们的业务
 * */

/*
● Text 文本组件-（Span子组件）
● Column 列组件，纵向排列，Flex布局主轴是Y （任意子组件）
● Row 行组件，横向向排列，Flex布局主轴是X （任意子组件）
● Flex 以弹性方式布局子组件的容器组件。(存在二次布局，官方推荐有性能要求，使用Column和Row代替) （任意子组件）
● Button 按钮组件 （单子组件）
● TextInput 输入框组件 （无子组件）
● Image （无子组件）
● Button (单个子组件)
● List (限制ListItem子组件)
● Scroll (限制单个子组件)
 *
 * */