#ifndef __PLAYER_H__
#define __PLAYER_H__
#include <string>

enum Race {soldier,wizard};

class Player
{
    private:
        std::string name;
        float hitPoints;
        float magicPoints;
        int creds;
        int ATK;
        Race race;
        int experiencePoints;

    public:
        Player(std::string name);
        void setName(std::string name);
        void setHitPoints(float hitPoints);
        void setMagicPoints(float magicPoints);
        void setCreds(int creds);
        std::string getName() const;
        float getHitPoints() const;
        float getMagicPoints() const;
        int getCreds() const;
        void printAttributes() const;
        int getATK() const;
        void setATK(int);
        void setRace(int);
        Race getRace() const;
        std::string whatRace() const;
        void setExperiencePoints(int);
        int getExperiencePoints() const;
};

#endif // __PLAYER_H__
