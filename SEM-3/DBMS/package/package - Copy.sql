--
--
--ALTER TABLE bill
--    DROP CONSTRAINT bill_ride;
--
--ALTER TABLE ride
--    DROP CONSTRAINT destination_ride_city;
--
--ALTER TABLE driver_ratings
--    DROP CONSTRAINT driver_ratings_ride;
--
--ALTER TABLE request
--    DROP CONSTRAINT request_ride;
--
--ALTER TABLE request
--    DROP CONSTRAINT request_user;
--
--ALTER TABLE ride
--    DROP CONSTRAINT ride_luggage_size;
--
--ALTER TABLE ride
--    DROP CONSTRAINT ride_user_car;
--
--ALTER TABLE ride
--    DROP CONSTRAINT source_ride_city;
--
--ALTER TABLE member_car
--    DROP CONSTRAINT user_car_car;
--
--ALTER TABLE member_car
--    DROP CONSTRAINT user_car_user;
--
---- tables
--DROP TABLE bill;
--
--DROP TABLE car;
--
--DROP TABLE city;
--
--DROP TABLE driver_ratings;
--
--DROP TABLE luggage_size;
--
--DROP TABLE member;
--
--DROP TABLE member_car;
--
--DROP TABLE request;
--
--DROP TABLE ride;
-- tables
-- Table: bill
CREATE TABLE bill (
    id number  NOT NULL,
    ride_id number  NOT NULL,
    bill_amount number  NULL,
    CONSTRAINT bill_pk PRIMARY KEY (id)
) ;

-- Table: car
CREATE TABLE car (
   id number  NOT NULL,
   name varchar2(50)  NOT NULL,
   model varchar2(50)  NOT NULL,
   company varchar2(50)  NOT NULL,
   comfort_level number(1)  NOT NULL,
   CONSTRAINT car_pk PRIMARY KEY (id)
);

-- Table: city
CREATE TABLE city (
    id number  NOT NULL,
    city_name varchar2(50)  NOT NULL,
    state varchar2(50)  NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
) ;

-- Table: driver_ratings
CREATE TABLE driver_ratings (
    id number  NOT NULL,
    ride_id number  NOT NULL,
    rating number  NULL,
    CONSTRAINT driver_ratings_pk PRIMARY KEY (id)
) ;

-- Table: luggage_size
CREATE TABLE luggage_size (
    id number  NOT NULL,
    description varchar2(50)  NOT NULL,
    CONSTRAINT luggage_size_pk PRIMARY KEY (id)
) ;

-- Table: member
CREATE TABLE member (
    id number  NOT NULL,
    first_name varchar2(50)  NULL,
    last_name varchar2(50)  NULL,
    contact_number number(10)  NULL,
    address varchar2(200)  NULL,
    username varchar2(255)  NULL,
    password varchar2(255)  NULL,
    member_type varchar2(30)  NULL,
    CONSTRAINT username UNIQUE (username),
    CONSTRAINT member_pk PRIMARY KEY (id)
) ;

-- Table: member_car
CREATE TABLE member_car (
    id number  NOT NULL,
    member_id number  NOT NULL,
    car_id number  NOT NULL,
    car_registration_number varchar2(50)  NOT NULL,
    car_color varchar2(20)  NOT NULL,
    CONSTRAINT member_car_pk PRIMARY KEY (id)
) ;

-- Table: request
CREATE TABLE request (
    id number  NOT NULL,
    requester_id number  NOT NULL,
    ride_id number  NOT NULL,
    request_staus varchar2(20)  NULL,
    CONSTRAINT request_pk PRIMARY KEY (id)
) ;


