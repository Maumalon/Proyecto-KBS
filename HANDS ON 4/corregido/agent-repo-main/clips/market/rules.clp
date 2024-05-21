
;;Define a rule for finding those customers who have not bought nothing at all... so far

(defrule cust-not-buying
     (customer (customer-id ?id) (name ?name))
     (not (order (order-number ?order) (customer-id ?id)))
   =>
   (printout t ?name " no ha comprado... nada!" crlf))

;;Define a rule for finding which products have been bought

(defrule prods-bought
   (order (order-number ?order))
   (line-item (order-number ?order) (part-number ?part))
   (product (part-number ?part) (name ?pn))
   =>
   (printout t ?pn " was bought " crlf))

;;Define a rule for finding which products have been bought AND their quantity

(defrule prods-qty-bgt
   (order (order-number ?order))
   (line-item (order-number ?order) (part-number ?part) (quantity ?q))
   (product (part-number ?part) (name ?p))
   =>
   (printout t ?q " " ?p " was/were bought " crlf))

;;Define a rule for finding customers and their shopping info

(defrule customer-shopping
   (customer (customer-id ?id) (name ?cn))
   (order (order-number ?order) (customer-id ?id))
   (line-item (order-number ?order) (part-number ?part))
   (product (part-number ?part) (name ?pn))
   =>
   (printout t ?cn " bought " ?pn crlf))


;;Define a rule for finding those customers who bought more than 5 products

(defrule cust-5-prods
   (customer (customer-id ?id) (name ?cn))
   (order (order-number ?order) (customer-id ?id))
   (line-item (order-number ?order) (part-number ?part) (quantity ?quantity&:(> ?quantity 5)))
   (product (part-number ?part) (name ?pn))
   =>
   (printout t ?cn " bought more than 5 products (" ?pn ")" crlf))


;; Define a rule for texting custormers who have not bought ...

(defrule text-cust 
   (customer (customer-id ?cid) (name ?name) (phone ?phone))
   (not (order (customer-id ?cid)))
   =>
   (assert (text-customer ?name ?phone "tienes 25% desc prox compra"))
   (printout t ?name " " ?phone " ¡Tienes un 25% de descuento en tu proxima compra!" crlf))


;; Define a rule for calling  custormers who have not bought ...

(defrule call-cust 
   (customer (customer-id ?cid) (name ?name) (phone ?phone))
   (not (order (customer-id ?cid)))
   =>
   (assert (call-customer ?name ?phone "tienes 25% desc prox compra"))
   (printout t ?name " " ?phone " Tienes un 25% de descuento en tu proxima compra" crlf))





