
-- 유저 테이블
CREATE TABLE `User` (
    `user_id` VARCHAR(100) NOT NULL,
    `no` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL,
    `nickname` VARCHAR(100),
    `password` VARCHAR(100) NOT NULL,
    `birth` VARCHAR(50) NULL,
    `phone_number` VARCHAR(20) NULL,
    `account` VARCHAR(255) NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`user_id`),
    UNIQUE KEY (`no`)
) COMMENT='유저';

-- 유저 권한
CREATE TABLE `user_auth` (
	`auth_no` INT NOT NULL AUTO_INCREMENT,
	`user_id` VARCHAR(100) NOT NULL,
	`AUTH` VARCHAR(100) NOT NULL,
	PRIMARY KEY (`auth_no`),
	FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON UPDATE CASCADE ON DELETE CASCADE
) COMMENT='사용자 권한';



-- 주문내역
CREATE TABLE `goodz`.`order` (
  `purchase_no` INT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(100) NOT NULL,
  `p_no` INT NOT NULL,
  `product_name` VARCHAR(255) NOT NULL,
  `purchase_price` INT NOT NULL,
  `ordered_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`purchase_no`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `userId`
    FOREIGN KEY (`userId`)
    REFERENCES `goodz`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
