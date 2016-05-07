# Beautiful query

Not nice:

```sql
select o.id, date(o.ins_dt), o.c1_selling_price * fx.currency_rate as selling_price_usd, d.code from `order` o join device d on d.id = o.device_id join fx_rate fx on fx.prim_currency_id = o.c1_currency_id and fx.scnd_currency_id=1 /* USD */ and fx.date=date(o.ins_dt) where o.del_flag=0 and order_status_id=1 order by order.id desc limit 100;
```

Nice:

``sql
SELECT /* Select the most recent 100 orders */

  order.id AS order_id,  /* Added alias */
  DATE(order.ins_dt) AS order_insert_date, /* Added alias */
  order.c1_selling_price * fx_rate.currency_rate AS selling_price_usd,
  device.code AS device_code /* Added alias */

FROM hqlive.order

JOIN hqlive.device ON 1=1
  AND device.id = order.device_id

JOIN fx_rate ON 1=1
  AND fx_rate.prim_currency_id = order.c1_currency_id
  AND fx_rate.scnd_currency_id = 1 /* currency_id 1 = USD */
  AND fx_rate.date = DATE(order.ins_dt)

WHERE 1=1
  AND order.del_flag = 0
  AND order_status_id = 1 /* ACTIVE */

ORDER BY
  order.id DESC

LIMIT 100;
;
```
