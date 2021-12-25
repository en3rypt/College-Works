#include <stdio.h>
#include <conio.h>
#include <windows.h>
#include<time.h>


int fparking[3][10],fcount=0,tcount=0;;
int tparking[3][10];
struct userdetails{
    long long int phone;
    int vnum;
    struct time{
        int hrs;
        int min;
        int sec;
    }time;
    int slot;
};
struct userdetails fwdetails[30],twdetails[30];

//check if 4 wheeler number exists
int fvnumcheck(int num){
    for(int i=0;i<30;i++){
        if(fwdetails[i].vnum == num){

            return 0;
        }
    }
    return 1;
}

//check if 2 wheeler number exists
int tvnumcheck(int num){
    for(int i=0;i<30;i++){
        if(twdetails[i].vnum == num){

            return 0;
        }
    }
    return 1;
}

//park 4 wheeler
void fpark(){
    int vnum;
    time_t now;
    struct tm *now_tm;
    int availi=-1,availj=-1,count=-1;
    for (int i=0;i<3;i++){
        for (int j=0;j<10;j++){
            if (fparking[i][j]==0){
                availi=i;
                availj=j;
                count = availi*10 +availj;
                break;
            }
        }
        if (count!=-1){
            break;
        }
    }

    if (count>=0){
        system("cls");
        printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb Four Wheeler Park \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
        now = time(NULL);
        now_tm = localtime(&now);
        printf("\n\tEnter phone number: ");
        scanf("%lld",&fwdetails[count].phone);
        printf("\n\tEnter Vehicle number: ");
        scanf("%d",&vnum);
        if (fvnumcheck(vnum)){
            fwdetails[count].vnum = vnum;
            fwdetails[count].slot = count;
            fwdetails[count].time.hrs = now_tm->tm_hour;
            fwdetails[count].time.min = now_tm->tm_min;
            fwdetails[count].time.sec = now_tm->tm_sec;
            fparking[availi][availj] = fwdetails[count].vnum;
            FILE *fp;
            if((fp=fopen("four_wheeler_park.txt", "a"))==NULL) {
                printf("Cannot open file.\n");
            }else{
                fprintf(fp,"################################\nContact Number: %lld\nVehicle Type: Four Wheeler\nVehicle Number: %d\nSlot Number: %d\n################################\n",fwdetails[count].phone,fwdetails[count].vnum,count);
            }
            fclose(fp);
            printf("\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdbPARKING SUCCESS\xdb\xdb\xdb\xdb\xdb\xdb\xdb\n\tPlease Park your vehicle at slot number %d\n",count);
            fcount++;
            printf(" \n\t Press Any Key To Continue:");
            getch();
            system("cls");
            return;
        }else{
            printf("\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb ERROR \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n\tInvalid Number! Vehicle Number already parked\n");
            printf(" \n\t Press Any Key To Continue:");
            getch();
            system("cls");
        }
    }else{
        system("cls");
        printf("\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdbPARKING FAILED\xdb\xdb\xdb\xdb\xdb\xdb\xdb\n\tNo slots available for four wheeler parking.\n");
        printf(" \n\t Press Any Key To Continue:");
        getch();
        system("cls");
        return;
    }
}

//park 2 wheeler
void tpark(){
    int vnum;
    time_t now;
    struct tm *now_tm;
    int availi=-1,availj=-1,count=-1;

    for (int i=0;i<3;i++){
        for (int j=0;j<10;j++){
            if (tparking[i][j]==0){
                availi=i;
                availj=j;
                count = availi*10 +availj;
                break;
            }
        }
        if (count!=-1){
            break;
        }
    }

    if (count>=0){

        system("cls");

        printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb Two Wheeler Park \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
        now = time(NULL);
        now_tm = localtime(&now);
        printf("\n\tEnter phone number: ");
        scanf("%lld",&twdetails[count].phone);
        printf("\n\tEnter Vehicle number: ");
        scanf("%d",&vnum);
        if (tvnumcheck(vnum)){
            twdetails[count].vnum = vnum;
            twdetails[count].slot = count;
            twdetails[count].time.hrs = now_tm->tm_hour;
            twdetails[count].time.min = now_tm->tm_min;
            twdetails[count].time.sec = now_tm->tm_sec;
            tparking[availi][availj] = twdetails[count].vnum;
            FILE *fp;
            if((fp=fopen("two_wheeler_park.txt", "a"))==NULL) {
                printf("Cannot open file.\n");
            }else{
                fprintf(fp,"################################\nContact Number: %lld\nVehicle Type: Two Wheeler\nVehicle Number: %d\nSlot Number: %d\n################################\n",twdetails[count].phone,twdetails[count].vnum,count);
            }
            fclose(fp);
            printf("\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdbPARKING SUCCESS\xdb\xdb\xdb\xdb\xdb\xdb\xdb\n\tPlease Park your vehicle at slot number %d\n",count);
            tcount++;
            printf(" \n\t Press Any Key To Continue:");
            getch();
            system("cls");
            return;
        }else{
            printf("\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb ERROR \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n\tInvalid Number! Vehicle Number already parked\n");
            printf(" \n\t Press Any Key To Continue:");
            getch();
            system("cls");
        }
    }else{
        system("cls");
        printf("\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdbPARKING FAILED\xdb\xdb\xdb\xdb\xdb\xdb\xdb\n\tNo slots available for two wheeler parking.\n");
        printf(" \n\t Press Any Key To Continue:");
        getch();
        system("cls");
        return;
    }
}

