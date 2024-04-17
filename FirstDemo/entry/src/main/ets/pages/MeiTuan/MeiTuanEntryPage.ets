
import http from '@ohos.net.http'
import { Log } from '../../common/Log'
import { Category, FoodItem } from './MeiTuanModel'
import { getCarts, addCutCart, clearCart } from './cardStore'

@Entry
@Component
// 美团点菜菜单 菜单加减 和购物车加减 数据联动。 并持久话到本地
struct MeiTuanEntryPage {
  @State showCart: boolean = false
  @State categoryList: Category[] = []
  @Provide cartList: FoodItem[] = []
  @StorageLink("user_cart") @Watch("updateCartJSON") cartJSON: string = "[]"

  aboutToAppear() {
    this.getAllData()
    this.updateCartJSON()
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
  updateCartJSON() {
    this.cartList = getCarts()
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      MTMain({ categoryList: $categoryList })
      if(this.showCart) {
        MTCart()
      }
      MTBottom({showCart: $showCart})
    }.height('100%')
  }
}
// 主内容
@Component struct MTMain {
  @Link categoryList: Category[]
  @State activeIndex: number = 0

  build() {
    Column() {
      // 导航
      MTNav()
      // 左右布局，左侧是大类，右侧是菜品
      Row() {
        Column() {
          ForEach(this.categoryList, (item: Category, index: number) => {
            Text(item.name)
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
          ForEach(this.categoryList[this.activeIndex]?.foods || [], (item: FoodItem) => {
            ListItem() {
              MTFoodItem({ item })
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
  item: Partial<FoodItem> = {}

  build() {
    Row() {
      Image(this.item.picture)
        .width(90)
        .aspectRatio(1)
      Column({ space: 5 }) {
        Text(this.item.name)
          .textOverflow({
            overflow: TextOverflow.Ellipsis,
          })
          .maxLines(2)
          .fontWeight(600)
        Text(this.item.description)
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
          Span(`月销售${this.item.month_saled}`)
          Span(' ')
          Span(this.item.like_ratio_desc)
        }
        .fontSize(12)
        .fontColor('#999')

        Row() {
          Text() {
            Span('¥ ')
              .fontColor('#ff8000')
              .fontSize(10)
            Span(this.item.price.toFixed(2))
              .fontColor('#ff8000')
              .fontWeight(FontWeight.Bold)
          }
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')

        MTAddCut({item: this.item})
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
  @Consume cartList: FoodItem[]

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
            .onClick(() => {
              clearCart()
            })
        }
        .width('100%')
        .height(40)
        .justifyContent(FlexAlign.SpaceBetween)
        .border({ width: { bottom: 0.5 }, color: '#f5f5f5' })
        .margin({ bottom: 10 })
        .padding({ left: 15, right: 15 })

        List({ space: 30 }) {
          ForEach(this.cartList, (item: FoodItem) => {
            ListItem() {
              MTCartItem({ item })
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
  item: Partial<FoodItem> = {}
  build() {
    Row() {
      Image(this.item.picture)
        .width(60)
        .aspectRatio(1)
        .borderRadius(8)
      Column({ space: 5 }) {
        Text(this.item.name)
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
            Span(this.item.price.toString())
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
  @Link showCart: boolean
  @Consume cartList: FoodItem[]
  getAllCount () {
    return this.cartList.reduce((preValue, item) => preValue + item.count, 0).toString()
  }
  getAllPrice () {
    var total: number = 0
    this.cartList.forEach(element => {
      if (element.count > 0) {
        total += element.count * element.price
      }
    });
    Log.info("DemoDebug", total.toString())
    return total.toFixed(2)
    // return this.cartList.reduce((preValue, item) => preValue + (item.count * item.price), 0).toFixed(2)
  }
  build() {
    // 底部悬浮层
    Row() {
      Row() {
        // 小黄人-角标
        Badge({
          value: this.getAllCount(),
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
        .onClick(() => {
          this.showCart = !this.showCart
        })

        // 金额-预估金额 Colum
        Column() {
          Text() {
            Span('¥')
              .fontColor('#fff')
              .fontSize(12)
            Span(this.getAllPrice())
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


@Component struct MTAddCut {
  @Consume cartList: FoodItem[] // 当前购物车
  item: Partial<FoodItem> = {} // 当前菜的对象
  getContent() {
    return this.cartList.find(item => item.id === this.item.id)?.count || 0
  }

  build() {
    Row({ space: 8 }) {
      // 减
      Row() {
        Image('/pages/MeiTuan/minus.png')
          .width(10)
          .aspectRatio(1)

      }.width(16)
      .aspectRatio(1)
      .justifyContent(FlexAlign.Center)
      .backgroundColor("#fff")
      .borderRadius(4)
      .border({ width: 0.5 , color: '#f8c74e'})
      .onClick(() => {
        addCutCart("cut", this.item as FoodItem)
      })
      .visibility(this.getContent() ? Visibility.Visible:  Visibility.Hidden)

      // 内容
      Text(this.getContent().toString()).fontSize(14)
      // 加
      Row() {
        Image('/pages/MeiTuan/plus.png')
          .width(10)
          .aspectRatio(1)

      }.width(16)
      .aspectRatio(1)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#f8c74e')
      .borderRadius(4)
      .onClick(() => {
        addCutCart("add", this.item as FoodItem)
      })
    }
  }
}
