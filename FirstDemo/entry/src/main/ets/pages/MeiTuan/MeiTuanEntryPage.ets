
import http from '@ohos.net.http'
import { Log } from '../../common/Log'
import { Category } from './MeiTuanModel'
@Entry
@Component
// 美团点菜菜单
struct MeiTuanEntryPage {
  @State showCart: boolean = false
  @State categoryList: Category[] = []
  aboutToAppear() {
    this.getAllData()
  }
  async getAllData () {
    try {
      let resp = await http.createHttp().request("https://zhoushugang.gitee.io/fe2022/takeaway.json")
      let result = JSON.parse(resp.result as string) as Category[]
      this.categoryList = result
    }catch(err) {
      Log.info("sss", '2')
    }

  }
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      MTMain()
      if(this.showCart) {
        MTCart()
      }
      MTBottom()
    }
  }
}
// 主内容
@Component struct MTMain {
  list: string[] = ['一人套餐', '特色烧烤', '杂粮主食']
  @State activeIndex: number = 0

  build() {
    Column() {
      // 导航
      MTNav()
      // 左右布局，左侧是大类，右侧是菜品
      Row() {
        Column() {
          ForEach(this.list, (item: string, index: number) => {
            Text(item)
              .height(50)
              .width('100%')
              .textAlign(TextAlign.Center)
              .fontSize(14)
              .backgroundColor(this.activeIndex === index ? '#fff' : '#f5f5f5')
              .onClick(() => {
                this.activeIndex = index
              })
          })
        }
        .width(90)
        //   右侧内容
        List() {
          ForEach([1,2,3,4,5,6,7,8,9], () => {
            ListItem() {
              MTFoodItem()
            }
          })
        }.layoutWeight(1)
        .backgroundColor('#fff')
        .padding({ bottom: 20 })
      }
      .layoutWeight(1)
      .alignItems(VerticalAlign.Top)
      .width('100%')

    }.height('100%')
    .backgroundColor('#fff')
  }
}

// 顶部点菜-菜单
@Component struct MTNav {
  @Builder NavItem(active: boolean, title: string, subTitle?: string) {
    Column() {
      Text() {
        Span(title)
        if (subTitle) {
          Span(' ' + subTitle)
            .fontSize(10)
            .fontColor(active ? '#000' : '#666')
        }
      }.layoutWeight(1)
      .fontColor(active ? '#000' : '#666')
      .fontWeight(active ? FontWeight.Bold : FontWeight.Normal)

      Text()
        .height(1)
        .width(20)
        .margin({ left: 6 })
        .backgroundColor(active ? '#fa0' : 'transparent')
    }
    .width(73)
    .alignItems(HorizontalAlign.Start)
    .padding({ top: 3 })
  }

  build() {
    Row() {
      this.NavItem(true, '点菜')
      this.NavItem(false, '评价', '1796')
      this.NavItem(false, '商家')
      Row() {
        Image($r('app.media.search'))
          .width(14)
          .aspectRatio(1)
          .fillColor('#999')
        Text('请输入菜品名称')
          .fontSize(12)
          .fontColor('#999')
      }
      .backgroundColor('#eee')
      .height(25)
      .borderRadius(13)
      .padding({ left: 5, right: 5 })
      .layoutWeight(1)
    }
    .padding({ left: 15, right: 15 })
    .height(40)
    .border({ width: { bottom: 0.5 }, color: '#e4e4e4' })
  }
}
// 每种菜品的样式
@Component struct MTFoodItem {
  build() {
    Row() {
      Image('https://zqran.gitee.io/images/waimai/8078956697.jpg')
        .width(90)
        .aspectRatio(1)
      Column({ space: 5 }) {
        Text('小份酸汤莜面鱼鱼+肉夹馍套餐')
          .textOverflow({
            overflow: TextOverflow.Ellipsis,
          })
          .maxLines(2)
          .fontWeight(600)
        Text('酸汤莜面鱼鱼，主料：酸汤、莜面 肉夹馍，主料：白皮饼、猪肉')
          .textOverflow({
            overflow: TextOverflow.Ellipsis,
          })
          .maxLines(1)
          .fontSize(12)
          .fontColor('#333')
        Text('点评网友推荐')
          .fontSize(10)
          .backgroundColor('#fff5e2')
          .fontColor('#ff8000')
          .padding({ top: 2, bottom: 2, right: 5, left: 5 })
          .borderRadius(2)
        Text() {
          Span('月销售40')
          Span(' ')
          Span('好评度100%')
        }
        .fontSize(12)
        .fontColor('#999')

        Row() {
          Text() {
            Span('¥ ')
              .fontColor('#ff8000')
              .fontSize(10)
            Span('34.23')
              .fontColor('#ff8000')
              .fontWeight(FontWeight.Bold)
          }
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 10, right: 10 })
    }
    .padding(10)
    .alignItems(VerticalAlign.Top)
  }
}

