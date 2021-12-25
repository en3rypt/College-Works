#include <iostream>
#include <string>
#include "../Headers/soldier.hpp"
using namespace std;
Soldier::Soldier(string name) : Player(name)
{
    setName(name);
    setHitPoints(200);
    setMagicPoints(100);
    setATK(20);
    setRace(0);
}