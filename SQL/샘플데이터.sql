-- Active: 1720141839282@@127.0.0.1@3306@goodz


-- 회원 등록
INSERT INTO user (user_id, username, nickname, password, birth, phone_number)
VALUES ('user', '이정용', 'wjddydWkd','$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '000325000325', '01012341234');
-- 권한 추가
INSERT INTO user_auth(user_id, auth) VALUES ('user','ROLE_USER');

-- ⭐ id: user / pw: 123456


