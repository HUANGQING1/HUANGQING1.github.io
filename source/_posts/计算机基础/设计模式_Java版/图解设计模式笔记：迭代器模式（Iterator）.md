---
abbrlink: 42
title: 图解设计模式笔记：迭代器模式（Iterator）
---
# 迭代器模式（Iterator）
**意图：**提供一种方法顺序访问一个聚合对象中的各个元素，而又不需要暴露该对象的内部表示。
这种设计模式要解决的根本问题是：
```c
聚合的种类有很多，比如对象、链表、数组、甚至自定义结构，但遍历这些结构时，不同结构的遍历方式又不同，所以我们必须了解每种结构的内部定义才能遍历。比如，链表，数组因内部定义不同，遍历方式是不同的。
迭代器模式可以做到用同一种 API 遍历任意类型聚合对象，且不用关心聚合对象的内部结构。
```

迭代器模式的类图：

![在这里插入图片描述](https://img-blog.csdnimg.cn/d7d91a0d2b44464fa91a7f59c2352fa8.png)
![在这里插入图片描述](https://img-blog.csdnimg.cn/b7f05378e62644eabbf46d3dafe541a8.png)


```java
    public interface Aggregate{//表示集合的接口
    	Iterator iterator();
    }
    
    public interface Iterator{//遍历集合的接口
    	boolean hasNext();
        Object next();
    }
    
    public class Book{
        private String name;
        public Book(String name){this.name=name;}
        public String getName(){return this.name;}
    }
    
    public class BookShelf implemtnts Aggregate{//具体的集合类
    	private Books[] books;
        private int last=0;
        public BookShelf(int maxsize){
            this.books=new Book[maxsize];
        }
        public Book getBookAt(int index){
            return books[index];
        }
        public void appendBook(Book book){
            this.books[last]=book;
            this.last++;
        }
        public int getLength(){return this.last;}
        public Iterator iterator(){return new BookShelfIterator(this);}
    }
    
    public class BookShelfIterator implemtnts Iterator{//遍历BookShelf的类
    	private BookShelf bookShelf
        private int index=0;
        public BookShelfIterator(BookShelf bookShelf){this.bookShelf=bookShelf;}
        public boolean hasNext(){
            return (index<bookShelf.getLength())
        }
        public Object next(){
        	return bookshelf.getBookAt(index++);
        }
    }
    
    public class Main{
        public static void main(String[] args) {
            BookShelf bookShelf=new BookShelf(10);
            bookShelf.appendBook(new Book("book1"));
            bookShelf.appendBook(new Book("book2"));
            Iterator iterator =bookShelf.iterator();
            /*
            这里只使用了Iterator的hasNext方法和next方法，并没有调用BookShelf的方法。
            也就是说,这里的while循环并不依赖于Bookshelf的实现。
            如果编写BookShelf的开发人员改用ArrayList集合取代数组来管理书本，会怎样呢?
            不管BookShelf如何变化，只要BookShelf的iterator方法能正确地返回工terator实例
            (也就是说，返回的Iterator类的实例没有问题，hasNext和next方法都可以正常工作)，
            即使不对上面的while循环做任何修改，代码都可以正常工作。
    		*/
    
            while(iterator.hasNext()){
                Book book=(Book)iterator.next();
                System.out.println(book.getName());
            }
        }
    }
```



优缺点：

迭代器模式优点 : 分离 了 集合对象 的 遍历行为 ; 抽象出了 迭代器 负责 集合对象的遍历 , 可以让外部的代码 透明的 访问集合内部的数据 ;

迭代器模式缺点 : 类的个数成对增加 ; 迭代器模式 , 将 存储数据 , 遍历数据 两个职责拆分 ; 如果新添加一个 集合类 , 需要增加该 集合类 对应的 迭代器类 , 类的个数成对增加 , 在一定程度上 , 增加了系统复杂性 ;

## 参考书籍
图解设计模式
