%%
%% Analysis of CPS Data
%%
%% Alexander Grycuk & Robert Stefanic
%% U. of Illinois, Chicago
%% CS109, Fall 2015
%% Final Project
%% Data set taken from the City of Chicago
%%

function CPSData(filename)
    
data = load(filename);

L1 = data(:, 1) > 0;
Schools = sum(L1);


fprintf('Chicago Public High School Data for %i schools.\n', Schools)

operation = menu('Please select a task to view CPS data:', ...
'Attendance vs. Average Grades',...
'School Probation vs. ACT Scores', ...
'Supportive Environment vs. Student Performance Level', ...
'Search by Zipcode to see Average ACT score');

if operation == 1
    Attendence(data, Schools);
elseif operation == 2
 	ProbationAndScores(data);
elseif operation == 3
	SupportAndPerformance(data);
elseif operation == 4
	inputPrompt = {'Please enter a Chicago Area Zip Code:'};
	inputTitle = 'Zip Code to analyze';
    inputLines = 1;
	inputDef = {'60617'};
	input = inputdlg(inputPrompt, inputTitle, inputLines, inputDef);
    value = input{1,1};
    zip = str2num(value);
    ZipCodeAndACT(zip, data, Schools);
else
    fprintf('**Error**\n Unknown Operation\n');
end

end

function Attendence(data, Schools)

studentAttendance = data(:, 7);
spl = data(:, 5);

i = 1;

for school=[1:Schools]
    
    X(i)= i;
    Y(i) = studentAttendance(i) * 100;
    Z(i) = spl(i);

    i = i + 1;
    
end
    

hold on;


plot(Y, Z, 'r.');
xlim([1 Schools])
title('Student Attendance vs ACT Scores');
axis([50,100,10,34]);
xlabel('Percentage of Attendance');
ylabel('Average ACT Score');

    
hold off;    

end

function ProbationAndScores(data)
i = 1;
proscore = 0;
protally = 0;
proavg = 0;
notscore = 0;
nottally = 0;
notavg = 0;
while (i <= 92)
  
    if(data(i,3) == 0)
    nottally = nottally + 1;
    notscore = notscore + data(i,5);
    elseif(data(i,3) == 1)  
    proscore = proscore + data(i,5);
    protally = protally + 1; 
end
i = i + 1;
end
proavg = proscore/protally;
notavg = notscore/nottally;

X = [0,1];
Y = [notavg,proavg];

bar(X,Y,'FaceColor',[0 .7 .5],'EdgeColor',[0 .8 .9],'LineWidth',4);
xlabel('Off Probation = 0 | On Probation = 1');
ylabel('Average ACT Score');
title('School Probation Status Vs ACT Score');

end

function SupportAndPerformance(data)

WFBA = 0;
WBA = 0;
WA = 0;
WAA = 0;
WFAA = 0;
NFBA = 0;
NBA = 0;
NA = 0;
NAA = 0;
NFAA = 0;
SFBA = 0;
SBA = 0;
SA = 0;
SAA = 0;
SFAA = 0;
VSFBA = 0;
VSBA = 0;
VSA = 0;
VSAA = 0;
VSFAA = 0;

i = 1;
while (i<92)
    
    if(data(i,6) == 1 && data(i,4) == 1)
    WFBA = WFBA + 1;   
    elseif(data(i,6) == 1 && data(i,4) == 2)
    WBA = WBA + 1;
    elseif(data(i,6) == 1 && data(i,4) == 3)
    WA = WA + 1;
    elseif(data(i,6) == 1 && data(i,4) == 4)
    WAA = WAA + 1;
    elseif(data(i,6) == 1 && data(i,4) == 5)
    WFAA = WFAA + 1;
    elseif(data(i,6) == 2 && data(i,4) == 1)
    NFBA = NFBA + 1;
    elseif(data(i,6) == 2 && data(i,4) == 2)
    NBA = NBA + 1;
    elseif(data(i,6) == 2 && data(i,4) == 3)
    NA = NA + 1;
    elseif(data(i,6) == 2 && data(i,4) == 4)
    NAA = NAA + 1;
    elseif(data(i,6) == 2 && data(i,4) == 5)
    NFAA = NFAA + 1;
    elseif(data(i,6) == 3 && data(i,4) == 1)
    SFBA = SFBA + 1;
    elseif(data(i,6) == 3 && data(i,4) == 2)
    SBA = SBA + 1;
    elseif(data(i,6) == 3 && data(i,4) == 3)
    SA = SA + 1;
    elseif(data(i,6) == 3 && data(i,4) == 4)
    SAA = SAA + 1;
    elseif(data(i,6) == 3 && data(i,4) == 5)
    SFAA = SFAA + 1;
    elseif(data(i,6) == 4 && data(i,4) == 1)
    VSFBA = VSFBA + 1;
    elseif(data(i,6) == 4 && data(i,4) == 2)
    VSBA = VSBA + 1;
    elseif(data(i,6) == 4 && data(i,4) == 3)
    VSA = VSA + 1;
    elseif(data(i,6) == 4 && data(i,4) == 4)
    VSAA = VSAA + 1;
    elseif(data(i,6) == 4 && data(i,4) == 5)
    VSFAA = VSFAA + 1;
    end
i = i +1;
end




operation = menu('Select Level Of Support in the Student Environment', ...
'Weak',...
'Average', ...
'Strong', ...
'Very Strong');

WEAK = [WFBA, WBA, WA, WAA, WFAA];
NEUTRAL =[NFBA, NBA, NA, NAA, NFAA];
STRONG = [SFBA, SBA, SA, SAA, SFAA];
VSTRONG = [VSFBA, VSBA, VSA, VSAA, VSFAA];

if operation == 1
    labels = {'Far Below Average' , 'Below Average' , ' Average', 'Above Average', 'Far Above Average'};
    pie(WEAK, labels);
    title('The Student Performance of Schools With a Weak Supportive Environment');
elseif operation == 2
    labels = {'Far Below Average' , 'Below Average' , ' Average', 'Above Average', 'Far Above Average'};
    pie(NEUTRAL, labels);
    title('The Student Performance of Schools With a Average Supportive Environment');
elseif operation == 3
    labels = {'Far Below Average' , 'Below Average' , ' Average', 'Above Average', 'Far Above Average'};
    pie(STRONG, labels);
    title('The Student Performance of Schools With a Strong Supportive Environment');
elseif operation == 4
    labels = {'Far Below Average' , 'Below Average' , ' Average', 'Above Average', 'Far Above Average'};
    pie(VSTRONG, labels);
   title('The Student Performance of Schools With a Very Strong Supportive Environment');
else
    fprintf('**Error**\n Unknown Operation\n');
end
end

function ZipCodeAndACT(zip, data, Schools)


i = 1;
ziptally = 0;
zipscore = 0;
while (i < 93)
if(data(i,2) == zip)
zipscore = zipscore + data(i,5);
ziptally = ziptally + 1;
end
i = i + 1;
end
zipavg = zipscore/ziptally;
zipavg = num2str(zipavg);
m = msgbox({'Average ACT Score for that Zip Code:', zipavg}, 'Average ACT Score');


end




