#ifndef __SOLDIER_H__
#define __SOLDIER_H__
#include <string>
#include "../Headers/player.hpp"
class Soldier : public Player
{
    public:
        Soldier(std::string name);
};

#endif // __SOLDIER_H__