-- Table: ride
CREATE TABLE ride (
    id number  NOT NULL,
    member_car_id number  NOT NULL,
    created_on date  NOT NULL,
    source_city_id number  NOT NULL,
    destination_city_id number  NOT NULL,
    seats_offered number  NULL,
    contribution_per_head number  NULL,
    luggage_size_id number  NOT NULL,
    ride_status varchar2(20)  NOT NULL,
    CONSTRAINT ride_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: bill_ride (table: bill)
ALTER TABLE bill ADD CONSTRAINT bill_ride
    FOREIGN KEY (ride_id)
    REFERENCES ride (id);

-- Reference: destination_ride_city (table: ride)
ALTER TABLE ride ADD CONSTRAINT destination_ride_city
    FOREIGN KEY (destination_city_id)
    REFERENCES city (id);

-- Reference: driver_ratings_ride (table: driver_ratings)
ALTER TABLE driver_ratings ADD CONSTRAINT driver_ratings_ride
    FOREIGN KEY (ride_id)
    REFERENCES ride (id);

-- Reference: request_ride (table: request)
ALTER TABLE request ADD CONSTRAINT request_ride
    FOREIGN KEY (ride_id)
    REFERENCES ride (id);

-- Reference: request_user (table: request)
ALTER TABLE request ADD CONSTRAINT request_user
    FOREIGN KEY (requester_id)
    REFERENCES member (id);

-- Reference: ride_luggage_size (table: ride)
ALTER TABLE ride ADD CONSTRAINT ride_luggage_size
    FOREIGN KEY (luggage_size_id)
    REFERENCES luggage_size (id);

-- Reference: ride_user_car (table: ride)
ALTER TABLE ride ADD CONSTRAINT ride_user_car
    FOREIGN KEY (member_car_id)
    REFERENCES member_car (id);

-- Reference: source_ride_city (table: ride)
ALTER TABLE ride ADD CONSTRAINT source_ride_city
    FOREIGN KEY (source_city_id)
    REFERENCES city (id);

-- Reference: user_car_car (table: member_car)
ALTER TABLE member_car ADD CONSTRAINT user_car_car
    FOREIGN KEY (car_id)
    REFERENCES car (id);

-- Reference: user_car_user (table: member_car)
ALTER TABLE member_car ADD CONSTRAINT user_car_user
    FOREIGN KEY (member_id)
    REFERENCES member (id);

----sequnces
CREATE  SEQUENCE member_id
     INCREMENT BY 1
     MINVALUE 10000
     MAXVALUE 99999
     START WITH 10000;

CREATE SEQUENCE request_id
     INCREMENT BY 1
     MINVALUE 50000
     MAXVALUE 60000
     START WITH 50000;


CREATE SEQUENCE ride_id
     INCREMENT BY 1
     MINVALUE 20000
     MAXVALUE 29999
     START WITH 20000;
    
CREATE SEQUENCE bill_id
     INCREMENT BY 1
     MINVALUE 30000
     MAXVALUE 39999
     START WITH 30000;


CREATE SEQUENCE rating_id
     INCREMENT BY 1
     MINVALUE 40000
     MAXVALUE 49999
     START WITH 40000;

CREATE SEQUENCE car_id
     INCREMENT BY 1
     MINVALUE 40000
     MAXVALUE 59999
     START WITH 40000;

CREATE SEQUENCE member_car_id
     INCREMENT BY 1
     MINVALUE 60000
     MAXVALUE 69999
     START WITH 60000;


--INSERTIONS COMMANDS
INSERT INTO LUGGAGE_SIZE VALUES(0,'No luggage');
INSERT INTO LUGGAGE_SIZE VALUES(1,'Light luggage');
INSERT INTO LUGGAGE_SIZE VALUES(2,'medium luggage');
INSERT INTO LUGGAGE_SIZE VALUES(3,'Heavy Luggage');



--city insertions
INSERT INTO CITY VALUES(10001,'Mumbai','Maharashtra');
INSERT INTO CITY VALUES(10002,'Delhi','Delhi');
INSERT INTO CITY VALUES(10003,'Bengaluru','Karnataka');
INSERT INTO CITY VALUES(10004,'Ahmedabad','Gujarat');
INSERT INTO CITY VALUES(10005,'Hyderabad','Telangana');
INSERT INTO CITY VALUES(10006,'Chennai','Tamil Nadu');
INSERT INTO CITY VALUES(10007,'Kolkata','West Bengal');
INSERT INTO CITY VALUES(10008,'Pune','Maharashtra');
INSERT INTO CITY VALUES(10009,'Jaipur','Rajasthan');
INSERT INTO CITY VALUES(10010,'Surat','Gujarat');
INSERT INTO CITY VALUES(10011,'Lucknow','Uttar Pradesh');
INSERT INTO CITY VALUES(10012,'Kanpur','Uttar Pradesh');
INSERT INTO CITY VALUES(10013,'Nagpur','Maharashtra');
INSERT INTO CITY VALUES(10014,'Patna','Bihar');
INSERT INTO CITY VALUES(10015,'Indore','Madhya Pradesh');
INSERT INTO CITY VALUES(10016,'Thane','Maharashtra');
INSERT INTO CITY VALUES(10017,'Bhopal','Madhya Pradesh');
INSERT INTO CITY VALUES(10018,'Visakhapatnam','Andhra Pradesh');
INSERT INTO CITY VALUES(10019,'Vadodara','Gujarat');
INSERT INTO CITY VALUES(10020,'Firozabad','Uttar Pradesh');
INSERT INTO CITY VALUES(10021,'Ludhiana','Punjab');
INSERT INTO CITY VALUES(10022,'Rajkot','Gujarat');
INSERT INTO CITY VALUES(10023,'Agra','Uttar Pradesh');
INSERT INTO CITY VALUES(10024,'Siliguri','West Bengal');
INSERT INTO CITY VALUES(10025,'Nashik','Maharashtra');
INSERT INTO CITY VALUES(10026,'Faridabad','Haryana');
INSERT INTO CITY VALUES(10027,'Patiala','Punjab');
INSERT INTO CITY VALUES(10028,'Meerut','Uttar Pradesh');
INSERT INTO CITY VALUES(10029,'Kalyan-Dombivali','Maharashtra');
INSERT INTO CITY VALUES(10030,'Vasai-Virar','Maharashtra');
INSERT INTO CITY VALUES(10031,'Varanasi','Uttar Pradesh');
INSERT INTO CITY VALUES(10032,'Srinagar','Jammu and Kashmir');
INSERT INTO CITY VALUES(10033,'Dhanbad','Jharkhand');
INSERT INTO CITY VALUES(10034,'Jodhpur','Rajasthan');
INSERT INTO CITY VALUES(10035,'Amritsar','Punjab');
INSERT INTO CITY VALUES(10036,'Raipur','Chhattisgarh');
INSERT INTO CITY VALUES(10037,'Allahabad','Uttar Pradesh');
INSERT INTO CITY VALUES(10038,'Coimbatore','Tamil Nadu');
INSERT INTO CITY VALUES(10039,'Jabalpur','Madhya Pradesh');
INSERT INTO CITY VALUES(10040,'Gwalior','Madhya Pradesh');
INSERT INTO CITY VALUES(10041,'Vijayawada','Andhra Pradesh');
INSERT INTO CITY VALUES(10042,'Madurai','Tamil Nadu');
INSERT INTO CITY VALUES(10043,'Guwahati','Assam');
INSERT INTO CITY VALUES(10044,'Chandigarh','Chandigarh');
INSERT INTO CITY VALUES(10045,'Hubli-Dharwad','Karnataka');
INSERT INTO CITY VALUES(10046,'Amroha','Uttar Pradesh');
INSERT INTO CITY VALUES(10047,'Moradabad','Uttar Pradesh');
INSERT INTO CITY VALUES(10048,'Gurgaon','Haryana');
INSERT INTO CITY VALUES(10049,'Aligarh','Uttar Pradesh');
INSERT INTO CITY VALUES(10050,'Solapur','Maharashtra');
INSERT INTO CITY VALUES(10051,'Ranchi','Jharkhand');
INSERT INTO CITY VALUES(10052,'Jalandhar','Punjab');
INSERT INTO CITY VALUES(10053,'Tiruchirappalli','Tamil Nadu');
INSERT INTO CITY VALUES(10054,'Bhubaneswar','Odisha');
INSERT INTO CITY VALUES(10055,'Salem','Tamil Nadu');
INSERT INTO CITY VALUES(10056,'Warangal','Telangana');
INSERT INTO CITY VALUES(10057,'Mira-Bhayandar','Maharashtra');
INSERT INTO CITY VALUES(10058,'Thiruvananthapuram','Kerala');
INSERT INTO CITY VALUES(10059,'Bhiwandi','Maharashtra');
INSERT INTO CITY VALUES(10060,'Saharanpur','Uttar Pradesh');
INSERT INTO CITY VALUES(10061,'Guntur','Andhra Pradesh');
INSERT INTO CITY VALUES(10062,'Amravati','Maharashtra');
INSERT INTO CITY VALUES(10063,'Bikaner','Rajasthan');
INSERT INTO CITY VALUES(10064,'Noida','Uttar Pradesh');
INSERT INTO CITY VALUES(10065,'Jamshedpur','Jharkhand');
INSERT INTO CITY VALUES(10066,'Bhilai Nagar','Chhattisgarh');
INSERT INTO CITY VALUES(10067,'Cuttack','Odisha');
INSERT INTO CITY VALUES(10068,'Kochi','Kerala');
INSERT INTO CITY VALUES(10069,'Udaipur','Rajasthan');
INSERT INTO CITY VALUES(10070,'Bhavnagar','Gujarat');
INSERT INTO CITY VALUES(10071,'Dehradun','Uttarakhand');
INSERT INTO CITY VALUES(10072,'Asansol','West Bengal');
INSERT INTO CITY VALUES(10073,'Nanded-Waghala','Maharashtra');
INSERT INTO CITY VALUES(10074,'Ajmer','Rajasthan');
INSERT INTO CITY VALUES(10075,'Jamnagar','Gujarat');
INSERT INTO CITY VALUES(10076,'Ujjain','Madhya Pradesh');
INSERT INTO CITY VALUES(10077,'Sangli','Maharashtra');
INSERT INTO CITY VALUES(10078,'Loni','Uttar Pradesh');
INSERT INTO CITY VALUES(10079,'Jhansi','Uttar Pradesh');
INSERT INTO CITY VALUES(10080,'Pondicherry','Puducherry');
INSERT INTO CITY VALUES(10081,'Nellore','Andhra Pradesh');
INSERT INTO CITY VALUES(10082,'Jammu','Jammu and Kashmir');
INSERT INTO CITY VALUES(10083,'Belagavi','Karnataka');
INSERT INTO CITY VALUES(10084,'Raurkela','Odisha');
INSERT INTO CITY VALUES(10085,'Mangaluru','Karnataka');
INSERT INTO CITY VALUES(10086,'Tirunelveli','Tamil Nadu');
INSERT INTO CITY VALUES(10087,'Malegaon','Maharashtra');
INSERT INTO CITY VALUES(10088,'Gaya','Bihar');
INSERT INTO CITY VALUES(10089,'Tiruppur','Tamil Nadu');
INSERT INTO CITY VALUES(10090,'Davanagere','Karnataka');
INSERT INTO CITY VALUES(10091,'Kozhikode','Kerala');
INSERT INTO CITY VALUES(10092,'Akola','Maharashtra');
INSERT INTO CITY VALUES(10093,'Kurnool','Andhra Pradesh');
INSERT INTO CITY VALUES(10094,'Bokaro Steel City','Jharkhand');
INSERT INTO CITY VALUES(10095,'Rajahmundry','Andhra Pradesh');
INSERT INTO CITY VALUES(10096,'Ballari','Karnataka');
INSERT INTO CITY VALUES(10097,'Agartala','Tripura');
INSERT INTO CITY VALUES(10098,'Bhagalpur','Bihar');
INSERT INTO CITY VALUES(10099,'Latur','Maharashtra');
INSERT INTO CITY VALUES(10100,'Dhule','Maharashtra');
INSERT INTO CITY VALUES(10101,'Korba','Chhattisgarh');
INSERT INTO CITY VALUES(10102,'Bhilwara','Rajasthan');
INSERT INTO CITY VALUES(10103,'Brahmapur','Odisha');
INSERT INTO CITY VALUES(10104,'Mysore','Karnatka');
INSERT INTO CITY VALUES(10105,'Muzaffarpur','Bihar');
INSERT INTO CITY VALUES(10106,'Ahmednagar','Maharashtra');
INSERT INTO CITY VALUES(10107,'Kollam','Kerala');
INSERT INTO CITY VALUES(10108,'Raghunathganj','West Bengal');
INSERT INTO CITY VALUES(10109,'Bilaspur','Chhattisgarh');
INSERT INTO CITY VALUES(10110,'Shahjahanpur','Uttar Pradesh');
INSERT INTO CITY VALUES(10111,'Thrissur','Kerala');
INSERT INTO CITY VALUES(10112,'Alwar','Rajasthan');
INSERT INTO CITY VALUES(10113,'Kakinada','Andhra Pradesh');
INSERT INTO CITY VALUES(10114,'Nizamabad','Telangana');
INSERT INTO CITY VALUES(10115,'Sagar','Madhya Pradesh');
INSERT INTO CITY VALUES(10116,'Tumkur','Karnataka');
INSERT INTO CITY VALUES(10117,'Hisar','Haryana');
INSERT INTO CITY VALUES(10118,'Rohtak','Haryana');
INSERT INTO CITY VALUES(10119,'Panipat','Haryana');
INSERT INTO CITY VALUES(10120,'Darbhanga','Bihar');
INSERT INTO CITY VALUES(10121,'Kharagpur','West Bengal');
INSERT INTO CITY VALUES(10122,'Aizawl','Mizoram');
INSERT INTO CITY VALUES(10123,'Ichalkaranji','Maharashtra');
INSERT INTO CITY VALUES(10124,'Tirupati','Andhra Pradesh');
INSERT INTO CITY VALUES(10125,'Karnal','Haryana');
INSERT INTO CITY VALUES(10126,'Bathinda','Punjab');
INSERT INTO CITY VALUES(10127,'Rampur','Uttar Pradesh');
INSERT INTO CITY VALUES(10128,'Shivamogga','Karnataka');
INSERT INTO CITY VALUES(10129,'Ratlam','Madhya Pradesh');
INSERT INTO CITY VALUES(10130,'Modinagar','Uttar Pradesh');
INSERT INTO CITY VALUES(10131,'Durg','Chhattisgarh');
INSERT INTO CITY VALUES(10132,'Shillong','Meghalaya');
INSERT INTO CITY VALUES(10133,'Imphal','Manipur');
INSERT INTO CITY VALUES(10134,'Hapur','Uttar Pradesh');
INSERT INTO CITY VALUES(10135,'Ranipet','Tamil Nadu');
INSERT INTO CITY VALUES(10136,'Anantapur','Andhra Pradesh');
INSERT INTO CITY VALUES(10137,'Arrah','Bihar');
INSERT INTO CITY VALUES(10138,'Karimnagar','Telangana');
INSERT INTO CITY VALUES(10139,'Parbhani','Maharashtra');
INSERT INTO CITY VALUES(10140,'Etawah','Uttar Pradesh');
INSERT INTO CITY VALUES(10141,'Bharatpur','Rajasthan');
INSERT INTO CITY VALUES(10142,'Begusarai','Bihar');
INSERT INTO CITY VALUES(10143,'New Delhi','Delhi');
INSERT INTO CITY VALUES(10144,'Chhapra','Bihar');
INSERT INTO CITY VALUES(10145,'Kadapa','Andhra Pradesh');
INSERT INTO CITY VALUES(10146,'Ramagundam','Telangana');
INSERT INTO CITY VALUES(10147,'Pali','Rajasthan');
INSERT INTO CITY VALUES(10148,'Satna','Madhya Pradesh');
INSERT INTO CITY VALUES(10149,'Vizianagaram','Andhra Pradesh');
INSERT INTO CITY VALUES(10150,'Katihar','Bihar');
INSERT INTO CITY VALUES(10151,'Hardwar','Uttarakhand');
INSERT INTO CITY VALUES(10152,'Sonipat','Haryana');
INSERT INTO CITY VALUES(10153,'Nagercoil','Tamil Nadu');
INSERT INTO CITY VALUES(10154,'Thanjavur','Tamil Nadu');
INSERT INTO CITY VALUES(10155,'Murwara (Katni)','Madhya Pradesh');
INSERT INTO CITY VALUES(10156,'Naihati','West Bengal');
INSERT INTO CITY VALUES(10157,'Sambhal','Uttar Pradesh');
INSERT INTO CITY VALUES(10158,'Nadiad','Gujarat');
INSERT INTO CITY VALUES(10159,'Yamunanagar','Haryana');
INSERT INTO CITY VALUES(10160,'English Bazar','West Bengal');
INSERT INTO CITY VALUES(10161,'Eluru','Andhra Pradesh');
INSERT INTO CITY VALUES(10162,'Munger','Bihar');
INSERT INTO CITY VALUES(10163,'Panchkula','Haryana');
INSERT INTO CITY VALUES(10164,'Raayachuru','Karnataka');
INSERT INTO CITY VALUES(10165,'Panvel','Maharashtra');
INSERT INTO CITY VALUES(10166,'Deoghar','Jharkhand');
INSERT INTO CITY VALUES(10167,'Ongole','Andhra Pradesh');
INSERT INTO CITY VALUES(10168,'Nandyal','Andhra Pradesh');
INSERT INTO CITY VALUES(10169,'Morena','Madhya Pradesh');
INSERT INTO CITY VALUES(10170,'Bhiwani','Haryana');
INSERT INTO CITY VALUES(10171,'Porbandar','Gujarat');
INSERT INTO CITY VALUES(10172,'Palakkad','Kerala');
INSERT INTO CITY VALUES(10173,'Anand','Gujarat');
INSERT INTO CITY VALUES(10174,'Purnia','Bihar');
INSERT INTO CITY VALUES(10175,'Baharampur','West Bengal');
INSERT INTO CITY VALUES(10176,'Barmer','Rajasthan');
INSERT INTO CITY VALUES(10177,'Morvi','Gujarat');
INSERT INTO CITY VALUES(10178,'Orai','Uttar Pradesh');
INSERT INTO CITY VALUES(10179,'Bahraich','Uttar Pradesh');
INSERT INTO CITY VALUES(10180,'Sikar','Rajasthan');
INSERT INTO CITY VALUES(10181,'Vellore','Tamil Nadu');
INSERT INTO CITY VALUES(10182,'Singrauli','Madhya Pradesh');
INSERT INTO CITY VALUES(10183,'Khammam','Telangana');
INSERT INTO CITY VALUES(10184,'Mahesana','Gujarat');
INSERT INTO CITY VALUES(10185,'Silchar','Assam');
INSERT INTO CITY VALUES(10186,'Sambalpur','Odisha');
INSERT INTO CITY VALUES(10187,'Rewa','Madhya Pradesh');
INSERT INTO CITY VALUES(10188,'Unnao','Uttar Pradesh');
INSERT INTO CITY VALUES(10189,'Hugli-Chinsurah','West Bengal');
INSERT INTO CITY VALUES(10190,'Raiganj','West Bengal');
INSERT INTO CITY VALUES(10191,'Phusro','Jharkhand');
INSERT INTO CITY VALUES(10192,'Adityapur','Jharkhand');
INSERT INTO CITY VALUES(10193,'Alappuzha','Kerala');
INSERT INTO CITY VALUES(10194,'Bahadurgarh','Haryana');
INSERT INTO CITY VALUES(10195,'Machilipatnam','Andhra Pradesh');
INSERT INTO CITY VALUES(10196,'Rae Bareli','Uttar Pradesh');
INSERT INTO CITY VALUES(10197,'Jalpaiguri','West Bengal');
INSERT INTO CITY VALUES(10198,'Bharuch','Gujarat');
INSERT INTO CITY VALUES(10199,'Pathankot','Punjab');
INSERT INTO CITY VALUES(10200,'Hoshiarpur','Punjab');
INSERT INTO CITY VALUES(10201,'Baramula','Jammu and Kashmir');
INSERT INTO CITY VALUES(10202,'Adoni','Andhra Pradesh');
INSERT INTO CITY VALUES(10203,'Jind','Haryana');
INSERT INTO CITY VALUES(10204,'Tonk','Rajasthan');
INSERT INTO CITY VALUES(10205,'Tenali','Andhra Pradesh');
INSERT INTO CITY VALUES(10206,'Kancheepuram','Tamil Nadu');
INSERT INTO CITY VALUES(10207,'Vapi','Gujarat');
INSERT INTO CITY VALUES(10208,'Sirsa','Haryana');
INSERT INTO CITY VALUES(10209,'Navsari','Gujarat');
INSERT INTO CITY VALUES(10210,'Mahbubnagar','Telangana');
INSERT INTO CITY VALUES(10211,'Puri','Odisha');
INSERT INTO CITY VALUES(10212,'Robertson Pet','Karnataka');
INSERT INTO CITY VALUES(10213,'Erode','Tamil Nadu');
INSERT INTO CITY VALUES(10214,'Batala','Punjab');
INSERT INTO CITY VALUES(10215,'Haldwani-cum-Kathgodam','Uttarakhand');
INSERT INTO CITY VALUES(10216,'Vidisha','Madhya Pradesh');
INSERT INTO CITY VALUES(10217,'Saharsa','Bihar');
INSERT INTO CITY VALUES(10218,'Thanesar','Haryana');
INSERT INTO CITY VALUES(10219,'Chittoor','Andhra Pradesh');
INSERT INTO CITY VALUES(10220,'Veraval','Gujarat');
INSERT INTO CITY VALUES(10221,'Lakhimpur','Uttar Pradesh');
INSERT INTO CITY VALUES(10222,'Sitapur','Uttar Pradesh');
INSERT INTO CITY VALUES(10223,'Hindupur','Andhra Pradesh');
INSERT INTO CITY VALUES(10224,'Santipur','West Bengal');
INSERT INTO CITY VALUES(10225,'Balurghat','West Bengal');
INSERT INTO CITY VALUES(10226,'Ganjbasoda','Madhya Pradesh');
INSERT INTO CITY VALUES(10227,'Moga','Punjab');
INSERT INTO CITY VALUES(10228,'Proddatur','Andhra Pradesh');
INSERT INTO CITY VALUES(10229,'Srinagar','Uttarakhand');
INSERT INTO CITY VALUES(10230,'Medinipur','West Bengal');
INSERT INTO CITY VALUES(10231,'Habra','West Bengal');
INSERT INTO CITY VALUES(10232,'Sasaram','Bihar');
INSERT INTO CITY VALUES(10233,'Hajipur','Bihar');
INSERT INTO CITY VALUES(10234,'Bhuj','Gujarat');
INSERT INTO CITY VALUES(10235,'Shivpuri','Madhya Pradesh');
INSERT INTO CITY VALUES(10236,'Ranaghat','West Bengal');
INSERT INTO CITY VALUES(10237,'Shimla','Himachal Pradesh');
INSERT INTO CITY VALUES(10238,'Tiruvannamalai','Tamil Nadu');
INSERT INTO CITY VALUES(10239,'Kaithal','Haryana');
INSERT INTO CITY VALUES(10240,'Rajnandgaon','Chhattisgarh');
INSERT INTO CITY VALUES(10241,'Godhra','Gujarat');
INSERT INTO CITY VALUES(10242,'Hazaribag','Jharkhand');
INSERT INTO CITY VALUES(10243,'Bhimavaram','Andhra Pradesh');
INSERT INTO CITY VALUES(10244,'Mandsaur','Madhya Pradesh');
INSERT INTO CITY VALUES(10245,'Dibrugarh','Assam');
INSERT INTO CITY VALUES(10246,'Kolar','Karnataka');
INSERT INTO CITY VALUES(10247,'Bankura','West Bengal');
INSERT INTO CITY VALUES(10248,'Mandya','Karnataka');
INSERT INTO CITY VALUES(10249,'Dehri-on-Sone','Bihar');
INSERT INTO CITY VALUES(10250,'Madanapalle','Andhra Pradesh');
INSERT INTO CITY VALUES(10251,'Malerkotla','Punjab');
INSERT INTO CITY VALUES(10252,'Lalitpur','Uttar Pradesh');
INSERT INTO CITY VALUES(10253,'Bettiah','Bihar');
INSERT INTO CITY VALUES(10254,'Pollachi','Tamil Nadu');
INSERT INTO CITY VALUES(10255,'Khanna','Punjab');
INSERT INTO CITY VALUES(10256,'Neemuch','Madhya Pradesh');
INSERT INTO CITY VALUES(10257,'Palwal','Haryana');
INSERT INTO CITY VALUES(10258,'Palanpur','Gujarat');
INSERT INTO CITY VALUES(10259,'Guntakal','Andhra Pradesh');
INSERT INTO CITY VALUES(10260,'Nabadwip','West Bengal');
INSERT INTO CITY VALUES(10261,'Udupi','Karnataka');
INSERT INTO CITY VALUES(10262,'Jagdalpur','Chhattisgarh');
INSERT INTO CITY VALUES(10263,'Motihari','Bihar');
INSERT INTO CITY VALUES(10264,'Pilibhit','Uttar Pradesh');
INSERT INTO CITY VALUES(10265,'Dimapur','Nagaland');
INSERT INTO CITY VALUES(10266,'Mohali','Punjab');
INSERT INTO CITY VALUES(10267,'Sadulpur','Rajasthan');
INSERT INTO CITY VALUES(10268,'Rajapalayam','Tamil Nadu');
INSERT INTO CITY VALUES(10269,'Dharmavaram','Andhra Pradesh');
INSERT INTO CITY VALUES(10270,'Kashipur','Uttarakhand');
INSERT INTO CITY VALUES(10271,'Sivakasi','Tamil Nadu');
INSERT INTO CITY VALUES(10272,'Darjiling','West Bengal');
INSERT INTO CITY VALUES(10273,'Chikkamagaluru','Karnataka');
INSERT INTO CITY VALUES(10274,'Gudivada','Andhra Pradesh');
INSERT INTO CITY VALUES(10275,'Baleshwar Town','Odisha');
INSERT INTO CITY VALUES(10276,'Mancherial','Telangana');
INSERT INTO CITY VALUES(10277,'Srikakulam','Andhra Pradesh');
INSERT INTO CITY VALUES(10278,'Adilabad','Telangana');
INSERT INTO CITY VALUES(10279,'Yavatmal','Maharashtra');
INSERT INTO CITY VALUES(10280,'Barnala','Punjab');
INSERT INTO CITY VALUES(10281,'Nagaon','Assam');
INSERT INTO CITY VALUES(10282,'Narasaraopet','Andhra Pradesh');
INSERT INTO CITY VALUES(10283,'Raigarh','Chhattisgarh');
INSERT INTO CITY VALUES(10284,'Roorkee','Uttarakhand');
INSERT INTO CITY VALUES(10285,'Valsad','Gujarat');
INSERT INTO CITY VALUES(10286,'Ambikapur','Chhattisgarh');
INSERT INTO CITY VALUES(10287,'Giridih','Jharkhand');
INSERT INTO CITY VALUES(10288,'Chandausi','Uttar Pradesh');
INSERT INTO CITY VALUES(10289,'Purulia','West Bengal');
INSERT INTO CITY VALUES(10290,'Patan','Gujarat');
INSERT INTO CITY VALUES(10291,'Bagaha','Bihar');
INSERT INTO CITY VALUES(10292,'Hardoi ','Uttar Pradesh');
INSERT INTO CITY VALUES(10293,'Achalpur','Maharashtra');
INSERT INTO CITY VALUES(10294,'Osmanabad','Maharashtra');
INSERT INTO CITY VALUES(10295,'Deesa','Gujarat');
INSERT INTO CITY VALUES(10296,'Nandurbar','Maharashtra');
INSERT INTO CITY VALUES(10297,'Azamgarh','Uttar Pradesh');
INSERT INTO CITY VALUES(10298,'Ramgarh','Jharkhand');
INSERT INTO CITY VALUES(10299,'Firozpur','Punjab');
INSERT INTO CITY VALUES(10300,'Baripada Town','Odisha');
INSERT INTO CITY VALUES(10301,'Karwar','Karnataka');
INSERT INTO CITY VALUES(10302,'Siwan','Bihar');
INSERT INTO CITY VALUES(10303,'Rajampet','Andhra Pradesh');
INSERT INTO CITY VALUES(10304,'Pudukkottai','Tamil Nadu');
INSERT INTO CITY VALUES(10305,'Anantnag','Jammu and Kashmir');
INSERT INTO CITY VALUES(10306,'Tadpatri','Andhra Pradesh');
INSERT INTO CITY VALUES(10307,'Satara','Maharashtra');
INSERT INTO CITY VALUES(10308,'Bhadrak','Odisha');
INSERT INTO CITY VALUES(10309,'Kishanganj','Bihar');
INSERT INTO CITY VALUES(10310,'Suryapet','Telangana');
INSERT INTO CITY VALUES(10311,'Wardha','Maharashtra');
INSERT INTO CITY VALUES(10312,'Ranebennuru','Karnataka');
INSERT INTO CITY VALUES(10313,'Amreli','Gujarat');
INSERT INTO CITY VALUES(10314,'Neyveli (TS)','Tamil Nadu');
INSERT INTO CITY VALUES(10315,'Jamalpur','Bihar');
INSERT INTO CITY VALUES(10316,'Marmagao','Goa');
INSERT INTO CITY VALUES(10317,'Udgir','Maharashtra');
INSERT INTO CITY VALUES(10318,'Tadepalligudem','Andhra Pradesh');
INSERT INTO CITY VALUES(10319,'Nagapattinam','Tamil Nadu');
INSERT INTO CITY VALUES(10320,'Buxar','Bihar');
INSERT INTO CITY VALUES(10321,'Aurangabad','Maharashtra');
INSERT INTO CITY VALUES(10322,'Jehanabad','Bihar');
INSERT INTO CITY VALUES(10323,'Phagwara','Punjab');
INSERT INTO CITY VALUES(10324,'Khair','Uttar Pradesh');
INSERT INTO CITY VALUES(10325,'Sawai Madhopur','Rajasthan');
INSERT INTO CITY VALUES(10326,'Kapurthala','Punjab');
INSERT INTO CITY VALUES(10327,'Chilakaluripet','Andhra Pradesh');
INSERT INTO CITY VALUES(10328,'Aurangabad','Bihar');
INSERT INTO CITY VALUES(10329,'Malappuram','Kerala');
INSERT INTO CITY VALUES(10330,'Rewari','Haryana');
INSERT INTO CITY VALUES(10331,'Nagaur','Rajasthan');
INSERT INTO CITY VALUES(10332,'Sultanpur','Uttar Pradesh');
INSERT INTO CITY VALUES(10333,'Nagda','Madhya Pradesh');
INSERT INTO CITY VALUES(10334,'Port Blair','Andaman and Nicobar Islands');
INSERT INTO CITY VALUES(10335,'Lakhisarai','Bihar');
INSERT INTO CITY VALUES(10336,'Panaji','Goa');
INSERT INTO CITY VALUES(10337,'Tinsukia','Assam');
INSERT INTO CITY VALUES(10338,'Itarsi','Madhya Pradesh');
INSERT INTO CITY VALUES(10339,'Kohima','Nagaland');
INSERT INTO CITY VALUES(10340,'Balangir','Odisha');
INSERT INTO CITY VALUES(10341,'Nawada','Bihar');
INSERT INTO CITY VALUES(10342,'Jharsuguda','Odisha');
INSERT INTO CITY VALUES(10343,'Jagtial','Telangana');
INSERT INTO CITY VALUES(10344,'Viluppuram','Tamil Nadu');
INSERT INTO CITY VALUES(10345,'Amalner','Maharashtra');
INSERT INTO CITY VALUES(10346,'Zirakpur','Punjab');
INSERT INTO CITY VALUES(10347,'Tanda','Uttar Pradesh');
INSERT INTO CITY VALUES(10348,'Tiruchengode','Tamil Nadu');
INSERT INTO CITY VALUES(10349,'Nagina','Uttar Pradesh');
INSERT INTO CITY VALUES(10350,'Yemmiganur','Andhra Pradesh');
INSERT INTO CITY VALUES(10351,'Vaniyambadi','Tamil Nadu');
INSERT INTO CITY VALUES(10352,'Sarni','Madhya Pradesh');
INSERT INTO CITY VALUES(10353,'Theni Allinagaram','Tamil Nadu');
INSERT INTO CITY VALUES(10354,'Margao','Goa');
INSERT INTO CITY VALUES(10355,'Akot','Maharashtra');
INSERT INTO CITY VALUES(10356,'Sehore','Madhya Pradesh');
INSERT INTO CITY VALUES(10357,'Mhow Cantonment','Madhya Pradesh');
INSERT INTO CITY VALUES(10358,'Kot Kapura','Punjab');
INSERT INTO CITY VALUES(10359,'Makrana','Rajasthan');
INSERT INTO CITY VALUES(10360,'Pandharpur','Maharashtra');
INSERT INTO CITY VALUES(10361,'Miryalaguda','Telangana');
INSERT INTO CITY VALUES(10362,'Shamli','Uttar Pradesh');
INSERT INTO CITY VALUES(10363,'Seoni','Madhya Pradesh');
INSERT INTO CITY VALUES(10364,'Ranibennur','Karnataka');
INSERT INTO CITY VALUES(10365,'Kadiri','Andhra Pradesh');
INSERT INTO CITY VALUES(10366,'Shrirampur','Maharashtra');
INSERT INTO CITY VALUES(10367,'Rudrapur','Uttarakhand');
INSERT INTO CITY VALUES(10368,'Parli','Maharashtra');
INSERT INTO CITY VALUES(10369,'Najibabad','Uttar Pradesh');
INSERT INTO CITY VALUES(10370,'Nirmal','Telangana');
INSERT INTO CITY VALUES(10371,'Udhagamandalam','Tamil Nadu');
INSERT INTO CITY VALUES(10372,'Shikohabad','Uttar Pradesh');
INSERT INTO CITY VALUES(10373,'Jhumri Tilaiya','Jharkhand');
INSERT INTO CITY VALUES(10374,'Aruppukkottai','Tamil Nadu');
INSERT INTO CITY VALUES(10375,'Ponnani','Kerala');
INSERT INTO CITY VALUES(10376,'Jamui','Bihar');
INSERT INTO CITY VALUES(10377,'Sitamarhi','Bihar');
INSERT INTO CITY VALUES(10378,'Chirala','Andhra Pradesh');
INSERT INTO CITY VALUES(10379,'Anjar','Gujarat');
INSERT INTO CITY VALUES(10380,'Karaikal','Puducherry');
INSERT INTO CITY VALUES(10381,'Hansi','Haryana');
INSERT INTO CITY VALUES(10382,'Anakapalle','Andhra Pradesh');
INSERT INTO CITY VALUES(10383,'Mahasamund','Chhattisgarh');
INSERT INTO CITY VALUES(10384,'Faridkot','Punjab');
INSERT INTO CITY VALUES(10385,'Saunda','Jharkhand');
INSERT INTO CITY VALUES(10386,'Dhoraji','Gujarat');
INSERT INTO CITY VALUES(10387,'Paramakudi','Tamil Nadu');
INSERT INTO CITY VALUES(10388,'Balaghat','Madhya Pradesh');
INSERT INTO CITY VALUES(10389,'Sujangarh','Rajasthan');
INSERT INTO CITY VALUES(10390,'Khambhat','Gujarat');
INSERT INTO CITY VALUES(10391,'Muktsar','Punjab');
INSERT INTO CITY VALUES(10392,'Rajpura','Punjab');
INSERT INTO CITY VALUES(10393,'Kavali','Andhra Pradesh');
INSERT INTO CITY VALUES(10394,'Dhamtari','Chhattisgarh');
INSERT INTO CITY VALUES(10395,'Ashok Nagar','Madhya Pradesh');
INSERT INTO CITY VALUES(10396,'Sardarshahar','Rajasthan');
INSERT INTO CITY VALUES(10397,'Mahuva','Gujarat');
INSERT INTO CITY VALUES(10398,'Bargarh','Odisha');
INSERT INTO CITY VALUES(10399,'Kamareddy','Telangana');
INSERT INTO CITY VALUES(10400,'Sahibganj','Jharkhand');
INSERT INTO CITY VALUES(10401,'Kothagudem','Telangana');
INSERT INTO CITY VALUES(10402,'Ramanagaram','Karnataka');
INSERT INTO CITY VALUES(10403,'Gokak','Karnataka');
INSERT INTO CITY VALUES(10404,'Tikamgarh','Madhya Pradesh');
INSERT INTO CITY VALUES(10405,'Araria','Bihar');
INSERT INTO CITY VALUES(10406,'Rishikesh','Uttarakhand');
INSERT INTO CITY VALUES(10407,'Shahdol','Madhya Pradesh');
INSERT INTO CITY VALUES(10408,'Medininagar (Daltonganj)','Jharkhand');
INSERT INTO CITY VALUES(10409,'Arakkonam','Tamil Nadu');
INSERT INTO CITY VALUES(10410,'Washim','Maharashtra');
INSERT INTO CITY VALUES(10411,'Sangrur','Punjab');
INSERT INTO CITY VALUES(10412,'Bodhan','Telangana');
INSERT INTO CITY VALUES(10413,'Fazilka','Punjab');
INSERT INTO CITY VALUES(10414,'Palacole','Andhra Pradesh');
INSERT INTO CITY VALUES(10415,'Keshod','Gujarat');
INSERT INTO CITY VALUES(10416,'Sullurpeta','Andhra Pradesh');
INSERT INTO CITY VALUES(10417,'Wadhwan','Gujarat');
INSERT INTO CITY VALUES(10418,'Gurdaspur','Punjab');
INSERT INTO CITY VALUES(10419,'Vatakara','Kerala');
INSERT INTO CITY VALUES(10420,'Tura','Meghalaya');
INSERT INTO CITY VALUES(10421,'Narnaul','Haryana');
INSERT INTO CITY VALUES(10422,'Kharar','Punjab');
INSERT INTO CITY VALUES(10423,'Yadgir','Karnataka');
INSERT INTO CITY VALUES(10424,'Ambejogai','Maharashtra');
INSERT INTO CITY VALUES(10425,'Ankleshwar','Gujarat');
INSERT INTO CITY VALUES(10426,'Savarkundla','Gujarat');
INSERT INTO CITY VALUES(10427,'Paradip','Odisha');
INSERT INTO CITY VALUES(10428,'Virudhachalam','Tamil Nadu');
INSERT INTO CITY VALUES(10429,'Kanhangad','Kerala');
INSERT INTO CITY VALUES(10430,'Kadi','Gujarat');
INSERT INTO CITY VALUES(10431,'Srivilliputhur','Tamil Nadu');
INSERT INTO CITY VALUES(10432,'Gobindgarh','Punjab');
INSERT INTO CITY VALUES(10433,'Tindivanam','Tamil Nadu');
INSERT INTO CITY VALUES(10434,'Mansa','Punjab');
INSERT INTO CITY VALUES(10435,'Taliparamba','Kerala');
INSERT INTO CITY VALUES(10436,'Manmad','Maharashtra');
INSERT INTO CITY VALUES(10437,'Tanuku','Andhra Pradesh');
INSERT INTO CITY VALUES(10438,'Rayachoti','Andhra Pradesh');
INSERT INTO CITY VALUES(10439,'Virudhunagar','Tamil Nadu');
INSERT INTO CITY VALUES(10440,'Koyilandy','Kerala');
INSERT INTO CITY VALUES(10441,'Jorhat','Assam');
INSERT INTO CITY VALUES(10442,'Karur','Tamil Nadu');
INSERT INTO CITY VALUES(10443,'Valparai','Tamil Nadu');
INSERT INTO CITY VALUES(10444,'Srikalahasti','Andhra Pradesh');
INSERT INTO CITY VALUES(10445,'Neyyattinkara','Kerala');
INSERT INTO CITY VALUES(10446,'Bapatla','Andhra Pradesh');
INSERT INTO CITY VALUES(10447,'Fatehabad','Haryana');
INSERT INTO CITY VALUES(10448,'Malout','Punjab');
INSERT INTO CITY VALUES(10449,'Sankarankovil','Tamil Nadu');
INSERT INTO CITY VALUES(10450,'Tenkasi','Tamil Nadu');
INSERT INTO CITY VALUES(10451,'Ratnagiri','Maharashtra');
INSERT INTO CITY VALUES(10452,'Rabkavi Banhatti','Karnataka');
INSERT INTO CITY VALUES(10453,'Sikandrabad','Uttar Pradesh');
INSERT INTO CITY VALUES(10454,'Chaibasa','Jharkhand');
INSERT INTO CITY VALUES(10455,'Chirmiri','Chhattisgarh');
INSERT INTO CITY VALUES(10456,'Palwancha','Telangana');
INSERT INTO CITY VALUES(10457,'Bhawanipatna','Odisha');
INSERT INTO CITY VALUES(10458,'Kayamkulam','Kerala');
INSERT INTO CITY VALUES(10459,'Pithampur','Madhya Pradesh');
INSERT INTO CITY VALUES(10460,'Nabha','Punjab');
INSERT INTO CITY VALUES(10461,'"Shahabad','Hardoi"');
INSERT INTO CITY VALUES(10462,'Dhenkanal','Odisha');
INSERT INTO CITY VALUES(10463,'Uran Islampur','Maharashtra');
INSERT INTO CITY VALUES(10464,'Gopalganj','Bihar');
INSERT INTO CITY VALUES(10465,'Bongaigaon City','Assam');
INSERT INTO CITY VALUES(10466,'Palani','Tamil Nadu');
INSERT INTO CITY VALUES(10467,'Pusad','Maharashtra');
INSERT INTO CITY VALUES(10468,'Sopore','Jammu and Kashmir');
INSERT INTO CITY VALUES(10469,'Pilkhuwa','Uttar Pradesh');
INSERT INTO CITY VALUES(10470,'Tarn Taran','Punjab');
INSERT INTO CITY VALUES(10471,'Renukoot','Uttar Pradesh');
INSERT INTO CITY VALUES(10472,'Mandamarri','Telangana');
INSERT INTO CITY VALUES(10473,'Shahabad','Karnataka');
INSERT INTO CITY VALUES(10474,'Barbil','Odisha');
INSERT INTO CITY VALUES(10475,'Koratla','Telangana');
INSERT INTO CITY VALUES(10476,'Madhubani','Bihar');
INSERT INTO CITY VALUES(10477,'Arambagh','West Bengal');
INSERT INTO CITY VALUES(10478,'Gohana','Haryana');
INSERT INTO CITY VALUES(10479,'Ladnu','Rajasthan');
INSERT INTO CITY VALUES(10480,'Pattukkottai','Tamil Nadu');
INSERT INTO CITY VALUES(10481,'Sirsi','Karnataka');
INSERT INTO CITY VALUES(10482,'Sircilla','Telangana');
INSERT INTO CITY VALUES(10483,'Tamluk','West Bengal');
INSERT INTO CITY VALUES(10484,'Jagraon','Punjab');
INSERT INTO CITY VALUES(10485,'AlipurdUrban Agglomerationr','West Bengal');
INSERT INTO CITY VALUES(10486,'Alirajpur','Madhya Pradesh');
INSERT INTO CITY VALUES(10487,'Tandur','Telangana');
INSERT INTO CITY VALUES(10488,'Naidupet','Andhra Pradesh');
INSERT INTO CITY VALUES(10489,'Tirupathur','Tamil Nadu');
INSERT INTO CITY VALUES(10490,'Tohana','Haryana');
INSERT INTO CITY VALUES(10491,'Ratangarh','Rajasthan');
INSERT INTO CITY VALUES(10492,'Dhubri','Assam');
INSERT INTO CITY VALUES(10493,'Masaurhi','Bihar');
INSERT INTO CITY VALUES(10494,'Visnagar','Gujarat');
INSERT INTO CITY VALUES(10495,'Vrindavan','Uttar Pradesh');
INSERT INTO CITY VALUES(10496,'Nokha','Rajasthan');
INSERT INTO CITY VALUES(10497,'Nagari','Andhra Pradesh');
INSERT INTO CITY VALUES(10498,'Narwana','Haryana');
INSERT INTO CITY VALUES(10499,'Ramanathapuram','Tamil Nadu');
INSERT INTO CITY VALUES(10500,'Ujhani','Uttar Pradesh');
INSERT INTO CITY VALUES(10501,'Samastipur','Bihar');
INSERT INTO CITY VALUES(10502,'Laharpur','Uttar Pradesh');
INSERT INTO CITY VALUES(10503,'Sangamner','Maharashtra');
INSERT INTO CITY VALUES(10504,'Nimbahera','Rajasthan');
INSERT INTO CITY VALUES(10505,'Siddipet','Telangana');
INSERT INTO CITY VALUES(10506,'Suri','West Bengal');
INSERT INTO CITY VALUES(10507,'Diphu','Assam');
INSERT INTO CITY VALUES(10508,'Jhargram','West Bengal');
INSERT INTO CITY VALUES(10509,'Shirpur-Warwade','Maharashtra');
INSERT INTO CITY VALUES(10510,'Tilhar','Uttar Pradesh');
INSERT INTO CITY VALUES(10511,'Sindhnur','Karnataka');
INSERT INTO CITY VALUES(10512,'Udumalaipettai','Tamil Nadu');
INSERT INTO CITY VALUES(10513,'Malkapur','Maharashtra');
INSERT INTO CITY VALUES(10514,'Wanaparthy','Telangana');
INSERT INTO CITY VALUES(10515,'Gudur','Andhra Pradesh');
INSERT INTO CITY VALUES(10516,'Kendujhar','Odisha');
INSERT INTO CITY VALUES(10517,'Mandla','Madhya Pradesh');
INSERT INTO CITY VALUES(10518,'Mandi','Himachal Pradesh');
INSERT INTO CITY VALUES(10519,'Nedumangad','Kerala');
INSERT INTO CITY VALUES(10520,'North Lakhimpur','Assam');
INSERT INTO CITY VALUES(10521,'Vinukonda','Andhra Pradesh');
INSERT INTO CITY VALUES(10522,'Tiptur','Karnataka');
INSERT INTO CITY VALUES(10523,'Gobichettipalayam','Tamil Nadu');
INSERT INTO CITY VALUES(10524,'Sunabeda','Odisha');
INSERT INTO CITY VALUES(10525,'Wani','Maharashtra');
INSERT INTO CITY VALUES(10526,'Upleta','Gujarat');
INSERT INTO CITY VALUES(10527,'Narasapuram','Andhra Pradesh');
INSERT INTO CITY VALUES(10528,'Nuzvid','Andhra Pradesh');
INSERT INTO CITY VALUES(10529,'Tezpur','Assam');
INSERT INTO CITY VALUES(10530,'Una','Gujarat');
INSERT INTO CITY VALUES(10531,'Markapur','Andhra Pradesh');
INSERT INTO CITY VALUES(10532,'Sheopur','Madhya Pradesh');
INSERT INTO CITY VALUES(10533,'Thiruvarur','Tamil Nadu');
INSERT INTO CITY VALUES(10534,'Sidhpur','Gujarat');
INSERT INTO CITY VALUES(10535,'Sahaswan','Uttar Pradesh');
INSERT INTO CITY VALUES(10536,'Suratgarh','Rajasthan');
INSERT INTO CITY VALUES(10537,'Shajapur','Madhya Pradesh');
INSERT INTO CITY VALUES(10538,'Rayagada','Odisha');
INSERT INTO CITY VALUES(10539,'Lonavla','Maharashtra');
INSERT INTO CITY VALUES(10540,'Ponnur','Andhra Pradesh');
INSERT INTO CITY VALUES(10541,'Kagaznagar','Telangana');
INSERT INTO CITY VALUES(10542,'Gadwal','Telangana');
INSERT INTO CITY VALUES(10543,'Bhatapara','Chhattisgarh');
INSERT INTO CITY VALUES(10544,'Kandukur','Andhra Pradesh');
INSERT INTO CITY VALUES(10545,'Sangareddy','Telangana');
INSERT INTO CITY VALUES(10546,'Unjha','Gujarat');
INSERT INTO CITY VALUES(10547,'Lunglei','Mizoram');
INSERT INTO CITY VALUES(10548,'Karimganj','Assam');
INSERT INTO CITY VALUES(10549,'Kannur','Kerala');
INSERT INTO CITY VALUES(10550,'Bobbili','Andhra Pradesh');
INSERT INTO CITY VALUES(10551,'Mokameh','Bihar');
INSERT INTO CITY VALUES(10552,'Talegaon Dabhade','Maharashtra');
INSERT INTO CITY VALUES(10553,'Anjangaon','Maharashtra');
INSERT INTO CITY VALUES(10554,'Mangrol','Gujarat');
INSERT INTO CITY VALUES(10555,'Sunam','Punjab');
INSERT INTO CITY VALUES(10556,'Gangarampur','West Bengal');
INSERT INTO CITY VALUES(10557,'Thiruvallur','Tamil Nadu');
INSERT INTO CITY VALUES(10558,'Tirur','Kerala');
INSERT INTO CITY VALUES(10559,'Rath','Uttar Pradesh');
INSERT INTO CITY VALUES(10560,'Jatani','Odisha');
INSERT INTO CITY VALUES(10561,'Viramgam','Gujarat');
INSERT INTO CITY VALUES(10562,'Rajsamand','Rajasthan');
INSERT INTO CITY VALUES(10563,'Yanam','Puducherry');
INSERT INTO CITY VALUES(10564,'Kottayam','Kerala');
INSERT INTO CITY VALUES(10565,'Panruti','Tamil Nadu');
INSERT INTO CITY VALUES(10566,'Dhuri','Punjab');
INSERT INTO CITY VALUES(10567,'Namakkal','Tamil Nadu');
INSERT INTO CITY VALUES(10568,'Kasaragod','Kerala');
INSERT INTO CITY VALUES(10569,'Modasa','Gujarat');
INSERT INTO CITY VALUES(10570,'Rayadurg','Andhra Pradesh');
INSERT INTO CITY VALUES(10571,'Supaul','Bihar');
INSERT INTO CITY VALUES(10572,'Kunnamkulam','Kerala');
INSERT INTO CITY VALUES(10573,'Umred','Maharashtra');
INSERT INTO CITY VALUES(10574,'Bellampalle','Telangana');
INSERT INTO CITY VALUES(10575,'Sibsagar','Assam');
INSERT INTO CITY VALUES(10576,'Mandi Dabwali','Haryana');
INSERT INTO CITY VALUES(10577,'Ottappalam','Kerala');
INSERT INTO CITY VALUES(10578,'Dumraon','Bihar');
INSERT INTO CITY VALUES(10579,'Samalkot','Andhra Pradesh');
INSERT INTO CITY VALUES(10580,'Jaggaiahpet','Andhra Pradesh');
INSERT INTO CITY VALUES(10581,'Goalpara','Assam');
INSERT INTO CITY VALUES(10582,'Tuni','Andhra Pradesh');
INSERT INTO CITY VALUES(10583,'Lachhmangarh','Rajasthan');
INSERT INTO CITY VALUES(10584,'Bhongir','Telangana');
INSERT INTO CITY VALUES(10585,'Amalapuram','Andhra Pradesh');
INSERT INTO CITY VALUES(10586,'Firozpur Cantt.','Punjab');
INSERT INTO CITY VALUES(10587,'Vikarabad','Telangana');
INSERT INTO CITY VALUES(10588,'Thiruvalla','Kerala');
INSERT INTO CITY VALUES(10589,'Sherkot','Uttar Pradesh');
INSERT INTO CITY VALUES(10590,'Palghar','Maharashtra');
INSERT INTO CITY VALUES(10591,'Shegaon','Maharashtra');
INSERT INTO CITY VALUES(10592,'Jangaon','Telangana');
INSERT INTO CITY VALUES(10593,'Bheemunipatnam','Andhra Pradesh');
INSERT INTO CITY VALUES(10594,'Panna','Madhya Pradesh');
INSERT INTO CITY VALUES(10595,'Thodupuzha','Kerala');
INSERT INTO CITY VALUES(10596,'KathUrban Agglomeration','Jammu and Kashmir');
INSERT INTO CITY VALUES(10597,'Palitana','Gujarat');
INSERT INTO CITY VALUES(10598,'Arwal','Bihar');
INSERT INTO CITY VALUES(10599,'Venkatagiri','Andhra Pradesh');
INSERT INTO CITY VALUES(10600,'Kalpi','Uttar Pradesh');
INSERT INTO CITY VALUES(10601,'Rajgarh (Churu)','Rajasthan');
INSERT INTO CITY VALUES(10602,'Sattenapalle','Andhra Pradesh');
INSERT INTO CITY VALUES(10603,'Arsikere','Karnataka');
INSERT INTO CITY VALUES(10604,'Ozar','Maharashtra');
INSERT INTO CITY VALUES(10605,'Thirumangalam','Tamil Nadu');
INSERT INTO CITY VALUES(10606,'Petlad','Gujarat');
INSERT INTO CITY VALUES(10607,'Nasirabad','Rajasthan');
INSERT INTO CITY VALUES(10608,'Phaltan','Maharashtra');
INSERT INTO CITY VALUES(10609,'Rampurhat','West Bengal');
INSERT INTO CITY VALUES(10610,'Nanjangud','Karnataka');
INSERT INTO CITY VALUES(10611,'Forbesganj','Bihar');
INSERT INTO CITY VALUES(10612,'Tundla','Uttar Pradesh');
INSERT INTO CITY VALUES(10613,'BhabUrban Agglomeration','Bihar');
INSERT INTO CITY VALUES(10614,'Sagara','Karnataka');
INSERT INTO CITY VALUES(10615,'Pithapuram','Andhra Pradesh');
INSERT INTO CITY VALUES(10616,'Sira','Karnataka');
INSERT INTO CITY VALUES(10617,'Bhadrachalam','Telangana');
INSERT INTO CITY VALUES(10618,'Charkhi Dadri','Haryana');
INSERT INTO CITY VALUES(10619,'Chatra','Jharkhand');
INSERT INTO CITY VALUES(10620,'Palasa Kasibugga','Andhra Pradesh');
INSERT INTO CITY VALUES(10621,'Nohar','Rajasthan');
INSERT INTO CITY VALUES(10622,'Yevla','Maharashtra');
INSERT INTO CITY VALUES(10623,'Sirhind Fatehgarh Sahib','Punjab');
INSERT INTO CITY VALUES(10624,'Bhainsa','Telangana');
INSERT INTO CITY VALUES(10625,'Parvathipuram','Andhra Pradesh');
INSERT INTO CITY VALUES(10626,'Shahade','Maharashtra');
INSERT INTO CITY VALUES(10627,'Chalakudy','Kerala');
INSERT INTO CITY VALUES(10628,'Narkatiaganj','Bihar');
INSERT INTO CITY VALUES(10629,'Kapadvanj','Gujarat');
INSERT INTO CITY VALUES(10630,'Macherla','Andhra Pradesh');
INSERT INTO CITY VALUES(10631,'Raghogarh-Vijaypur','Madhya Pradesh');
INSERT INTO CITY VALUES(10632,'Rupnagar','Punjab');
INSERT INTO CITY VALUES(10633,'Naugachhia','Bihar');
INSERT INTO CITY VALUES(10634,'Sendhwa','Madhya Pradesh');
INSERT INTO CITY VALUES(10635,'Byasanagar','Odisha');
INSERT INTO CITY VALUES(10636,'Sandila','Uttar Pradesh');
INSERT INTO CITY VALUES(10637,'Gooty','Andhra Pradesh');
INSERT INTO CITY VALUES(10638,'Salur','Andhra Pradesh');
INSERT INTO CITY VALUES(10639,'Nanpara','Uttar Pradesh');
INSERT INTO CITY VALUES(10640,'Sardhana','Uttar Pradesh');
INSERT INTO CITY VALUES(10641,'Vita','Maharashtra');
INSERT INTO CITY VALUES(10642,'Gumia','Jharkhand');
INSERT INTO CITY VALUES(10643,'Puttur','Karnataka');
INSERT INTO CITY VALUES(10644,'Jalandhar Cantt.','Punjab');
INSERT INTO CITY VALUES(10645,'Nehtaur','Uttar Pradesh');
INSERT INTO CITY VALUES(10646,'Changanassery','Kerala');
INSERT INTO CITY VALUES(10647,'Mandapeta','Andhra Pradesh');
INSERT INTO CITY VALUES(10648,'Dumka','Jharkhand');
INSERT INTO CITY VALUES(10649,'Seohara','Uttar Pradesh');
INSERT INTO CITY VALUES(10650,'Umarkhed','Maharashtra');
INSERT INTO CITY VALUES(10651,'Madhupur','Jharkhand');
INSERT INTO CITY VALUES(10652,'Vikramasingapuram','Tamil Nadu');
INSERT INTO CITY VALUES(10653,'Punalur','Kerala');
INSERT INTO CITY VALUES(10654,'Kendrapara','Odisha');
INSERT INTO CITY VALUES(10655,'Sihor','Gujarat');
INSERT INTO CITY VALUES(10656,'Nellikuppam','Tamil Nadu');
INSERT INTO CITY VALUES(10657,'Samana','Punjab');
INSERT INTO CITY VALUES(10658,'Warora','Maharashtra');
INSERT INTO CITY VALUES(10659,'Nilambur','Kerala');
INSERT INTO CITY VALUES(10660,'Rasipuram','Tamil Nadu');
INSERT INTO CITY VALUES(10661,'Ramnagar','Uttarakhand');
INSERT INTO CITY VALUES(10662,'Jammalamadugu','Andhra Pradesh');
INSERT INTO CITY VALUES(10663,'Nawanshahr','Punjab');
INSERT INTO CITY VALUES(10664,'Thoubal','Manipur');
INSERT INTO CITY VALUES(10665,'Athni','Karnataka');
INSERT INTO CITY VALUES(10666,'Cherthala','Kerala');
INSERT INTO CITY VALUES(10667,'Sidhi','Madhya Pradesh');
INSERT INTO CITY VALUES(10668,'Farooqnagar','Telangana');
INSERT INTO CITY VALUES(10669,'Peddapuram','Andhra Pradesh');
INSERT INTO CITY VALUES(10670,'Chirkunda','Jharkhand');
INSERT INTO CITY VALUES(10671,'Pachora','Maharashtra');
INSERT INTO CITY VALUES(10672,'Madhepura','Bihar');
INSERT INTO CITY VALUES(10673,'Pithoragarh','Uttarakhand');
INSERT INTO CITY VALUES(10674,'Tumsar','Maharashtra');
INSERT INTO CITY VALUES(10675,'Phalodi','Rajasthan');
INSERT INTO CITY VALUES(10676,'Tiruttani','Tamil Nadu');
INSERT INTO CITY VALUES(10677,'Rampura Phul','Punjab');
INSERT INTO CITY VALUES(10678,'Perinthalmanna','Kerala');
INSERT INTO CITY VALUES(10679,'Padrauna','Uttar Pradesh');
INSERT INTO CITY VALUES(10680,'Pipariya','Madhya Pradesh');
INSERT INTO CITY VALUES(10681,'Dalli-Rajhara','Chhattisgarh');
INSERT INTO CITY VALUES(10682,'Punganur','Andhra Pradesh');
INSERT INTO CITY VALUES(10683,'Mattannur','Kerala');
INSERT INTO CITY VALUES(10684,'Mathura','Uttar Pradesh');
INSERT INTO CITY VALUES(10685,'Thakurdwara','Uttar Pradesh');
INSERT INTO CITY VALUES(10686,'Nandivaram-Guduvancheri','Tamil Nadu');
INSERT INTO CITY VALUES(10687,'Mulbagal','Karnataka');
INSERT INTO CITY VALUES(10688,'Manjlegaon','Maharashtra');
INSERT INTO CITY VALUES(10689,'Wankaner','Gujarat');
INSERT INTO CITY VALUES(10690,'Sillod','Maharashtra');
INSERT INTO CITY VALUES(10691,'Nidadavole','Andhra Pradesh');
INSERT INTO CITY VALUES(10692,'Surapura','Karnataka');
INSERT INTO CITY VALUES(10693,'Rajagangapur','Odisha');
INSERT INTO CITY VALUES(10694,'Sheikhpura','Bihar');
INSERT INTO CITY VALUES(10695,'Parlakhemundi','Odisha');
INSERT INTO CITY VALUES(10696,'Kalimpong','West Bengal');
INSERT INTO CITY VALUES(10697,'Siruguppa','Karnataka');
INSERT INTO CITY VALUES(10698,'Arvi','Maharashtra');
INSERT INTO CITY VALUES(10699,'Limbdi','Gujarat');
INSERT INTO CITY VALUES(10700,'Barpeta','Assam');
INSERT INTO CITY VALUES(10701,'Manglaur','Uttarakhand');
INSERT INTO CITY VALUES(10702,'Repalle','Andhra Pradesh');
INSERT INTO CITY VALUES(10703,'Mudhol','Karnataka');
INSERT INTO CITY VALUES(10704,'Shujalpur','Madhya Pradesh');
INSERT INTO CITY VALUES(10705,'Mandvi','Gujarat');
INSERT INTO CITY VALUES(10706,'Thangadh','Gujarat');
INSERT INTO CITY VALUES(10707,'Sironj','Madhya Pradesh');
INSERT INTO CITY VALUES(10708,'Nandura','Maharashtra');
INSERT INTO CITY VALUES(10709,'Shoranur','Kerala');
INSERT INTO CITY VALUES(10710,'Nathdwara','Rajasthan');
INSERT INTO CITY VALUES(10711,'Periyakulam','Tamil Nadu');
INSERT INTO CITY VALUES(10712,'Sultanganj','Bihar');
INSERT INTO CITY VALUES(10713,'Medak','Telangana');
INSERT INTO CITY VALUES(10714,'Narayanpet','Telangana');
INSERT INTO CITY VALUES(10715,'Raxaul Bazar','Bihar');
INSERT INTO CITY VALUES(10716,'Rajauri','Jammu and Kashmir');
INSERT INTO CITY VALUES(10717,'Pernampattu','Tamil Nadu');
INSERT INTO CITY VALUES(10718,'Nainital','Uttarakhand');
INSERT INTO CITY VALUES(10719,'Ramachandrapuram','Andhra Pradesh');
INSERT INTO CITY VALUES(10720,'Vaijapur','Maharashtra');
INSERT INTO CITY VALUES(10721,'Nangal','Punjab');
INSERT INTO CITY VALUES(10722,'Sidlaghatta','Karnataka');
INSERT INTO CITY VALUES(10723,'Punch','Jammu and Kashmir');
INSERT INTO CITY VALUES(10724,'Pandhurna','Madhya Pradesh');
INSERT INTO CITY VALUES(10725,'Wadgaon Road','Maharashtra');
INSERT INTO CITY VALUES(10726,'Talcher','Odisha');
INSERT INTO CITY VALUES(10727,'Varkala','Kerala');
INSERT INTO CITY VALUES(10728,'Pilani','Rajasthan');
INSERT INTO CITY VALUES(10729,'Nowgong','Madhya Pradesh');
INSERT INTO CITY VALUES(10730,'Naila Janjgir','Chhattisgarh');
INSERT INTO CITY VALUES(10731,'Mapusa','Goa');
INSERT INTO CITY VALUES(10732,'Vellakoil','Tamil Nadu');
INSERT INTO CITY VALUES(10733,'Merta City','Rajasthan');
INSERT INTO CITY VALUES(10734,'Sivaganga','Tamil Nadu');
INSERT INTO CITY VALUES(10735,'Mandideep','Madhya Pradesh');
INSERT INTO CITY VALUES(10736,'Sailu','Maharashtra');
INSERT INTO CITY VALUES(10737,'Vyara','Gujarat');
INSERT INTO CITY VALUES(10738,'Kovvur','Andhra Pradesh');
INSERT INTO CITY VALUES(10739,'Vadalur','Tamil Nadu');
INSERT INTO CITY VALUES(10740,'Nawabganj','Uttar Pradesh');
INSERT INTO CITY VALUES(10741,'Padra','Gujarat');
INSERT INTO CITY VALUES(10742,'Sainthia','West Bengal');
INSERT INTO CITY VALUES(10743,'Siana','Uttar Pradesh');
INSERT INTO CITY VALUES(10744,'Shahpur','Karnataka');
INSERT INTO CITY VALUES(10745,'Sojat','Rajasthan');
INSERT INTO CITY VALUES(10746,'Noorpur','Uttar Pradesh');
INSERT INTO CITY VALUES(10747,'Paravoor','Kerala');
INSERT INTO CITY VALUES(10748,'Murtijapur','Maharashtra');
INSERT INTO CITY VALUES(10749,'Ramnagar','Bihar');
INSERT INTO CITY VALUES(10750,'Sundargarh','Odisha');
INSERT INTO CITY VALUES(10751,'Taki','West Bengal');
INSERT INTO CITY VALUES(10752,'Saundatti-Yellamma','Karnataka');
INSERT INTO CITY VALUES(10753,'Pathanamthitta','Kerala');
INSERT INTO CITY VALUES(10754,'Wadi','Karnataka');
INSERT INTO CITY VALUES(10755,'Rameshwaram','Tamil Nadu');
INSERT INTO CITY VALUES(10756,'Tasgaon','Maharashtra');
INSERT INTO CITY VALUES(10757,'Sikandra Rao','Uttar Pradesh');
INSERT INTO CITY VALUES(10758,'Sihora','Madhya Pradesh');
INSERT INTO CITY VALUES(10759,'Tiruvethipuram','Tamil Nadu');
INSERT INTO CITY VALUES(10760,'Tiruvuru','Andhra Pradesh');
INSERT INTO CITY VALUES(10761,'Mehkar','Maharashtra');
INSERT INTO CITY VALUES(10762,'Peringathur','Kerala');
INSERT INTO CITY VALUES(10763,'Perambalur','Tamil Nadu');
INSERT INTO CITY VALUES(10764,'Manvi','Karnataka');
INSERT INTO CITY VALUES(10765,'Zunheboto','Nagaland');
INSERT INTO CITY VALUES(10766,'Mahnar Bazar','Bihar');
INSERT INTO CITY VALUES(10767,'Attingal','Kerala');
INSERT INTO CITY VALUES(10768,'Shahbad','Haryana');
INSERT INTO CITY VALUES(10769,'Puranpur','Uttar Pradesh');
INSERT INTO CITY VALUES(10770,'Nelamangala','Karnataka');
INSERT INTO CITY VALUES(10771,'Nakodar','Punjab');
INSERT INTO CITY VALUES(10772,'Lunawada','Gujarat');
INSERT INTO CITY VALUES(10773,'Murshidabad','West Bengal');
INSERT INTO CITY VALUES(10774,'Mahe','Puducherry');
INSERT INTO CITY VALUES(10775,'Lanka','Assam');
INSERT INTO CITY VALUES(10776,'Rudauli','Uttar Pradesh');
INSERT INTO CITY VALUES(10777,'Tuensang','Nagaland');
INSERT INTO CITY VALUES(10778,'Lakshmeshwar','Karnataka');
INSERT INTO CITY VALUES(10779,'Zira','Punjab');
INSERT INTO CITY VALUES(10780,'Yawal','Maharashtra');
INSERT INTO CITY VALUES(10781,'Thana Bhawan','Uttar Pradesh');
INSERT INTO CITY VALUES(10782,'Ramdurg','Karnataka');
INSERT INTO CITY VALUES(10783,'Pulgaon','Maharashtra');
INSERT INTO CITY VALUES(10784,'Sadasivpet','Telangana');
INSERT INTO CITY VALUES(10785,'Nargund','Karnataka');
INSERT INTO CITY VALUES(10786,'Neem-Ka-Thana','Rajasthan');
INSERT INTO CITY VALUES(10787,'Memari','West Bengal');
INSERT INTO CITY VALUES(10788,'Nilanga','Maharashtra');
INSERT INTO CITY VALUES(10789,'Naharlagun','Arunachal Pradesh');
INSERT INTO CITY VALUES(10790,'Pakaur','Jharkhand');
INSERT INTO CITY VALUES(10791,'Wai','Maharashtra');
INSERT INTO CITY VALUES(10792,'Tarikere','Karnataka');
INSERT INTO CITY VALUES(10793,'Malavalli','Karnataka');
INSERT INTO CITY VALUES(10794,'Raisen','Madhya Pradesh');
INSERT INTO CITY VALUES(10795,'Lahar','Madhya Pradesh');
INSERT INTO CITY VALUES(10796,'Uravakonda','Andhra Pradesh');
INSERT INTO CITY VALUES(10797,'Savanur','Karnataka');
INSERT INTO CITY VALUES(10798,'Sirohi','Rajasthan');
INSERT INTO CITY VALUES(10799,'Udhampur','Jammu and Kashmir');
INSERT INTO CITY VALUES(10800,'Umarga','Maharashtra');
INSERT INTO CITY VALUES(10801,'Pratapgarh','Rajasthan');
INSERT INTO CITY VALUES(10802,'Lingsugur','Karnataka');
INSERT INTO CITY VALUES(10803,'Usilampatti','Tamil Nadu');
INSERT INTO CITY VALUES(10804,'Palia Kalan','Uttar Pradesh');
INSERT INTO CITY VALUES(10805,'Wokha','Nagaland');
INSERT INTO CITY VALUES(10806,'Rajpipla','Gujarat');
INSERT INTO CITY VALUES(10807,'Vijayapura','Karnataka');
INSERT INTO CITY VALUES(10808,'Rawatbhata','Rajasthan');
INSERT INTO CITY VALUES(10809,'Sangaria','Rajasthan');
INSERT INTO CITY VALUES(10810,'Paithan','Maharashtra');
INSERT INTO CITY VALUES(10811,'Rahuri','Maharashtra');
INSERT INTO CITY VALUES(10812,'Patti','Punjab');
INSERT INTO CITY VALUES(10813,'Zaidpur','Uttar Pradesh');
INSERT INTO CITY VALUES(10814,'Lalsot','Rajasthan');
INSERT INTO CITY VALUES(10815,'Maihar','Madhya Pradesh');
INSERT INTO CITY VALUES(10816,'Vedaranyam','Tamil Nadu');
INSERT INTO CITY VALUES(10817,'Nawapur','Maharashtra');
INSERT INTO CITY VALUES(10818,'Solan','Himachal Pradesh');
INSERT INTO CITY VALUES(10819,'Vapi','Gujarat');
INSERT INTO CITY VALUES(10820,'Sanawad','Madhya Pradesh');
INSERT INTO CITY VALUES(10821,'Warisaliganj','Bihar');
INSERT INTO CITY VALUES(10822,'Revelganj','Bihar');
INSERT INTO CITY VALUES(10823,'Sabalgarh','Madhya Pradesh');
INSERT INTO CITY VALUES(10824,'Tuljapur','Maharashtra');
INSERT INTO CITY VALUES(10825,'Simdega','Jharkhand');
INSERT INTO CITY VALUES(10826,'Musabani','Jharkhand');
INSERT INTO CITY VALUES(10827,'Kodungallur','Kerala');
INSERT INTO CITY VALUES(10828,'Phulabani','Odisha');
INSERT INTO CITY VALUES(10829,'Umreth','Gujarat');
INSERT INTO CITY VALUES(10830,'Narsipatnam','Andhra Pradesh');
INSERT INTO CITY VALUES(10831,'Nautanwa','Uttar Pradesh');
INSERT INTO CITY VALUES(10832,'Rajgir','Bihar');
INSERT INTO CITY VALUES(10833,'Yellandu','Telangana');
INSERT INTO CITY VALUES(10834,'Sathyamangalam','Tamil Nadu');
INSERT INTO CITY VALUES(10835,'Pilibanga','Rajasthan');
INSERT INTO CITY VALUES(10836,'Morshi','Maharashtra');
INSERT INTO CITY VALUES(10837,'Pehowa','Haryana');
INSERT INTO CITY VALUES(10838,'Sonepur','Bihar');
INSERT INTO CITY VALUES(10839,'Pappinisseri','Kerala');
INSERT INTO CITY VALUES(10840,'Zamania','Uttar Pradesh');
INSERT INTO CITY VALUES(10841,'Mihijam','Jharkhand');
INSERT INTO CITY VALUES(10842,'Purna','Maharashtra');
INSERT INTO CITY VALUES(10843,'Puliyankudi','Tamil Nadu');
INSERT INTO CITY VALUES(10844,'"Shikarpur','Bulandshahr"');
INSERT INTO CITY VALUES(10845,'Umaria','Madhya Pradesh');
INSERT INTO CITY VALUES(10846,'Porsa','Madhya Pradesh');
INSERT INTO CITY VALUES(10847,'Naugawan Sadat','Uttar Pradesh');
INSERT INTO CITY VALUES(10848,'Fatehpur Sikri','Uttar Pradesh');
INSERT INTO CITY VALUES(10849,'Manuguru','Telangana');
INSERT INTO CITY VALUES(10850,'Udaipur','Tripura');
INSERT INTO CITY VALUES(10851,'Pipar City','Rajasthan');
INSERT INTO CITY VALUES(10852,'Pattamundai','Odisha');
INSERT INTO CITY VALUES(10853,'Nanjikottai','Tamil Nadu');
INSERT INTO CITY VALUES(10854,'Taranagar','Rajasthan');
INSERT INTO CITY VALUES(10855,'Yerraguntla','Andhra Pradesh');
INSERT INTO CITY VALUES(10856,'Satana','Maharashtra');
INSERT INTO CITY VALUES(10857,'Sherghati','Bihar');
INSERT INTO CITY VALUES(10858,'Sankeshwara','Karnataka');
INSERT INTO CITY VALUES(10859,'Madikeri','Karnataka');
INSERT INTO CITY VALUES(10860,'Thuraiyur','Tamil Nadu');
INSERT INTO CITY VALUES(10861,'Sanand','Gujarat');
INSERT INTO CITY VALUES(10862,'Rajula','Gujarat');
INSERT INTO CITY VALUES(10863,'Kyathampalle','Telangana');
INSERT INTO CITY VALUES(10864,'"Shahabad','Rampur"');
INSERT INTO CITY VALUES(10865,'Tilda Newra','Chhattisgarh');
INSERT INTO CITY VALUES(10866,'Narsinghgarh','Madhya Pradesh');
INSERT INTO CITY VALUES(10867,'Chittur-Thathamangalam','Kerala');
INSERT INTO CITY VALUES(10868,'Malaj Khand','Madhya Pradesh');
INSERT INTO CITY VALUES(10869,'Sarangpur','Madhya Pradesh');
INSERT INTO CITY VALUES(10870,'Robertsganj','Uttar Pradesh');
INSERT INTO CITY VALUES(10871,'Sirkali','Tamil Nadu');
INSERT INTO CITY VALUES(10872,'Radhanpur','Gujarat');
INSERT INTO CITY VALUES(10873,'Tiruchendur','Tamil Nadu');
INSERT INTO CITY VALUES(10874,'Utraula','Uttar Pradesh');
INSERT INTO CITY VALUES(10875,'Patratu','Jharkhand');
INSERT INTO CITY VALUES(10876,'"Vijainagar','Ajmer"');
INSERT INTO CITY VALUES(10877,'Periyasemur','Tamil Nadu');
INSERT INTO CITY VALUES(10878,'Pathri','Maharashtra');
INSERT INTO CITY VALUES(10879,'Sadabad','Uttar Pradesh');
INSERT INTO CITY VALUES(10880,'Talikota','Karnataka');
INSERT INTO CITY VALUES(10881,'Sinnar','Maharashtra');
INSERT INTO CITY VALUES(10882,'Mungeli','Chhattisgarh');
INSERT INTO CITY VALUES(10883,'Sedam','Karnataka');
INSERT INTO CITY VALUES(10884,'Shikaripur','Karnataka');
INSERT INTO CITY VALUES(10885,'Sumerpur','Rajasthan');
INSERT INTO CITY VALUES(10886,'Sattur','Tamil Nadu');
INSERT INTO CITY VALUES(10887,'Sugauli','Bihar');
INSERT INTO CITY VALUES(10888,'Lumding','Assam');
INSERT INTO CITY VALUES(10889,'Vandavasi','Tamil Nadu');
INSERT INTO CITY VALUES(10890,'Titlagarh','Odisha');
INSERT INTO CITY VALUES(10891,'Uchgaon','Maharashtra');
INSERT INTO CITY VALUES(10892,'Mokokchung','Nagaland');
INSERT INTO CITY VALUES(10893,'Paschim Punropara','West Bengal');
INSERT INTO CITY VALUES(10894,'Sagwara','Rajasthan');
INSERT INTO CITY VALUES(10895,'Ramganj Mandi','Rajasthan');
INSERT INTO CITY VALUES(10896,'Tarakeswar','West Bengal');
INSERT INTO CITY VALUES(10897,'Mahalingapura','Karnataka');
INSERT INTO CITY VALUES(10898,'Dharmanagar','Tripura');
INSERT INTO CITY VALUES(10899,'Mahemdabad','Gujarat');
INSERT INTO CITY VALUES(10900,'Manendragarh','Chhattisgarh');
INSERT INTO CITY VALUES(10901,'Uran','Maharashtra');
INSERT INTO CITY VALUES(10902,'Tharamangalam','Tamil Nadu');
INSERT INTO CITY VALUES(10903,'Tirukkoyilur','Tamil Nadu');
INSERT INTO CITY VALUES(10904,'Pen','Maharashtra');
INSERT INTO CITY VALUES(10905,'Makhdumpur','Bihar');
INSERT INTO CITY VALUES(10906,'Maner','Bihar');
INSERT INTO CITY VALUES(10907,'Oddanchatram','Tamil Nadu');
INSERT INTO CITY VALUES(10908,'Palladam','Tamil Nadu');
INSERT INTO CITY VALUES(10909,'Mundi','Madhya Pradesh');
INSERT INTO CITY VALUES(10910,'Nabarangapur','Odisha');
INSERT INTO CITY VALUES(10911,'Mudalagi','Karnataka');
INSERT INTO CITY VALUES(10912,'Samalkha','Haryana');
INSERT INTO CITY VALUES(10913,'Nepanagar','Madhya Pradesh');
INSERT INTO CITY VALUES(10914,'Karjat','Maharashtra');
INSERT INTO CITY VALUES(10915,'Ranavav','Gujarat');
INSERT INTO CITY VALUES(10916,'Pedana','Andhra Pradesh');
INSERT INTO CITY VALUES(10917,'Pinjore','Haryana');
INSERT INTO CITY VALUES(10918,'Lakheri','Rajasthan');
INSERT INTO CITY VALUES(10919,'Pasan','Madhya Pradesh');
INSERT INTO CITY VALUES(10920,'Puttur','Andhra Pradesh');
INSERT INTO CITY VALUES(10921,'Vadakkuvalliyur','Tamil Nadu');
INSERT INTO CITY VALUES(10922,'Tirukalukundram','Tamil Nadu');
INSERT INTO CITY VALUES(10923,'Mahidpur','Madhya Pradesh');
INSERT INTO CITY VALUES(10924,'Mussoorie','Uttarakhand');
INSERT INTO CITY VALUES(10925,'Muvattupuzha','Kerala');
INSERT INTO CITY VALUES(10926,'Rasra','Uttar Pradesh');
INSERT INTO CITY VALUES(10927,'Udaipurwati','Rajasthan');
INSERT INTO CITY VALUES(10928,'Manwath','Maharashtra');
INSERT INTO CITY VALUES(10929,'Adoor','Kerala');
INSERT INTO CITY VALUES(10930,'Uthamapalayam','Tamil Nadu');
INSERT INTO CITY VALUES(10931,'Partur','Maharashtra');
INSERT INTO CITY VALUES(10932,'Nahan','Himachal Pradesh');
INSERT INTO CITY VALUES(10933,'Ladwa','Haryana');
INSERT INTO CITY VALUES(10934,'Mankachar','Assam');
INSERT INTO CITY VALUES(10935,'Nongstoin','Meghalaya');
INSERT INTO CITY VALUES(10936,'Losal','Rajasthan');
INSERT INTO CITY VALUES(10937,'Sri Madhopur','Rajasthan');
INSERT INTO CITY VALUES(10938,'Ramngarh','Rajasthan');
INSERT INTO CITY VALUES(10939,'Mavelikkara','Kerala');
INSERT INTO CITY VALUES(10940,'Rawatsar','Rajasthan');
INSERT INTO CITY VALUES(10941,'Rajakhera','Rajasthan');
INSERT INTO CITY VALUES(10942,'Lar','Uttar Pradesh');
INSERT INTO CITY VALUES(10943,'Lal Gopalganj Nindaura','Uttar Pradesh');
INSERT INTO CITY VALUES(10944,'Muddebihal','Karnataka');
INSERT INTO CITY VALUES(10945,'Sirsaganj','Uttar Pradesh');
INSERT INTO CITY VALUES(10946,'Shahpura','Rajasthan');
INSERT INTO CITY VALUES(10947,'Surandai','Tamil Nadu');
INSERT INTO CITY VALUES(10948,'Sangole','Maharashtra');
INSERT INTO CITY VALUES(10949,'Pavagada','Karnataka');
INSERT INTO CITY VALUES(10950,'Tharad','Gujarat');
INSERT INTO CITY VALUES(10951,'Mansa','Gujarat');
INSERT INTO CITY VALUES(10952,'Umbergaon','Gujarat');
INSERT INTO CITY VALUES(10953,'Mavoor','Kerala');
INSERT INTO CITY VALUES(10954,'Nalbari','Assam');
INSERT INTO CITY VALUES(10955,'Talaja','Gujarat');
INSERT INTO CITY VALUES(10956,'Malur','Karnataka');
INSERT INTO CITY VALUES(10957,'Mangrulpir','Maharashtra');
INSERT INTO CITY VALUES(10958,'Soro','Odisha');
INSERT INTO CITY VALUES(10959,'Shahpura','Rajasthan');
INSERT INTO CITY VALUES(10960,'Vadnagar','Gujarat');
INSERT INTO CITY VALUES(10961,'Raisinghnagar','Rajasthan');
INSERT INTO CITY VALUES(10962,'Sindhagi','Karnataka');
INSERT INTO CITY VALUES(10963,'Sanduru','Karnataka');
INSERT INTO CITY VALUES(10964,'Sohna','Haryana');
INSERT INTO CITY VALUES(10965,'Manavadar','Gujarat');
INSERT INTO CITY VALUES(10966,'Pihani','Uttar Pradesh');
INSERT INTO CITY VALUES(10967,'Safidon','Haryana');
INSERT INTO CITY VALUES(10968,'Risod','Maharashtra');
INSERT INTO CITY VALUES(10969,'Rosera','Bihar');
INSERT INTO CITY VALUES(10970,'Sankari','Tamil Nadu');
INSERT INTO CITY VALUES(10971,'Malpura','Rajasthan');
INSERT INTO CITY VALUES(10972,'Sonamukhi','West Bengal');
INSERT INTO CITY VALUES(10973,'"Shamsabad','Agra"');
INSERT INTO CITY VALUES(10974,'Nokha','Bihar');
INSERT INTO CITY VALUES(10975,'PandUrban Agglomeration','West Bengal');
INSERT INTO CITY VALUES(10976,'Mainaguri','West Bengal');
INSERT INTO CITY VALUES(10977,'Afzalpur','Karnataka');
INSERT INTO CITY VALUES(10978,'Shirur','Maharashtra');
INSERT INTO CITY VALUES(10979,'Salaya','Gujarat');
INSERT INTO CITY VALUES(10980,'Shenkottai','Tamil Nadu');
INSERT INTO CITY VALUES(10981,'Pratapgarh','Tripura');
INSERT INTO CITY VALUES(10982,'Vadipatti','Tamil Nadu');
INSERT INTO CITY VALUES(10983,'Nagarkurnool','Telangana');
INSERT INTO CITY VALUES(10984,'Savner','Maharashtra');
INSERT INTO CITY VALUES(10985,'Sasvad','Maharashtra');
INSERT INTO CITY VALUES(10986,'Rudrapur','Uttar Pradesh');
INSERT INTO CITY VALUES(10987,'Soron','Uttar Pradesh');
INSERT INTO CITY VALUES(10988,'Sholingur','Tamil Nadu');
INSERT INTO CITY VALUES(10989,'Pandharkaoda','Maharashtra');
INSERT INTO CITY VALUES(10990,'Perumbavoor','Kerala');
INSERT INTO CITY VALUES(10991,'Maddur','Karnataka');
INSERT INTO CITY VALUES(10992,'Nadbai','Rajasthan');
INSERT INTO CITY VALUES(10993,'Talode','Maharashtra');
INSERT INTO CITY VALUES(10994,'Shrigonda','Maharashtra');
INSERT INTO CITY VALUES(10995,'Madhugiri','Karnataka');
INSERT INTO CITY VALUES(10996,'Tekkalakote','Karnataka');
INSERT INTO CITY VALUES(10997,'Seoni-Malwa','Madhya Pradesh');
INSERT INTO CITY VALUES(10998,'Shirdi','Maharashtra');
INSERT INTO CITY VALUES(10999,'SUrban Agglomerationr','Uttar Pradesh');
INSERT INTO CITY VALUES(11000,'Terdal','Karnataka');
INSERT INTO CITY VALUES(11001,'Raver','Maharashtra');
INSERT INTO CITY VALUES(11002,'Tirupathur','Tamil Nadu');
INSERT INTO CITY VALUES(11003,'Taraori','Haryana');
INSERT INTO CITY VALUES(11004,'Mukhed','Maharashtra');
INSERT INTO CITY VALUES(11005,'Manachanallur','Tamil Nadu');
INSERT INTO CITY VALUES(11006,'Rehli','Madhya Pradesh');
INSERT INTO CITY VALUES(11007,'Sanchore','Rajasthan');
INSERT INTO CITY VALUES(11008,'Rajura','Maharashtra');
INSERT INTO CITY VALUES(11009,'Piro','Bihar');
INSERT INTO CITY VALUES(11010,'Mudabidri','Karnataka');
INSERT INTO CITY VALUES(11011,'Vadgaon Kasba','Maharashtra');
INSERT INTO CITY VALUES(11012,'Nagar','Rajasthan');
INSERT INTO CITY VALUES(11013,'Vijapur','Gujarat');
INSERT INTO CITY VALUES(11014,'Viswanatham','Tamil Nadu');
INSERT INTO CITY VALUES(11015,'Polur','Tamil Nadu');
INSERT INTO CITY VALUES(11016,'Panagudi','Tamil Nadu');
INSERT INTO CITY VALUES(11017,'Manawar','Madhya Pradesh');
INSERT INTO CITY VALUES(11018,'Tehri','Uttarakhand');
INSERT INTO CITY VALUES(11019,'Samdhan','Uttar Pradesh');
INSERT INTO CITY VALUES(11020,'Pardi','Gujarat');
INSERT INTO CITY VALUES(11021,'Rahatgarh','Madhya Pradesh');
INSERT INTO CITY VALUES(11022,'Panagar','Madhya Pradesh');
INSERT INTO CITY VALUES(11023,'Uthiramerur','Tamil Nadu');
INSERT INTO CITY VALUES(11024,'Tirora','Maharashtra');
INSERT INTO CITY VALUES(11025,'Rangia','Assam');
INSERT INTO CITY VALUES(11026,'Sahjanwa','Uttar Pradesh');
INSERT INTO CITY VALUES(11027,'Wara Seoni','Madhya Pradesh');
INSERT INTO CITY VALUES(11028,'Magadi','Karnataka');
INSERT INTO CITY VALUES(11029,'Rajgarh (Alwar)','Rajasthan');
INSERT INTO CITY VALUES(11030,'Rafiganj','Bihar');
INSERT INTO CITY VALUES(11031,'Tarana','Madhya Pradesh');
INSERT INTO CITY VALUES(11032,'Rampur Maniharan','Uttar Pradesh');
INSERT INTO CITY VALUES(11033,'Sheoganj','Rajasthan');
INSERT INTO CITY VALUES(11034,'Raikot','Punjab');
INSERT INTO CITY VALUES(11035,'Pauri','Uttarakhand');
INSERT INTO CITY VALUES(11036,'Sumerpur','Uttar Pradesh');
INSERT INTO CITY VALUES(11037,'Navalgund','Karnataka');
INSERT INTO CITY VALUES(11038,'Shahganj','Uttar Pradesh');
INSERT INTO CITY VALUES(11039,'Marhaura','Bihar');
INSERT INTO CITY VALUES(11040,'Tulsipur','Uttar Pradesh');
INSERT INTO CITY VALUES(11041,'Sadri','Rajasthan');
INSERT INTO CITY VALUES(11042,'Thiruthuraipoondi','Tamil Nadu');
INSERT INTO CITY VALUES(11043,'Shiggaon','Karnataka');
INSERT INTO CITY VALUES(11044,'Pallapatti','Tamil Nadu');
INSERT INTO CITY VALUES(11045,'Mahendragarh','Haryana');
INSERT INTO CITY VALUES(11046,'Sausar','Madhya Pradesh');
INSERT INTO CITY VALUES(11047,'Ponneri','Tamil Nadu');
INSERT INTO CITY VALUES(11048,'Mahad','Maharashtra');
INSERT INTO CITY VALUES(11049,'Lohardaga','Jharkhand');
INSERT INTO CITY VALUES(11050,'Tirwaganj','Uttar Pradesh');
INSERT INTO CITY VALUES(11051,'Margherita','Assam');
INSERT INTO CITY VALUES(11052,'Sundarnagar','Himachal Pradesh');
INSERT INTO CITY VALUES(11053,'Rajgarh','Madhya Pradesh');
INSERT INTO CITY VALUES(11054,'Mangaldoi','Assam');
INSERT INTO CITY VALUES(11055,'Renigunta','Andhra Pradesh');
INSERT INTO CITY VALUES(11056,'Longowal','Punjab');
INSERT INTO CITY VALUES(11057,'Ratia','Haryana');
INSERT INTO CITY VALUES(11058,'Lalgudi','Tamil Nadu');
INSERT INTO CITY VALUES(11059,'Shrirangapattana','Karnataka');
INSERT INTO CITY VALUES(11060,'Niwari','Madhya Pradesh');
INSERT INTO CITY VALUES(11061,'Natham','Tamil Nadu');
INSERT INTO CITY VALUES(11062,'Unnamalaikadai','Tamil Nadu');
INSERT INTO CITY VALUES(11063,'PurqUrban Agglomerationzi','Uttar Pradesh');
INSERT INTO CITY VALUES(11064,'"Shamsabad','Farrukhabad"');
INSERT INTO CITY VALUES(11065,'Mirganj','Bihar');
INSERT INTO CITY VALUES(11066,'Todaraisingh','Rajasthan');
INSERT INTO CITY VALUES(11067,'Warhapur','Uttar Pradesh');
INSERT INTO CITY VALUES(11068,'Rajam','Andhra Pradesh');
INSERT INTO CITY VALUES(11069,'Urmar Tanda','Punjab');
INSERT INTO CITY VALUES(11070,'Lonar','Maharashtra');
INSERT INTO CITY VALUES(11071,'Powayan','Uttar Pradesh');
INSERT INTO CITY VALUES(11072,'P.N.Patti','Tamil Nadu');
INSERT INTO CITY VALUES(11073,'Palampur','Himachal Pradesh');
INSERT INTO CITY VALUES(11074,'Srisailam Project (Right Flank Colony) Township','Andhra Pradesh');
INSERT INTO CITY VALUES(11075,'Sindagi','Karnataka');
INSERT INTO CITY VALUES(11076,'Sandi','Uttar Pradesh');
INSERT INTO CITY VALUES(11077,'Vaikom','Kerala');
INSERT INTO CITY VALUES(11078,'Malda','West Bengal');
INSERT INTO CITY VALUES(11079,'Tharangambadi','Tamil Nadu');
INSERT INTO CITY VALUES(11080,'Sakaleshapura','Karnataka');
INSERT INTO CITY VALUES(11081,'Lalganj','Bihar');
INSERT INTO CITY VALUES(11082,'Malkangiri','Odisha');
INSERT INTO CITY VALUES(11083,'Rapar','Gujarat');
INSERT INTO CITY VALUES(11084,'Mauganj','Madhya Pradesh');
INSERT INTO CITY VALUES(11085,'Todabhim','Rajasthan');
INSERT INTO CITY VALUES(11086,'Srinivaspur','Karnataka');
INSERT INTO CITY VALUES(11087,'Murliganj','Bihar');
INSERT INTO CITY VALUES(11088,'Reengus','Rajasthan');
INSERT INTO CITY VALUES(11089,'Sawantwadi','Maharashtra');
INSERT INTO CITY VALUES(11090,'Tittakudi','Tamil Nadu');
INSERT INTO CITY VALUES(11091,'Lilong','Manipur');
INSERT INTO CITY VALUES(11092,'Rajaldesar','Rajasthan');
INSERT INTO CITY VALUES(11093,'Pathardi','Maharashtra');
INSERT INTO CITY VALUES(11094,'Achhnera','Uttar Pradesh');
INSERT INTO CITY VALUES(11095,'Pacode','Tamil Nadu');
INSERT INTO CITY VALUES(11096,'Naraura','Uttar Pradesh');
INSERT INTO CITY VALUES(11097,'Nakur','Uttar Pradesh');
INSERT INTO CITY VALUES(11098,'Palai','Kerala');
INSERT INTO CITY VALUES(11099,'"Morinda','India"');
INSERT INTO CITY VALUES(11100,'Manasa','Madhya Pradesh');
INSERT INTO CITY VALUES(11101,'Nainpur','Madhya Pradesh');
INSERT INTO CITY VALUES(11102,'Sahaspur','Uttar Pradesh');
INSERT INTO CITY VALUES(11103,'Pauni','Maharashtra');
INSERT INTO CITY VALUES(11104,'Prithvipur','Madhya Pradesh');
INSERT INTO CITY VALUES(11105,'Ramtek','Maharashtra');
INSERT INTO CITY VALUES(11106,'Silapathar','Assam');
INSERT INTO CITY VALUES(11107,'Songadh','Gujarat');
INSERT INTO CITY VALUES(11108,'Safipur','Uttar Pradesh');
INSERT INTO CITY VALUES(11109,'Sohagpur','Madhya Pradesh');
INSERT INTO CITY VALUES(11110,'Mul','Maharashtra');
INSERT INTO CITY VALUES(11111,'Sadulshahar','Rajasthan');
INSERT INTO CITY VALUES(11112,'Phillaur','Punjab');
INSERT INTO CITY VALUES(11113,'Sambhar','Rajasthan');
INSERT INTO CITY VALUES(11114,'Prantij','Rajasthan');
INSERT INTO CITY VALUES(11115,'Nagla','Uttarakhand');
INSERT INTO CITY VALUES(11116,'Pattran','Punjab');
INSERT INTO CITY VALUES(11117,'Mount Abu','Rajasthan');
INSERT INTO CITY VALUES(11118,'Reoti','Uttar Pradesh');
INSERT INTO CITY VALUES(11119,'Tenu dam-cum-Kathhara','Jharkhand');
INSERT INTO CITY VALUES(11120,'Panchla','West Bengal');
INSERT INTO CITY VALUES(11121,'Sitarganj','Uttarakhand');
INSERT INTO CITY VALUES(11122,'Pasighat','Arunachal Pradesh');
INSERT INTO CITY VALUES(11123,'Motipur','Bihar');
INSERT INTO CITY VALUES(11124,'O'' Valley','Tamil Nadu');
INSERT INTO CITY VALUES(11125,'Raghunathpur','West Bengal');
INSERT INTO CITY VALUES(11126,'Suriyampalayam','Tamil Nadu');
INSERT INTO CITY VALUES(11127,'Qadian','Punjab');
INSERT INTO CITY VALUES(11128,'Rairangpur','Odisha');
INSERT INTO CITY VALUES(11129,'Silvassa','Dadra and Nagar Haveli');
INSERT INTO CITY VALUES(11130,'Nowrozabad (Khodargama)','Madhya Pradesh');
INSERT INTO CITY VALUES(11131,'Mangrol','Rajasthan');
INSERT INTO CITY VALUES(11132,'Soyagaon','Maharashtra');
INSERT INTO CITY VALUES(11133,'Sujanpur','Punjab');
INSERT INTO CITY VALUES(11134,'Manihari','Bihar');
INSERT INTO CITY VALUES(11135,'Sikanderpur','Uttar Pradesh');
INSERT INTO CITY VALUES(11136,'Mangalvedhe','Maharashtra');
INSERT INTO CITY VALUES(11137,'Phulera','Rajasthan');
INSERT INTO CITY VALUES(11138,'Ron','Karnataka');
INSERT INTO CITY VALUES(11139,'Sholavandan','Tamil Nadu');
INSERT INTO CITY VALUES(11140,'Saidpur','Uttar Pradesh');
INSERT INTO CITY VALUES(11141,'Shamgarh','Madhya Pradesh');
INSERT INTO CITY VALUES(11142,'Thammampatti','Tamil Nadu');
INSERT INTO CITY VALUES(11143,'Maharajpur','Madhya Pradesh');
INSERT INTO CITY VALUES(11144,'Multai','Madhya Pradesh');
INSERT INTO CITY VALUES(11145,'Mukerian','Punjab');
INSERT INTO CITY VALUES(11146,'Sirsi','Uttar Pradesh');
INSERT INTO CITY VALUES(11147,'Purwa','Uttar Pradesh');
INSERT INTO CITY VALUES(11148,'Sheohar','Bihar');
INSERT INTO CITY VALUES(11149,'Namagiripettai','Tamil Nadu');
INSERT INTO CITY VALUES(11150,'Parasi','Uttar Pradesh');
INSERT INTO CITY VALUES(11151,'Lathi','Gujarat');
INSERT INTO CITY VALUES(11152,'Lalganj','Uttar Pradesh');
INSERT INTO CITY VALUES(11153,'Narkhed','Maharashtra');
INSERT INTO CITY VALUES(11154,'Mathabhanga','West Bengal');
INSERT INTO CITY VALUES(11155,'Shendurjana','Maharashtra');
INSERT INTO CITY VALUES(11156,'Peravurani','Tamil Nadu');
INSERT INTO CITY VALUES(11157,'Mariani','Assam');
INSERT INTO CITY VALUES(11158,'Phulpur','Uttar Pradesh');
INSERT INTO CITY VALUES(11159,'Rania','Haryana');
INSERT INTO CITY VALUES(11160,'Pali','Madhya Pradesh');
INSERT INTO CITY VALUES(11161,'Pachore','Madhya Pradesh');
INSERT INTO CITY VALUES(11162,'Parangipettai','Tamil Nadu');
INSERT INTO CITY VALUES(11163,'Pudupattinam','Tamil Nadu');
INSERT INTO CITY VALUES(11164,'Panniyannur','Kerala');
INSERT INTO CITY VALUES(11165,'Maharajganj','Bihar');
INSERT INTO CITY VALUES(11166,'Rau','Madhya Pradesh');
INSERT INTO CITY VALUES(11167,'Monoharpur','West Bengal');
INSERT INTO CITY VALUES(11168,'Mandawa','Rajasthan');
INSERT INTO CITY VALUES(11169,'Marigaon','Assam');
INSERT INTO CITY VALUES(11170,'Pallikonda','Tamil Nadu');
INSERT INTO CITY VALUES(11171,'Pindwara','Rajasthan');
INSERT INTO CITY VALUES(11172,'Shishgarh','Uttar Pradesh');
INSERT INTO CITY VALUES(11173,'Patur','Maharashtra');
INSERT INTO CITY VALUES(11174,'Mayang Imphal','Manipur');
INSERT INTO CITY VALUES(11175,'Mhowgaon','Madhya Pradesh');
INSERT INTO CITY VALUES(11176,'Guruvayoor','Kerala');
INSERT INTO CITY VALUES(11177,'Mhaswad','Maharashtra');
INSERT INTO CITY VALUES(11178,'Sahawar','Uttar Pradesh');
INSERT INTO CITY VALUES(11179,'Sivagiri','Tamil Nadu');
INSERT INTO CITY VALUES(11180,'Mundargi','Karnataka');
INSERT INTO CITY VALUES(11181,'Punjaipugalur','Tamil Nadu');
INSERT INTO CITY VALUES(11182,'Kailasahar','Tripura');
INSERT INTO CITY VALUES(11183,'Samthar','Uttar Pradesh');
INSERT INTO CITY VALUES(11184,'Sakti','Chhattisgarh');
INSERT INTO CITY VALUES(11185,'Sadalagi','Karnataka');
INSERT INTO CITY VALUES(11186,'Silao','Bihar');
INSERT INTO CITY VALUES(11187,'Mandalgarh','Rajasthan');
INSERT INTO CITY VALUES(11188,'Loha','Maharashtra');
INSERT INTO CITY VALUES(11189,'Pukhrayan','Uttar Pradesh');
INSERT INTO CITY VALUES(11190,'Padmanabhapuram','Tamil Nadu');
INSERT INTO CITY VALUES(11191,'Belonia','Tripura');
INSERT INTO CITY VALUES(11192,'Saiha','Mizoram');
INSERT INTO CITY VALUES(11193,'Srirampore','West Bengal');
INSERT INTO CITY VALUES(11194,'Talwara','Punjab');
INSERT INTO CITY VALUES(11195,'Puthuppally','Kerala');
INSERT INTO CITY VALUES(11196,'Khowai','Tripura');
INSERT INTO CITY VALUES(11197,'Vijaypur','Madhya Pradesh');
INSERT INTO CITY VALUES(11198,'Takhatgarh','Rajasthan');
INSERT INTO CITY VALUES(11199,'Thirupuvanam','Tamil Nadu');
INSERT INTO CITY VALUES(11200,'Adra','West Bengal');
INSERT INTO CITY VALUES(11201,'Piriyapatna','Karnataka');
INSERT INTO CITY VALUES(11202,'Obra','Uttar Pradesh');
INSERT INTO CITY VALUES(11203,'Adalaj','Gujarat');
INSERT INTO CITY VALUES(11204,'Nandgaon','Maharashtra');
INSERT INTO CITY VALUES(11205,'Barh','Bihar');
INSERT INTO CITY VALUES(11206,'Chhapra','Gujarat');
INSERT INTO CITY VALUES(11207,'Panamattom','Kerala');
INSERT INTO CITY VALUES(11208,'Niwai','Uttar Pradesh');
INSERT INTO CITY VALUES(11209,'Bageshwar','Uttarakhand');
INSERT INTO CITY VALUES(11210,'Tarbha','Odisha');
INSERT INTO CITY VALUES(11211,'Adyar','Karnataka');
INSERT INTO CITY VALUES(11212,'Narsinghgarh','Madhya Pradesh');
INSERT INTO CITY VALUES(11213,'Warud','Maharashtra');
INSERT INTO CITY VALUES(11214,'Asarganj','Bihar');
INSERT INTO CITY VALUES(11215,'Sarsod','Haryana');


--cars table

INSERT INTO CAR VALUES(CAR_ID.nextval,'Mahindra XUV700','SUV','Mahindra',3);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Tata Punch','SUV','Tata',3);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Mahindra Thar','SUV','Mahindra',4);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Hyundai Creta','SUV','Hyundai',3);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Maruti Vitara Brezza','SUV','Maruti',2);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Toyota Fortuner','SUV','Toyota',3);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Tata Nexon','SUV','Tata',4);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Kia Seltos','SUV','Kia',2);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Mahindra Scorpio','SUV','Mahindra',3);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Hyundai Venue','SUV','Hyundai',4);

