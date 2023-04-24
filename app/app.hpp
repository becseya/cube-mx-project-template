#pragma once

#ifdef __cplusplus
    #define APP_EXTERN extern "C"
#else
    #define APP_EXTERN extern
#endif

APP_EXTERN void app_init();
APP_EXTERN void app_loop();
APP_EXTERN void irq_timer_1();
