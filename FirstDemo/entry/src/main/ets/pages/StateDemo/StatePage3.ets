
import { Log } from '../../common/Log'
// ArkTS支持跨组件传递状态数据来实现双向同步@Provide和 @Consume
// 1 是通过相同的变量名
// 2 是 通过相同的变量别名绑定 @Provide('key') 和 @Consume('key') key需要保持一致
// ArkTS所有内容都不支持深层数据更新 UI渲染
@Entry
@Component
struct StatePage3 {
  @Provide("pagecount") @Watch('pagecountUpdate') count: number = 0

  pagecountUpdate(keyName: string) {
    Log.info("DemoTest", this.count.toString())
  }
  build() {
    Row() {
      Column({ space: 15 }) {
        Text(this.count.toString())
          .fontSize(50)
        Button("顶级组件+1")
          .onClick(() => {
            this.count++
          })
        Divider()
        ChildLevel1()

        Column({space: 10}) {
          Text("1 是通过相同的变量名")
          Text("2 是 通过相同的变量别名绑定 @Provide('key') 和 @Consume('key') key需要保持一致")
          Text("3 ArkTS所有内容都不支持深层数据更新 UI渲染")
          Text("4 @Watch('updateCount'), Watch修饰符要写在 State Prop Link Provide的修饰符下面")
        }.width("100%")
        .alignItems(HorizontalAlign.Start)
        .padding({left: 20})
      }
      .width('100%')
    }
    .height('100%')
  }
}

// 子组件
@Component struct ChildLevel1 {
  build() {
    Column() {
      Text("子组件")
        .fontSize(40)
      Divider()
      ChildLevel2()
    }
  }
}
// 孙组件
@Component struct ChildLevel2 {
  @Consume('pagecount') count: number
  build() {
    Column() {
      Text("孙组件")
        .fontSize(30)
      Text(this.count.toString())
      Text('点击加加：' + this.count)
        .onClick(() => {
          this.count++
        })
    }
  }
}