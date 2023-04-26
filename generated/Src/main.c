
/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#ifdef ENABLE_APP_OVERLAY
#include <app.hpp>
#endif
/* USER CODE END Includes */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{
  /* Infinite loop */
  /* USER CODE BEGIN WHILE */

#ifdef ENABLE_APP_OVERLAY
  app_init();
#endif

  while (1)
  {
#ifdef ENABLE_APP_OVERLAY
    app_loop();
#endif

    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */
  }
  /* USER CODE END 3 */
}
