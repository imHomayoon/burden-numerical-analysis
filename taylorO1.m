% TAYLOR 1ST ORDER ALGORITHM - Homayoon
% F     = F(t,y)
% OK    = Defined it to make infinite loops for getting input - Dummy variable!
% A,B   = Starting and ending point of the interval
% ALPHA = Initial condition value
% N     = Number of subintervals
% FLAG  = 
% Name  = 
% OUP   = 
% H     = Amount of steps calculated by H = B-A/N
% T     = Contains current TIME T_I+1 = T_I + H , I=0,1,2,... , T_0 = A
% s     = string varialbe to hold F(t,y)
% Y     = The exact solution of differential equation

syms('F','OK','A','B','ALPHA','N','FLAG', 'ERFLAG','NAME','OUP','H');
syms('T','W','I','x','s', 'y', 'Y', 'ERROR');
%-------------------------------------------------------
% Defined TRUE and FALSE to make logical decisions!
TRUE = 1;
FALSE = 0;
%-------------------------------------------------------
fprintf(1,'This is Eulers Method.\n');
fprintf(1,'Input the function F(t,y) in terms of t and y\n');
fprintf(1,'For example: y-t^2+1\n');
s = input(' ', 's');
%F = inline(s,'t','y');
%F = @(t,y) s; Not working!
F = str2func(strcat('@(t,y)', s));
fprintf(1,'Do you want to evaluate the error?\n');
fprintf(1,'1. YES\n');
fprintf(1,'2. NO\n');
ERFLAG = input(' ');
if ERFLAG==1
    fprintf(1,'Input solution of differential equation\n');
    fprintf(1,'For example: (t+1)^2-(0.5*exp(t))\n');
    s = input(' ', 's'); % Exact solution of differential equation
    Y = str2func(strcat('@(t)', s));
else
    Y = str2func(strcat('@(t)', '0')); % Sets exact solution to constant 0 function!
end
OK = FALSE;
while OK == FALSE 
    fprintf(1,'Input left and right endpoints on separate lines.\n');
    A = input(' ');
    B = input(' ');
    if A >= B  
    fprintf(1,'Left endpoint must be less than right endpoint\n');
    else
        OK = TRUE;
    end
end
fprintf(1,'Input the initial condition\n');
ALPHA = input(' ');
OK = FALSE;
while OK == FALSE 
 fprintf(1,'Input a positive integer for the number of subintervals\n');
 N = input(' ');
 if N <= 0 
    fprintf(1,'Number must be a positive integer\n');
 else
    OK = TRUE;
 end
end
if OK == TRUE 
    fprintf(1,'Choice of output method:\n');
    fprintf(1,'1. Output to screen\n');
    fprintf(1,'2. Output to text file\n');
    fprintf(1,'Please enter 1 or 2\n');
    FLAG = input(' ');
    if FLAG == 2
        fprintf(1,'Input the file name in the form - drive:\\name.ext\n');
        fprintf(1,'For example   A:\\OUTPUT.DTA\n');
        NAME = input(' ','s');
        OUP = fopen(NAME,'wt');
    else
        OUP = 1;
    end
    fprintf(OUP, 'EULERS METHOD\n\n');
    fprintf(OUP, '    t           w           Y           Error           \n\n');
    % STEP 1
    H = (B-A)/N;
    T = A;
    W = ALPHA;
    y = Y(A);
    ERROR = abs(Y(A)-W);
    fprintf(OUP, '%5.3f %11.7f %11.7f %11.7f\n', T, W, y, ERROR);
    % STEP 2
    for I = 1:N 
        % STEP 3
        % Compute W(I)
        W = W+H*F(T, W);
        % Compute T(I)
        T = A+I*H;
        % Compute Y(T)
        y = Y(T);
        % Compute Error
        ERROR = abs(Y(T)-W);
        % STEP 4
        fprintf(OUP, '%5.3f %11.7f %11.7f %11.7f\n', T, W, y, ERROR); % 5.3f means field width of five digits including 3 digits after decimal point
    end
    % STEP 5
        if OUP ~= 1 
            fclose(OUP);
            fprintf(1,'Output file %s created successfully \n',NAME);
        end
end