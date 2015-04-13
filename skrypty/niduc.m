%N jest liczb¹ generowanych bitów
N = input('Podaj liczbê bitów do wygenerowania');
PID = fopen('signal.txt', 'w');

x = randi(2,N,1) - 1; %randi generuje losowe wartoœci typu int miêdzy 1 i 2, gdy od wyniku odejmiemy '1' otrzymamy losowy ci¹g zer i jedynek

fprintf(PID, '%i\n',x);
fclose(PID);