clear all
% ****************************************************
% Lageregelung: Riccati-Entwurf f�r endliches Zeitintervall, 
% wie Beiblatt 4.4
% ****************************************************

global K T A b Q r p t_vorwaerts
% diese Variablen sind damit auch in allen functions verf�gbar, ohne dort
% erneut definiert werden zu m�ssen.

% Zustandsraummodell der Regelstrecke:
K = 1
T = 1
A = [0 1; 0 -1/T]
b = [0; K/T]
x0 = [3 0]

% Gewichtungen und t_e:
Q = [1 0; 0 1]
r = 1
t_e = 2

% Numerische Integration der Riccati-DGL, Beiblatt 4.4-2 unten, bei
% r�ckw�rts laufender Zeit, f�r p11, p12, p22:
[t_rueckwaerts,p] = ode45(@p_dot,[0 t_e],[0 0 0]);  % ode45 = Ordinary Differential Equations solver by Runge-Kutte 4/5-Verfahren
% Argumente: p_dot ist eine function, die die rechte Seite der DGL enth�lt;
% dann folgt das interessierende Zeitintervall [0 t_e] und die Anfangswerte [0 0 0]

plot(t_rueckwaerts,p(:,2),t_rueckwaerts,p(:,3));  % Kontrollausgabe, vergleiche Beiblatt 4.4-4
pause % nach Betrachten des Plot Return dr�cken, dann n�chstes Bild betrachten.

% nun kehren wir die Zeitrichtung um:
t_vorwaerts = t_e - flipud(t_rueckwaerts);
p = flipud(p);
plot(t_vorwaerts,p(:,2),t_vorwaerts,p(:,3));  % Kontrollausgabe, vergleiche Beiblatt 4.4-4
pause

% Simulieren wir nun das Verhalten des geschlossenen Lageregelkreises:
[t,x] = ode45(@x_dot,[0 t_e],x0);
plot(t,x)


% Bemerkungen:

% Man sieht, dass f�r t_e = 2 der Zustandspunkt nicht sehr nah an 0
% herangef�hrt wird. Erg�nzt man das G�tema� um einen Term x(te)*S*x(te)
% zur Gewichtung des Endpunktes, so �ndert dies in obigem Programm
% lediglich den Anfangswert von P zu P(te)=S. Ersetzen Sie mal die Zeile
% [t_rueckwaerts,p] = ode45(@p_dot,[0 t_e],[0 0 0]); 
% durch 
% [t_rueckwaerts,p] = ode45(@p_dot,[0 t_e],[100 0 100]); 
% und der gew�nschte Endpunkt [0 0] wird fast genau erreicht.

% Probieren Sie verschiedene Werte t_e und verschiedene Gewichte Q. F�r
% gro�e Werte t_e wird P(t) ungef�hr konstant im �berwiegenden Teil des
% Zeitintervalls.

% MATLAB geht nicht konsequent mit der Unterscheidung von Zeilen- und
% Spaltenvektoren um. Deshalb kommt es zu Inkonsistenzen, hier
% z.B. werden die Vektoren der Anfangswerte p0 und x0 f�lschlich als 
% ZEILENvektoren benutzt.

