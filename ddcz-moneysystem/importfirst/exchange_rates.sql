CREATE TABLE IF NOT EXISTS `exchange_rates` (
    `from_currency` VARCHAR(20) NOT NULL,
    `to_currency` VARCHAR(20) NOT NULL,
    `rate` FLOAT NOT NULL,
    `last_updated` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`from_currency`, `to_currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Výchozí kurzy
INSERT INTO `exchange_rates` (`from_currency`, `to_currency`, `rate`) VALUES
('cash', 'bank', 0.98),
('bank', 'cash', 0.95),
('dirty', 'cash', 0.65)
ON DUPLICATE KEY UPDATE rate = VALUES(rate);