INSERT INTO CAR VALUES(CAR_ID.nextval,'Kia Carnival','MPV','Kia',2);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Maruti Suzuki Eeco','MPV','Maruti',1);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Maruti Suzuki Ertiga','MPV','Maruti',3);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Toyota Innova Crysta','MPV','Toyota',2);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Toyota Innova Touring Sport','MPV','Toyota',3);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Mahindra Marazzo','MPV','Mahindra',2);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Mercedes-Benz V-Class','MPV','Mercedes',3);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Toyota Vellfire','MPV','Toyota',4);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Maruti Suzuki XL6','MPV','Maruti',3);

INSERT INTO CAR VALUES(CAR_ID.nextval,'Honda City 4th Generation','sedan','Honda',4);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Maruti Dzire','sedan','Maruti',3);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Hyundai Verna','sedan','Hyundai',2);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Hyundai Aura','sedan','Hyundai',3);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Honda Amaze','sedan','Honda',4);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Tata Tigor','sedan','Tata',2);
INSERT INTO CAR VALUES(CAR_ID.nextval,'Skoda Rapid','sedan','Skoda',3);



--members insertions

INSERT INTO MEMBER values(member_id.nextval,'Esha','Gala',4101105723,'4-1-852, Abids Hyderabad, Andhra Pradesh, 500001','younggarrulous','ZFbKUG','passenger');
INSERT INTO MEMBER VALUES(member_id.nextval,'Esha','Samuel',9270598609,'50, Borivali, Mumbai - 143065','phalangesuntie','6JtfNK','passenger');
INSERT INTO MEMBER VALUES(member_id.nextval,'Radhe','Kar',5314383044,'72, Sushmita Society, Sodala Panaji - 288562','passivebaa','Jm9ywB','driver');
INSERT INTO MEMBER VALUES(member_id.nextval,'Nitika','Om',2419885578,'87, MunniGunj, Indore - 333960','floweryorgan','ybv8hW','passenger');
INSERT INTO MEMBER VALUES(member_id.nextval,'Isha','Bhat',7144434071,'68, MukulPur, Pune - 335711','jacksound','yG7jLD','driver');
INSERT INTO MEMBER VALUES(member_id.nextval,'Devendra','Karnik',2742803202,'41, Roma Apartments, OmarGarh Raipur - 527156','toothsomemizzenmast','SJpSTkRcN','passenger');
INSERT INTO MEMBER VALUES(member_id.nextval,'Aslam','Mander',8575260766,'53, Aastha Heights, Goregaon Pune - 370182','maskingredient','5RixMGwcd','driver');
INSERT INTO MEMBER VALUES(member_id.nextval,'Manpreet','Thomas',3751063067,'29, Aditi Villas, Kharadi Surat - 447011','scoreboardinspector','vqKKg6MJw','passenger');
INSERT INTO MEMBER VALUES(member_id.nextval,'Rita','Ganesan',5989613809,'75, MohanGunj, Delhi - 192948','appointcrackle','lrZ3Ildkm','driver');
INSERT INTO MEMBER VALUES(member_id.nextval,'Sweta','Raval',8585420214,'83, Nagma Society, Kormangala Nagpur - 359666','tomatoessucker','TvxEbLdbw','passenger');
INSERT INTO MEMBER VALUES(member_id.nextval,'Chitra','Bali',1092791908,'22, Bhola Apartments, Marathahalli Jaipur - 555139','gartershatch','EpBJxexjp','driver');
INSERT INTO MEMBER VALUES(member_id.nextval,'Samir','Garg',9485595376,'18, Chandpole, Jamnagar - 208166','daylightadmired','u2algksGA','passenger');
INSERT INTO MEMBER VALUES(member_id.nextval,'Alpa','Patel',9543610629,'57, Poonam Apartments, ChiragPur Kolkata - 302007','lunchdireful','LNOhbhtB9','driver');
INSERT INTO MEMBER VALUES(member_id.nextval,'Mridula','Kota',9054502062,'24, HimanshuGarh, Vadodara - 590504','journalistsweep','W6EwgHOOl','passenger');
INSERT INTO MEMBER VALUES(member_id.nextval,'Lakshmi','Mistry',0106294427,'10, Faisal Villas, Wahid Chowk Patna - 165741','chimneymacedonian','VTbwOrulK','passenger');
INSERT INTO MEMBER VALUES(member_id.nextval,'Tarun','Persad',9205949691,'35, Churchgate, Pondicherry - 444989','shoothaunt','LTd36WZkt','driver');
INSERT INTO MEMBER VALUES(member_id.nextval,'Kasturba','Yogi',5794648245,'60, Binita Society, Hinjewadi Warangal - 135216','tapedisability','auS2mfwRB','passenger');
INSERT INTO MEMBER VALUES(member_id.nextval,'Ajeet','Talwar',2243938389,'39, NilamGarh, Jodhpur - 528516','spawnfire','3ULfok7Qm','passenger');
INSERT INTO MEMBER VALUES(member_id.nextval,'Teena','Din',0462136527,'96, Dadar, Surat - 195768','stammertree','5ACUOsX4U','driver');
INSERT INTO MEMBER VALUES(member_id.nextval,'Azhar','Mital',1690963707,'45, Omar Apartments, VijayPur Gandhinagar - 585858','huddleacid','3ULfok7Qm','passenger');