// 已加的购物车
@Component struct MTCart {
  build() {
    // 购物车弹出层
    Column() {
      Column() {
        Row() {
          Text('购物车')
            .fontSize(12)
            .fontWeight(600)
          Text('清空购物车')
            .fontSize(12)
            .fontColor('#999')
        }
        .width('100%')
        .height(40)
        .justifyContent(FlexAlign.SpaceBetween)
        .border({ width: { bottom: 0.5 }, color: '#f5f5f5' })
        .margin({ bottom: 10 })
        .padding({ left: 15, right: 15 })

        List({ space: 30 }) {
          ForEach([1,2,3,4], () => {
            ListItem() {
              MTCartItem()
            }
          })
        }
        .divider({ strokeWidth: 0.5, color: '#f5f5f5' })
        .padding({ left: 15, right: 15, bottom: 100 })
      }
      .backgroundColor('#fff')
      .borderRadius({ topLeft: 16, topRight: 16 })
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.End)
    .backgroundColor('rgba(0,0,0,0.5)')
  }
}
// 购物车的子项
@Component struct MTCartItem {
  build() {
    Row() {
      Image('https://zqran.gitee.io/images/waimai/7384994864.jpg')
        .width(60)
        .aspectRatio(1)
        .borderRadius(8)
      Column({ space: 5 }) {
        Text('小份酸汤莜面鱼鱼+肉夹馍套餐')
          .fontSize(14)
          .textOverflow({
            overflow: TextOverflow.Ellipsis
          })
          .maxLines(2)
        Row() {
          Text() {
            Span('¥ ')
              .fontColor('#ff8000')
              .fontSize(10)
            Span('34.23')
              .fontColor('#ff8000')
              .fontWeight(FontWeight.Bold)
          }
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 10, right: 10 })
    }
    .alignItems(VerticalAlign.Top)
  }
}

// 底部 总金额-结算组件
@Component struct MTBottom {
  build() {
    // 底部悬浮层
    Row() {
      Row() {
        // 小黄人-角标
        Badge({
          value: '0',
          position: BadgePosition.Right,
          style: { badgeSize: 18 }
        }) {
          Image('/pages/MeiTuan/cart_2.png')
            .width(47)
            .height(69)
            .position({ y: -19 })
        }
        .width(50)
        .height(50)
        .margin({ left: 25, right: 10 })

        // 金额-预估金额 Colum
        Column() {
          Text() {
            Span('¥')
              .fontColor('#fff')
              .fontSize(12)
            Span('0.00')
              .fontColor('#fff')
              .fontSize(24)
          }

          Text('预估另需配送费 ¥5')
            .fontSize(12)
            .fontColor('#999')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        // 右侧的去结算
        Text('去结算')
          .backgroundColor('#f8c74e')
          .alignSelf(ItemAlign.Stretch)
          .padding(15)
          .borderRadius({
            topRight: 25,
            bottomRight: 25
          })

      }
      .height(50)
      .width('100%')
      .backgroundColor('#222426')
      .borderRadius(25)
    }
    .width('100%')
    .padding({ left: 20, right: 20, bottom: 20 })

  }
}