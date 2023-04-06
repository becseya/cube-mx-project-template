#include "app.hpp"

#include <main.h>

extern "C" void app_init() {}

extern "C" void app_loop() {
  LL_GPIO_TogglePin(GPIOA, 1 << 5);
  LL_mDelay(500);
}
