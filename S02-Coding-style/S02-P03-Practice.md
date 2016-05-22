# S02-P03 Practice

## Assignment

Beautify this query:

```sql
-- Load USD data
insert into bi_data.valid_offers (offer_id, hotel_id, price_usd, original_price, original_currency_code,
      checkin_date, checkout_date, breakfast_included_flag, valid_from_date, valid_to_date)
select 	of.id, of.hotel_id, of.sellings_price as price_usd, of.sellings_price as original_price,
    lc.code AS original_currency_code, of.checkin_date, of.checkout_date, of.breakfast_included_flag,
    of.offer_valid_from, of.offer_valid_to
from  enterprise_data.offer_cleanse_date_fix of, primary_data.lst_currency lc
where of.currency_id=1 and lc.id=1;
```
