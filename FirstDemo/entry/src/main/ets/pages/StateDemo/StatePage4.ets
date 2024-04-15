
// 1定义 Observed Model 2 父组件引入State变量，传入子组件。 子组件使用@objectLink 接收，可以动态化
/*
 ● State组件内状态
● Prop子组件修饰符-4.0 boolean/number/string- 单向数据流
● Link 子组件修饰符-双向数据流，所有类型都支持- 必须通过$前缀-（循环数据就没有办法传入）
● Provide和Consume 双向数据流-所有结构均支持
● Watch 可以监听State Link Prop ObjectLink的数据变化
● Observed和ObjectLink
 * */
@Entry
@Component
struct StatePage4 {
  @State list: FoodObjectClass[] = [
    new FoodObjectClass({
      order_id: 1,
      food_name: '鱼香肉丝',
      food_price: 18.8,
      food_count: 1
    }),
    new FoodObjectClass({
      order_id: 2,
      food_name: '粗溜丸子',
      food_price: 26,
      food_count: 2
    }),
    new FoodObjectClass({
      order_id: 3,
      food_name: '杂粮煎饼',
      food_price: 12,
      food_count: 1
    })
  ]
  build() {
    Row() {
      Column({ space: 20 }) {
        ForEach(this.list, (item: FoodObjectClass) => {
          // 单独修改
          FoodItem({ item: item })
        })
        // 全局修改
        BottomCart1({ myList: $list  })
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Extend(Text) function TextStyle () {
  .layoutWeight(1).textAlign(TextAlign.Center).fontSize(20)
}

@Extend(Text) function AddCutStyle () {
  .width(40)
  .height(40)
  .borderRadius(20)
  .backgroundColor(Color.Grey)
  .textAlign(TextAlign.Center)
  .fontSize(20)
}

@Component struct FoodItem {
  // Observed必须和ObjectLink才有UI更新的效果
  @ObjectLink item: FoodObjectClass
  build() {
    Row() {
      Text(this.item.food_name).TextStyle()
      Text(this.item.food_price.toFixed(2)).TextStyle()
      // 数量加减1
      Row() {
        Text("-").AddCutStyle()
          .onClick(() => {
            this.item.food_count--
          })
          .visibility(this.item.food_count > 0 ? Visibility.Visible : Visibility.Hidden)
        Text(this.item.food_count.toString()).TextStyle()
          .visibility(this.item.food_count > 0 ? Visibility.Visible : Visibility.Hidden)

        Text("+").AddCutStyle()
          .onClick(() => {
            this.item.food_count++
          })
      }.layoutWeight(1)
    }
    .width('100%')
    .height(40)
  }
}

// 底部组件
@Component struct BottomCart1 {
  // 全部修改
  @Link myList: FoodObjectClass[]
  build() {
    Button("更改菜品的数量")
      .onClick(() => {
        this.myList = this.myList.map(item => {
          item.food_count++
          return item
        })
      })
  }
}

// 定义了一个接口
interface IFoodInfo {
  order_id: number
  food_name: string
  food_price: number
  food_count: number
}

// 食品类
@Observed class FoodObjectClass implements IFoodInfo  {
  order_id: number = 0
  food_name:  string = ""
  food_price: number = 0
  food_count: number = 0
  constructor(obj: IFoodInfo) {
    this.order_id = obj.order_id
    this.food_name = obj.food_name
    this.food_price = obj.food_price
    this.food_count = obj.food_count
  }
}