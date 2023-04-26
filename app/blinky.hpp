#include <functional>

class Blinky
{
    typedef void (*toggle_callback_t)(void);

  public:
    enum class Mode
    {
        Pulse,
        HalfPeriod,
    };

    Blinky(Mode mode, toggle_callback_t toggle);
    void update();
    void switchState();

  private:
    enum class State
    {
        Fast,
        Slow,
    };

    int getDelay();

    State                   state;
    const Mode              mode;
    const toggle_callback_t toggle;
};
