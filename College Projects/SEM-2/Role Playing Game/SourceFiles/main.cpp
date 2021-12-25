#include <string>
#include <iostream>
#include <fstream>
#include <ctime>
#include "../Headers/soldier.hpp"
#include "../Headers/wizard.hpp"
using namespace std;

void attack(Player*,Player*);
bool checkLoss(Player*);
Player* makeAccount(string,int);
Player* getWinner(Player*,Player*);
void resetStats(Player*);

int main()
{
    string tempName1, tempName2;
    int charType;
    Player *p1; 
    Player *p2;
    char yn;
    time_t now = time(0);
    string timeNow = ctime(&now);

    ofstream logFile("../Log/log.txt",ios_base::app);
    logFile << endl << endl <<"Game started at "<< timeNow << endl;
    float tempF;
    while(1)
    {
        cout<<"Welcome to THEBESTGAME"<<endl;
        cout<<"Do you,player 1, already have an account? y/n";
        cin>>yn;
        cin.get();
        if(yn == 'y')
        {
            int f = 0;
            string accName;
            string fileName;
            ifstream accFile;
            int chT;
            cout<<"Enter your account name: ";
            getline(cin, accName);
            fileName = "../Saves/" + accName + ".txt";
            p1 = makeAccount(accName,1);
            accFile.open(fileName);
            if(!accFile)
            {
                cout<<"Account not found.Going back to main screen..."<<endl;
                accFile.close();
                continue;
            }
            else
            {
                accFile>>tempF;
                p1->setHitPoints(tempF);
                accFile>>tempF;
                p1->setMagicPoints(tempF);
                accFile>>tempF;
                p1->setCreds(tempF);
                accFile>>tempF;
                p1->setATK(tempF);
                accFile>>tempF;
                p1->setRace(tempF);
                accFile>>tempF;
                p1->setExperiencePoints(tempF);
                cout<<"Player 1 data imported successfully."<<endl;
                accFile.close();
                logFile<<"["<< p1->getName() << "] data imported successfully."<<endl;
                break;
            }
        }
        else if(yn == 'n')
        {
            string accName;
            string fileName;
            int chT;
            cout<<"Enter a name to make a new account: ";
            getline(cin,accName);
            cout<<"Enter the type of the character:\n 1 - Soldier\n 2 - Wizard\n";
            cin>>chT;
            cin.get();

            p1 = makeAccount(accName,chT);
            fileName = "../Saves/" + accName + ".txt";
            ofstream acF(fileName);
            acF<<p1->getHitPoints()<<endl;
            acF<<p1->getMagicPoints()<<endl;
            acF<<p1->getCreds()<<endl;
            acF<<p1->getATK()<<endl;
            acF<<p1->getRace()<<endl;
            acF<<p1->getExperiencePoints()<<endl;

            acF.close();
            cout<<"Player 1 account created."<<endl;
            logFile<<"["<< p1->getName() << "] created successfully."<<endl;
            break;
        }
        else
        {
            cout<<"Invalid choice.Going back to menu..."<<endl;
            continue;
        }
    }
    
    while(1)
    {
        cout << "Does player 2 have an account?";
        cin>>yn;
        cin.get();
        if(yn == 'y')
        {
            int f = 0;
            string accName;
            string fileName;
            ifstream accFile;
            int chT;
            cout<<"Enter your account name: ";
            getline(cin, accName);
            cin.get();
            p2 = makeAccount(accName,1);
            fileName = "../Saves/" + accName + ".txt";
            accFile.open(fileName);
            if(!accFile)
            {
                cout<<"Account not found. Going back to menu..."<<endl;
                accFile.close();
                continue;
            }
            else
            {
                accFile>>tempF;
                p2->setHitPoints(tempF);
                accFile>>tempF;
                p2->setMagicPoints(tempF);
                accFile>>tempF;
                p2->setCreds(tempF);
                accFile>>tempF;
                p2->setATK(tempF);
                accFile>>tempF;
                p2->setRace(tempF);
                accFile>>tempF;
                p2->setExperiencePoints(tempF);
                cout<<"Player 2 data imported successfully."<<endl;
                logFile<<"["<< p2->getName() << "] imported successfully."<<endl;
                accFile.close();
                break;
            }
        }
        else if(yn == 'n')
        {
            string accName;
            string fileName;
            int chT;
            cout<<"Enter a name to make a new account: ";
            getline(cin,accName);
            cout<<"Enter the type of the character:\n 1 - Soldier\n 2 - Wizard\n";
            cin>>chT;

            p2 = makeAccount(accName,chT);
            fileName = "../Saves/" + accName + ".txt";
            ofstream acF(fileName);
            acF<<p2->getHitPoints()<<endl;
            acF<<p2->getMagicPoints()<<endl;
            acF<<p2->getCreds()<<endl;
            acF<<p2->getATK()<<endl;
            acF<<p2->getRace()<<endl;
            acF<<p2->getExperiencePoints()<<endl;
            cout<<"Player 2 created successfully"<<endl;
            logFile<<"["<< p2->getName() << "] created successfully."<<endl;
            acF.close();
            break;
        }
        else
        {
            cout<<"Invalid choice. Going back to menu..."<<endl;
            continue;
        }
    }
    
    cout<<p1->getName()<<" gets to attack first because they initiated the battle."<<endl;
    logFile<<"["<< p1->getName() << "] initiated the battle against ["<< p2->getName() <<"]."<<endl;
    bool turn = 0;
    cout<<"==================================================="<<endl;
        
    cout<<p1->getName()<<" is a "<<p1->whatRace()<<endl;
    cout<<p1->getName()<<"'s HP :"<<p1->getHitPoints()<<endl;
    cout<<p1->getName()<<"'s MP :"<<p1->getMagicPoints()<<endl;
    cout<<p1->getName()<<"'s ATK :"<<p1->getATK()<<endl;
    
    cout<<endl;

    cout<<p2->getName()<<" is a "<<p2->whatRace()<<endl;
    cout<<p2->getName()<<"'s HP :"<<p2->getHitPoints()<<endl;
    cout<<p2->getName()<<"'s MP :"<<p2->getMagicPoints()<<endl;
    cout<<p2->getName()<<"'s ATK :"<<p2->getATK()<<endl;
    
    cout<<"==================================================="<<endl;
    while(!(checkLoss(p1) || checkLoss(p2)))
    {
        if(turn == 0)
        {
            cout<< p1->getName() << "'s turn :" << endl;
            logFile<<"["<< p1->getName() << "] 's turn ..."<<endl;
            while(1)
            {
                int choice;
                cout<<"Enter your move :"<<endl;
                cout<<"1 - Attack"<<endl;
                cout<<"2 - Use Spell"<<endl;
                cout<<"3 - Surrender"<<endl;
                cin>>choice;
                if(choice == 1)
                {
                    logFile<<"["<< p1->getName() << "] 's attacked."<<endl;
                    attack(p1,p2);
                    break;
                }
                else if(choice == 2 && p1->getMagicPoints() < 1)
                {
                    cout<<"Out of magic points."<<endl;
                    continue;
                }
                else if(choice == 2 && p1->getMagicPoints() > 0)
                {
                    int innerChoice;
                    cout<<"Enter a spell to use :"<<endl;
                    cout<<"1 - Heal ( +50 HP and -50 MP)"<<endl;
                    cout<<"2 - PowerUp ( +10 ATK and - 50 MP)"<<endl;
                    cout<<"0 - Go back"<<endl;
                    cin>>innerChoice;
                    if(innerChoice == 1)
                    {
                        int newHitPoints = p1->getHitPoints() + 50;
                        p1->setHitPoints(newHitPoints);
                        p1->setMagicPoints(p1->getMagicPoints() - 50);
                        logFile<<"["<< p1->getName() << "] 's heal."<<endl;
                    }
                    else if(innerChoice == 2)
                    {
                        int newATKPoints = p1->getATK() + 10;
                        p1->setATK(newATKPoints);
                        p1->setMagicPoints(p1->getMagicPoints() - 50);
                        logFile<<"["<< p1->getName() << "] 's powered up."<<endl;
                    }
                    else if(innerChoice == 0)
                    {
                        continue;
                    }
                    else
                    {
                        cout<<"Invalid choice. Going back..."<<endl;
                        continue;
                    }
                }
                else if(choice == 3)
                {
                    if(p1->getCreds()>=2500)
                    {
                        p1->setCreds(p1->getCreds() - 2500);
                        p1->setHitPoints(0);
                        logFile<<"["<< p1->getName() << "] 's surrendered. "<<endl;
                        break;
                    }
                    else
                    {
                        cout<<"Surrendering costs 2500 Creds which you don't have. So keep fighting."<<endl;
                    }
                }
                else
                {
                    cout<<"Invalid choice."<<endl;
                    cout<<"Going  back..."<<endl;
                    continue;
                }
            }
        }
        else
        {
            cout<< p2->getName() << "'s turn :" << endl;
            logFile<<"["<< p2->getName() << "] 's turn ..."<<endl;
            while(1)
            {
                int choice;
                cout<<"Enter your move :"<<endl;
                cout<<"1 - Attack"<<endl;
                cout<<"2 - Use Spell"<<endl;
                cout<<"3 - Surrender"<<endl;
                cin>>choice;
                if(choice == 1)
                {
                    attack(p2,p1);
                    logFile<<"["<< p2->getName() << "] 's attacked."<<endl;
                }
                else if(choice == 2 && p2->getMagicPoints() < 1)
                {
                    cout<<"Out of magic points."<<endl;
                    continue;
                }
                else if(choice == 2 && p2->getMagicPoints() > 0)
                {
                    int innerChoice;
                    cout<<"Enter a spell to use :"<<endl;
                    cout<<"1 - Heal ( +50 HP and -50 MP)"<<endl;
                    cout<<"2 - PowerUp ( +10 ATK and - 50 MP)"<<endl;
                    cout<<"0 - Go back"<<endl;
                    cin>>innerChoice;
                    if(innerChoice == 1)
                    {
                        int newHitPoints = p2->getHitPoints() + 50;
                        p2->setHitPoints(newHitPoints);
                        p2->setMagicPoints(p2->getMagicPoints() - 50);
                        logFile<<"["<< p2->getName() << "] 's healed."<<endl;
                    }
                    else if(innerChoice == 2)
                    {
                        int newATKPoints = p2->getATK() + 10;
                        p2->setATK(newATKPoints);
                        p2->setMagicPoints(p2->getMagicPoints() - 50);
                        logFile<<"["<< p2->getName() << "] 's powered up."<<endl;
                    }
                    else if(innerChoice == 0)
                    {
                        continue;
                    }
                    else
                    {
                        cout<<"Invalid choice. Going back..."<<endl;
                        continue;
                    }
                }
                else if(choice == 3)
                {
                    if(p2->getCreds()>=2500)
                    {
                        p2->setCreds(p2->getCreds() - 2500);
                        p2->setHitPoints(0);
                        logFile<<"["<< p2->getName() << "] 's surrendered."<<endl;
                        break;
                    }
                    else
                    {
                        cout<<"Surrendering costs 2500 Creds which you don't have. So keep fighting."<<endl;
                    }
                    
                }
                else
                {
                    cout<<"Invalid choice.Going back..."<<endl;
                    continue;
                }
            }
        }
        cout<<"==================================================="<<endl;
        
        cout<<p1->getName()<<" is a "<<p1->whatRace()<<endl;
        cout<<p1->getName()<<"'s HP :"<<p1->getHitPoints()<<endl;
        cout<<p1->getName()<<"'s MP :"<<p1->getMagicPoints()<<endl;
        cout<<p1->getName()<<"'s ATK :"<<p1->getATK()<<endl;
        cout<<endl;

        cout<<p2->getName()<<" is a "<<p2->whatRace()<<endl;
        cout<<p2->getName()<<"'s HP :"<<p2->getHitPoints()<<endl;
        cout<<p2->getName()<<"'s MP :"<<p2->getMagicPoints()<<endl;
        cout<<p2->getName()<<"'s ATK :"<<p2->getATK()<<endl;
        cout<<"==================================================="<<endl;        
        if(turn == 0)
        {
            int newXP = p1->getExperiencePoints() + p1->getATK()*10;
            p1->setExperiencePoints(newXP);
        }
        else
        {
            int newXP = p2->getExperiencePoints() + p2->getATK()*10;
            p2->setExperiencePoints(newXP); 
        }
        
        
        turn = !turn;
    }
    Player* winPtr = getWinner(p1,p2);
    cout<<"The winner of the battle is "<<winPtr->getName()<<endl;
    logFile<<"The winner of the battle is ["<<winPtr->getName()<<"]."<<endl;
    cout<<winPtr->getName()<<" is awarded with 5000 XP and 5000 Credits."<<endl;
    logFile<<"["<<winPtr->getName()<<"] is awarded with 5000 XP and 5000 Credits."<<endl;
    winPtr->setExperiencePoints(winPtr->getExperiencePoints() + 5000);
    winPtr->setCreds(winPtr->getCreds() + 5000);
    cout<<endl;
    winPtr->printAttributes();

    resetStats(p1);
    resetStats(p2);

    string finalName;
    finalName = "../Saves/" + winPtr->getName() + ".txt";
    ofstream finalSave;
    finalSave.open(finalName);
    
    finalSave<<p2->getHitPoints()<<endl;
    finalSave<<p2->getMagicPoints()<<endl;
    finalSave<<p2->getCreds()<<endl;
    finalSave<<p2->getATK()<<endl;
    finalSave<<p2->getRace()<<endl;
    finalSave<<p2->getExperiencePoints()<<endl;
    
    finalSave.close();
    logFile<<"Battle ended."<<endl;
    logFile.close();
    cout<<"Stats saved."<<endl;

    return 0;
}

