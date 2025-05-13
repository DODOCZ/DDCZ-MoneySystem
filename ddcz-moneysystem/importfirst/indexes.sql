ALTER TABLE `player_bonuses` ADD INDEX `last_claimed_idx` (`last_claimed`);
ALTER TABLE `money_transactions` ADD INDEX `type_idx` (`type`);
ALTER TABLE `money_transactions` ADD INDEX `timestamp_idx` (`timestamp`);