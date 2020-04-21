#include "stm32f4xx.h"
#include "stm32f4xx_rcc.h"
#include "stm32f4xx_gpio.h"
#include "stm32f4xx_usart.h"
#include "stm32f4xx_flash.h"
/*******************************************************************/
// Функция main()

int main()
{
    //Port clock enable
    RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOA, ENABLE);
    RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOB, ENABLE);
    RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOC, ENABLE);
    RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOD, ENABLE);
    // UART periph enable
    RCC_APB1PeriphClockCmd(RCC_APB1Periph_UART4, ENABLE);

    RCC->CR |= RCC_CR_HSEON;// Use out oscillator 
    

    GPIO_InitTypeDef gpio;




    GPIO_StructInit(&gpio);
    gpio.GPIO_Mode = GPIO_Mode_OUT;
    gpio.GPIO_Pin = GPIO_Pin_13;
    gpio.GPIO_Speed = GPIO_Speed_100MHz;
    gpio.GPIO_OType = GPIO_OType_PP;
    gpio.GPIO_PuPd = GPIO_PuPd_NOPULL;
    GPIO_Init(GPIOD, &gpio);
    /*
        Configure PORTC 10,11 as UART4
    */
    GPIO_StructInit(&gpio);
    gpio.GPIO_Mode = GPIO_Mode_AF;
    gpio.GPIO_Pin = GPIO_Pin_11;
    gpio.GPIO_Speed = GPIO_Speed_50MHz;
    gpio.GPIO_OType = GPIO_OType_PP;
    gpio.GPIO_PuPd = GPIO_PuPd_UP;
    GPIO_Init(GPIOC, &gpio);

    GPIO_StructInit(&gpio);
    gpio.GPIO_Mode = GPIO_Mode_AF;
    gpio.GPIO_Pin = GPIO_Pin_10;
    gpio.GPIO_Speed = GPIO_Speed_100MHz;
    gpio.GPIO_OType = GPIO_OType_PP;
    gpio.GPIO_PuPd = GPIO_PuPd_UP;
    GPIO_PinAFConfig(GPIOC, GPIO_PinSource10, GPIO_AF_UART4);
    GPIO_Init(GPIOC, &gpio);
    
    GPIO_PinAFConfig(GPIOC, GPIO_PinSource11, GPIO_AF_UART4);

    /*
        Use default UART configuration
    */
    USART_InitTypeDef uart;
    USART_StructInit(&uart);
    USART_Init(UART4, &uart);

    USART_Cmd(UART4, ENABLE);
    
    
    while(1){
        UART4->DR = 'A';
        while(!(UART4->SR & USART_SR_TXE));
        GPIO_ToggleBits(GPIOD, GPIO_Pin_13);
        //No binding to CPU freq
        for(int i = 0; i < 100000; i++)
            __NOP();
    }
    return 0;
}
 
 
 
 
