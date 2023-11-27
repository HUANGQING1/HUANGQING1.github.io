---
abbrlink: 37
title: Java的动态绑定和静态绑定
---
# 定义
**绑定**指的是一个方法的调用与方法所在的类(方法主体)关联起来。对java来说，绑定分为静态绑定和动态绑定。
**静态绑定**：在程序执行前方法已经被绑定（也就是说在编译过程中就已经知道这个方法到底是哪个类中的方法），此时由 编译器或其它连接程序实现。
**动态绑定**： 在运行时根据具体对象的类型进行绑定。

**在Java中对属性采用静态绑定，对方法采用动态绑定。**


# 举例说明

首先定义两个类
```java
class Animal{
    public String name="Animal";

    public String getName() {
        System.out.println ("Animal的方法getName被调用");
        return name;
    }
    public void animalSeeName(){
        System.out.println ("animalSeeName方法调用");
        System.out.println (name);
    }
}

class Dog extends Animal{
    public String name="Dog";

    public String getName() {
        System.out.println ("Dog的方法getName被调用");
        return name;
    }
    public void dogSeeName(){
        System.out.println ("dogSeeName方法调用");
        System.out.println (name);
    }
}
```

## 属性的静态绑定：

 - 如果子类和父类拥有同名成员变量，那么在编译时定义时是什么类，绑定的就是该类的属性。

Dog类的对象Dog dog=new Dog()在堆中的内存图

![在这里插入图片描述](https://img-blog.csdnimg.cn/f9a778867cc8457aa7875b1b771c2264.png)
注意：字符串变量也是引用，保存的也是内存地址，字符串是保存在字符串常量池的。这里的name变量应该是保存指向字符串的内存地址，这么画只是为了简单直观，并不正确。
```java
public static void main(String[] args) {
    Animal animal=new Dog();
    Dog dog =new Dog();
    System.out.println ("animal.name: "+animal.name);//在编译时animal绑定的是Animal类，所以绑定的是Animal的name属性。
    System.out.println ("dog.name: "+dog.name);//dog编译时绑定的是Dog类，所以绑定的是Dog的name属性。
}
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/8e509edb7d7e40618572941dbd1b2d54.png)

可能有人会有好奇，如果Dog类没有定义name成员变量呢？
答案是两个都打印"Animal",
因为这种情况下，Dog类对象中只有一个name属性了，不需要考虑上述问题。

## 方法的动态绑定：

 - 编译时静态绑定，也就是定义时是什么类，就绑定什么类的方法，到了运行时，它就动态绑定它实际指向的对象的方法。

```java
public static void main(String[] args) {
    Animal animal=new Dog();
    Dog dog =new Dog();

    animal.getName ();//animal编译时绑定的是Animal类的getName方法，但到了运行时，由于它实际指向是一个Dog对象，所以执行的是Dog类的getName方法。
    dog.getName ();
}
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/6b5549948c574d48b3c6a7cba9c80f66.png)


 - 如果子类和父类定义了同名成员变量，且在方法中使用了该同名成员变量，那么使用的是父类的成员变量还是子类的呢？
 答：由方法所在的类决定，也就是说方法在父类中定义和执行，则使用父类的成员变量，在子类中定义和执行，即使用子类的成员变量。
 

```java
public static void main(String[] args) {
    Animal animal=new Dog();
    Dog dog =new Dog();

    animal.animalSeeName ();//"Animal" 因为animalSeeName()在Animal类中定义和使用，
    dog.dogSeeName ();//"Dog" 因为dogSeeName()在Dog类中定义和使用
    
    System.out.println ();
    System.out.println (animal.getName ());//"Dog" 因为执行的是Dog的方法getName(),在Dog类中定义和使用，
    System.out.println (dog.getName ());//"Dog" 因为执行的是Dog的方法getName()在Dog类中定义和使用，
}
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/da6de0b7f8c143c2a7399d81d8e99c0f.png)