CREATE OR REPLACE FUNCTION convert_temp_to (temperature real, to_celsius bool DEFAULT true) RETURNS real AS $$
DECLARE
    result_temp real;
BEGIN 
    IF to_celsius THEN
        result_temp = (5.0/9.0) * (temperature - 32);
    ELSE
        result_temp = (9*temperature + (32*5))/5.0;
    END IF;
    RETURN result_temp;
END
$$ LANGUAGE plpgsql;

SELECT convert_temp_to(26.667, false);

--

CREATE OR REPLACE FUNCTION get_season (month_number int) RETURNS text AS $$
DECLARE
    season text;
BEGIN
    IF month_number BETWEEN 3 AND 5 THEN
    season = 'spring';
    ELSEIF month_number BETWEEN 6 AND 8 THEN
    season = 'summer';
    ELSEIF month_number BETWEEN 9 AND 11 THEN
    season = 'autumn';
    ELSE season = 'winter';
    END IF;
    
    RETURN season;
END
$$ LANGUAGE plpgsql;

SELECT get_season(12);
