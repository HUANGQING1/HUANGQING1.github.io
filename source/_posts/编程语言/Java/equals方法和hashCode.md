---
abbrlink: 38
title: equals方法和hashCode
---
## 为什么在重写equals方法时应该同时重写hashCode方法？

### 1、定义
**equals方法**：用于判断两个对象是否相等。
**hashCode**：对象的hashCode,主要是为了查找的便捷性。
### 2、为什么要使用hashCode?

```java
为了查找方便。
设想一下，如果字典没有目录，要在成千上万个字中找到要查的字，那该是多么麻烦的事情！
而有了目录，我们只需通过笔画或拼音就可以确定，要查的字在哪一页，在该页寻找所要查的字即可。hashCode就是这么个东西。
```

#### 2.1、举例

```java
我们要在方圆小学寻找学号为31的学生，(查找学号为31的对象)，已知该学生是1班的(hashCode为1）,
那么只需要到1班中去寻找即可(遍历hashCode为1对应的数据，找到学号为31的对象)。
```

#### 2.2、 从这个案例中我们可以得到什么结论？

```java
如果另一个人也要寻找一个学号为31的学生，由于学号唯一，那么这个学生也一定是1班的。
如果两个学生都是1班的，它们不一定是同一个学生。
```
换言之：
  **如果两个对象equals相等，那么它们的hashCode一定相同。**
  **hashCode相同的两个对象，未必equals相等。**

### 3、如果在重写equals方法时不重写hashCode方法会如何？
#### 3.1、直接影响：
代码:

```java
class Student{
    int id;

    public Student() {
    }
    public Student(int id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass () != o.getClass ()) return false;
        Student student = (Student) o;
        return id == student.id;
    }
}

class Student2{
    int id;

    public Student2() {
    }
    public Student2(int id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass () != o.getClass ()) return false;
        Student2 student2 = (Student2) o;
        return id == student2.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash (id);
    }
}
public class Main {
    public static void main(String[] args) {
        System.out.println ("#只重写equals方法：#");
        Student stu1=new Student (31);
        Student stu2=new Student (31);
        System.out.println ("stu1和stu2相等吗："+(stu1.equals (stu2)?"相等":"不相等"));
        System.out.println ("stu1的hashCode："+stu1.hashCode ());
        System.out.println ("stu2的hashCode："+stu2.hashCode ());
        System.out.println ();

        System.out.println ("#同时重写equals方法与hashCode方法：#");
        Student2 stu3=new Student2 (31);
        Student2 stu4=new Student2 (31);
        System.out.println ("stu3和stu4相等吗："+(stu3.equals (stu4)?"相等":"不相等"));
        System.out.println ("stu3的hashCode："+stu3.hashCode ());
        System.out.println ("stu4的hashCode："+stu4.hashCode ());
    }
}

```
![在这里插入图片描述](https://img-blog.csdnimg.cn/32de8b39f33543849ce411fbf53bc16f.png)

**从这里可以看出，只重写equals方法时，两个对象equals相等，当它们的hashCode不相等**

#### 3.2、这会引发什么后果呢？
代码：

```java
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

class Student{
    int id;

    public Student() {
    }
    public Student(int id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass () != o.getClass ()) return false;
        Student student = (Student) o;
        return id == student.id;
    }
}

class Student2{
    int id;

    public Student2() {
    }
    public Student2(int id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass () != o.getClass ()) return false;
        Student2 student2 = (Student2) o;
        return id == student2.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash (id);
    }
}
public class Main {
    public static void main(String[] args) {
        System.out.println ("#只重写equals方法：#");
        Student stu1=new Student (31);
        Student stu2=new Student (31);

        Map map=new HashMap ();
        map. put(stu1,null);
        map.put (stu2,null);
        System.out.println (map);
        System.out.println ();


        System.out.println ("#同时重写equals方法与hashCode方法：#");
        Student2 stu3=new Student2 (31);
        Student2 stu4=new Student2 (31);

        Map map1=new HashMap ();
        map1. put(stu3,null);
        map1.put (stu4,null);
        System.out.println (map1);
    }
}
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/d66164e187fa425d84a789df72bdedba.png)
可以明显的看出，如果不重写hashCode,同一个对象重复地出现在Map集合中，这显然是不对的。

##### 3.2.1、(不重要的分析)为什么会出现这种情况？
**Map 是先根据 Key 值的 hashcode 分配和获取对象保存数组下标的，然后再根据 equals 区分唯一值的。**
**如果不重写hashCode方法，调用的是Object的hashCode方法，对每一个地址不同的对象分配不同的hashCode值。**
举个例子：
到了期末，A、B两班的班长都通知同学去领退回的班费，已领的同学名字记录在已领名单中，避免一个同学领两次钱。
A班的班长将不同日期领班费的同学记录在不同的页上，学号1的小明同学20号领班费时，A班班长没有在20号已领班费同学中找到小明，所以退了一次班费。
小明同学21号领班费时，A班班长没有在21号已领班费同学中找到小明，又退了一次班费。
B班的班长将不同学号领班费的同学记录在不同的页上，1-20号同学记录于页1，21-40号同学记录于页2。学号31的小李同学20号领班费时，A班班长没有在页2已领班费同学中找到小明，所以退了一次班费。小明同学21号领班费时，A班班长在页2已领班费同学中找到小明，拒绝再退班费。
A班的班长的处理方式正如Object的hashCode方法，不同地址的对象(不同日期领班费的学生），即使相等，也分配了不同的hashCode（记录的页码<-->hashCode）。
B班的班长的处理方式则是只要对象相等(学号不变），hashCode就不变（记录的页码<-->hashCode）。