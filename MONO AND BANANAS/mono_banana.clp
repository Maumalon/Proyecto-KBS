(deftemplate estado
   (slot posicion-mono)
   (slot posicion-caja)
   (slot mono-en-caja (default no))
   (slot tiene-banana (default no)))

(defrule inicial
   =>
   (assert (estado (posicion-mono puerta) (posicion-caja esquina) (mono-en-caja no) (tiene-banana no)))
   (printout t "Estado inicial: El mono está en la puerta y la caja en la esquina." crlf))

(defrule subir-a-caja
   (estado (posicion-mono centro) (posicion-caja debajo-de-banana) (mono-en-caja no) (tiene-banana no))
   =>
   (retract (estado (posicion-mono centro) (posicion-caja debajo-de-banana) (mono-en-caja no) (tiene-banana no)))
   (assert (estado (posicion-mono encima-de-caja) (posicion-caja debajo-de-banana) (mono-en-caja si) (tiene-banana no)))
   (printout t "El mono se sube a la caja." crlf))

(defrule mover-mono-al-centro
   (estado (posicion-mono puerta) (posicion-caja ?pos-caja) (mono-en-caja no) (tiene-banana no))
   =>
   (retract (estado (posicion-mono puerta) (posicion-caja ?pos-caja) (mono-en-caja no) (tiene-banana no)))
   (assert (estado (posicion-mono centro) (posicion-caja ?pos-caja) (mono-en-caja no) (tiene-banana no)))
   (printout t "El mono se mueve al centro de la habitación." crlf))

(defrule bajar-de-la-caja
   (estado (posicion-mono encima-de-caja) (posicion-caja debajo-de-banana) (mono-en-caja si) (tiene-banana si))
   =>
   (retract (estado (posicion-mono encima-de-caja) (posicion-caja debajo-de-banana) (mono-en-caja si) (tiene-banana si)))
   (assert (estado (posicion-mono debajo-de-banana) (posicion-caja debajo-de-banana) (mono-en-caja no) (tiene-banana si)))
   (printout t "El mono baja de la caja con la banana." crlf))

(defrule tomar-banana
   (estado (posicion-mono encima-de-caja) (posicion-caja debajo-de-banana) (mono-en-caja si) (tiene-banana no))
   =>
   (retract (estado (posicion-mono encima-de-caja) (posicion-caja debajo-de-banana) (mono-en-caja si) (tiene-banana no)))
   (assert (estado (posicion-mono encima-de-caja) (posicion-caja debajo-de-banana) (mono-en-caja si) (tiene-banana si)))
   (printout t "El mono toma la banana." crlf))

(defrule mover-mono-a-la-caja
   (estado (posicion-mono centro) (posicion-caja esquina) (mono-en-caja no) (tiene-banana no))
   =>
   (retract (estado (posicion-mono centro) (posicion-caja esquina) (mono-en-caja no) (tiene-banana no)))
   (assert (estado (posicion-mono esquina) (posicion-caja esquina) (mono-en-caja no) (tiene-banana no)))
   (printout t "El mono se mueve hacia la caja en la esquina." crlf))

(defrule empujar-caja-debajo-de-banana
   (estado (posicion-mono centro) (posicion-caja centro) (mono-en-caja no) (tiene-banana no))
   =>
   (retract (estado (posicion-mono centro) (posicion-caja centro) (mono-en-caja no) (tiene-banana no)))
   (assert (estado (posicion-mono centro) (posicion-caja debajo-de-banana) (mono-en-caja no) (tiene-banana no)))
   (printout t "El mono empuja la caja debajo de la banana." crlf))

(defrule mover-caja-al-centro
   (estado (posicion-mono esquina) (posicion-caja esquina) (mono-en-caja no) (tiene-banana no))
   =>
   (retract (estado (posicion-mono esquina) (posicion-caja esquina) (mono-en-caja no) (tiene-banana no)))
   (assert (estado (posicion-mono esquina) (posicion-caja centro) (mono-en-caja no) (tiene-banana no)))
   (printout t "El mono mueve la caja al centro de la habitación." crlf))

(defrule mover-mono-al-centro-nuevamente
   (estado (posicion-mono esquina) (posicion-caja centro) (mono-en-caja no) (tiene-banana no))
   =>
   (retract (estado (posicion-mono esquina) (posicion-caja centro) (mono-en-caja no) (tiene-banana no)))
   (assert (estado (posicion-mono centro) (posicion-caja centro) (mono-en-caja no) (tiene-banana no)))
   (printout t "El mono se mueve al centro nuevamente." crlf))

(defrule objetivo-alcanzado
   (estado (posicion-mono debajo-de-banana) (posicion-caja debajo-de-banana) (mono-en-caja no) (tiene-banana si))
   =>
   (printout t "¡El mono ha alcanzado la banana y está en el suelo con ella!" crlf))
