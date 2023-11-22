---
abbrlink: 4
tags:
  - 草稿
title: IIC
---
```
#include "iic.h"
#include "led.h"
#define write 0
#define read  1

#define	ADDRESS	0x7F

//IIC总线接口定义

void mDelayuS(unsigned char cnt)   
{   
	unsigned short int  i  ;
	for(i = 0;i<cnt;i++)
	{
		unsigned char  us = 2; 
		while (us--)//延1微秒
		{
				;   
		}
	}	 
  /*      while (cnt--)//延1微秒
        {           ;   
        }*/
}    
// 延时指定毫秒时间    
void mDelaymS( unsigned short int  ms)   
{   
    while ( ms -- ) {   
        mDelayuS( 250 );   
        mDelayuS( 250 );   
        mDelayuS( 250 );   
        mDelayuS( 250 ); 		
    }   
}


#define   IIC_TIME() mDelayuS(1)


unsigned char res_buf[4]={0};

#define SCL_PIN         GPIO_Pin_3
#define SDA_PIN         GPIO_Pin_4
       
       
#define SCL_GPIO        GPIOB
#define SDA_GPIO        GPIOB
      

#define SCL(a) if (a)  \
	GPIO_SetBits(SCL_GPIO, SCL_PIN);\
else  \
	GPIO_ResetBits(SCL_GPIO, SCL_PIN)
 

#define SDA(a) if (a)  \
	GPIO_SetBits(SDA_GPIO, SDA_PIN);\
else  \
	GPIO_ResetBits(SDA_GPIO, SDA_PIN)

#define SDA_OUT_MODE()\
{\
	GPIO_InitTypeDef GPIO_InitStructure;\
  GPIO_InitStructure.GPIO_Pin = SDA_PIN;\
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;\
  GPIO_InitStructure.GPIO_OType = GPIO_OType_OD;\
  GPIO_InitStructure.GPIO_Speed =GPIO_Speed_Level_3;\
  GPIO_Init(SDA_GPIO, &GPIO_InitStructure);	\
}

#define SDA_IN_MODE()\
{\
	GPIO_InitTypeDef GPIO_InitStructure;\
  GPIO_InitStructure.GPIO_Pin = SDA_PIN;\
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN;\
  GPIO_InitStructure.GPIO_OType = GPIO_OType_OD;\
  GPIO_InitStructure.GPIO_Speed =GPIO_Speed_Level_3;\
  GPIO_Init(SDA_GPIO, &GPIO_InitStructure);	\
}

#define SDA_READ() GPIO_ReadInputDataBit(SDA_GPIO,SDA_PIN)

void IIC_Init(void)
{
    GPIO_InitTypeDef GPIO_InitStructure;

    // Enable GPIO clock
    RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOB, ENABLE);

    // Configure CLK pin
    GPIO_InitStructure.GPIO_Pin = SCL_PIN;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
    GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
    GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(SCL_GPIO, &GPIO_InitStructure);

    // Configure DIN pin
    GPIO_InitStructure.GPIO_Pin = SDA_PIN;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
    GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
    GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(SDA_GPIO, &GPIO_InitStructure);
}	




/*******************************************************************
功能:启动I2C总线,即发送I2C起始条件.  
********************************************************************/
void IIC_Start(void)
{
	SDA_OUT_MODE();//初始化SDA为输出模式
  SDA(1);						//数据线拉高
  SCL(1);								 //时钟线拉高
	IIC_TIME();
  SDA(0);					 		//数据线拉低
	IIC_TIME();
	SCL(0);
	IIC_TIME();
}

/*******************************************************************
功能:结束I2C总线,即发送I2C结束条件.  
********************************************************************/
void IIC_Stop(void)
{
	
	SDA_OUT_MODE();	//初始化SDA为输出模式
	SCL(0);									//数据线拉低
	SDA(0);  						//时钟线拉低
	IIC_TIME();
	SCL(1);								//时钟线拉高
	IIC_TIME();
	SDA(1);							 //数据线拉高
	IIC_TIME();
}

/*******************************************************************
字节数据发送函数               
函数原型: void  SendByte(UCHAR c);
功能:将数据c发送出去,可以是地址,也可以是数据
********************************************************************/
void  IIC_WriteByte(u8 byte)
{
	
	SDA_OUT_MODE();
	SCL(0);
	IIC_TIME();
	for(u8 i=0;i<8;i++)//要传送的数据长度为8位
	{
		if(byte&0x80) //判断发送位
			SDA(1);
		else 
			SDA(0); 
		byte<<=1;
		IIC_TIME();
		SCL(1);
		IIC_TIME();
		SCL(0);
		IIC_TIME();
	}
}

/*******************************************************************
 字节数据接收函数               
函数原型: UCHAR  RcvByte();
功能: 用来接收从器件传来的数据  
********************************************************************/
u8 IIC_ReadByte(void)
{
	u8 byte=0; 
  SDA_IN_MODE();//置数据线为输入方式   
  IIC_TIME();	
  for(u8 i=0;i<8;i++)
	{
		SCL(0);//置时钟线为低，准备接收数据位     
    IIC_TIME();		
		SCL(1);//置时钟线为高使数据线上数据有效                
		byte=byte<<1;
		if(SDA_READ()) byte |=1;//读数据位,接收的数据位放入retc中 
		IIC_TIME();
	}
  
  SCL(0);    
  return byte;
}


 /*主机等待从机的ACK*/
//返 回 值：1表示失败，0表示成功
u8 IIC_wait_ACK(void)
{
	u8 t = 0;
	
	SDA_IN_MODE();//初始化SDA为输入模式
	SDA(1);					//数据线上拉
	IIC_TIME();
	SCL(0);						//时钟线拉低，告诉从机，主机需要数据
	IIC_TIME();
	SCL(1);						//时钟线拉高，告诉从机，主机现在开始读取数据
	while(SDA_READ())   //等待从机应答信号
	{
				t++;
				if(t>250)
				{
					IIC_Stop();
					return 1;
				}
	}
	SCL(0);     		  //时钟线拉低，告诉从机，主机需要数据
	return 0;	
}

 /*主机发送ACK*/
void IIC_ACK(void)
{
	SDA_OUT_MODE();
  SCL(0);
	IIC_TIME();
  SDA(0); 
  IIC_TIME();	
  SCL(1);
  IIC_TIME();	
  SCL(0);   
  IIC_TIME();	
}


 /*主机发送NACK*/
void IIC_NACK(void)
{
	SDA_OUT_MODE();
  SCL(0);
	IIC_TIME();
  SDA(1); 
  IIC_TIME();	
  SCL(1);  
  IIC_TIME();	
  SCL(0);  
  IIC_TIME();	
}


 /*转换设置*/
void Sensor_Set(void)
{
	IIC_Start();
	IIC_WriteByte(ADDRESS<<1 | write);//写7位I2C设备地址加0作为写取位,1为读取位
	IIC_wait_ACK();
	IIC_WriteByte(0x01);//写寄存器地址
	IIC_wait_ACK();
	IIC_WriteByte(0x01);//写寄存器值，设置测量参数，开始转换
	IIC_wait_ACK();
	IIC_Stop();
	mDelaymS(200);//等待转换
	
}

 /*读取转换结果数字量*/
void Sensor_Read_Res(void)
{
	IIC_Start();
	IIC_WriteByte(ADDRESS<<1 | write);//写7位I2C设备地址加0作为写取位,1为读取位
	IIC_wait_ACK();
	IIC_WriteByte(0x04);//写寄存器地址
	IIC_wait_ACK();
	
	IIC_Start();			//再次发送起始信号
	IIC_WriteByte(ADDRESS<<1 | read);//写7位I2C设备地址加0作为写取位,1为读取位
	//IIC_wait_ACK();
	if(IIC_wait_ACK()==0)
	{
		res_buf[0]=IIC_ReadByte();//读取湿度数字量低8位
		IIC_ACK();
		res_buf[1]=IIC_ReadByte();//读取湿度数字量高8位
		IIC_ACK();
		res_buf[2]=IIC_ReadByte();//读取温度数字量低8位
		IIC_ACK();
		res_buf[3]=IIC_ReadByte();//读取温度数字量高8位
		IIC_NACK();								//最后一个字节发送NOACK
		IIC_Stop();
	}	
	
}

unsigned int fun(){
	return ((256*res_buf[3]+res_buf[2]) - (1024-25/0.1) ) ;//100*(256*res_buf[1]+res_buf[0])/1024 ;//
}
//注意
//以上涉及的延迟函数需自行添加，并校准，若延迟不准，会导致IIC操作失效


//读取流程
//①配置IIC端口初始化：Sensor_Init();

//②配置传感器转换参数并启动转换：Sensor_Set();

//③读取转换结果数字量：Sensor_Read_Res();


//转换公式：
//湿度RH = 100*(256*res_buf[1]+res_buf[0])/1024    (0~100%RH)

//温度T = [ (256*res_buf[3]+res_buf[2]) - (1024-25/0.1) ] *0.1  (-30~100℃)
/*
int main(void)
{
	
	IIC_Init();
	Sensor_Read_Res();
	Sensor_Read_Res();
	while(1);
	
}
*/






```

