#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include <limits>
#include <ctime>
#include <bits/stdc++.h>
#include <conio.h>

using namespace std;


//STRUCTURE DEFINITIONS
struct date{
    int day;
    int month;
    int year;
};


struct node{
    int empid;
    string name;
    string city;
    struct date dob;
    string gender;
    struct date doj;
    int salary;
    string dep;
};

struct City{
    string city;
    int Count;
};

struct year{
    int Year;
    int Count;
};

//ARRAY DEFINITIONS
string month_lower[13] = {"","jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec"};
string month_upper[13] = {"","JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
int md[] = { 31,28,31,30,31,30,31,31,30,31,30,31 };



//FUNCTION DEFINITIONS
void age(int pd, int pm, int py,int bd, int bm, int by)
{
  int d, m, y;

  y = py - by;
  if (pm < bm)
  {
    y--;
    m = 12 - (bm - pm);
  }
  else
  {m = pm - bm;}
  if (pd < bd)
  {
    m--;
    d = md[pm - 1] - (bd - pd);
  }
  else
  {d = pd - bd;}
  cout << y << " years " << m << " months " << d <<" days";
}


date str_to_int(string str){
    struct date temp;
    int day,year;
    string d = str.substr(0,2);
    string m = str.substr(3,3);
    string y = str.substr(7,2);
    for(int i=1;i<13;i++){
        if (m == month_lower[i] || m == month_upper[i]){
            temp.month = i;
        }
    }

    temp.day = stoi(d);
    temp.year = stoi(y);
    if (temp.year>10){
        temp.year+=1900;
    }else{
        temp.year+=2000;
    }
    return temp;
}

int check_str(string str, char c)
{

    for (int i=0;i<str.length();i++)
        if (str[i] == c)
            return 1;

    return 0;
}





int main(){

    time_t t = time(0);
    tm* now = localtime(&t);
    int q=0;
    vector<City> city_record;
    vector<year> year_record;
    vector <int> salary;
    struct node data[13];

    //FILE HANDLING
    ifstream  ifs("file.txt");
    int i =0;
	while(!ifs.eof()){
        string dob,doj;
     	ifs >> data[i].empid >> data[i].name >> data[i].city >> dob >> data[i].gender >> doj >> data[i].salary >> data[i].dep;
		data[i].dob = str_to_int(dob);
		data[i].doj = str_to_int(doj);
		i++;
	}


	//1
	cout << endl << "sub-division 1"<<endl<<"List the name of all employees who are from Delhi." <<endl;
	for(int i=0;i<13;i++){
        if (data[i].city == "Delhi"){
            cout << data[i].name << endl;
        }
	}
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");

	//2
    cout << endl << "sub-division 2"<<endl <<"Display the name of all employees who gets the salary above 40000."<<endl;
	for(int i=0;i<13;i++){
        if (data[i].salary > 40000){
            cout << data[i].name << endl;
        }
	}
	cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");


    //3
	cout << endl << "sub-division 3"<<endl<<"Display the highest Salary." <<endl;
	int max_sal = data[0].salary;
	string emp_name = data[0].name;
	for(int i=1;i<13;i++){
        if (data[i].salary > max_sal){
            max_sal = data[i].salary;
            emp_name = data[i].name;
        }
	}
	cout << max_sal<< endl;
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");


	//4
	cout << endl << "sub-division 4"<<endl <<"Name the employee who got highest salary."<<endl;
	cout << emp_name << endl;
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");


    //5
	cout << endl << "sub-division 5"<<endl <<"Name the employee who got lowest salary."<<endl;
	int min_sal = data[0].salary;
	string min_emp_name = data[0].name;
	for(int i=1;i<13;i++){
        if (data[i].salary < min_sal){
            min_sal = data[i].salary;
            min_emp_name = data[i].name;
        }
	}
	cout << min_emp_name << endl;
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");


	//6
	cout << endl << "sub-division 6"<<endl <<"Display the age of all employees."<<endl;
	for(int i=0;i<13;i++){
        cout << data[i].name << " is ";
        age( now->tm_mday, now->tm_mon + 1, now->tm_year +1900, data[i].dob.day, data[i].dob.month, data[i].dob.year);
        cout << " old" << endl;
	}
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");


	//7
	cout << endl << "sub-division 7"<<endl<<"Display the experience of all employees." <<endl;
	for(int i=0;i<13;i++){
        cout << data[i].name << " has experience of ";
        age( now->tm_mday, now->tm_mon + 1, now->tm_year +1900, data[i].doj.day, data[i].doj.month, data[i].doj.year);
        cout << endl;
	}
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");


	//8
	cout << endl << "sub-division 8" <<endl<<"Name the employee who is the senior most employees."<<endl;
	int exp_arr[13] = {0,0,0,0,0,0,0,0,0,0,0,0,0};
	int smax=0,jmin=100,result;
	for(int i=0;i<13;i++){
        exp_arr[i] = now->tm_year +1900 - data[i].doj.year;
        if(exp_arr[i] > smax){
            smax = exp_arr[i];

        }
        if(exp_arr[i] < jmin){
            jmin = exp_arr[i];

        }
	}

	for(int i=0;i<13;i++){
        if (now->tm_year +1900 - data[i].doj.year == smax){
            cout << data[i].name << endl;
        }
	}
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");



	//9
	cout << endl << "sub-division 9" <<endl<<"Name the employee who is the junior most employees."<<endl;
	for(int i=0;i<13;i++){
        if (now->tm_year +1900 - data[i].doj.year == jmin){
            cout << data[i].name << endl;
        }
	}
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");



	//10
	cout << endl << "sub-division 10" <<endl<<"Name and age of person who got 50000 salary"<<endl;
	for(int i=0;i<13;i++){
            if(data[i].salary == 50000){
                cout << data[i].name << " : ";
                age( now->tm_mday, now->tm_mon + 1, now->tm_year +1900, data[i].doj.day, data[i].doj.month, data[i].doj.year);
                cout << " old" << endl;
            }

	}
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");

	//11
	cout << endl << "sub-division 11" <<endl<<"Name and age of person who got 100000 salary"<<endl;
	for(int i=0;i<13;i++){
            if(data[i].salary == 100000){
                cout << data[i].name << " : ";
                age( now->tm_mday, now->tm_mon + 1, now->tm_year +1900, data[i].doj.day, data[i].doj.month, data[i].doj.year);
                cout << " old" << endl;
            }

	}
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");

	//12
	cout << endl << "sub-division 12" <<endl<<"Age of the persons whose branch city is Bombay."<<endl;
	for(int i=0;i<13;i++){
            if(data[i].city == "Bombay"){
                age( now->tm_mday, now->tm_mon + 1, now->tm_year +1900, data[i].doj.day, data[i].doj.month, data[i].doj.year);
                cout << " old" << endl;
            }

	}
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");

	//13
	cout << endl << "sub-division 13" <<endl<<"Name and age of the employees whose name has the letter [i]"<<endl;
	for(int i=0;i<13;i++){
            if(check_str(data[i].name,'i') == 1){
                cout << data[i].name << " : ";
                age( now->tm_mday, now->tm_mon + 1, now->tm_year +1900, data[i].doj.day, data[i].doj.month, data[i].doj.year);
                cout << " old" << endl;
            }

	}
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");



	//14
	cout << endl << "sub-division 14" <<endl<<"name of the employees who lives in the same city as the one whose date of birth is 15-dec-58."<<endl;
    for(int i=0;i<13;i++){
        if(data[i].dob.day == 15 && data[i].dob.month == 12 && data[i].dob.year == 1958  ){
            cout <<endl<< data[i].city <<" : "<< endl;
            for(int j=0;j<13;j++){
                if(i!=j && data[i].city == data[j].city){
                    cout << data[j].name << endl;
                }
            }
        }
    }
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");



    //15
	cout << endl << "sub-division 15" <<endl<<"age of the persons getting less than 40000 as salary and who are from Prod."<<endl;
	for(int i=0;i<13;i++){
        if(data[i].salary < 40000 && data[i].dep == "Prod"){
            age( now->tm_mday, now->tm_mon + 1, now->tm_year +1900, data[i].doj.day, data[i].doj.month, data[i].doj.year);
                cout << " old" << endl;
        }

	}
	cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");


    //16
    cout << endl << "sub-division 16" <<endl<<"Find the age of the eldest person?"<<endl;
    vector<int> age_arr;

    for(int i=0;i<13;i++){

        age_arr.push_back(now->tm_year +1900 - data[i].dob.year);
    }
    cout << 1900+*max_element(age_arr.begin(), age_arr.end());
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");



    //17
    cout << endl << "sub-division 17" <<endl<<"Find the age of the youngest person?"<<endl;
    cout << 1900+*min_element(age_arr.begin(), age_arr.end());
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");



	//18
	cout << endl << "sub-division 18" <<endl<<"name of the employees who lives in the same city as the one who got 100000 as salary."<<endl;
    for(int i=0;i<13;i++){
        if(data[i].salary ==  100000){
            cout <<endl<< data[i].city <<" : "<< endl;
            for(int j=0;j<13;j++){
                if(i!=j && data[i].city == data[j].city){
                    cout << data[j].name << endl;
                }
            }
        }
    }
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");



    //19
    cout << endl << "sub-division 19" <<endl<<"How many of the employees come from each city?"<<endl;
    for(int i=0;i<13;i++){
        int k=1,index=0;
        for (auto j: city_record){
            if(j.city == data[i].city){
                city_record[index].Count++;
                k=0;
                break;
            }
            index++;
        }
        if(k){
            struct City temp;
            temp.city = data[i].city;
            temp.Count = 1;
            city_record.push_back(temp);
        }
    }

    for(auto i: city_record){
        cout<< i.city << " : " << i.Count << endl;
    }
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");



    //20
    cout << endl << "sub-division 20" <<endl<<"City where the maximum of the employees come from"<<endl;
    int m = 0;
    string city_name;
    for(auto i: city_record){
        if(i.Count >m){
            m = i.Count;
            city_name = i.city;
        }
    }
    cout << city_name<<endl;
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");


    //21
    cout << endl << "sub-division 21" <<endl<<"names of the persons come from the city where maximum of the persons come."<<endl;
    for(int i=0;i<13;i++){
        if(data[i].city == city_name){
            cout << data[i].name << endl;
        }
    }
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");



    //22
    cout << endl << "sub-division 22" <<endl<<"Add Rs. 20000 as bonus to those who have the letter ‘a’ in their name and come from the city from where minimum number of the employees comes."<<endl;
    int minc = 10000;
    for(auto i: city_record){
        if (i.Count < minc){
            minc = i.Count;
        }
    }

    for(int i=0;i<13;i++){
        if(check_str(data[i].name,'a')==1 || check_str(data[i].name,'A')==1){
            for(auto j:city_record){
                if(j.city == data[i].city && j.Count == minc){
                    data[i].salary+=20000;
                    cout << "Bonus added to " << data[i].name << endl;
                    break;
                }
            }
        }

    }
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");


    //23
	cout << endl << "sub-division 23" <<endl << "Display the highest, lowest and average salary for those earning more than 40000." << endl;
    int s=0;
    float avg;
    int high = 0;
    int low = std::numeric_limits<int>::max();
    int coun = 0;

    for(int i=0;i<13;i++){
            if (data[i].salary > 40000 && data[i].salary < low ){
                low = data[i].salary;
            }
            if (data[i].salary > 40000 && data[i].salary > high ){
                high = data[i].salary;
            }
            if(data[i].salary > 40000){
                s+=data[i].salary;
                coun+=1;
            }
    }
    cout << "Highest salary : " << high << endl;
    cout << "Lowest salary : " << low << endl;
    avg = (float)s/(float)coun;
    cout << "Average: " << avg << endl;
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");

    //24
    int mc = 0,fc=2000;

    for(int i=0;i<13;i++){
        if(data[i].dob.year>mc && data[i].gender == "M"){
            mc= data[i].dob.year;
        }
        if(data[i].dob.year<fc && data[i].gender == "F"){
            fc = data[i].dob.year;

        }
    }

    cout << endl << "sub-division 24" <<endl << "youngest male employee" << endl;
    for(int i=0;i<13;i++){
        if(data[i].dob.year == mc && data[i].gender == "M"){
            cout << data[i].name << endl;
        }
    }
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");



    //25

    cout << endl << "sub-division 25" <<endl << "oldest female employee" << endl;
    for(int i=0;i<13;i++){
        if(data[i].dob.year<fc && data[i].gender == "F"){
            fc = data[i].dob.year;

        }
    }

    for(int i=0;i<13;i++){
        if(data[i].dob.year == fc){
            cout << data[i].name << endl;
        }
    }
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");


    //26
    cout << endl << "sub-division 26" <<endl << " month in which most no. of employees  were born" << endl;
    int month_arr[13] = {0,0,0,0,0,0,0,0,0,0,0,0,0};
    for(int i=0;i<13;i++){
        month_arr[data[i].dob.month]++;
    }


    int max1 = 0;
    for(int i=1;i<13;i++){
        if(month_arr[i] > max1){
            max1 = month_arr[i];
        }
    }
    for(int i=1;i<13;i++){
        if(month_arr[i] == max1){
            cout << month_upper[i] << endl;
        }
    }
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");


    //27
    cout << endl << "sub-division 27" <<endl << "year in which most no. of employees  were born" << endl;
    for(int i=0;i<13;i++){
        int k=1,index=0;
        for (auto j: year_record){
            if(j.Year == data[i].dob.year){
                year_record[index].Count++;
                k=0;
                break;
            }
            index++;
        }
        if(k){
            struct year temp;
            temp.Year = data[i].dob.year;
            temp.Count = 1;
            year_record.push_back(temp);
        }
    }

    int max2 = 0,year;
    for(auto i: year_record){
        if(i.Count>max2){
            max2 = i.Count;
            year = i.Year;
        }
    }

    cout << year<<endl;


    int msum=0,fsum=0,fcount=0,mcount=0;
    float favg,mavg;
    for(int i=0;i<13;i++){
        if(data[i].gender == "M"){
            msum +=data[i].salary;
            mcount++;

        }
        if(data[i].gender == "F"){
            fsum+= data[i].salary;
            fcount++;
        }
    }
    mavg = (float)msum/(float)mcount;
    favg = (float)fsum/(float)fcount;
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");


    //28
    cout << endl << "sub-division 28" <<endl << "male employees earning below the average salary of female employees" << endl;
    for(int i=0;i<13;i++){
        if(data[i].gender == "M" && data[i].salary<favg){
            cout << data[i].name << endl;
        }
    }
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");


    //29
    cout << endl << "sub-division 29" <<endl << "Female employees earning below the average salary of male employees" << endl;
    for(int i=0;i<13;i++){
        if(data[i].gender == "F" && data[i].salary<mavg){
            cout << data[i].name << endl;
        }
    }
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");


    //30
    cout << endl << "sub-division 30" <<endl << "Name of employees who are getting same salary" << endl;

    for(int i=0;i<13;i++){
        int k=1;
        for(auto j: salary){
            if (j == data[i].salary){
                k=0;
                break;
            }
        }
        if(k==1){
            salary.push_back(data[i].salary);
        }
    }

    for(auto j: salary){
        cout << "Salary " << j << " :" << endl;
        for(int i=0;i<13;i++){
            if(data[i].salary == j){
                cout << data[i].name << endl;
            }
        }
        cout << endl;
    }
    cout << " \nPress Any Key To Continue...";
    getch();
    system("cls");
}
