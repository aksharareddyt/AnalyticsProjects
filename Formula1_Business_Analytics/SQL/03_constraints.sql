ALTER TABLE races
ADD CONSTRAINT fk_races_circuit
FOREIGN KEY (circuitId)
REFERENCES circuits(circuitId);

ALTER TABLE results
ADD CONSTRAINT fk_results_driver
FOREIGN KEY (driverId)
REFERENCES drivers(driverId);

ALTER TABLE results
ADD CONSTRAINT fk_results_constructor
FOREIGN KEY (constructorId)
REFERENCES constructors(constructorId);

ALTER TABLE results
ADD CONSTRAINT fk_results_status
FOREIGN KEY (statusId)
REFERENCES status(statusId);