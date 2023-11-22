---
abbrlink: 36
title: HashMap的容量为什么必定为2的次幂
---
## 一、HashMap的容量为2的次幂
```java
public static void main(String[] args) throws Exception{
    for(int initCapacity=0;initCapacity<10;initCapacity++){
        Map map=new HashMap (initCapacity);
        Class<?> mapType = map.getClass();
        Method capacity = mapType.getDeclaredMethod("capacity");
        capacity.setAccessible(true);
        System.out.println("指定的初始容量："+initCapacity+"\t"+"实际的初始容量："+capacity.invoke(map));
    }
}
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/5e9a52fbd53942278b0c6167e47baa5e.png)
![在这里插入图片描述](https://img-blog.csdnimg.cn/da4d7ffee6ac4ef7bf349334d4dea5ae.png)

从以下源代码中也可以看出来，HashMap的容量必定为2的次幂。
HashMap的默认初始化容量也是2的次幂。

```java
    /**
     * The default initial capacity - MUST be a power of two.
     */
    static final int DEFAULT_INITIAL_CAPACITY = 1 << 4; // aka 16
```
如果指定的初始化容量不是2的次幂，在实际初始化时通过该函数返回一个和它最接近的且比它大的数为实际的初始化容量。该数为2的次幂。
```java
    /**
     * Returns a power of two size for the given target capacity.
     */
    static final int tableSizeFor(int cap) {
        int n = -1 >>> Integer.numberOfLeadingZeros(cap - 1);
        return (n < 0) ? 1 : (n >= MAXIMUM_CAPACITY) ? MAXIMUM_CAPACITY : n + 1;
    }
```
扩容时容量变为原容量的二倍（newCap = oldCap << 1）
```java
final Node<K,V>[] resize() {
		......
        if (oldCap > 0) {
            if (oldCap >= MAXIMUM_CAPACITY) {
            	.....
            }
            else if ((newCap = oldCap << 1) < MAXIMUM_CAPACITY &&
                     oldCap >= DEFAULT_INITIAL_CAPACITY)
                newThr = oldThr << 1; // double threshold
        }
        ......
    }

```
综上可知，HashMap的容量必定为2的次幂。

## 二、HashMap的容量为什么必定是2的次幂？
哈希表为了高效存取数据，要求尽可能使数据分布均匀，避免哈希碰撞。
由于hash值是整数，如果采用取余的方式分配数据，任意给定一个hash值，它被分配任一组的概率都是相等的，想必没有更加分布均匀的分配方式了吧。
**经证明可得：hash%n==hash&(n-1)(如果n=2^k)**
由于位运算的效率远远高于求余运算，所以采用位运算。
**为了采用位运算，便要求HashMap的容量为2的次幂。**

源代码：
```java
    final V putVal(int hash, K key, V value, boolean onlyIfAbsent,
                   boolean evict) {
		.......
        if ((p = tab[i = (n - 1) & hash]) == null)
        ......
    }

```
