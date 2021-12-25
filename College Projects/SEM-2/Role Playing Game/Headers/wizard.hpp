#ifndef __WIZARD_H__
#define __WIZARD_H__
#include <string>
#include "../Headers/player.hpp"
class Wizard : public Player
{
    public:
        Wizard(std::string name);
};

#endif // __WIZARD_H__