//main parking function
void park(){
    int choice,availi=-1,availj=-1,count=0;
    time_t now;
    struct tm *now_tm;

    L2:system("cls");
    printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb MENU \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
    printf ( "\n\t1) Park Four Wheeler\n" );
    printf ( "\n\t2) Park Two Wheeler\n" );
    printf ( "\n\t3) back\n" );
    printf ("\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb");
    printf(" \n\n\tEnter Your Choice Here:");
    scanf ( "%d", &choice );
    if(choice ==1){
        fpark();
    }else if(choice == 2){
        tpark();
    }else if(choice ==3){
        return;
    }else{
        goto L2;
    }

}

//parked vehicles info function
void info(){
    int choice;

    L3:system("cls");
    printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb MENU \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
    printf ( "\n\t1) Display Four Wheeler Parked\n" );
    printf ( "\n\t2) Display Two Wheeler Parked\n" );
    printf ( "\n\t3) back\n" );
    printf ("\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb");
    printf(" \n\n\tEnter Your Choice Here:");
    scanf ( "%d", &choice );
    if (choice == 1){
        system("cls");
        printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb Four Wheeler Parked Order \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
        for (int i=0;i<3;i++){
            for (int j=0;j<10;j++){
                printf("%d\t",fparking[i][j]);
            }printf("\n");
        }
        printf(" \n\t Press Any Key To Continue:");
        getch();
    }else if (choice==2){
        system("cls");
        printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb Two Wheeler Parked Order \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
        for (int i=0;i<3;i++){
            for (int j=0;j<10;j++){
                printf("%d\t",tparking[i][j]);
            }printf("\n");
        }
        printf(" \n\t Press Any Key To Continue:");
        getch();
    }else if(choice == 3){
        return;
    }else{
        goto L3;
    }
}

//calculates time difference
int calc_time(int endhrs,int endmin,int endsec){
    int starthrs,startmin,startsec;
    time_t now;
    struct tm *now_tm;
    now = time(NULL);
    now_tm = localtime(&now);
    starthrs = now_tm->tm_hour;
    startmin = now_tm->tm_min;
    startsec = now_tm->tm_sec;
    int diffhrs,diffmin,diffsec;
    while (endsec > startsec) {
      --startmin;
      startsec += 60;
   }
   diffsec = startsec - endsec;
   while (endmin > startmin) {
      --starthrs;
      startmin += 60;
   }
   diffmin = startmin - endmin;
   diffhrs = starthrs- endhrs;
   if (diffsec>30){
        diffmin++;
        if (diffmin==60){
            diffhrs++;
            diffmin=0;
        }
   }if (diffmin > 30){
       diffhrs++;
   }
   return diffhrs;
}

//4 wheeler departure function
void fdeparture(){
    int count=0,totaltime,vnum,amount=0,row,column;
    printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb Four Wheeler Departure \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
    printf ( "\n\tEnter Vehicle number: " );
    scanf("%d",&vnum);
    for(int i=0;i<30;i++){
            if (fwdetails[i].vnum == vnum){
                count++;
                totaltime = calc_time(fwdetails[i].time.hrs,fwdetails[i].time.min,fwdetails[i].time.sec);
                if (totaltime<=3){
                    amount = 40;

                }else{
                    amount = 40 + (totaltime-3)*10;
                }
                system("cls");
                printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb BILL \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
                printf("\n\tContact Number: %lld",fwdetails[i].phone);
                printf("\n\tVehicle Type: Four Wheeler");
                printf("\n\tVehicle Number: %d",fwdetails[i].vnum);
                printf("\n\t================================");
                printf("\n\tTotal amount to Be paid: %d",amount);
                printf("\n\t================================");
                FILE *fp;
                if((fp=fopen("four_wheeler_dep.txt", "a"))==NULL) {
                    printf("Cannot open file.\n");
                }else{
                    fprintf(fp,"################################\nContact Number: %d\nVehicle Type: Four Wheeler\nVehicle Number: %lld\nTotal amount: %d\n################################\n",fwdetails[i].phone,fwdetails[i].vnum,amount);
                }
                fclose(fp);
                fwdetails[i].time.hrs=0;
                fwdetails[i].time.min=0;
                fwdetails[i].time.sec=0;
                fwdetails[i].phone=0;
                fwdetails[i].vnum=0;
                fwdetails[i].slot=0;
                row = i/10;
                column=i%10;
                fparking[row][column] = 0;
                fcount--;

                printf(" \n\t Press Any Key To Continue:");
                getch();
                return;
            }
    }printf("\n\t No vehicle record found.");
    printf(" \n\t Press Any Key To Continue:");
    getch();
    return;
}

