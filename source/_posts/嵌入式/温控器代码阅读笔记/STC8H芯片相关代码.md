---
abbrlink: 17
---
```
参考例程包：https://www.stcaimcu.com/forum.php?mod=viewthread&tid=1525
```
# ADC
```
//代码来自STC8H8K64U为主控芯片的实验箱8
//ADC需做操作：AD口设置为输入口，浮空输入。配置初始化。使用ADC
#include	"config.h"
#include	"STC8G_H_ADC.h"
#include	"STC8G_H_GPIO.h"
void	GPIO_config(void)
{
	GPIO_InitTypeDef	GPIO_InitStructure;		//结构定义

	GPIO_InitStructure.Pin  = GPIO_Pin_0 ;		//指定要初始化的IO, GPIO_Pin_0 ~ GPIO_Pin_7
	GPIO_InitStructure.Mode = GPIO_HighZ;	//指定IO的输入或输出方式,GPIO_PullUp,GPIO_HighZ,GPIO_OUT_OD,GPIO_OUT_PP
	GPIO_Inilize(GPIO_P0,&GPIO_InitStructure);	//初始化
}

/******************* AD配置函数 *******************/
void	ADC_config(void)
{
	ADC_InitTypeDef		ADC_InitStructure;		//结构定义

	ADC_InitStructure.ADC_SMPduty   = 31;		//ADC 模拟信号采样时间控制, 0~31（注意： SMPDUTY 一定不能设置小于 10）
	ADC_InitStructure.ADC_CsSetup   = 0;		//ADC 通道选择时间控制 0(默认),1
	ADC_InitStructure.ADC_CsHold    = 1;		//ADC 通道选择保持时间控制 0,1(默认),2,3
	ADC_InitStructure.ADC_Speed     = ADC_SPEED_2X16T;		//设置 ADC 工作时钟频率	ADC_SPEED_2X1T~ADC_SPEED_2X16T
	ADC_InitStructure.ADC_AdjResult = ADC_RIGHT_JUSTIFIED;	//ADC结果调整,	ADC_LEFT_JUSTIFIED,ADC_RIGHT_JUSTIFIED
	ADC_Inilize(&ADC_InitStructure);		//初始化
	ADC_PowerControl(ENABLE);				//ADC电源开关, ENABLE或DISABLE
	//NVIC_ADC_Init(DISABLE,Priority_0);		//中断使能, ENABLE/DISABLE; 优先级(低到高) Priority_0,Priority_1,Priority_2,Priority_3
}

void main(void)
{
	GPIO_config();
	ADC_config();
	EA = 1;//开中断
	while (1)
	{
		Get_ADCResult(8);		//ADC有0-15这16个通道，这里读取的是P0.0对应的ADC8的AD值
	}
}

```
# EEPROM
```
//调用库函数就可以了，没有别的
#include	"config.h"
#include "STC8G_H_EEPROM.h"

void main(void)
{
	u8 dat[10]={0};
	
	EEPROM_read_n(0,dat,10);//将10个字节数据从首地址为0的EEPROM读出
	EEPROM_SectorErase(0);//擦除地址0对应的一个扇区（512字节）
	EEPROM_write_n(0,dat,10);//将10个字节数据写入首地址为0的EEPROM
	//还是改一下，擦除扇区和读写字节不协调。
	EA = 1;//开中断	
	while (1);
}
void EEPROM_ReadPage(u8 *dat,u8 addr,u8 len)
{
		EEPROM_read_n(addr,dat,len);
}

void EEPROM_ErasePage(u8 addr)
{
		EEPROM_SectorErase(addr);
}
void EEPROM_WritePage(u8 *dat,u8 addr,u8 len)
{
		EEPROM_write_n(addr,dat,len);
}
```