--member car

INSERT INTO MEMBER_CAR VALUES(member_car_id.nextval, 10002, 40003, 'AP01PA1234', 'White');
INSERT INTO MEMBER_CAR VALUES(member_car_id.nextval, 10004, 40006, 'BR02RB2345', 'Black');
INSERT INTO MEMBER_CAR VALUES(member_car_id.nextval, 10006, 40009, 'CG03GC3456', 'Silver');
INSERT INTO MEMBER_CAR VALUES(member_car_id.nextval, 10008, 40012, 'DD04DD4567', 'White');
INSERT INTO MEMBER_CAR VALUES(member_car_id.nextval, 10010, 40015, 'GJ05JG5678', 'Black');
INSERT INTO MEMBER_CAR VALUES(member_car_id.nextval, 10012, 40018, 'HP06PH6789', 'Red');
INSERT INTO MEMBER_CAR VALUES(member_car_id.nextval, 10015, 40021, 'JK07KJ7890', 'Blue');
INSERT INTO MEMBER_CAR VALUES(member_car_id.nextval, 10018, 40024, 'LA08AL8901', 'White');


--RIDE INSERTIONS
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'29-10-2012',10243,10126,1,964,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'12-03-2009',10415,10170,1,817,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'06-03-2019',10181,11209,2,767,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'06-02-2019',10621,10313,2,819,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'26-11-2011',11136,10457,1,766,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'18-06-2008',10609,10288,4,448,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'18-01-2012',10683,10849,1,192,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'30-08-2014',10467,10872,3,981,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'26-03-2014',10105,10785,2,297,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'09-12-2017',10175,10552,3,384,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'03-06-2019',10490,10885,1,320,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'03-10-2015',10698,10751,1,699,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'23-03-2009',10542,10704,2,760,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'01-05-2014',10173,10402,3,203,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'23-08-2020',10890,11148,1,916,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'02-10-2012',10674,10354,4,668,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'08-10-2011',10671,10209,2,759,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'06-09-2013',10120,10401,4,161,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'04-07-2019',10995,11175,2,744,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'24-07-2018',10808,10035,3,939,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'15-08-2014',11094,10611,2,121,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'29-08-2018',10193,10033,4,836,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'10-11-2015',10179,10124,3,220,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'24-09-2014',10979,11195,3,878,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'26-05-2016',10191,11073,2,656,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'04-10-2018',10090,10598,4,214,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'08-01-2020',10178,10911,1,311,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'03-12-2020',11063,10793,4,274,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'12-05-2019',10257,10405,2,479,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'07-01-2018',10624,11014,3,888,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'16-10-2013',10910,10951,4,459,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'16-01-2016',10955,10513,3,846,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'06-07-2008',11078,10082,3,395,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'27-01-2011',11035,10190,3,295,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'28-11-2008',10578,10392,3,924,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'08-01-2011',10273,10959,1,734,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'20-08-2011',11139,10902,2,397,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'24-12-2019',10764,10579,4,537,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'08-06-2020',10235,10205,2,161,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'15-01-2016',11137,11156,3,927,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'13-05-2015',10524,10939,1,781,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'04-05-2021',10560,10804,4,269,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'10-01-2011',10519,10914,4,174,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'02-10-2020',10822,10903,2,684,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'16-05-2016',10734,10069,1,258,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'15-06-2021',10821,11081,3,513,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'31-07-2016',10283,10582,3,970,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'26-02-2011',10104,10606,1,544,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'16-03-2018',10266,10350,1,634,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'02-08-2016',10221,11060,2,521,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'16-07-2010',10601,11186,3,527,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'14-11-2009',10759,10391,4,499,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'17-11-2010',10205,10430,3,873,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'18-08-2018',10229,10170,3,632,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'15-08-2015',10453,10100,2,728,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'13-03-2010',10115,10434,4,679,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'06-07-2012',10961,10657,4,857,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'13-07-2021',10207,10107,1,210,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'27-07-2020',10543,11154,3,975,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'23-10-2008',10818,10127,1,860,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'20-10-2013',10984,10603,4,387,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'12-08-2008',10384,10154,1,299,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'23-05-2010',10918,10296,1,410,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'17-11-2017',10138,10389,4,650,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'14-02-2019',10977,10489,3,458,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'08-09-2008',10313,10778,2,448,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'20-04-2013',10704,10764,3,576,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'19-07-2014',10174,10859,2,529,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'17-12-2016',11011,10170,1,757,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'29-03-2018',11204,10304,4,308,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'23-10-2010',10577,10468,4,296,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'24-03-2008',11070,10364,3,864,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'21-03-2010',10873,10619,4,514,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'26-10-2021',10416,10280,2,328,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'11-01-2020',10862,10953,1,896,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'16-12-2020',10983,10515,4,336,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'23-06-2014',10108,11198,3,203,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'16-01-2021',10153,11124,3,530,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'25-05-2011',10038,10380,4,925,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'02-10-2012',10768,11062,3,151,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'24-09-2012',10239,10901,2,657,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'20-09-2013',10224,10747,4,723,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'11-08-2018',10583,10626,4,433,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'10-09-2010',10833,11206,3,445,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'13-10-2011',10274,10059,4,961,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'29-03-2020',11205,10466,3,909,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'17-01-2020',11123,10844,2,248,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'29-01-2021',10074,10510,3,849,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'24-10-2021',10014,10782,4,844,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'25-09-2017',10058,10769,4,312,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'11-06-2013',11005,10135,1,526,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'18-04-2017',11178,10479,4,983,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'19-06-2009',10711,10472,4,483,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'25-01-2015',10340,10792,4,397,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'11-05-2018',11055,10142,4,848,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'02-09-2020',10860,10200,4,211,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'24-12-2019',10552,10156,2,716,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'18-10-2015',10961,10305,4,664,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'04-04-2017',10871,11197,3,713,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'19-11-2017',11113,10911,3,402,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'28-05-2017',10292,11032,4,525,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'15-09-2010',10326,10655,3,170,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'24-04-2013',10009,10860,2,562,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'15-06-2013',11071,10946,3,936,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'14-06-2013',10093,10804,3,606,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'07-03-2013',10402,10823,1,505,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'09-12-2018',11156,11109,1,955,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'20-11-2011',10317,10891,4,971,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'13-05-2011',10379,10234,2,409,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'04-10-2009',11073,10843,1,247,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'16-08-2010',10494,10759,2,978,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'21-05-2016',11016,11093,1,782,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'04-04-2010',10748,10217,3,447,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'14-04-2009',10508,11025,2,494,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'27-08-2011',10722,10889,2,962,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'06-08-2011',11156,10173,2,130,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'04-09-2019',10370,10012,2,632,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'24-04-2015',10073,11210,3,781,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'03-05-2014',10647,10112,1,573,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'13-12-2010',10672,10828,4,700,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'21-08-2021',11160,10683,2,156,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'05-09-2021',10016,10130,4,753,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'25-01-2011',10917,10321,4,213,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'23-02-2014',10526,11189,2,302,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'13-05-2020',10328,10757,3,597,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'06-05-2018',10516,10270,3,824,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'30-01-2016',10657,10693,1,981,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'15-04-2012',10319,10765,3,543,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'08-01-2020',10927,10996,4,631,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'08-09-2020',10124,10423,2,183,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'25-08-2008',10685,10262,2,977,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'20-10-2016',10012,10195,4,802,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'02-01-2009',10535,10569,4,407,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'03-12-2018',10719,10433,2,792,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'05-03-2020',10154,10390,2,376,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'20-05-2019',10456,11130,4,146,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'27-01-2019',11183,10313,2,592,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'17-05-2020',10215,10823,2,741,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'12-01-2010',10068,10020,4,973,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'01-11-2008',10334,10503,4,458,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'30-10-2011',10166,10635,3,927,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'05-06-2020',11081,10781,3,985,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'22-11-2019',10955,10088,3,104,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'13-05-2011',10819,11209,2,357,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'21-12-2014',11158,10898,4,754,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'08-09-2008',11013,10655,1,728,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'31-01-2014',10561,10376,3,371,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'15-08-2008',10675,10818,4,662,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'10-03-2014',10197,10490,3,961,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'15-06-2008',11168,10157,2,906,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'07-06-2010',10565,10639,4,435,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'15-06-2011',10406,10132,1,995,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'02-10-2017',10776,10810,4,176,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'13-03-2011',10566,10763,3,905,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'30-01-2014',10709,10877,3,398,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'01-06-2021',10495,10084,4,909,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'04-12-2018',11196,11193,4,783,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'23-07-2018',11074,10972,1,674,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'09-01-2021',10549,10374,2,162,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'12-04-2017',10782,11186,4,297,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'16-03-2010',10624,11173,4,839,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'07-07-2012',10786,10562,2,858,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'13-04-2012',10116,10860,2,347,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'03-08-2013',10742,10287,1,862,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'27-08-2016',10307,10052,1,609,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'15-07-2016',10807,10441,1,248,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'11-05-2014',10719,10665,4,229,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'14-08-2019',10129,10912,1,534,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'06-08-2016',10022,10034,2,190,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'21-04-2017',11194,10560,2,696,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'29-12-2011',10555,10433,2,684,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'12-03-2016',10526,10214,2,282,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60006,'26-08-2020',10552,10782,1,803,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'10-07-2018',10887,10360,3,382,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'20-12-2019',10963,10667,2,194,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'19-08-2015',10532,10824,4,637,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'14-11-2013',10394,10996,4,626,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'23-03-2009',10118,10903,4,473,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'03-10-2021',10236,10719,2,616,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'27-05-2017',10635,11186,2,955,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'29-08-2015',10161,11020,1,516,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60001,'20-10-2015',10037,11147,1,148,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'22-09-2008',11042,10488,1,286,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'14-04-2014',10976,10347,1,477,0,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'04-08-2018',10121,10672,3,463,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'07-01-2008',10514,10712,2,689,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'30-04-2017',10366,10456,4,765,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'23-12-2014',10044,10968,1,989,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60005,'02-12-2017',10888,11084,3,201,0,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'01-06-2013',10593,10295,3,529,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'23-07-2009',10088,10553,1,423,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'06-03-2009',10654,10946,4,598,3,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'20-11-2011',10115,10401,2,153,3,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'10-03-2014',10321,10595,2,702,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60002,'27-02-2008',10570,11198,3,229,1,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'03-09-2014',10835,10096,2,259,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60000,'02-06-2008',10203,10997,4,123,1,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60003,'10-06-2021',11094,10582,4,693,2,'on-going');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60004,'12-04-2018',10272,10830,2,432,2,'completed');
INSERT INTO RIDE VALUES(RIDE_ID.nextval,60007,'31-12-2020',10228,10986,2,184,2,'on-going');