//2 wheeler departure function
void tdeparture(){
    int count=0,totaltime,vnum,amount=0,row,column;

    printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb Two Wheeler Departure \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
    printf ( "\n\tEnter Vehicle number: " );
    scanf("%d",&vnum);
    for(int i=0;i<30;i++){
            if (twdetails[i].vnum == vnum){
                count++;
                totaltime = calc_time(twdetails[i].time.hrs,twdetails[i].time.min,twdetails[i].time.sec);
                if (totaltime<=3){
                    amount = 20;

                }else{
                    amount = 20 + (totaltime-3)*5;
                }
                system("cls");
                printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb BILL \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
                printf("\n\tContact Number: %lld",twdetails[i].phone);
                printf("\n\tVehicle Type: Two Wheeler");
                printf("\n\tVehicle Number: %d",twdetails[i].vnum);
                printf("\n\t================================");
                printf("\n\tTotal amount to Be paid: %d",amount);
                printf("\n\t================================");
                FILE *fp;
                if((fp=fopen("two_wheeler_dep.txt", "a"))==NULL) {
                    printf("Cannot open file.\n");
                }else{
                    fprintf(fp,"################################\nContact Number: %d\nVehicle Type: Two Wheeler\nVehicle Number: %lld\nTotal amount: %d\n################################\n",twdetails[i].phone,twdetails[i].vnum,amount);
                }
                fclose(fp);
                twdetails[i].time.hrs=0;
                twdetails[i].time.min=0;
                twdetails[i].time.sec=0;
                twdetails[i].phone=0;
                twdetails[i].vnum=0;
                twdetails[i].slot=0;
                row = i/10;
                column=i%10;
                tparking[row][column] = 0;
                tcount--;

                printf(" \n\t Press Any Key To Continue:");
                getch();
                return;
            }
    }printf("\n\t No vehicle record found.");
    printf(" \n\t Press Any Key To Continue:");
    getch();
    return;
}

//vehicle departure main function
void departure(){
    int choice,vnum;
    L4:system("cls");
    printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb MENU \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
    printf ( "\n\t1) Four Wheeler Departure\n" );
    printf ( "\n\t2) Two Wheeler Departure\n" );
    printf ( "\n\t3) back\n" );
    printf ("\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb");
    printf(" \n\n\tEnter Your Choice Here:");
    scanf ( "%d", &choice );
    if (choice ==1){
        system("cls");
        fdeparture();
    }else if (choice == 2){
        system("cls");
        tdeparture();
    }
}

