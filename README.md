# call-of-beacons

Zainspirowani jednym z trybów gry wieloosobowej serii Call of Duty, wyobraziliśmy sobie mecz paintball'a pomiędzy dwiema kilkuosobowymi drużynami. Jedna z drużyn oznaczona jest kolorem czerwonym, a druga niebieskim.

Na mapie przeznaczonej dla tej rozgrywki wyróżniamy dwa punkty, będące miejscami odrodzenia zawodników poszczególnych drużyn, rozmieszczone po przeciwległych stronach mapy, do których trafiony zawodnik musi się udać, aby kontynuować grę.

W odróżnieniu od standardowej potyczki, na mapie znajdują się trzy punkty specjalne. Zadaniem każdej z drużyn jest ich przejęcie oraz jak najdłuższe utrzymanie. Celem gry jest dominacja drużyny na mapie, czyli posiadanie przeważającej ilości punktów specjalnych przez większą ilość czasu, niż drużyna przeciwna.

Mówimy, że punkt specjalny jest przejęty przez drużynę niebieskich, gdy w jego ustalonym pobliżu w danej chwili przebywa więcej zawodników drużyny niebieskich, niż zawodników drużyny czerwonych.

W każdym punkcie specjalnym znajduje się beacon oraz lampa. Każdy zawodnik poza standardowym wyposażeniem posiada telefon z zainstalowaną aplikacją, pozwalającą na przechwytywanie sygnałów od poszczególnych beacon'ów. Całą rozgrywką zarządza serwer, do którego co pewien czas każdy z telefonów przekazuje komunikat o aktualnym położeniu względem beacon'ów.

Zadaniem serwera jest dokonanie obliczeń, rozstrzygających o przynależności każdego z punktów specjalnych, jak również sygnalizowanie tej przynależności graczom przez wysłanie do odpowiednich lamp wiadomości z liczbą, określającą kolor oraz intensywność światła. Im większa jest różnica ilości zawodników drużyny niebieskiej, przebywających w pobliżu danego beacon'a w stosunku do zawodników drużyny czerwonej, tym intensywniej lampa będzie świecić na niebiesko.

Nasz projekt realizuje część powyższej gry. Zaimplementowaliśmy aplikację mobilną na telefon komunikującą się z beaconem lub beaconami (w miarę możliwości pożyczenia) i serwerem. Aplikacja sprawdza periodycznie odległości do beaconów, a następnie przesyła te dane do serwera. Serwer przekazuje dane o pozycjach do jednego (lub więcej) klienta (będącego sędzią, graczem lub widzem), który prezentuje sytuację gry w sposób czytelny dla człowieka, a konkretnie w postaci strony internetowej.

Aplikację mobilną napisaliśmy na system iOS w języku Swift z wykorzystaniem SDK od Estimote. Serwer napisaliśmy w node-red. Komunikacja między nimi zachodzi z wykorzystaniem protokołu HTTP. Interfejsem użytkownika jest strona internetowa połączona z serwerem node-red przez websocket. Strona (lub więcej jej instancji) odbiera informacje o pozycjach graczy i aktualizowała kolor wyświetlanych prostokątów symbolizujących lampy.
