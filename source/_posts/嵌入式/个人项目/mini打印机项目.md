---
abbrlink: 1
---
```
嘉立创PCB官网：https://www.jlc.com​
嘉立创FA官网：https://www.jlcfa.com​
嘉立创3D打印官网：https://www.sanweihou.com​
立创商城官网：https://www.szlcsc.com​
立创EDA官网：https://lceda.cn

# Arduino 官网

http://www.arduino.cc

# 推荐仿真平台

推荐：https://www.wokwi.com/

[wokwi.com](https://wokwi.com/projects/new/esp32)

一般：https://www.tinkercad.com/

产品需求生成AI：https://www.pm-ai.cn/prd

## ESP32 API手册和ESP32 SDK源码
https://docs.espressif.com/projects/arduino-esp32/en/latest/libraries.html

https://github.com/espressif/arduino-esp32
```
# ESP32版本


# Arduino软件环境搭建
```
安装Python（PlatformIO依赖Python)
Vscode+插件PlatformIO插件(写代码)
PlatformIO插件中安装ESP32平台SDK等等
```
# Arduino语法
```


//头文件
#include <Arduino.h>  

//初始化函数，只执行一次，把只需执行一次的代码放到setup
void setup() {

}

//循环执行函数，重复执行，把需要重复执行的代码放到loop
void loop() {

}

//这两个函数是arduino固定的，可以理解为代码运行的入口，每次开机都从setup开始运行
```

串口通信代码
```Python
//引入头文件
#include <Arduino.h>

uint8_t temp_data;

void setup() {
  Serial.begin(9600);
  // Serial.begin(115200);
  Serial.print("setup\n");
}

void loop() {
  delay(1000);
  Serial.print("loop\n");
  //判断串口是否可用
  while(Serial.available()) {
    //读取接收到的数据
    temp_data = Serial.read();
    if(temp_data == '$') {
      Serial.printf("get data %d\n",temp_data);
    }
  }
}

/*
如果设置Serial.begin(115200);
则需要在platformio.ini中添加
[env:esp32dev]
platform = espressif32
board = esp32dev
framework = arduino
monitor_speed = 115200
*/

//可以尝试，使用电脑控制LED灯
```

