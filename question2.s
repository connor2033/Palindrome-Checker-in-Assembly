		AREA Pointers, CODE, READONLY
		ENTRY
		
		ADR	r1, STRING			;	Register R1 points to beginning of STRING
		ADR	r2, EoS				;	Register R2 points to EoS
		
		LDRB r4, [r2], #-1		;	Decrement R2 to to put right after STRING
		
		
LOOP	LDRB r3, [r1], #1		;	Increment r3 up by 1
		LDRB r4, [r2], #-1		;	Decrement r4 down by 1
		
check	CMP r3, #0x00			;	Checking if R3 is at 
		BEQ pal					;	If Palindrome
		
		CMP r3, #'A'			;	Comapre r3 to 'A'
		BLT range1				;	Continue if r3 is not uppercase
		CMPGE r3, #'Z'			;	Compare r3 to 'Z'
		ADDLE r3, r3, #0x20		;	Making r3 lowerase
		
range1	CMP r3, #'a'			;	Comparing r3 to 'a' to see if non alphabetic
		LDRLTB r3, [r1], #1		;	Skipping to next byte if non alpha
		BLT check				;	Looping back to check EoS
		CMP r3, #'z'			;	Comparing r3 to 'z'
		LDRGTB r3, [r1], #1		;	Skipping to next byte if non alpha
		BGT check				;	Looping back to check EoS
		 
		CMP r4, #'A'			;	Comparing r4 to 'A'
		BLT	range2				;	Continue if r4 is not uppercase
		CMPGE r4, #'Z'			;	Compare r4 to 'Z'
		ADDLE r4, r4, #0x20		;	Making r4 loweracse
		
range2	CMP r4, #'a'			;	Comparing r4 to 'a' to see if non alphabetic
		LDRLTB r4, [r2], #-1	;	Skipping to next byte if non alpha
		BLT check				;	Looping back to check EoS
		CMP r4, #'z'			;	Comparing r4 to 'z'
		LDRGTB r4, [r2], #-1	;	Skipping to next byte if non alpha
		BGT check				;	Looping back to check EoS
		
		CMP r3, r4				;	Comparing the 2 chars
		MOVNE r0, #2			;	If not equal, not palindrome
		BNE finish				;	Exit this loop to end program
		
		B LOOP					;	Main loop
		
		

pal		MOV r0, #1				;	Setting r0 to 1 if palindrome
finish	MOV r0, r0				;	Branch here to terminate the program
		
STRING 	DCB "He lived as a devil, eh?" ;string 
EoS		DCB 0x00				;end of string 
		
		END