program liste (input,output);
{ Dieses Programm baut eine Liste auf, die einer Zeile im 
* Pascalschen Dreieck entsprechen sollte
* 
*     1
*    1 1
*   1 2 1
*  1 3 3 1
* 1 4 6 4 1 
* 
* bei Eingabe von 1 4 6 4 1 
* gibt das Programm aus: 1 5 10 10 5 1 usw.
*   }
   type
   tRefListe = ^tListe;
   tListe = record
              wert : integer;
              next : tRefListe;
   end;
   
   var 
   listenanfang : tRefListe; 
   zeiger : tRefListe; 
   endeListe : tRefListe;
   eingabe : integer;
   
   procedure alleDrucken(zuDrucken: tRefListe);
   var
   zeiger: tRefListe;
   
   begin
   zeiger := zuDrucken;
   write(' ');
   while zeiger <> nil do 
     begin
{    writeln(zeiger^.zahl); }
     write(zeiger^.wert ,' '); 
     zeiger:= zeiger^.next;
     end;
   writeln(' ');
   end;
   
   function pascalDreieck(inListe:tRefListe) : tRefListe;
 { inListe, weil eine liste angenommen wird }
 
 { diese funktion erwartet eine zeile aus dem pascalschen dreieck
 * und erstellt / berechnet die folgende zeile }
    
    var
    alteliste : tRefListe;
    neueliste : tRefListe; 
    neuesziel : tRefListe;
 
{ wichtig für das verständnis: liste wird von hinten aufgebaut
* das geht, weil die zeilen im pascalschen dreieck symmetrisch sind } 
     begin
     alteliste := inListe;
     new (neueliste);
     neueliste^.wert := 1;
     neueliste^.next := nil;
{ der erste neue 'wert' ist der letzte }

{ weitere 'werte' baut die while-schleife auf, 
* bis die alteliste / inListe erschöpft ist }     
     while alteliste <> nil do
     begin
      new (neuesziel);

{ bedingung: hat alteliste noch 'werte' ? }       
       if alteliste^.next <> nil then
         begin
         neuesziel^.wert := alteliste^.wert + alteliste^.next^.wert; 
         neuesziel^.next := neueliste ;
         neueliste := neuesziel; 
         end
       else
{ letzten 'wert' also ersten 'wert' der neuen liste anfügen }
         begin
         neuesziel^.wert := 1;
         neuesziel^.next := neueliste ;
         neueliste := neuesziel; 
         end;  

{ iteration in der while-schreife }        
       alteliste := alteliste^.next;
      end; { while }
     pascalDreieck := neueliste;       
     end; { pascalDreieck }

{ hier beginnt das Hauptprogramm }   
   BEGIN
   listenanfang := nil;
   endeListe := nil; 
   writeln('Eingabe der Zahlen, Beenden mit 0'); 
   readln(eingabe);
   
   while eingabe <> 0 do
     begin
     new(zeiger);
     zeiger^.wert := eingabe;
     zeiger^.next:=nil;
     if listenanfang = nil then
     listenanfang := zeiger
     else
     endeListe^.next:=zeiger;
     endeListe := zeiger; 
     readln(eingabe);
     end;
   
   alleDrucken(listenanfang);
 
{ hier wird die funktion aufgerufen }  
   listenanfang := pascalDreieck(listenanfang); 

{ hier wird die neu berechnete liste ausgegeben }   
   alleDrucken(listenanfang);
   
      
   END.
