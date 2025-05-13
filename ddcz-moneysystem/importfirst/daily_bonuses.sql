CREATE TABLE IF NOT EXISTS `player_bonuses` (
    `citizenid` VARCHAR(50) NOT NULL,
    `streak` INT(11) NOT NULL DEFAULT 0,
    `last_claimed` BIGINT(20) DEFAULT NULL,
    PRIMARY KEY (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;