SELECT id,SEATS_OFFERED*CONTRIBUTION_PER_HEAD FROM RIDE where RIDE_STATUS = 'completed' fetch first 200 rows only;


--BILL INSERTIONS

INSERT INTO BILL VALUES(BILL_ID.nextval,20000,964);
INSERT INTO BILL VALUES(BILL_ID.nextval,20005,1792);
INSERT INTO BILL VALUES(BILL_ID.nextval,20007,2943);
INSERT INTO BILL VALUES(BILL_ID.nextval,20008,594);
INSERT INTO BILL VALUES(BILL_ID.nextval,20009,1152);
INSERT INTO BILL VALUES(BILL_ID.nextval,20011,699);
INSERT INTO BILL VALUES(BILL_ID.nextval,20013,609);
INSERT INTO BILL VALUES(BILL_ID.nextval,20014,916);
INSERT INTO BILL VALUES(BILL_ID.nextval,20017,644);
INSERT INTO BILL VALUES(BILL_ID.nextval,20018,1488);
INSERT INTO BILL VALUES(BILL_ID.nextval,20019,2817);
INSERT INTO BILL VALUES(BILL_ID.nextval,20020,242);
INSERT INTO BILL VALUES(BILL_ID.nextval,20021,3344);
INSERT INTO BILL VALUES(BILL_ID.nextval,20023,2634);
INSERT INTO BILL VALUES(BILL_ID.nextval,20026,311);
INSERT INTO BILL VALUES(BILL_ID.nextval,20027,1096);
INSERT INTO BILL VALUES(BILL_ID.nextval,20028,958);
INSERT INTO BILL VALUES(BILL_ID.nextval,20030,1836);
INSERT INTO BILL VALUES(BILL_ID.nextval,20031,2538);
INSERT INTO BILL VALUES(BILL_ID.nextval,20032,1185);
INSERT INTO BILL VALUES(BILL_ID.nextval,20037,2148);
INSERT INTO BILL VALUES(BILL_ID.nextval,20040,781);
INSERT INTO BILL VALUES(BILL_ID.nextval,20047,544);
INSERT INTO BILL VALUES(BILL_ID.nextval,20050,1581);
INSERT INTO BILL VALUES(BILL_ID.nextval,20051,1996);
INSERT INTO BILL VALUES(BILL_ID.nextval,20054,1456);
INSERT INTO BILL VALUES(BILL_ID.nextval,20060,1548);
INSERT INTO BILL VALUES(BILL_ID.nextval,20062,410);
INSERT INTO BILL VALUES(BILL_ID.nextval,20063,2600);
INSERT INTO BILL VALUES(BILL_ID.nextval,20064,1374);
INSERT INTO BILL VALUES(BILL_ID.nextval,20065,896);
INSERT INTO BILL VALUES(BILL_ID.nextval,20066,1728);
INSERT INTO BILL VALUES(BILL_ID.nextval,20072,2056);
INSERT INTO BILL VALUES(BILL_ID.nextval,20079,453);
INSERT INTO BILL VALUES(BILL_ID.nextval,20082,1732);
INSERT INTO BILL VALUES(BILL_ID.nextval,20083,1335);
INSERT INTO BILL VALUES(BILL_ID.nextval,20086,496);
INSERT INTO BILL VALUES(BILL_ID.nextval,20087,2547);
INSERT INTO BILL VALUES(BILL_ID.nextval,20093,1588);
INSERT INTO BILL VALUES(BILL_ID.nextval,20094,3392);
INSERT INTO BILL VALUES(BILL_ID.nextval,20096,1432);
INSERT INTO BILL VALUES(BILL_ID.nextval,20097,2656);
INSERT INTO BILL VALUES(BILL_ID.nextval,20098,2139);
INSERT INTO BILL VALUES(BILL_ID.nextval,20099,1206);
INSERT INTO BILL VALUES(BILL_ID.nextval,20101,510);
INSERT INTO BILL VALUES(BILL_ID.nextval,20102,1124);
INSERT INTO BILL VALUES(BILL_ID.nextval,20103,2808);
INSERT INTO BILL VALUES(BILL_ID.nextval,20105,505);
INSERT INTO BILL VALUES(BILL_ID.nextval,20106,955);
INSERT INTO BILL VALUES(BILL_ID.nextval,20107,3884);
INSERT INTO BILL VALUES(BILL_ID.nextval,20108,818);
INSERT INTO BILL VALUES(BILL_ID.nextval,20110,1956);
INSERT INTO BILL VALUES(BILL_ID.nextval,20115,260);
INSERT INTO BILL VALUES(BILL_ID.nextval,20116,1264);
INSERT INTO BILL VALUES(BILL_ID.nextval,20117,2343);
INSERT INTO BILL VALUES(BILL_ID.nextval,20121,3012);
INSERT INTO BILL VALUES(BILL_ID.nextval,20122,852);
INSERT INTO BILL VALUES(BILL_ID.nextval,20123,604);
INSERT INTO BILL VALUES(BILL_ID.nextval,20125,2472);
INSERT INTO BILL VALUES(BILL_ID.nextval,20126,981);
INSERT INTO BILL VALUES(BILL_ID.nextval,20134,752);
INSERT INTO BILL VALUES(BILL_ID.nextval,20137,1482);
INSERT INTO BILL VALUES(BILL_ID.nextval,20138,3892);
INSERT INTO BILL VALUES(BILL_ID.nextval,20142,312);
INSERT INTO BILL VALUES(BILL_ID.nextval,20143,714);
INSERT INTO BILL VALUES(BILL_ID.nextval,20144,3016);
INSERT INTO BILL VALUES(BILL_ID.nextval,20145,728);
INSERT INTO BILL VALUES(BILL_ID.nextval,20147,2648);
INSERT INTO BILL VALUES(BILL_ID.nextval,20150,1740);
INSERT INTO BILL VALUES(BILL_ID.nextval,20153,2715);
INSERT INTO BILL VALUES(BILL_ID.nextval,20157,674);
INSERT INTO BILL VALUES(BILL_ID.nextval,20159,1188);
INSERT INTO BILL VALUES(BILL_ID.nextval,20160,3356);
INSERT INTO BILL VALUES(BILL_ID.nextval,20161,1716);
INSERT INTO BILL VALUES(BILL_ID.nextval,20163,862);
INSERT INTO BILL VALUES(BILL_ID.nextval,20164,609);
INSERT INTO BILL VALUES(BILL_ID.nextval,20165,248);
INSERT INTO BILL VALUES(BILL_ID.nextval,20167,534);
INSERT INTO BILL VALUES(BILL_ID.nextval,20168,380);
INSERT INTO BILL VALUES(BILL_ID.nextval,20169,1392);
INSERT INTO BILL VALUES(BILL_ID.nextval,20170,1368);
INSERT INTO BILL VALUES(BILL_ID.nextval,20174,388);
INSERT INTO BILL VALUES(BILL_ID.nextval,20175,2548);
INSERT INTO BILL VALUES(BILL_ID.nextval,20177,1892);
INSERT INTO BILL VALUES(BILL_ID.nextval,20183,477);
INSERT INTO BILL VALUES(BILL_ID.nextval,20192,306);
INSERT INTO BILL VALUES(BILL_ID.nextval,20195,518);
INSERT INTO BILL VALUES(BILL_ID.nextval,20196,492);
INSERT INTO BILL VALUES(BILL_ID.nextval,20198,864);



