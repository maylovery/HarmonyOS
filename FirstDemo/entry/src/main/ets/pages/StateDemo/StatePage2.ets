class FoodClass {
  order_id: number = 0
  food_name:  string = ""
  food_price: number = 0
  food_count: number = 0
}

@Entry
@Component
struct StatePage2 {
  @State cartList: FoodClass[] = [{
    order_id: 1,
    food_name: '鱼香肉丝',
    food_price: 18.8,
    food_count: 1
  },{
    order_id: 2,
    food_name: '粗溜丸子',
    food_price: 26,
    food_count: 2
  },{
    order_id: 3,
    food_name: '杂粮煎饼',
    food_price: 12,
    food_count: 1
  }]
  build() {
    Row() {
      Column() {
        // 各种菜品
        ForEach(this.cartList, (item: FoodClass) => {
          //
          Row() {
            Text(item.food_name)
            Text("价格："+item.food_price.toString())
            Text("数量："+item.food_count.toString())
          }
          .height(60)
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({
            left: 20,
            right: 20
          })
        })
        // 子组件
        BottomCart({ foodList: $cartList })
      }
      .width('100%')
    }
    .height('100%')
  }
}
// 子组件 @Link 逆向传值， 不可以处理 ForEach 传过了的响应式数据
@Component struct BottomCart {
  @Link foodList: FoodClass[]
  build() {
    Row() {
      Button("加菜")
        .onClick(() => {
          this.foodList = this.foodList.map(item => {
            item.food_count++
            return item
          })
        })
    }
  }
}