#include <iostream>
#include <string>
#include "../Headers/wizard.hpp"
using namespace std;
Wizard::Wizard(string name) : Player(name)
{
    setName(name);
    setHitPoints(100);
    setMagicPoints(200);
    setATK(10);
    setRace(1);
}