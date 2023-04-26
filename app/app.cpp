#include "app.hpp"

#include "blinky.hpp"

#include <main.h>

Blinky myBlinker(Blinky::Mode::HalfPeriod, []() -> void { //
    LL_GPIO_TogglePin(GPIOC, LL_GPIO_PIN_13);
});

extern "C" void app_init() {
    LL_TIM_EnableCounter(TIM1);
    LL_TIM_EnableIT_UPDATE(TIM1);
    LL_GPIO_SetOutputPin(GPIOC, LL_GPIO_PIN_13);
}

extern "C" void app_loop() {
    myBlinker.update();
}

extern "C" void irq_timer_1() {
    myBlinker.switchState();
    LL_TIM_ClearFlag_UPDATE(TIM1);
}
