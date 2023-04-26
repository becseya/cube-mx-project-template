#include "blinky.hpp"

#include <main.h>

static constexpr int DELAY_MS_SPIKE = 10;
static constexpr int DELAY_MS_FAST  = 100;
static constexpr int DELAY_MS_SLOW  = 500;

Blinky::Blinky(Mode mode, toggle_callback_t toggle)
    : state(State::Fast)
    , mode(mode)
    , toggle(toggle)
//
{}

void Blinky::update() {

    toggle();

    if (mode == Mode::Pulse) {
        LL_mDelay(DELAY_MS_SPIKE);
        toggle();
    }

    int delay = getDelay();

    if (mode == Mode::Pulse) {
        delay -= DELAY_MS_SPIKE;
    }

    LL_mDelay(delay);
}

void Blinky::switchState() {
    if (state == State::Fast)
        state = State::Slow;
    else
        state = State::Fast;
}

int Blinky::getDelay() {
    if (state == State::Fast)
        return DELAY_MS_FAST;
    else
        return DELAY_MS_SLOW;
}
