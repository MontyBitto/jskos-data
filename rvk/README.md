# Regensburger Verbundklassifikation in JSKOS

Die Regensburger Verbundklassifikation (RVK) wird etwa vierteljährlich von der UB Regensburg als Gesamtabzug und als Teilabzug der Änderungen [zur Verfügung gestellt](https://rvk.uni-regensburg.de/regensburger-verbundklassifikation-online/rvk-download). Die vollständige gepackte MARCXML-Datei umfasst etwa 30MB und entpackt etwa 1.5GB.

Die RVK-Daten werden aus dem internen Verwaltungsystem in das [MARC 21 Format for Classification Data](http://www.loc.gov/marc/classification/) konvertiert. Die Teilmenge der verwendeten MARC-Felder sind [auf einer eigenen Seite](https://rvk.uni-regensburg.de/api_2.0/marcxml.html) beschrieben.

Der Datenbankdump enthält allerdings nicht die in der RVK-Druckversion angegebene Schlüssel und Informationen über die Zusammensetzung von RVK-Klassen.

## Download

Das Bash-Skript `rvkdata.sh` enthalten die vollständigen Befehle für Download und Konvertierung der RVK. Als erstes Kommandozeilenargument wird das Datum des jeweiligen Dumps in der Form `XXXX_X` angegeben (z.B. `2018_4`):

    ./rvkdata.sh 2018_4

Die Daten werden für jedes Datum in ein eigenes Unterverzeichnis mit geschrieben.

## Konvertierung

Zur Konvertierung wird [mc2skos](https://github.com/scriptotek/mc2skos) benötigt. Die in mc2skos festgelegte URI-Struktur der RVK ist jedoch veraltet, so dass anschließend mit eine [jq](https://stedolan.github.io/jq/)-Skript die JSKOS-Daten bereinigt werden. Beide Konvertierungsschritte lassen sich so aufrufen:

    ./rvkdata.sh 2018_4 jskos

## Datenanalyse

Zur Kontrolle der MARCXML-Daten lässt sich mit Catmandu eine Statistik der tatsächlich verwendeten MARC-Felder und Unterfelder erstellen. Die dafür benötigten Perl-Module sind in `cpanfile` aufgeführt (`cpanm --installdeps .`):

    ./rvkdata.sh 2018_4 mcstats