--ratings insertions
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20000,6);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20005,7);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20007,7);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20008,5);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20009,8);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20011,10);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20013,3);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20014,7);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20017,7);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20018,4);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20019,2);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20020,3);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20021,2);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20023,1);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20026,10);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20027,4);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20028,5);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20030,5);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20031,10);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20032,5);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20037,10);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20040,3);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20047,8);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20050,5);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20051,8);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20054,10);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20060,4);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20062,6);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20063,10);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20064,8);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20065,8);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20066,1);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20072,6);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20079,7);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20082,6);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20083,7);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20086,6);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20087,6);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20093,3);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20094,7);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20096,7);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20097,4);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20098,8);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20099,5);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20101,8);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20102,10);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20103,6);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20105,4);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20106,8);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20107,9);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20108,9);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20110,6);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20115,5);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20116,6);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20117,5);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20121,3);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20122,5);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20123,9);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20125,4);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20126,9);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20134,9);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20137,7);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20138,8);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20142,5);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20143,9);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20144,4);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20145,2);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20147,1);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20150,1);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20153,7);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20157,4);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20159,5);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20160,9);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20161,10);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20163,9);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20164,10);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20165,2);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20167,4);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20168,2);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20169,10);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20170,5);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20174,2);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20175,4);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20177,8);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20183,1);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20192,2);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20195,2);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20196,7);
INSERT INTO DRIVER_RATINGS VALUES(RATING_ID.nextval,20198,7);



