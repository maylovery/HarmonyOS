
import { Log } from '../../common/Log'
import { FoodItem } from './MeiTuanModel'

// 初始化持久化购物车
PersistentStorage.PersistProp("user_cart", '[]')
const getCarts = () => {
  return JSON.parse(AppStorage.Get('user_cart') || '[]') as FoodItem[]
}
const addCutCart = (type: 'add' | 'cut', item: FoodItem ) =>  {
  const list = getCarts()
  const f = list.find(f => f.id === item.id)
  if(type === 'add') {
    // +1
    if(f) {
      f.count++
    }else {
      item.count = 1
      list.unshift(item) // 加入
      Log.info("DemoDebug", item.price.toFixed(2).toString())
    }

  } else if(type === 'cut') {
    if(f && f.count > 0) {
      f.count--
      if(f.count === 0) {
        // 移除
        const index = list.findIndex(f => f.id === item.id)
        list.splice(index, 1) // 移除该元素
      }
    }
  }
  AppStorage.Set<string>("user_cart", JSON.stringify(list))
}

const clearCart = () => {
  AppStorage.Set<string>("user_cart", '[]')
}

export {getCarts, addCutCart, clearCart }