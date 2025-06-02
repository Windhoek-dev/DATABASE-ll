CREATE OR REPLACE FUNCTION free_table_after_closing()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.state = 'closed' THEN
        UPDATE tables
        SET state = 'free'
        WHERE table_id = NEW.table_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_free_table
AFTER UPDATE ON commands
FOR EACH ROW
WHEN (OLD.state IS DISTINCT FROM NEW.state)
EXECUTE FUNCTION free_table_after_closing();



CREATE OR REPLACE FUNCTION calculate_invoice_total()
RETURNS TRIGGER AS $$
DECLARE
    total_amount NUMERIC(10,2);
BEGIN
    SELECT SUM(d.price * dc.quantity)
    INTO total_amount
    FROM dishes d
    JOIN dish_com dc ON d.dish_id = dc.dish_id
    WHERE dc.command_id = NEW.command_id;

    NEW.total := COALESCE(total_amount, 0);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_calculate_invoice_total
BEFORE INSERT ON invoices
FOR EACH ROW
EXECUTE FUNCTION calculate_invoice_total();
