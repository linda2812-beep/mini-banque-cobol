      *============================================================*
      * PROGRAMME : MINI BANQUE EVOLUEE                            *
      * DESCRIPTION : Gestion simple de comptes bancaires           *
      *============================================================*
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MINI-BANQUE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FICHIER-COMPTE ASSIGN TO "comptes.txt"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS FS-COMPTE.
           SELECT TEMP-FICHIER ASSIGN TO "temp.txt"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS FS-TEMP.

       DATA DIVISION.
       FILE SECTION.
       FD  FICHIER-COMPTE.
       01  ENREG-COMPTE.
           05 NUM-COMPTE      PIC 9(5).
           05 NOM-CLIENT      PIC X(20).
           05 TYPE-COMPTE     PIC X(10).
           05 SOLDE           PIC 9(7)V99.
           05 DATE-CREATION   PIC X(10).

       FD  TEMP-FICHIER.
       01  ENREG-TEMP.
           05 NUM-TEMP        PIC 9(5).
           05 NOM-TEMP        PIC X(20).
           05 TYPE-TEMP       PIC X(10).
           05 SOLDE-TEMP      PIC 9(7)V99.
           05 DATE-TEMP       PIC X(10).

       WORKING-STORAGE SECTION.
       01  FS-COMPTE          PIC XX.
       01  FS-TEMP            PIC XX.
       01  CHOIX              PIC 9 VALUE 0.
       01  FIN-PROG           PIC X VALUE 'N'.
       01  EOF                PIC X VALUE 'N'.
       01  NOM-ENTREE         PIC X(20).
       01  TYPE-ENTREE        PIC X(10).
       01  MONTANT            PIC 9(7)V99 VALUE 0.
       01  DATE-AUJOURD       PIC X(10).
       01  NUM-COMPTE-COURANT PIC 9(5) VALUE 0.
       01  TROUVE             PIC X VALUE 'N'.
       01  REPONSE            PIC X VALUE SPACE.

       PROCEDURE DIVISION.
       MAIN-PARA.
           PERFORM INITIALISATION.
           PERFORM MENU-PRINCIPAL
               UNTIL FIN-PROG = 'O'.
           STOP RUN.

      *------------------------------------------------------------*
      * INITIALISATION                                             *
      *------------------------------------------------------------*
       INITIALISATION.
           MOVE FUNCTION CURRENT-DATE(1:10) TO DATE-AUJOURD.
           OPEN I-O FICHIER-COMPTE
           IF FS-COMPTE = "35"
               OPEN OUTPUT FICHIER-COMPTE
               CLOSE FICHIER-COMPTE
               OPEN I-O FICHIER-COMPTE
           END-IF
           CLOSE FICHIER-COMPTE.

      *------------------------------------------------------------*
      * MENU PRINCIPAL                                             *
      *------------------------------------------------------------*
       MENU-PRINCIPAL.
           DISPLAY "================================".
           DISPLAY "   MINI SYSTEME BANCAIRE COBOL   ".
           DISPLAY "================================".
           DISPLAY "1 - Ajouter un compte".
           DISPLAY "2 - Afficher tous les comptes".
           DISPLAY "3 - Rechercher un compte".
           DISPLAY "4 - Dépôt / Retrait".
           DISPLAY "5 - Supprimer un compte".
           DISPLAY "6 - Quitter".
           DISPLAY "Votre choix : ".
           ACCEPT CHOIX.

           EVALUATE CHOIX
               WHEN 1 PERFORM AJOUTER-COMPTE
               WHEN 2 PERFORM AFFICHER-COMPTES
               WHEN 3 PERFORM RECHERCHER-COMPTE
               WHEN 4 PERFORM DEPOT-RETRAIT
               WHEN 5 PERFORM SUPPRIMER-COMPTE
               WHEN 6 MOVE 'O' TO FIN-PROG
               WHEN OTHER DISPLAY "Choix invalide."
           END-EVALUATE.

      *------------------------------------------------------------*
      * AJOUTER UN COMPTE                                          *
      *------------------------------------------------------------*
       AJOUTER-COMPTE.
           DISPLAY "Nom du client : ".
           ACCEPT NOM-ENTREE.
           DISPLAY "Type de compte (Courant/Epargne) : ".
           ACCEPT TYPE-ENTREE.
           DISPLAY "Solde initial : ".
           ACCEPT MONTANT.

           ADD 1 TO NUM-COMPTE-COURANT.

           OPEN EXTEND FICHIER-COMPTE.
           MOVE NUM-COMPTE-COURANT TO NUM-COMPTE.
           MOVE NOM-ENTREE TO NOM-CLIENT.
           MOVE TYPE-ENTREE TO TYPE-COMPTE.
           MOVE MONTANT TO SOLDE.
           MOVE DATE-AUJOURD TO DATE-CREATION.
           WRITE ENREG-COMPTE.
           CLOSE FICHIER-COMPTE.

           DISPLAY "Compte ajouté avec succès.".

      *------------------------------------------------------------*
      * AFFICHER TOUS LES COMPTES                                  *
      *------------------------------------------------------------*
       AFFICHER-COMPTES.
           MOVE 'N' TO EOF.
           OPEN INPUT FICHIER-COMPTE.
           DISPLAY "LISTE DES COMPTES :".
           PERFORM UNTIL EOF = 'O'
               READ FICHIER-COMPTE
                   AT END MOVE 'O' TO EOF
                   NOT AT END
                       DISPLAY "--------------------------------"
                       DISPLAY "Numéro : " NUM-COMPTE
                       DISPLAY "Nom    : " NOM-CLIENT
                       DISPLAY "Type   : " TYPE-COMPTE
                       DISPLAY "Solde  : " SOLDE
                       DISPLAY "Date création : " DATE-CREATION
               END-READ
           END-PERFORM.
           CLOSE FICHIER-COMPTE.

      *------------------------------------------------------------*
      * RECHERCHER UN COMPTE                                       *
      *------------------------------------------------------------*
       RECHERCHER-COMPTE.
           DISPLAY "Entrez le nom du client à rechercher : ".
           ACCEPT NOM-ENTREE.
           MOVE 'N' TO TROUVE.
           MOVE 'N' TO EOF.
           OPEN INPUT FICHIER-COMPTE.

           PERFORM UNTIL EOF = 'O'
               READ FICHIER-COMPTE
                   AT END MOVE 'O' TO EOF
                   NOT AT END
                       IF NOM-CLIENT = NOM-ENTREE
                           DISPLAY "--------------------------------"
                           DISPLAY "Numéro : " NUM-COMPTE
                           DISPLAY "Nom    : " NOM-CLIENT
                           DISPLAY "Type   : " TYPE-COMPTE
                           DISPLAY "Solde  : " SOLDE
                           MOVE 'O' TO TROUVE
                       END-IF
               END-READ
           END-PERFORM.
           CLOSE FICHIER-COMPTE.

           IF TROUVE = 'N'
               DISPLAY "Aucun compte trouvé pour ce nom."
           END-IF.

      *------------------------------------------------------------*
      * DEPOT OU RETRAIT                                           *
      *------------------------------------------------------------*
       DEPOT-RETRAIT.
           DISPLAY "Nom du client : ".
           ACCEPT NOM-ENTREE.
           DISPLAY "Montant : ".
           ACCEPT MONTANT.
           DISPLAY "Type d'opération (D = Dépôt / R = Retrait) : ".
           ACCEPT REPONSE.

           MOVE 'N' TO EOF.
           MOVE 'N' TO TROUVE.
           OPEN I-O FICHIER-COMPTE.

           PERFORM UNTIL EOF = 'O'
               READ FICHIER-COMPTE
                   AT END MOVE 'O' TO EOF
                   NOT AT END
                       IF NOM-CLIENT = NOM-ENTREE
                           MOVE 'O' TO TROUVE
                           IF REPONSE = 'D'
                               ADD MONTANT TO SOLDE
                           ELSE
                               IF SOLDE >= MONTANT
                                   SUBTRACT MONTANT FROM SOLDE
                               ELSE
                                   DISPLAY "Solde insuffisant."
                               END-IF
                           END-IF
                           REWRITE ENREG-COMPTE
                           DISPLAY "Opération réussie."
                       END-IF
               END-READ
           END-PERFORM.
           CLOSE FICHIER-COMPTE.

           IF TROUVE = 'N'
               DISPLAY "Compte introuvable."
           END-IF.

      *------------------------------------------------------------*
      * SUPPRIMER UN COMPTE                                        *
      *------------------------------------------------------------*
       SUPPRIMER-COMPTE.
           DISPLAY "Nom du client à supprimer : ".
           ACCEPT NOM-ENTREE.
           MOVE 'N' TO TROUVE.
           MOVE 'N' TO EOF.

           OPEN INPUT FICHIER-COMPTE.
           OPEN OUTPUT TEMP-FICHIER.

           PERFORM UNTIL EOF = 'O'
               READ FICHIER-COMPTE
                   AT END MOVE 'O' TO EOF
                   NOT AT END
                       IF NOM-CLIENT NOT = NOM-ENTREE
                           MOVE NUM-COMPTE TO NUM-TEMP
                           MOVE NOM-CLIENT TO NOM-TEMP
                           MOVE TYPE-COMPTE TO TYPE-TEMP
                           MOVE SOLDE TO SOLDE-TEMP
                           MOVE DATE-CREATION TO DATE-TEMP
                           WRITE ENREG-TEMP
                       ELSE
                           MOVE 'O' TO TROUVE
                       END-IF
               END-READ
           END-PERFORM.

           CLOSE FICHIER-COMPTE.
           CLOSE TEMP-FICHIER.

           IF TROUVE = 'O'
               DISPLAY "Compte supprimé avec succès."
           ELSE
               DISPLAY "Compte introuvable."
           END-IF.

           CALL "SYSTEM" USING BY CONTENT "mv temp.txt comptes.txt".
