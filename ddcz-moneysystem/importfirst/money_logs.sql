CREATE TABLE IF NOT EXISTS `money_transactions` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `citizenid` VARCHAR(50) NOT NULL,
    `type` ENUM('drop','pickup','transfer','exchange') NOT NULL,
    `amount` INT(11) NOT NULL,
    `details` VARCHAR(255) DEFAULT NULL,
    `timestamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;