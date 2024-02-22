---
abbrlink: 10
---
# 用途
用于差错检验，检查收到的数据是否误码
# 基本思想
- 收发双方基于事先约定的生成多项式G(x)。
- 发送方通过G(x)对待发送数据进行处理，得到差错校验码。
- 接受方在接收到数据后通过G(x)对接收数据进行处理，从而判断发送过程是否产生误码。 
- 其本质是选取合适除数，要进行校验的数据是被除数，然后做模2除法，得到的余数就是CRC校验值。

# 手工计算
## 手工计算
![](嵌入式/温控器代码阅读笔记/assets/CRC校验.assets/image-20231220163606439.png)

![](嵌入式/温控器代码阅读笔记/assets/CRC校验.assets/image-20231220163652748.png)
![](嵌入式/温控器代码阅读笔记/assets/CRC校验.assets/image-20231220163959925.png)


![](嵌入式/温控器代码阅读笔记/assets/CRC校验.assets/image-20231220163929443.png)



**

## 举例说明

# 编程实现
## 思路
## 代码

```
u16 Caculate_CRC16(u8 *DAT,u8 len)//crc校验
{
		u16 CRC = 0xFFFF;
		u8 i,j;
		for(i=0;i<len;i++)
	  {
				CRC = CRC^DAT[i];
				for(j=0;j<8;j++)
			  {
						if(CRC&0x01)
					  {
								CRC = CRC>>1;
								CRC = CRC^0xA001;
						}
						else
					  {
								CRC = CRC>>1;
						}
				}
		}
		return CRC;
}

//在MODBUS_RTU中，如果计算结果是7F38，发送时是发送0x38,0x7F

```

背景：
应用：检错能力√
流程图：
联系：
