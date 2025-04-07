# 1 Rahmenbedingungen

Die zu entwickelnde App soll eine gewisse Komplexität aufweisen. Damit die Rahmenbedingungen für alle gleich oder möglichst ähnlich sind und dennoch zu den individuellen Ideen passen, sollen die einzelnen Kriterien pro App und Idee definiert werden.

Aus den unterhalb aufgelisteten Kriterien müssen so viele durch ankreuzen ausgewählt werden, damit mindestens zehn Punkte erreicht werden. Die Punkte werden nur einmal vergeben.

| Kriterium                                                                     | Punkte | Wahl |
| ----------------------------------------------------------------------------- | ------ | ---- |
| Sensor auslesen und dessen Daten verarbeiten                                  | 5      |      |
| Aktuator verwenden                                                            | 4      |      |
| Kommunikation über Bluetooth, NFC, WiFi-Direct oder AdHoc-WiFi                | 6      |      |
| Externe Schnittstelle lesen                                                   | 2      |      |
| Externe Schnittstelle schreiben                                               | 3      |      |
| Mehr als eine Aktivität oder View verwenden                                   | 1      |      |
| Kommunikation zwischen zwei Aktivitäten oder Views                            | 1      |      |
| Verwenden einer persistenten, lokalen Datenablage                             | 2      |      |
| Verwenden von Hintergrundoperationen (z. B. Services, Notifications, ...)     | 4      |      |
| Interaktion mit Systemapplikationen (z. B. Kamera, SMS, …)                    | 2      |      |
| Verwenden von selbsterstellten Animationen (z. B. Sprites, Pfadverfolgung, …) | 2      |      |
| Plattformspezifische APIs: Widgets, Badges, andere Integrationen              | 6      |      |
| Spezifisches Icon wird verwendet                                              | 1      |      |
| **Erreichte Punkte**                                                          |        |      |

## Bewertung:

### ✅ Verwenden einer persistenten, lokalen Datenablage (2 Punkte)

- Implementiert in StorageService mit SharedPreferences
- Speichert Tasks und Einstellungen lokal

### ✅ Mehr als eine Aktivität oder View verwenden (1 Punkt)

- Hat mehrere Screens (HomeScreen, etc.)
- Verwendet Provider für State Management

### ✅ Kommunikation zwischen zwei Aktivitäten oder Views (1 Punkt)

- Verwendet Provider für Kommunikation zwischen Views
- TaskProvider und SettingsProvider ermöglichen Datenfluss

### ✅ Verwenden von Hintergrundoperationen (4 Punkte)

- Implementiert asynchrone Operationen für Datenpersistenz
- Verwendet Future und async/await für Hintergrundoperationen

### ✅ Spezifisches Icon wird verwendet (1 Punkt)

- App hat ein eigenes Icon (standardmäßig in Flutter)

# 3 Bewertungsraster

Die einzelnen Kriterien mit den Gütestufen beschreiben, wie Ihre Leistung bei dieser Projektarbeit bewertet wird.
Beachten Sie, dass die einzelnen Kriterien nach einer Dokumentation verlangen. Der Kursleiter definiert wie diese abzugeben sind.

## 1. Inhalt des Kurzvortrages (Pitch)

Der Kurzvortrag wurde als PDF-Dokument rechtzeitig abgegeben und enthält mindestens folgende Elemente:

- A. Name der App
- B. Kurzbeschreibung der Idee in einem Satz oder als Stichwortliste
- C. Erwähnung der Rahmenbedingungen
- D. Motivation hinter der Idee. Weshalb braucht es diese App?

| Punkte | Beschreibung                                                                                                                                 |
| ------ | -------------------------------------------------------------------------------------------------------------------------------------------- |
| 3      | Alle Elemente sind nachvollziehbar beschrieben. Die Abgabe erfolgte rechtzeitig.                                                             |
| 2      | Ein Element fehlt in der Beschreibung oder ist nicht nachvollziehbar. Die Abgabe erfolgte rechtzeitig.                                       |
| 1      | Zwei Elemente fehlen oder sind nicht nachvollziehbar in der Beschreibung und/oder Abgabe erfolgte verspätet, jedoch bis zum Ende des Kurses. |
| 0      | Keine Abgabe als PDF oder mehr als zwei Elemente wurden nicht beschrieben.                                                                   |

**Erreichte Punkte:**

## 2. Halten des Kurzvortrags (Pitch)

Der Kurzvortrag wurde gehalten, dauerte maximal 90 Sekunden und alle Inhalte aus Kriterium 1 wurden vorgestellt.

| Punkte | Beschreibung                                                                                                         |
| ------ | -------------------------------------------------------------------------------------------------------------------- |
| 3      | Alle Bedingungen erfüllt.                                                                                            |
| 2      | Der Kurzvortrag dauerte 30 Sekunden länger als 90 Sekunden, aber alle Punkte aus dem Kriterium 1 wurden vorgestellt. |
| 1      | Nicht alle Inhalte aus dem Kriterium 1 wurden vorgestellt.                                                           |
| 0      | Der Kurzvortrag wurde nicht gehalten.                                                                                |

