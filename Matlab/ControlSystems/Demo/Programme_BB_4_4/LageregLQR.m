clear all
% ****************************************************
% Lageregelung: Riccati-Entwurf f�r unendliches Zeitintervall, 
% wie Abschnitt 4.7.4 der Vorlesung
% ****************************************************

global A b R

% Zustandsraummodell der Regelstrecke:
K = 1
T = 1
A = [0 1; 0 -1/T]
b = [0; K/T]
x0 = [3 0]

% Gewichtungen:
Q = [2 0; 0 1]
r = 1

% L�sen der algebraischen Riccati-Gleichung und Berechnung des Reglers R f�r
% u = -Rx mittels Aufruf LQR:
[R,P,e] = lqr(A,b,Q,r)  % e liefert zus�tzlich die Eigenwerte von A-bR

% Simulieren wir nun das Verhalten des geschlossenen Lageregelkreises:
te = 6;
[t,x] = ode45(@x_dotLQR,[0 te],x0);
plot(t,x,t,(-R*x')') % rot ist der Stellgr��enverlauf

% Durch Variieren von r kann man den Stellgr��eneinsatz in transparenter
% Weise einstellen. Man beobachtet: Auch sehr hohe Stellgr��en k�nnen den
% Einschwingvorgang kaum unter 2sec dr�cken. 