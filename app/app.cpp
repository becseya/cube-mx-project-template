#include "app.hpp"

#include <main.h>

extern "C" void app_init() {
  LL_TIM_EnableCounter(TIM1);
  LL_TIM_EnableIT_UPDATE(TIM1);
}

#define DELAY_BLINK_SLOW 500
#define DELAY_BLINK_FAST 100

static int delay_length = DELAY_BLINK_FAST;

extern "C" void app_loop() {
  LL_GPIO_TogglePin(GPIOC, LL_GPIO_PIN_13);
  LL_mDelay(delay_length);
}

static void toggle_delay_length() {
  if (delay_length == DELAY_BLINK_FAST)
    delay_length = DELAY_BLINK_SLOW;
  else
    delay_length = DELAY_BLINK_FAST;
}

extern "C" void irq_timer_1() {
  toggle_delay_length();
  LL_TIM_ClearFlag_UPDATE(TIM1);
}