# GPIO
```
//初始化输入输出
#include	"config.h"
#include	"STC8G_H_GPIO.h"


void	GPIO_config(void)
{
	GPIO_InitTypeDef	GPIO_InitStructure;		//结构定义
	GPIO_InitStructure.Pin  = GPIO_Pin_0;		//指定要初始化的IO,
	GPIO_InitStructure.Mode = GPIO_PullUp;		//指定IO的输入或输出方式,GPIO_PullUp,GPIO_HighZ,GPIO_OUT_OD,GPIO_OUT_PP
	GPIO_Inilize(GPIO_P4,&GPIO_InitStructure);	//初始化
}

/******************** 主函数 **************************/
void main(void)
{

	GPIO_config();
	P40 = 0;		//小灯灭
	P40 = 1;		//小灯亮
	EA = 1;//开中断	
	while(1);
}




```
# 定时器
```
//初始化定时器，按需要修改定时器中断函数
#include	"config.h"
#include	"STC8G_H_Timer.h"

void	Timer_config(void)
{
	TIM_InitTypeDef		TIM_InitStructure;						//结构定义

	//定时器0做16位自动重装, 中断频率为100000HZ，中断函数从P6.7取反输出50KHZ方波信号.
	TIM_InitStructure.TIM_Mode      = TIM_16BitAutoReload;	//指定工作模式,   TIM_16BitAutoReload,TIM_16Bit,TIM_8BitAutoReload,TIM_16BitAutoReloadNoMask
	TIM_InitStructure.TIM_ClkSource = TIM_CLOCK_1T;		//指定时钟源,     TIM_CLOCK_1T,TIM_CLOCK_12T,TIM_CLOCK_Ext
	TIM_InitStructure.TIM_ClkOut    = DISABLE;				//是否输出高速脉冲, ENABLE或DISABLE
	TIM_InitStructure.TIM_Value     = 65536UL - (MAIN_Fosc / 100000UL);		//初值,
	TIM_InitStructure.TIM_Run       = ENABLE;				//是否初始化后启动定时器, ENABLE或DISABLE
	Timer_Inilize(Timer0,&TIM_InitStructure);				//初始化Timer0	  Timer0,Timer1,Timer2,Timer3,Timer4
	//NVIC_Timer0_Init(ENABLE,Priority_0);		//中断使能, ENABLE/DISABLE; 优先级(低到高) Priority_0,Priority_1,Priority_2,Priority_3

}

void main(void)
{
	Timer_config();
	while (1);
}

void timer0_int (void) interrupt TIMER0_VECTOR //中断处理函数
{
	//省略
}


```
# UART通信
```
//初始化串口，使用。需要的话，初始化输入输出，修改串口函数。
#include	"config.h"
#include	"STC8G_H_UART.h"




/***************  串口初始化函数 *****************/
void	UART_config(void)
{
	COMx_InitDefine		COMx_InitStructure;					//结构定义

	COMx_InitStructure.UART_Mode      = UART_8bit_BRTx;		//模式,   UART_ShiftRight,UART_8bit_BRTx,UART_9bit,UART_9bit_BRTx
//	COMx_InitStructure.UART_BRT_Use   = BRT_Timer2;			//选择波特率发生器, BRT_Timer2 (注意: 串口2固定使用BRT_Timer2, 所以不用选择)
	COMx_InitStructure.UART_BaudRate  = 115200ul;			//波特率,     110 ~ 115200
	COMx_InitStructure.UART_RxEnable  = ENABLE;				//接收允许,   ENABLE或DISABLE
	UART_Configuration(UART2, &COMx_InitStructure);		//初始化串口2 USART1,USART2,USART3,USART4
	//NVIC_UART2_Init(ENABLE,Priority_1);		//中断使能, ENABLE/DISABLE; 优先级(低到高) Priority_0,Priority_1,Priority_2,Priority_3
	//UART2_SW(UART2_SW_P46_P47);		//UART2_SW_P10_P11,UART2_SW_P46_P47
}

/**********************************************/
void main(void)
{
	u8	i;
	u16	j;
	UART_config();
	//如果使用RS485通信，只需将对应485芯片使能端使能，发送端使能是发送，接收端使能是接收，其余和uart通信无区别
	//举例：这里是用的stm8中的部分代码举例
	//#define   RS485_TxMode()          PD_ODR_bit.ODR7 = 1  
	//#define   RS485_RxMode()          PD_ODR_bit.ODR7 = 0
	//一般485芯片发送接收端接在一起的，一个是高电平使能，一个是低电平使能，所以485使能是这样的。
	//也见过一种接法，接收端与485芯片的RO相连，发送端与RI相连，并且发送端通过上拉电阻与三极管与使能端连在一起，这样就不必使能
	while (1)
	{
		TX2_write2buff(RX1_Buffer[0]);//将接收的数据发送回去
	}
}

"""
TX2_write2buff，是将放入发送缓冲区

这是库函数中串口的发送部分,放入缓冲区后，用串口中断函数接收，发送。只摘取了关键部分代码
void TX2_write2buff(u8 dat)	//串口2发送函数
{
}

void UART2_int (void) interrupt UART2_VECTOR
{
	if(RI2)
	{
		RI2 = 0;
		RX2_Buffer[COM2.RX_Cnt++] = S2BUF;
	}

	if(TI2)
	{
		TI2 = 0;
		S2BUF = TX2_Buffer[COM2.TX_read];
	}

}
"""
```
# 看门狗

```
#include	"STC8G_H_WDT.h"

void	WDT_config(void)
{
	WDT_InitTypeDef	WDT_InitStructure;					//结构定义

	WDT_InitStructure.WDT_Enable     = ENABLE;					//中断使能   ENABLE或DISABLE
	WDT_InitStructure.WDT_IDLE_Mode  = WDT_IDLE_STOP;		//IDLE模式是否停止计数		WDT_IDLE_STOP,WDT_IDLE_RUN
	WDT_InitStructure.WDT_PS         = WDT_SCALE_16;		//看门狗定时器时钟分频系数		WDT_SCALE_2,WDT_SCALE_4,WDT_SCALE_8,WDT_SCALE_16,WDT_SCALE_32,WDT_SCALE_64,WDT_SCALE_128,WDT_SCALE_256
	WDT_Inilize(&WDT_InitStructure);					//初始化
}

void main(void)
{
	//代码启动
	
	WDT_config();

	while(1)
	{
		WDT_Clear();   //喂狗。给定时间内（由时钟频率和分频系数决定)不喂狗, 将复位,
	}
}


```



