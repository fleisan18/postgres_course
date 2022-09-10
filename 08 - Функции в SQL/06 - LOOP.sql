CREATE OR REPLACE FUNCTION fib (n int) RETURNS int AS $$
DECLARE
    counter int = 0;
    i int = 0;
    j int = 1;
BEGIN
    IF n < 1 THEN 
    RETURN 0;
    END IF;
    
    WHILE counter <= n
    LOOP
        counter = counter + 1;
        SELECT j, i+j INTO i, j;
    END LOOP;
    RETURN i;
END;
$$ LANGUAGE plpgsql;

SELECT fib(10);

--

CREATE OR REPLACE FUNCTION fib (n int) RETURNS int AS $$
DECLARE
    counter int = 0;
    i int = 0;
    j int = 1;
BEGIN
    IF n < 1 THEN 
    RETURN 0;
    END IF;
    
    LOOP
        EXIT WHEN counter > n;
        counter = counter + 1;
        SELECT j, i+j INTO i, j;
    END LOOP;
    RETURN i;
END;
$$ LANGUAGE plpgsql;

SELECT fib(10);

--

DO $$
BEGIN
    FOR counter IN REVERSE 10..1 BY 2
    LOOP
        RAISE NOTICE 'Counter: %', counter;
    END LOOP;
END $$;