void attack(Player* player1, Player* player2)
{
    int newHitPoints = player2->getHitPoints() - (player1->getATK() + (player1->getExperiencePoints()/1000));
    player2->setHitPoints(newHitPoints);
    player1->setExperiencePoints(player1->getExperiencePoints() + player1->getATK());
}

bool checkLoss(Player* player)
{
    if(player->getHitPoints() <= 0)
    {
        return true;
    }
    else
    {
        return false;
    }
}

Player* makeAccount(string name,int type)
{
    if(type == 1)
    {
        Player* tempPtr = new Soldier(name);
        return tempPtr;
    }
    else if(type == 2)
    {
        Player* tempPtr = new Wizard(name);
        return tempPtr;
    }
    else
    {
        cout<<"Invalid choice of character."<<endl;
        exit(1);
    }
    
}

Player* getWinner(Player* pl1,Player* pl2)
{
    if(pl1->getHitPoints() <= 0)
    {
        
        return pl2;
    }
    else
    {
        return pl1;
    }
    
}

void resetStats(Player* p)
{
    if(p->getRace() == soldier)
    {
        p->setHitPoints(200);
        p->setMagicPoints(100);
        p->setATK(20);
    }
    else
    {
        p->setHitPoints(100);
        p->setMagicPoints(200);
        p->setATK(10);
    }
}