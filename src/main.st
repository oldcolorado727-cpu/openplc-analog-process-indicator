IF potValue <= 341 THEN
    Green := TRUE;
    Yellow := FALSE;
    Red := FALSE;

ELSIF potValue <= 682 THEN
    Green := FALSE;
    Yellow := TRUE;
    Red := FALSE;

ELSE
    Green := FALSE;
    Yellow := FALSE;
    Red := TRUE;
END_IF;
