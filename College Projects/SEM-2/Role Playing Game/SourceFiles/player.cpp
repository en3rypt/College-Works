#include <iostream>
#include <string>
#include "../Headers/player.hpp"
using namespace std;
Player::Player(string name)
{
    this->name = name;
    setHitPoints(0);
    setMagicPoints(0);
    setCreds(5000);
    setExperiencePoints(0);
}
void Player::setName(string name)
{
    this->name = name;
}

void Player::setHitPoints(float hitPoints)
{
    this->hitPoints = hitPoints;
}

void Player::setMagicPoints(float magicPoints)
{
    this->magicPoints = magicPoints;
}

void Player::setCreds(int creds)
{
    this->creds = creds;
}

string Player::getName() const
{
    return name;
}

float Player::getHitPoints() const
{
    return hitPoints;
}

float Player::getMagicPoints() const
{
    return magicPoints;
}

int Player::getCreds() const
{
    return creds;
}

void Player::printAttributes() const
{
    cout<<name<<"'s attributes:"<<endl;
    cout<<"Character is a :"<<whatRace()<<endl;
    cout<<"HP:"<<getHitPoints()<<endl;
    cout<<"MP:"<<getMagicPoints()<<endl;
    cout<<"Creds:"<<getCreds()<<endl;
    cout<<"Attack Points (ATK):"<<getATK()<<endl;
    cout<<endl<<endl<<endl;
}

int Player::getATK() const
{
    return ATK;
}

void Player::setATK(int ATK)
{
    this->ATK = ATK;
}

void Player::setRace(int race)
{
    if(race==0)
    {
        this->race = soldier;
    }
    else if(race==1)
    {
        this->race = wizard;
    }
}

Race Player::getRace() const
{
    return race;
}

string Player::whatRace() const
{
    if(getRace() == 0)
    {
        return "Soldier";
    }
    else
    {
        return "Wizard";
    }
}

void Player::setExperiencePoints(int experiencePoints)
{
    this->experiencePoints = experiencePoints;
}

int Player::getExperiencePoints() const
{
    return experiencePoints;
}