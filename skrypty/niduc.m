%N jest liczb� generowanych bit�w
N = input('Podaj liczb� bit�w do wygenerowania');
PID = fopen('signal.txt', 'w');

x = randi(2,N,1) - 1; %randi generuje losowe warto�ci typu int mi�dzy 1 i 2, gdy od wyniku odejmiemy '1' otrzymamy losowy ci�g zer i jedynek

fprintf(PID, '%i\n',x);
fclose(PID);