**Erreichte Punkte:**

## 3. Storyboard

Folgende Anforderungen an das Storyboard (Einzelne Screens der App und der möglichen Aktionen) sind zu erfüllen:

- A. Rechtzeitige Abgabe zu dem vom Kursleiter definierten Bedingungen als PDF
- B. Logische Abfolge
- C. Zuvor beschriebene Idee wird vollständig abgebildet

| Punkte | Beschreibung                   |
| ------ | ------------------------------ |
| 3      | Alle Bedingungen erfüllt.      |
| 2      | Zwei Bedingungen erfüllt.      |
| 1      | Eine Bedingung erfüllt.        |
| 0      | Keine Abgabe oder unbrauchbar. |

**Erreichte Punkte:**

## 4. Beschreiben der funktionalen und nicht-funktionalen Anforderungen

Beschreiben Sie die funktionalen und nicht-funktionalen Anforderungen wie folgt:

- A. Bilden Sie die funktionalen Anforderungen als vollständiges Anwendungsfalldiagramm (Use Case) nach UML ab
- B. Beschreiben Sie jeden Akteur mit einem Satz
- C. Beschreiben Sie die nicht-funktionalen Anforderungen (Qualitätsanforderungen) nach FURPS. Jede Anforderung muss messbar sein. Es sind mindestens drei nicht-funktionale Anforderungen zu erfassen

| Punkte | Beschreibung                   |
| ------ | ------------------------------ |
| 3      | Alle Bedingungen erfüllt.      |
| 2      | Zwei Bedingungen erfüllt.      |
| 1      | Eine Bedingung erfüllt.        |
| 0      | Keine Abgabe oder unbrauchbar. |

**Erreichte Punkte:**

## 5. Testkonzept

Stellen Sie ein Testkonzept auf, welches beschreibt, wie Sie Ihre Applikation auf deren Funktionalität und Qualität überprüfen wollen. Folgende Bedingungen werden an das Testkonzept gestellt:

- A. Beschreiben Sie das Testumfeld genau
- B. Beschreiben Sie die Testmethode
- C. Beschreiben Sie mindestens für jeden Anwendungsfall einen aussagekräftigen Testfall mit:
  - a. Identifikation
  - b. Vorbedingungen
  - c. Schritt für Schritt vorgehen (Aufzählung)
  - d. Erwartetes Resultat

| Punkte | Beschreibung                   |
| ------ | ------------------------------ |
| 3      | Alle Bedingungen erfüllt.      |
| 2      | Zwei Bedingungen erfüllt.      |
| 1      | Eine Bedingung erfüllt.        |
| 0      | Keine Abgabe oder unbrauchbar. |

**Erreichte Punkte:**

## 6. Aufbau des Systems

Beschreiben Sie den Aufbau des Systems in einem Klassen- oder Paketdiagramm.

- A. Das Klassen- oder Paketdiagramm ist verständlich und mehrheitlich nach UML
- B. Das Diagramm bildet die Beziehungen ab
- C. Das Diagramm und die Implementation passen zusammen

| Punkte | Beschreibung                   |
| ------ | ------------------------------ |
| 3      | Alle Bedingungen erfüllt.      |
| 2      | Zwei Bedingungen erfüllt.      |
| 1      | Eine Bedingung erfüllt.        |
| 0      | Keine Abgabe oder unbrauchbar. |

**Erreichte Punkte:**

## 7. Schichtentrennung

Die App wurde einzelne passende Schichten aufgeteilt. Folgende Bedingungen sind zu erfüllen:

- A. Die Paketstruktur oder Modularisierung widerspiegelt die Schichtentrennung
- B. Die Beschreibung der einzelnen Entitäten (Modell) erfolgt separat von Benutzeroberfläche und Businesslogik
- C. Die Benutzeroberfläche enthält keine Businesslogik

| Punkte | Beschreibung              |
| ------ | ------------------------- |
| 3      | Alle Bedingungen erfüllt. |
| 2      | Zwei Bedingungen erfüllt. |
| 1      | Eine Bedingung erfüllt.   |
| 0      | Keine Abgabe.             |

**Erreichte Punkte:**

## 8. Versionsverwaltung

Der Quellcode der App ist mittels einem Source Code Management (SCM) verwaltet.

- A. Ein Commit enthält immer nur Änderungen zu einem Thema (atomare Commits)
- B. Die Commits sind mit einem Kommentar, welche die jeweilige Änderung umschreibt, passend beschrieben
- C. Nachweise zur Versionierung sind mit einer Abgabe (bspw. Screenshot) der Historie erbracht

| Punkte | Beschreibung              |
| ------ | ------------------------- |
| 3      | Alle Bedingungen erfüllt. |
| 2      | Zwei Bedingungen erfüllt. |
| 1      | Eine Bedingung erfüllt.   |
| 0      | Keine Abgabe.             |

