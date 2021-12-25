#include <iostream>
#include <string>
#include <iomanip>
#include <fstream>
#include <vector>
#include "DoublyLL.cpp"
using namespace std;
struct node{
    string mName;
    int mCount;
};

int main()
{
    int choice;
    string movieName;
    Status movieStatus;
    int innerChoice;
    int movieRating;
    string movieRemarks;
    DoublyLL theList;
    vector<string> Ulist;
    vector<node> cList;
    int max=0;
    cout<<endl<<endl;

    string userName;
    cout<<"Hi!"<<endl;
    cout<<"Enter your name:";
    getline(cin,userName);

    ofstream outFile,userfiles ("../UserLists/Users.txt",std::ios_base::app);
    ifstream inFile,readfiles ("../UserLists/Users.txt"),tInFile;
    //read from users fils
    string user;
    while (getline (readfiles, user)) {
        if (user!=userName){
            Ulist.push_back(user);
        }
    }
    readfiles.close();


    inFile.open("../UserLists/" + userName + ".csv");
    if(!inFile)
    {
        cout<<"UserLists doesn't contain  your list, "<<userName<<"!"<<endl;
    }
    else
    {
        string mStat,mRat;
        int intStat;
        while(!inFile.eof())
        {
            getline(inFile,movieName,'|');
            getline(inFile,mStat,'|');
            getline(inFile,mRat,'|');
            getline(inFile,movieRemarks,'\n');
            intStat = stod(mStat);
            movieRating = stod(mRat);
            switch (intStat)
            {
            case 0:
                movieStatus = Watched;
                break;
            case 1:
                movieStatus = Watching;
                break;
            case 2:
                movieStatus = PlanningToWatch;
                break;
            default:
                break;
            }
            if(movieName != "")
                theList.createNode(movieName,movieStatus,movieRating,movieRemarks);
        }
        cout<<"UserList imported successfully."<<endl;
    }
    cout<<"Press any key to continue to menu..."<<endl;
    cin.get();
    cout<<"Continuing to menu..."<<endl;
    system("CLS");

    cout<<"Hello " + userName + "!"<<endl;
    cout<<"\nWelcome to your movie list, here you can organize and track your movie watching."<<endl;
    MENU : cout<<"What do you want to do ?"<<endl;
    cout<<"1. View your list of movies."<<endl;
    cout<<"2. View movies that you plan to watch."<<endl;
    cout<<"3. View movies that you are watching."<<endl;
    cout<<"4. View movies that you have watched."<<endl;
    cout<<"5. Add a movie to the list."<<endl;
    cout<<"6. Change a movie's data (Status/Rating/Remarks)."<<endl;
    cout<<"7. Delete a movie from the list."<<endl;
    cout<<"8. View trending movie"<<endl;
    cout<<"9. Export and exit the program."<<endl;
    cout<<"10. Exit the program without export."<<endl;
    cin>>choice;
    cin.get();
    system("CLS");

    switch(choice)
    {
        case 1:
            theList.displayMovieList();
            cout<<"\n\nPress any key to continue to MENU..."<<endl;
            cin.get();
            system("CLS");
            goto MENU;
        
        case 2:
            theList.displayPTWList();
            cout<<"\n\nPress any key to continue to MENU..."<<endl;
            cin.get();
            system("CLS");
            goto MENU;
        
        case 3:
            theList.displayWatchingList();
            cout<<"\n\nPress any key to continue to MENU..."<<endl;
            cin.get();
            system("CLS");
            goto MENU;
        
        case 4:
            theList.displayWatchedList();
            cout<<"\n\nPress any key to continue to MENU..."<<endl;
            cin.get();
            system("CLS");
            goto MENU;
        
        case 5:
            cout<<"Enter the name of the movie: ";
            getline(cin,movieName);
            movieStatus = PlanningToWatch;
            movieRating = 0;
            movieRemarks = " ";
            theList.createNode(movieName);
            cout<<"\n\nPress any key to continue to MENU..."<<endl;
            cin.get();
            system("CLS");
            goto MENU;
        
        case 6:
            cout<<"Enter the name of the movie to modify the data :";
            getline(cin,movieName);
            theList.modifyElement(movieName);
            cout<<"Changes have been made.(or changing was terminated due to invalid choices."<<endl;
            cout<<"\n\nPress any key to continue to MENU..."<<endl;
            cin.get();
            system("CLS");
            goto MENU;

        case 7:
            cout<<"Enter the name of the movie to delete.";
            getline(cin,movieName);
            theList.delElement(movieName);
            cout<<"\n\nPress any key to continue to MENU..."<<endl;
            cin.get();
            system("CLS");
            goto MENU;
        case 8:
            cList.clear();
            for(auto i: Ulist){
                tInFile.open("../UserLists/" + i + ".csv");
                while(!tInFile.eof())
                {
                    string tempName,trash,mStat;
                    int istatus;
                    Status status;
                    getline(tInFile,tempName,'|');
                    getline(tInFile,mStat,'|');
                    getline(tInFile,trash,'\n');
                
                    int flag = 1;
                    int index=0;
                    for(auto j: cList){
                        if (j.mName==tempName && mStat == "0"){
                            cList[index].mCount++;
                            flag=0;
                            break;
                        }
                        index++;
                    }if(flag && mStat == "0"){
                        cList.push_back(node());
                        cList[cList.size()-1].mName = tempName;
                        cList[cList.size()-1].mCount = 1;
                    }
                    
                }
                tInFile.close();

            }
            struct Node *q;
            q = start;
            while (q != NULL && q->mName != "")
            {   
                int flag = 1;
                int index=0;
                for(auto i: cList){
                    if (q->mName == i.mName && q->mStatus == Watched){
                        cList[index].mCount++;
                        flag = 0;
                        break;
                    }
                    index++;
                }if (flag && q->mStatus == Watched){
                    cList.push_back(node());
                    cList[cList.size()-1].mName = q->mName;
                    cList[cList.size()-1].mCount = 1;
                }
                q=q->next;
            }

            
            
            for (auto i: cList){
                if(i.mCount>max){
                    max = i.mCount;
                }
            }
            cout << "MOST POPULAR MOVIE(S) TILL DATE:" << endl;
            for(auto i: cList){
                if(i.mCount == max){
                    cout << i.mName << endl;
                }
            }
            
            cout<<"\n\nPress any key to continue to menu..."<<endl;
            cin.get();
            system("CLS");
            goto MENU;
        case 9:
            outFile.open("../UserLists/" + userName + ".csv");
            if(theList.count() > 0)
            {
                struct Node *q;
                q = start;
                while (q != NULL && q->mName != "")
                {
                    outFile<<q->mName<<"|"<<q->mStatus<<"|"<<q->mRating<<"|"<<q->mRemarks<<endl;
                    q = q->next;
                }
                 //reading from file
                readfiles.open("../UserLists/Users.txt");
                string user;
                Ulist.clear();
                while (getline (readfiles, user)) {
                    Ulist.push_back(user);
                }
                readfiles.close();

                //writing to file
                int flag = 1;
                for(auto i:Ulist){
                    if(i==userName){
                        flag = 0;
                        break;
                    }
                }if (flag){
                    
                    userfiles<<userName<<endl;
                }
                userfiles.close();
                cout<<"Export success!"<<endl;
                cout<<"Press any key to close the program..."<<endl;
                cin.get();
                system("CLS");
                break;
            }
        case 10:
            cout<<"Bye bye!"<<endl;
            break;
        default:
            cout<<"Invalid choice.\nGoing back to menu...";
            cout<<"Press any key to continue to menu..."<<endl;
            cin.get();
            system("CLS");
            goto MENU;
    }
    inFile.close();
    outFile.close();

    return 0; //return success
    exit(0); // close the terminal after success

}