      ******************************************************************
      * Author: Brock Sharp
      * Date: 03/01/2019
      * Purpose: Add a new part to the inventory management system
      * TODO: Allow looking up supplier to get ID
      *       Automatically get the next partID (first empty value)
      ******************************************************************
       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. PARTS_ADD.
       ENVIRONMENT DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       CONFIGURATION SECTION.
      *-----------------------
       INPUT-OUTPUT SECTION.
      *-----------------------
       DATA DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       FILE SECTION.
      *-----------------------
       WORKING-STORAGE SECTION.
       01 WS-ERROR-MESSAGE     PIC X(40).
       01 WS-DATA-VALIDATED    PIC X VALUE "F".
       01 PART-OBJECT.
           05 WS-PART-ID       PIC 9(5).
           05 WS-PART-NAME     PIC X(15).
           05 WS-PART-DESC     PIC X(35).
           05 WS-PART-PRICE    PIC 999V99.
           05 WS-PART-SUPP     PIC 9(5).
       SCREEN SECTION.
       01 PART-ADD-SCREEN.
           05 TITLE-SECTION.
               10 VALUE "PARTS INVENTORY MAINTENANCE" BLANK SCREEN
                   LINE 1 COL 29.
               10 VALUE "-----------------------------------------------
      -             "--------------------------------"
                  LINE 2 COL 1.
           05 DATA-ENTRY-SECTION.
               10 PART-ID-FIELD.
                   20 VALUE "Part ID: "                   LINE 5 COL 25.
                   20 PART-ID PIC 9(5) FROM WS-PART-ID    LINE 5 COL 34.
               10 PART-SUPP-FIELD.
                   20 VALUE "Supplier ID: "              LINE 7 COL 21.
                   20 PART-SUPP PIC 9(5) TO WS-PART-SUPP LINE 7 COL 34.
               10 PART-NAME-FIELD.
                   20 VALUE "Part Name: "                 LINE 9 COL 23.
                   20 PART-NAME PIC X(15) TO WS-PART-NAME LINE 9 COL 34.
               10 PART-DESC-FIELD.
                   20 VALUE "Description: "              LINE 11 COL 21.
                   20 PART-DESC PIC X(35) TO WS-PART-DESC
                                                         LINE 11 COL 34.
               10 PART-PRICE-FIELD.
                   20 VALUE "Part Price: "               LINE 13 COL 22.
                   20 PART-PRICE PIC 999V99 TO WS-PART-PRICE
                                                         LINE 13 COL 34.
           05 FOOTER-MESSAGES.
               10 ERROR-MESSAGE PIC X(40) FROM WS-ERROR-MESSAGE
                     JUSTIFIED BLANK LINE                LINE 18 COL 30.
               10 VALUE "PRESS ENTER TO SUBMIT THE FORM" LINE 20 COL 27.

      *-----------------------
       PROCEDURE DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       MAIN-PROCEDURE.
      **
      * The main procedure of the program
      **
      * TEMPORARY - SET DEFAULT VALUE OF NEXT ID
            MOVE 12345 TO WS-PART-ID.
            DISPLAY PART-ADD-SCREEN.
            PERFORM UNTIL WS-DATA-VALIDATED = "T"
               ACCEPT PART-ADD-SCREEN
               PERFORM VALIDATE-DATA
            END-PERFORM.
            STOP RUN.

       VALIDATE-DATA.
           MOVE SPACES TO WS-ERROR-MESSAGE.
           IF WS-PART-ID <= 0 OR WS-PART-ID > 99999 THEN
               MOVE "INVALID PART-ID" TO WS-ERROR-MESSAGE
           END-IF.
           IF WS-PART-NAME = SPACES THEN
               MOVE "INVALID PART-NAME" TO WS-ERROR-MESSAGE
           END-IF.
           IF WS-PART-DESC = SPACES THEN
               MOVE "INVALID PART DESCRIPTION" TO WS-ERROR-MESSAGE
           END-IF.
           IF WS-PART-SUPP <= 0 OR WS-PART-SUPP > 99999 THEN
               MOVE "INVALID PART SUPPLIER" TO WS-ERROR-MESSAGE
           END-IF.
           IF WS-ERROR-MESSAGE = SPACES THEN
               MOVE "T" TO WS-DATA-VALIDATED
           END-IF.

       END PROGRAM PARTS_ADD.