//info function
void display_info(){
    int choice,vnum;
    L4:system("cls");
    printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb MENU \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
    printf ( "\n\t1) Four Wheeler Information\n" );
    printf ( "\n\t2) Two Wheeler Information\n" );
    printf ( "\n\t3) back\n" );
    printf ("\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb");
    printf(" \n\n\tEnter Your Choice Here:");
    scanf ( "%d", &choice );
    if (choice ==1){
        system("cls");
        printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb Four Wheeler Information \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
        printf ( "\n\tEnter Vehicle number:" );
        scanf ( "%d", &vnum);
        for(int i=0;i<30;i++){
            if (fwdetails[i].vnum == vnum){
                system("cls");
                printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb Four Wheeler Information \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
                printf("\n\tContact number: %lld",fwdetails[i].phone);
                printf("\n\tVehicle number: %d",fwdetails[i].vnum);
                printf("\n\tParked slot: %d",fwdetails[i].slot);
                printf("\n\tIn time: %d:%d:%d",fwdetails[i].time.hrs,fwdetails[i].time.min,fwdetails[i].time.sec);
                printf ("\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb");
                printf("\n\t Press Any Key To Continue:");
                getch();
                return;
            }
        }
        printf ("\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb ERROR \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
        printf("\n\tFailed to Return information.\n\tNo Four Wheeler parked with number :  %lld\n",vnum);
        printf("\n\t Press Any Key To Continue:");
        getch();
        return;
    }if (choice == 2){
        system("cls");
        printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb Two Wheeler Information \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
        printf ( "\n\tEnter Vehicle number:" );
        scanf ( "%d", &vnum);
        for(int i=0;i<30;i++){
            if (fwdetails[i].vnum == vnum){
                system("cls");
                printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb Two Wheeler Information \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
                printf("\n\tContact number: %lld",twdetails[i].phone);
                printf("\n\tVehicle number: %d",twdetails[i].vnum);
                printf("\n\tParked slot: %d",twdetails[i].slot);
                printf("\n\tIn time: %d:%d:%d",twdetails[i].time.hrs,twdetails[i].time.min,twdetails[i].time.sec);
                printf ("\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb");
                printf("\n\t Press Any Key To Continue:");
                getch();
                return;
            }
        }
        printf ("\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb ERROR \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
        printf("\n\tFailed to Return information.\n\tNo Two Wheeler parked with number :  %lld\n",vnum);
        printf("\n\t Press Any Key To Continue:");
        getch();
        return;

    }
}
// greeting funcition
void greet(){
    printf("\n\t\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\n");
	printf("\t\t\xdb                                             \xdb\n");
	printf("\t\t\xdb       =============================         \xdb\n");
	printf("\t\t\xdb        VEHICLE PARKING MANAGEMENT           \xdb\n");
	printf("\t\t\xdb                 SYSTEM                      \xdb\n");
	printf("\t\t\xdb       =============================         \xdb\n");
	printf("\t\t\xdb                                             \xdb\n");
	printf("\t\t\xdb                    BY                       \xdb\n");
	printf("\t\t\xdb                 SANJITH T                   \xdb\n");
	printf("\t\t\xdb                                             \xdb\n");
	printf("\t\t\xdb                                             \xdb\n");
	printf("\t\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\n\n\n");
	printf(" \n\t Press Any Key To Continue:");
	getch();
    system("cls");
}

//login function
void login()
{
	int a=0,i=0;
    char uname[10],c=' ';
    char pword[10],code[10];
    char user[10]="admin";
    char pass[10]="admin";
    do{

        printf("\n  \xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb  LOGIN FIRST  \xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb  ");
        printf(" \n\n                       ENTER USERNAME:-");
        scanf("%s", &uname);
        printf(" \n\n                       ENTER PASSWORD:-");
        while(i<10)
        {
            pword[i]=getch();
            c=pword[i];
            if(c==13){
                break;
            }
            if (c==8){
                    if (i>0){
                    printf("\b \b");
                    i--;
                    }
            }
            else {
                printf("*");
                i++;
            }
        }
        pword[i]='\0';
        i=0;
        if(strcmp(uname,user)==0 && strcmp(pword,pass)==0)
        {
            printf("  \n\n\n       WELCOME !! YOUR LOGIN IS SUCCESSFUL");
            printf("\n\n\n\t\t\t\tPress any key to continue...");
            getch();
            break;
        }
        else
        {
            printf("\n        SORRY !!!!  LOGIN IS UNSUCCESSFUL");
            a++;
            getch();
        }
    }
	while(a<=2);
	if (a>2)
	{
		printf("\nSorry you have entered the wrong username and password for four times!!!");

		getch();
		exit(0);

    }
    system("cls");
}

//main function
int main(){
    int choice=1;

    greet();
    login();
    while (choice){
        system("cls");
        printf ( "\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb MENU \xdb\xdb\xdb\xdb\xdb\xdb\xdb\n" );
        printf ( "\n\t1) Park Vehicle\n" );
        printf ( "\n\t2) Total No. Of Vehicles Parked\n" );
        printf ( "\n\t3) Total No. Of Four Wheeler Parked\n" );
        printf ( "\n\t4) Total No. Of Two Wheeler Parked\n" );
        printf ( "\n\t5) Display Vehicles Parked (Order)\n" );
        printf ( "\n\t6) Display Vehicle information\n" );
        printf ( "\n\t7) Departure Of Vehicle\n" );
        printf ( "\n\t0) Exit\n" );
        printf ("\n\t\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb\xdb");
        printf(" \n\n\tEnter Your Choice Here:");
        scanf ( "%d", &choice );
        if (choice == 1){
                park();
        }else if(choice == 2){
            system("cls");
            printf("Total Vehicles parked: %d\n",fcount+tcount);
            printf(" \n\t Press Any Key To Continue:");
            getch();
        }else if(choice == 3){
            system("cls");
            printf("Total Four Wheelers parked: %d\n",fcount);
            printf(" \n\t Press Any Key To Continue:");
            getch();
        }else if(choice == 4){
            system("cls");
            printf("Total Two Wheelers parked: %d\n",tcount);
            printf(" \n\t Press Any Key To Continue:");
            getch();
        }else if(choice == 5){
            system("cls");
            info();
        }else if (choice ==6){
            system("cls");
            display_info();
        }else if(choice == 7){
            system("cls");
            departure();
        }else if (choice == 0){
            exit(0);
        }
    }

}