**Erreichte Punkte:**

## 9. Testprotokoll

Für das in Kriterium 5 beschriebenen Testkonzept ist ein Testprotokoll zu erstellen mit folgenden Angaben:

- A. Zeitpunkt der Prüfung, sowie der Person, welche die Prüfung durchführt
- B. Angabe welcher Testfall geprüft wurde
- C. Ergebnis der Prüfung

| Punkte | Beschreibung              |
| ------ | ------------------------- |
| 3      | Alle Bedingungen erfüllt. |
| 2      | Zwei Bedingungen erfüllt. |
| 1      | Eine Bedingung erfüllt.   |
| 0      | Keine Abgabe.             |

**Erreichte Punkte:**

## 10. Reflexion

Die geleistete Arbeit wird zum Schluss in einer 3 Punkte Reflexion kritisch gewürdigt. Die Reflexion enthält folgende Punkte:

- A. Beschreibung der Absicht (SOLL)
- B. Beschreibung des Resultats (IST)
- C. Beschreibung der Erkenntnis: Die Erkenntnis gibt Aufschluss darüber, was das nächste Mal wieder so gemacht werden und wo das Vorgehen angepasst werden sollte

| Punkte | Beschreibung              |
| ------ | ------------------------- |
| 3      | Alle Bedingungen erfüllt. |
| 2      | Zwei Bedingungen erfüllt. |
| 1      | Eine Bedingung erfüllt.   |
| 0      | Keine Abgabe.             |

**Erreichte Punkte:**

## 11. Vorbereitung für die Veröffentlichung

Analog zu den Einträgen in den bekannten Vertriebsplattformen (Apple AppStore, Google Play, …) soll eine Webseite erstellt und abgegeben werden, welche die App bewirbt. Diese beinhaltet mindestens:

- A. Name der App
- B. Icon der App
- C. Beschreibung mit weniger als 40 Wörter
- D. Mindestens drei Screenshots der App

| Punkte | Beschreibung              |
| ------ | ------------------------- |
| 3      | Alle Bedingungen erfüllt. |
| 2      | Drei Bedingungen erfüllt. |
| 1      | Zwei Bedingungen erfüllt. |
| 0      | Keine Abgabe.             |

**Erreichte Punkte:**

## 12. Abgabe des Quellcodes

Der Quellcode des Projekts wurde nach folgenden Kriterien abgegeben:

1. Das vollständige Projekt wurde abgegeben
2. Generierte Dateien (bspw. Build-Cache) sind nicht enthalten

| Punkte | Beschreibung                                                                                                            |
| ------ | ----------------------------------------------------------------------------------------------------------------------- |
| 3      | Alle Kriterien sind erfüllt.                                                                                            |
| 0      | Das genannte Lieferobjekt wurde nicht, verspätet, in einem falschen Format abgegeben oder nicht alle Kriterien erfüllt. |

**Erreichte Punkte:**

## 13. Code Conventions

Die Umsetzung berücksichtigt folgende Code Conventions:

1. Die Methoden dürfen (mit Methodenkopf) nicht länger als 30 Zeilen sein. Ausnahmen sind die UI-Generierungsmethoden von den deklarativen Frameworks (Flutter, React Native)
2. Die Variablen-, Property- und Methodennamen sind Englisch
3. Bei der Benennung der Namen wurde auf Pascal Case (Java: Public Properties) und Camel Case (Dart bei allen Properties, Java: bei den Methoden) geachtet
4. Eine automatisierte Möglichkeit zur Überprüfung dieser Regeln ist umgesetzt (Linter)

| Punkte | Beschreibung                   |
| ------ | ------------------------------ |
| 3      | Alle Bedingungen erfüllt.      |
| 2      | Drei Bedingungen erfüllt.      |
| 1      | Zwei Bedingungen erfüllt.      |
| 0      | Keine Abgabe oder unbrauchbar. |

**Erreichte Punkte:**

## 14. Abgabe der Installationsdatei

Die Installationsdatei muss den vom Kursleiter bekanntgegeben Bedingungen entsprechen und wurde wie definiert, rechtzeitig abgegeben. Die Installationsdatei muss in der bekanntgegebenen Umgebung funktionieren.

| Punkte | Beschreibung                                   |
| ------ | ---------------------------------------------- |
| 3      | Bedingungen erfüllt.                           |
| 0      | Bedingungen nicht erfüllt. Funktioniert nicht. |

**Erreichte Punkte:**

## 15. Leistungsfähigkeit

Dieses Kriterium bewertet, ob Sie die Idee vollständig in der zur Verfügung stehenden Zeit implementieren konnten.

| Punkte | Beschreibung                                               |
| ------ | ---------------------------------------------------------- |
| 3      | Alle Anforderungen implementiert.                          |
| 2      | Alle ausser einer Anforderung implementiert.               |
| 1      | Alle ausser zwei Anforderungen implementiert.              |
| 0      | App wurde nur ungenügend oder unvollständig implementiert. |

**Erreichte Punkte:**