--request insertions
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10019,20138,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10003,20192,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10013,20165,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10007,20072,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10000,20026,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10017,20047,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10011,20097,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10000,20147,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10005,20098,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10001,20040,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10016,20122,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10007,20123,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10014,20021,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10000,20102,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10019,20134,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10011,20143,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10005,20028,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10000,20051,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10009,20066,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10001,20013,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10019,20047,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10017,20093,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10016,20165,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10007,20021,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10016,20028,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10011,20065,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10017,20134,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10014,20051,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10019,20163,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10014,20079,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10001,20040,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10013,20000,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10013,20063,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10003,20108,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10005,20177,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10011,20116,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10009,20196,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10016,20192,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10013,20027,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10016,20145,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10003,20183,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10007,20005,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10005,20040,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10019,20007,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10011,20143,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10017,20195,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10017,20021,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10003,20094,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10001,20065,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10019,20168,'accepted');

INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10005,20091,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10009,20135,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10009,20015,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10011,20024,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10014,20151,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10014,20002,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10003,20080,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10000,20180,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10005,20055,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10009,20091,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10003,20172,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10017,20152,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10005,20133,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10011,20127,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10014,20104,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10009,20131,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10009,20172,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10009,20085,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10003,20114,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10000,20049,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10007,20003,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10019,20091,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10000,20190,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10016,20057,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10019,20172,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10009,20042,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10003,20043,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10009,20042,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10013,20015,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10014,20132,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10011,20015,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10007,20104,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10007,20171,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10005,20016,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10019,20185,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10003,20199,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10000,20194,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10011,20166,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10014,20073,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10019,20124,'accepted');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10005,20074,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10001,20181,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10001,20088,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10014,20004,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10011,20034,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10017,20088,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10009,20056,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10016,20181,'rejected');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10000,20152,'waiting');
INSERT INTO REQUEST VALUES(REQUEST_ID.nextval,10014,20152,'accepted');



