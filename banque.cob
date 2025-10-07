      *========================================================*
      *  PROGRAMME : MINI-BANQUE                              *
      *  DESCRIPTION : Gestion simple de comptes bancaires     *
      *========================================================*
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MINI-BANQUE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FICHIER-COMPTE ASSIGN TO 'comptes.txt'
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  FICHIER-COMPTE.
       01  ENREG-COMPTE.
           05 NOM-CLIENT       PIC X(20).
           05 SOLDE            PIC 9(7)V99.

       WORKING-STORAGE SECTION.
       01  CHOIX               PIC 9.
       01  FIN-PROG            PIC X VALUE 'N'.
       01  NOM-ENTREE          PIC X(20).
       01  MONTANT             PIC 9(7)V99.
       01  EOF                 PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       DEBUT.
           PERFORM UNTIL FIN-PROG = 'O'
               DISPLAY "================================"
               DISPLAY "   MINI SYSTEME BANCAIRE COBOL"
               DISPLAY "================================"
               DISPLAY "1 - Ajouter un compte"
               DISPLAY "2 - Afficher tous les comptes"
               DISPLAY "3 - Quitter"
               DISPLAY "Votre choix : "
               ACCEPT CHOIX
               EVALUATE CHOIX
                   WHEN 1
                       PERFORM AJOUTER-COMPTE
                   WHEN 2
                       PERFORM LIRE-COMPTES
                   WHEN 3
                       MOVE 'O' TO FIN-PROG
                   WHEN OTHER
                       DISPLAY "Choix invalide."
               END-EVALUATE
           END-PERFORM
           STOP RUN.

      *--------------------------------------------------------*
      * AJOUTER UN NOUVEAU COMPTE                              *
      *--------------------------------------------------------*
       AJOUTER-COMPTE.
           DISPLAY "Nom du client : "
           ACCEPT NOM-ENTREE
           DISPLAY "Solde initial : "
           ACCEPT MONTANT
           OPEN EXTEND FICHIER-COMPTE
           MOVE NOM-ENTREE TO NOM-CLIENT
           MOVE MONTANT TO SOLDE
           WRITE ENREG-COMPTE
           CLOSE FICHIER-COMPTE
           DISPLAY "Compte ajoute avec succes.".

      *--------------------------------------------------------*
      * LIRE ET AFFICHER TOUS LES COMPTES                      *
      *--------------------------------------------------------*
       LIRE-COMPTES.
           OPEN INPUT FICHIER-COMPTE
           PERFORM UNTIL EOF = 'O'
               READ FICHIER-COMPTE
                   AT END
                       MOVE 'O' TO EOF
                   NOT AT END
                       DISPLAY "Nom : " NOM-CLIENT
                       DISPLAY "Solde : " SOLDE
                       DISPLAY "----------------------"
               END-READ
           END-PERFORM
           CLOSE FICHIER-COMPTE.

