DECLARE SUB Delay (WaitFor!)
DEFINT A-Z
TIMER OFF

SUB Delay (WaitFor!) STATIC
	x! = TIMER + WaitFor!
	IF x! >= 86400 THEN
		x! = x! - 86400
		DO UNTIL TIMER <= x!: LOOP
	END IF
	DO UNTIL TIMER >= x!
	LOOP
END SUB

