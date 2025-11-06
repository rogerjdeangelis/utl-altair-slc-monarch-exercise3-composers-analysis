%let pgm=utl-altair-slc-monarch-exercise3-composers-analysis;

%stop_submission;

RE: Altair-SLC-Monarch-Exercise-3-Composers-Analysis

Too long to post here, see github

github
https://github.com/rogerjdeangelis/utl-altair-slc-monarch-exercise3-composers-analysis

This programming wqas done without the eclipse IDE.
Some programmers feel a persistent work directory has unintended consequences.
Ultra-Edit starts new session with each submission.
https://community.altair.com/discussion/38746

download composers.txt to
c:/txt/composers.txt;


PROBLEM
=======

You are an Operations Analyst, and you need to analyze the most popular composers by customers.
Your manager wants you to answer the following questions using Altair Monarch Classic:

What is the total count of Composers by Contact & Account Number?
Who are the top 5 Composers for the following Contacts; Betty Yoder, Bill Saxman, and Howie Franklin?
Who are the bottom 5 Composers for the following Contacts; Alain Lebon, Lidia Rosado, and Maria Seefeld?


ONCE YOU CREATE THIS TABLE THE SOLUTION IS STRAIGT FORWARD, SEE BELOW.
=====================================================================

TABLE SD1.HAVE

 ACCOUNT      CONTACT          COMPOSERS

  11887     Betty Yoder        PACHELBEL, J.
  11887     Betty Yoder        MOZART, W.A
  11887     Betty Yoder        WEELKES, T.
  11887     Betty Yoder        GRIEG, E.
  11887     Betty Yoder        GERSHWIN, G.
  11887     Betty Yoder        GINASTERA, A.
  ....
  14162     Braulio Sánchez    SCHUBERT, F.
  14162     Braulio Sánchez    LOCKE, M.
  14162     Braulio Sánchez    STRAUSS, J.I
  14162     Braulio Sánchez    ALBENIZ, I.
  14162     Braulio Sánchez    FANO, G.A


1 WHAT IS THE TOTAL COUNT OF COMPOSERS BY CONTACT & ACCOUNT NUMBER?
===================================================================

                           COMPOSER
  ACCOUNT  CONTACT              UNQ
  ---------------------------------
   10073    Mo Malone            90
   10609    Bill Saxman          90
   10929    Roberto Gil          90
   11433    Mike Kelly           90
   11860    Maria Seefeld        90
   11887    Betty Yoder          90
   12014    Howie Franklin       90
   12705    Lidia Rosado         90
   13487    Thomas Kurze         90
   14162    Braulio Sánchez      90
   15091    Marie Thibedeau      90
   15403    Terry McDowell       90
   15844    Kies van Der Houwe   90
   16284    Thomas Martinez      90
   17658    Lionel Sampson       90
   17959    Marvin Mabry         90
   18172    Louise Heinerlein    90
   18635    Alain Lebon          90
   18917    Ray Woolley          90
   19764    Lucien Lejeune       90

  proc sql;
    select
       account
      ,contact
      ,count (distinct nam) as composers_unq
    from
      have
    group
      by account, contact
 ;quit;

2 WHO ARE THE TOP 5 COMPOSERS FOR THE FOLLOWING CONTACTS; BETTY YODER, BILL SAXMAN, AND HOWIE FRANKLIN?
=======================================================================================================

  There are many more ties, I Listed the first five in alphabetic order

   COMPOSERS         COUNT

   BACH, J.S           3
   BARTOK, B.          3
   BEETHOVEN, L.v      3
   BERLIOZ, H.         3
   BERNSTEIN, L.       3

   libname sd1 "d:/sd1";
   proc sql;
   reset outobs=5;
   select
     composers
    ,count(composers) as count
   from
     sd1.have
   where
     strip(contact) in ("Betty Yoder", "Bill Saxman", "Howie Franklin")
   group
     by composers
   order
     by count descending, composers
   ;quit;

3 WHO ARE THE BOTTOM 5 COMPOSERS FOR THE FOLLOWING CONTACTS; ALAIN LEBON, LIDIA ROSADO, AND MARIA SEEFELD?
==========================================================================================================

    COMPOSERS     count
    -------------------
    ADAM, A.          1
    ADAMS, J.         1
    ALBINONI, T.      1
    ALKAN, C.         1
    ARCADELT, J.      1

   libname sd1 "d:/sd1";
   &_init_;
   proc sql;
   reset outobs=5;
   select
     composers
    ,count(composers) as count
   from
     sd1.have
   where
     strip(contact) in ("Alain Lebon", "Lidia Rosado", "Maria Seefeld")
   group
     by composers
   order
     by count, composers
   ;quit;

/*                   _                                       _        _     _
  ___ _ __ ___  __ _| |_ ___   ___  ___  _   _ _ __ ___ ___ | |_ __ _| |__ | | ___
 / __| `__/ _ \/ _` | __/ _ \ / __|/ _ \| | | | `__/ __/ _ \| __/ _` | `_ \| |/ _ \
| (__| | |  __/ (_| | ||  __/ \__ \ (_) | |_| | | | (_|  __/| || (_| | |_) | |  __/
 \___|_|  \___|\__,_|\__\___| |___/\___/ \__,_|_|  \___\___| \__\__,_|_.__/|_|\___|

*/

libname sd1 "f:/sd1";
data sd1.have (keep=account contact composers);;
  length account contact $32;
  retain account contact;
  informat account contact nam1 nam2 nam3 $32.;
  infile "d:/txt/composers.txt" missover;
  input @; /*--- hold the buffer ----*/
  if _infile_=:"ACCOUNT" then account=scan(_infile_,2,':');
  if _infile_=:"CONTACT" then contact=scan(_infile_,2,':');
  input nam1 1-25 nam2 30-55 nam3 59-80;
  if countc(_infile_,',')=3 then do;
     composers=nam1;output;
     composers=nam2;output;
     composers=nam3;output;
    end;
;;;;
run;quit;


TABLE SD1.HAVE

 ACCOUNT      CONTACT          NAM

  11887     Betty Yoder        PACHELBEL, J.
  11887     Betty Yoder        MOZART, W.A
  11887     Betty Yoder        WEELKES, T.
  11887     Betty Yoder        GRIEG, E.
  11887     Betty Yoder        GERSHWIN, G.
  11887     Betty Yoder        GINASTERA, A.
  ....
  14162     Braulio Sánchez    SCHUBERT, F.
  14162     Braulio Sánchez    LOCKE, M.
  14162     Braulio Sánchez    STRAUSS, J.I
  14162     Braulio Sánchez    ALBENIZ, I.
  14162     Braulio Sánchez    FANO, G.A

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
