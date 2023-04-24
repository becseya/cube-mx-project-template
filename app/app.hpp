#pragma once

#ifdef __cplusplus

extern "C" void app_init();
extern "C" void app_loop();

#else

extern void app_init();
extern void app_loop();

#endif
