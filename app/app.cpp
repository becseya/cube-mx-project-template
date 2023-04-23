#include "app.hpp"

#include <main.h>

extern "C" void app_init() {}

extern "C" void app_loop() {
  LL_GPIO_TogglePin(GPIOC, LL_GPIO_PIN_13);
  LL_mDelay(500);
}
