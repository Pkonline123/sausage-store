CREATE INDEX index_product ON product
(
    id
);

CREATE INDEX index_orders ON orders
(
    id
);

CREATE INDEX index_order_roduct ON order_product
(
    order_id,
    product_id
);
