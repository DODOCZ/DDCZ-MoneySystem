CREATE TABLE IF NOT EXISTS `vip_players` (
    `citizenid` VARCHAR(50) NOT NULL,
    `vip_level` INT(11) DEFAULT 1,
    `expire_date` BIGINT(20) DEFAULT NULL,
    `permissions` TEXT DEFAULT NULL,
    PRIMARY KEY (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;