```
int main(void)
{
	unsigned short int i = 0;
	unsigned short SYS_second_last = 0xff;

	RCC_Configuration();
//GPIO_PinRemapConfig(GPIO_Remap_SWJ_JTAGDisable ,DISABLE ); 
	MY_GPIO_Init();

  mDelaymS(1000);
   RCC_ClearFlag();
//    IWDG_Config();
				__IIC_SDA_SET();
			__IIC_SCL_SET();
 
    modCtlSettings.BaudRate = 2;
 
	IWDG_ReloadCounter();
	LOAD_DATA();
// 	Adc_Init();
	if(modCtlSettings.BaudRate < 5 )
	{
//			eStatus = eMBInit( MB_RTU, ucMBAddress, 0, Baudrate[modCtlSettings.BaudRate], MB_PAR_NONE );
			USART1_Configuration(modCtlSettings.BaudRate);
	}
	else
	{
	  	USART1_Configuration(2);
//			eStatus = eMBInit( MB_RTU, ucMBAddress, 0, 19200, MB_PAR_NONE );
			usRegHoldingBuf[iRegBaudRateIndex] = 2;
			modCtlSettings.BaudRate = 2;
	}
	TIM3_Configuration();
	TIM16_Configuration();
 	NVIC_IRQ_config();
	ssd1306_init();
	ssd1306_clear_screen(0x00);
	RS485_EN_REC;
 SYS_second = 250;
 
  
		IWDG_ReloadCounter();
//	 eStatus = eMBEnable(  );
 // HC595_EN;	
		LED_CTR_DATA = 0x00;
		W_LED_CTR_DATA = 0x00;
	modCtlSettings.fan_speed_old = 0xff;
	modCtlSettings.Disp_Parameter_old = 0xff;
//	modCtlSettings.Disp_Parameter = 0x01;
//	modCtlSettings.temp_max = 290;
//	modCtlSettings.temp_min = 150; 
mDelaymS(500); 
OLED_DROW_BIG_C_DIR(104,0);
	SetBrightness(1);
 	 ssd1306_refresh_gram();
   
		 	IWDG_ReloadCounter();
   TEMP_AD_DATA = 0;
	 	wendu_get = 250;
		ten_second_cn = 0;
 	 mDelaymS(500);
	 	IWDG_ReloadCounter();
// 	wendu_get = TMP75ReadTemprature();
 // 	modCtlSettings.Disp_Parameter = 1;
//		usRegHoldingBuf[iReg_Disp_Parameter] = 1;
Sensor_Init();
	while(1)
	{
		IWDG_ReloadCounter();
//    eMBPoll();
		
		if(Timer_1ms_F != CVV_base)
		{
			Timer_1ms_F = CVV_base;
			Timer_1ms_cn++;
	
			if(Timer_1ms_cn > 20)//20ms scan key_press data
			{
				Timer_1ms_cn = 0;
				key_data_pro();
 				LED_CTRL_OUT();
			 if(modCtlSettings.Disp_Parameter_old != modCtlSettings.Disp_Parameter) //if Show content changes
			 {
				 modCtlSettings.Disp_Parameter_old = modCtlSettings.Disp_Parameter;
				 if(modCtlSettings.Disp_Parameter == show_fan_mode)
				 {
						ssd1306_clear_screen(0x00);
					  ssd1306_refresh_gram();
				 }
				else
				{
					ssd1306_clear_screen(0x00);
				 if(modCtlSettings.temp_unit == 1)
						OLED_DROW_BIG_C_DIR(104,1);
				 else
						OLED_DROW_BIG_C_DIR(104,0);
				 ssd1306_refresh_gram();
				 modCtlSettings.fan_speed_old = 0xff;
				 ten_second_cn = 55;
				}
				Disp_data_buf_old[0] = Disp_data_buf_old[1] = Disp_data_buf_old[2] = 0xff;
			 }

				if(modCtlSettings.Disp_Parameter != show_fan_mode)/// Displays the current or setting temperature 
				{
					if(modCtlSettings.Disp_Parameter == show_Current_mode)
					{
						if(modCtlSettings.temp_unit == 1)
						{
						 U16_TEMP = modCtlSettings.Current_Temp *18+3200;
					 	 U16_TEMP = (U16_TEMP+5)/10;	
						}
						else U16_TEMP = modCtlSettings.Current_Temp;
					}
					else if(modCtlSettings.Disp_Parameter == set_temp_mode)
					{
						if(modCtlSettings.temp_unit == 1)
						{
						 U16_TEMP = modCtlSettings.Set_temp *18+3200;
							U16_TEMP = (U16_TEMP+5)/10;
						}
						else U16_TEMP = modCtlSettings.Set_temp;
					}
					else if(modCtlSettings.Disp_Parameter == show_display_mode)
					{
						if(modCtlSettings.temp_unit == 1)
						{
						 U16_TEMP = modCtlSettings.show_display *18+3200;
							U16_TEMP = (U16_TEMP+5)/10;
						}
						else U16_TEMP = modCtlSettings.show_display;
					}
					Disp_data_buf[0] = U16_TEMP/100%10;
					Disp_data_buf[1] = U16_TEMP/10%10;
					Disp_data_buf[2] = U16_TEMP%10;		
					i = 0;
					if(Disp_data_buf[0]!=Disp_data_buf_old[0])
					{
						OLED_DROW_BIG_NUM_DIR(0,Disp_data_buf[0]);
						Disp_data_buf_old[0] =Disp_data_buf[0];
						i = 1;
					}
					if(Disp_data_buf[1]!=Disp_data_buf_old[1])
					{
						OLED_DROW_BIG_NUM_DIR(32,Disp_data_buf[1]);
						
						Disp_data_buf_old[1] =Disp_data_buf[1];
						i = 1;
					}
					if(Disp_data_buf[2]!=Disp_data_buf_old[2])
					{
						OLED_DROW_BIG_NUM_DIR(72,Disp_data_buf[2]);
						Disp_data_buf_old[2] =Disp_data_buf[2];
						i = 1;
					}
					if(modCtlSettings.temp_unit_old !=modCtlSettings.temp_unit)
					{
						i = 1;
						modCtlSettings.temp_unit_old =modCtlSettings.temp_unit;
						if(modCtlSettings.temp_unit == 1)
							OLED_DROW_BIG_C_DIR(104,1);
					 else
							OLED_DROW_BIG_C_DIR(104,0);
				  }
				 
					if(i>0)	ssd1306_refresh_gram();
					modCtlSettings.fan_speed_old = 0xfa;
				}
				else   /// show fan speed
				{
					 if(modCtlSettings.fan_speed_old != Fan_speed_temp)
					 {
							modCtlSettings.fan_speed_old = Fan_speed_temp;
						 if((Fan_speed_temp > 0)&&(Fan_speed_temp < 255))
						 {
							 OLED_DROW_BIG_NUM_DIR(8,10);
							 OLED_DROW_BIG_NUM_DIR(36,10);
							 OLED_DROW_BIG_NUM_DIR(64,10);
							 OLED_DROW_BIG_NUM_DIR(92,10);
							 if(Fan_speed_temp <10)
							 {
								OLED_DROW_BIG_NUM_DIR(30,16); 
								OLED_DROW_BIG_NUM_DIR(75,Fan_speed_temp);
							 }
							 else
							 {
							   OLED_DROW_BIG_NUM_DIR(32,Fan_speed_temp/10);
								 OLED_DROW_BIG_NUM_DIR(72,Fan_speed_temp%10);
							 }
						 }
						 else if(Fan_speed_temp == 255)
						 {
							 OLED_DROW_BIG_NUM_DIR(8,11);
							 OLED_DROW_BIG_NUM_DIR(36,12);
							 OLED_DROW_BIG_NUM_DIR(64,13);
							 OLED_DROW_BIG_NUM_DIR(92,14);
						 }
						 else
						 {
							 Sensor_Set();
							 Sensor_Read_Res();
							 unsigned int i = fun();
							 unsigned char t1=i%10;
							unsigned char t2=i%100/10;
							 unsigned char t3=i%1000/100;
							 OLED_DROW_BIG_NUM_DIR(8,10); 
							 OLED_DROW_BIG_NUM_DIR(92,10);
							/*
							 OLED_DROW_BIG_NUM_DIR(22,14);
							 OLED_DROW_BIG_NUM_DIR(50,15);
							 OLED_DROW_BIG_NUM_DIR(78,15);
							 */
							 OLED_DROW_BIG_NUM_DIR(22,t3);
							 OLED_DROW_BIG_NUM_DIR(50,t2);
							 OLED_DROW_BIG_NUM_DIR(78,t1);
							 
						 }
						 ssd1306_refresh_gram();
					 }
				}

			}		
		}
		if(SYS_second!=SYS_second_last)//every one second enter
		{
			SYS_second_last = SYS_second;
			ten_second_cn++;
//			if(ten_second_cn > 59)////60s updata temperature on LCD
			{
//				TEMP_AD_DATA = 0;
				ten_second_cn = 0;
		
 //     U8_TEMP = 1;//TEMP_AD_DATA;				
//				wendu_get = TMP75ReadTemprature();
			//	if(wendu_get > 600)wendu_get = 250;
		/*		 
				for(i = 0;i<ADC_LEN;i++)
				TEMP_AD_DATA+=ADC_TEMP[i];
				TEMP_AD_DATA =  TEMP_AD_DATA/ADC_LEN;
			 
				for(U8_TEMP = 0;U8_TEMP<MAX_DATA_BUF;U8_TEMP++)
				{
					if(TEMP_AD_DATA  <= NTC_buf[U8_TEMP])
					{
						break;
					}
				}
				
				if((U8_TEMP < MAX_DATA_BUF)&&(U8_TEMP > 0))
				{
					U32_TEMP = (TEMP_AD_DATA - NTC_buf[U8_TEMP-1])*(Warm_buf[U8_TEMP] - Warm_buf[U8_TEMP-1]);//10
					TEMP_AD_DATA = U32_TEMP*10.0 /(NTC_buf[U8_TEMP] - NTC_buf[U8_TEMP-1]);//149
					wendu_get = TEMP_AD_DATA	+ Warm_buf[U8_TEMP-1]*10 - 200;//200;//192
				}
				else
				wendu_get = 255;
				TEMP_AD_DATA = 0;
 				*/
			}
		  usRegHoldingBuf[iReg_Current_Temp] = wendu_get;
			modCtlSettings.Current_Temp = usRegHoldingBuf[iReg_Current_Temp];

				CHEACK_BL();///cheack backlight
		}

      if(REC_DATA_FLAG == 1)//UART_REC
      {
        REC_DATA_FLAG = 0;
      }
      if(REP_TIMER_F > 0)
      {
				//CHEAK_USART_BUF();
        REP_TIMER_F = 0;
				if(Save_flag == 1)
				{
					SAVE_DATA();
					Save_flag = 0;
					if(cheack_bl_F == 1)
					{
					 cheack_bl_F = 0;
					if(usRegHoldingBuf[iReg_show_timeout]==0)
					{
						if(modCtlSettings.show_timeout > 0){CHEACK_BL();modCtlSettings.show_timeout = 0;}
					}
					else
					{
						if(modCtlSettings.show_timeout > 0)modCtlSettings.show_timeout= usRegHoldingBuf[iReg_show_timeout];
						else 
						{
							modCtlSettings.show_timeout= usRegHoldingBuf[iReg_show_timeout];
							CHEACK_BL();
						}
					}
					}
					
				}
      }
  }
}
```

```

```

