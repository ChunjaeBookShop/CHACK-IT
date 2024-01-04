use bookshop;

-- 회원정보 테이블
CREATE TABLE t_shopping_member
(
    `member_id`       varchar(20) PRIMARY KEY comment '회원아이디',
    `member_pw`       varchar(30) NOT NULL comment '비밀번호',
    `member_name`     varchar(50) NOT NULL comment '이름',
    `member_gender`   varchar(10) comment '성별',
    `member_hp1`       varchar(20) comment '휴대폰번호1',
    `member_hp2`       varchar(20) comment '휴대폰번호2',
    `member_hp3`       varchar(20) comment '휴대폰번호3',
    `smssts_yn`       varchar(5) comment '문자수신동의여부',
    `member_email1`    varchar(20) comment '이메일1',
    `member_email2`    varchar(20) comment '이메일2',
    `emailsts_yn`     varchar(5) comment '이메일수신동의여부',
    `zipcode`         varchar(20) comment '우편번호',
    `road_address`    varchar(50) comment '도로명',
    `jibun_address`   varchar(50) comment '지번',
    `namuji_address`  varchar(50) comment '나머지주소',
    `member_birth_y`    varchar(20) comment '생년월일',
    `member_birth_m`    varchar(20) comment '생년월일',
    `member_birth_d`    varchar(20) comment '생년월일',
    `member_birth_gn` varchar(20) comment '양력음력',
    `join_date`       date       DEFAULT current_date comment '가입일',
    `del_yn`          varchar(5) default 'n' comment '탈퇴여부'
);
-- 주문 테이블
CREATE TABLE t_shopping_order
(
    order_seq_num      bigint PRIMARY KEY comment '주문상품일련번호',
    order_id           bigint comment '주문번호',
    member_id          varchar(20) comment '주문자아이디', -- FK
    goods_id           bigint comment '상품번호',        -- FK
    orderer_name       varchar(50) comment '주문자이름',
    goods_title        varchar(100) comment '상품이름',
    order_goods_qty    smallint comment '주문수량',
    goods_sales_price  int comment '상품판매가격',
    goods_file_name    varchar(60) comment '상품이미지파일이름',
    receiver_name      varchar(50) comment '수령자이름',
    receiver_hp1        varchar(20) comment '수령자 휴대폰번호1',
	receiver_hp2 varchar(20) comment '수령자 휴대폰번호2',
    receiver_hp3 varchar(20) comment '수령자 휴대폰번호3',
-- 컬럼 삭제 	"receiver_tel1" varchar(20) comment '수령자 유선 전화번호1',
-- 컬럼 삭제	"receiver_tel2" varchar(20) comment '수령자 유선 전화번호2',
-- 컬럼 삭제	"receiver_tel3" varchar(20) comment '수령자 유선 전화번호3',
    delivery_address   varchar(100) comment '배송주소',
    delivery_method    varchar(40) comment '배송방법',
    delivery_message   varchar(300) comment '부재시 전달 메시지',
    gift_wrapping      varchar(20) comment '상품 포장여부',
    pay_method         varchar(200) comment '결제방법',
    card_com_name      varchar(50) comment '결제카드회사이름',
    card_pay_month     varchar(20) comment '할부개월수',
    pay_orderer_hp_num varchar(20) comment '휴대폰 결재번호',
    delivery_state     varchar(20) default 'delivery_prepared' comment '상품배송상태',
    pay_order_time     datetime    default current_time comment '결제시간',
    orderer_hp         varchar(20) comment '주문자 휴대폰번호'
);
-- 상품정보 테이블
CREATE TABLE t_shopping_goods
(
    goods_id                bigint AUTO_INCREMENT PRIMARY KEY comment '상품번호',
    goods_title             varchar(100)  NOT NULL comment '상품제목',
    goods_writer            varchar(50)   NOT NULL comment '저자이름',
    goods_publisher         varchar(50)   NOT NULL comment '출판사이름',
    goods_price             int           NOT NULL comment '상품정가',
    goods_sales_price       int           NOT NULL comment '상품판매가',
    goods_published_date    date          NOT NULL comment '상품출판일',
    goods_total_page        int           NOT NULL comment '상품총페이지수',
    goods_isbn              varchar(50)   NOT NULL comment 'isbn번호',
    goods_delivery_price    int           NOT NULL comment '배송비',
    goods_delivery_date     date          NOT NULL comment '상품배송일',
    goods_file_name         varchar(50) comment '이미지파일명',
    goods_status            varchar(50)   NOT NULL comment '상품분류',
    goods_intro             varchar(2000) NOT NULL comment '상품소개',
    goods_writer_intro      varchar(2000) comment '저자소개',
    goods_publisher_comment varchar(2000) comment '출판사평',
    goods_recommendation    varchar(2000) comment '상품추천사',
    goods_contents_order    longtext comment '목차',
    goods_entered_date      date          NOT NULL DEFAULT current_date comment '상품입고일'
);
-- 상품 이미지 정보 테이블
CREATE TABLE t_goods_detail_image
(
    image_id      bigint PRIMARY KEY comment '이미지번호',
    goods_id      bigint      NOT NULL comment '상품번호',
    file_name     varchar(50) NOT NULL comment '이미지파일명',
    reg_id        varchar(20) NOT NULL comment '등록자아이디',
    file_type     varchar(40) NOT NULL comment '이미지파일종류',
    goods_credate date DEFAULT current_date comment '등록일'
);
-- 장바구니 테이블
CREATE TABLE t_shopping_cart
(
    cart_id        int         NOT NULL AUTO_INCREMENT PRIMARY KEY comment '장바구니번호',
    member_id      varchar(20) NOT NULL comment '회원아이디',
    goods_id       bigint      NOT NULL comment '상품번호',
    cart_goods_qty smallint    NOT NULL comment '상품개수',
    credate        date DEFAULT current_date comment '등록일'
);
-- 게시판 테이블
CREATE TABLE board
(
    brd_id     bigint AUTO_INCREMENT PRIMARY KEY comment '게시물 번호',
    goods_id   bigint comment '상품번호',
    member_id  varchar(20)   NOT NULL comment '회원 아이디',
    title      varchar(100)  NOT NULL comment '제목',
    content    varchar(3000) NOT NULL comment '내용',
    reg_date   date          NOT NULL DEFAULT current_date comment '작성일',
    cate       tinyint       NOT NULL comment '게시판 종류',
    view_cnt   int           NOT NULL DEFAULT 0 comment '조회수',
    com_status varchar(10)            DEFAULT 'n' comment '답변상태'
);
-- 게시판 종류 테이블
CREATE TABLE `categories`
(
    cate_no   int AUTO_INCREMENT PRIMARY KEY comment '게시판 번호',
    cate      tinyint NOT NULL UNIQUE KEY comment '게시판 종류',
    cate_name varchar(20) DEFAULT NULL comment '게시판 이름'
);
-- 게시판 댓글 테이블
CREATE TABLE `board_comment`
(
    `com_id`      bigint AUTO_INCREMENT PRIMARY KEY comment '댓글 번호',
    `brd_id`      bigint       NOT NULL comment '게시물 번호',
    `com_content` varchar(100) NOT NULL comment '댓글 내용',
    `member_id`   varchar(20)  NOT NULL comment '회원 아이디',
    `reg_date`    date         NOT NULL DEFAULT current_date comment '작성일',
    `mod_date`    date                  DEFAULT NULL comment '수정일'
);
-- 멤버 권한 테이블
CREATE TABLE member_auth
(
    member_id varchar(20) comment '회원 아이디',
    auth      varchar(20) not null comment '권한명'
);

-- 더미데이터

-- t_shopping_member
insert into t_shopping_member(member_id, member_pw, member_name, member_gender, member_hp1, member_hp2, member_hp3, smssts_yn, member_email1, member_email2, emailsts_yn, zipcode, road_address, jibun_address, namuji_address, member_birth_y, member_birth_m, member_birth_d, member_birth_gn) values
    ('lee', '1212', '이병승', '101', '010','2222','3333','Y','lee','test.com','Y','13547','경기 성남시 분당구 고기로 25(동원동)','경기 성남시 분당구 동원동 79-1','럭키빌딩 101호','2000','5','10','2');
insert into t_shopping_member(member_id, member_pw, member_name, member_gender, member_hp1, member_hp2 ,member_hp3, smssts_yn, member_email1 ,member_email2, emailsts_yn, zipcode, road_address, jibun_address, namuji_address, member_birth_y, member_birth_m, member_birth_d, member_birth_gn) values
    ('admin', '1212', '어드민', '101', '010','1111','2222','Y','admin','test.com','Y','06253','서울 강남구 강남대로 298(역삼동)','서울 강남구 역삼동 838','럭키빌딩 101호','2000','5','10','2');


-- 상품 정보
INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (334, '포토샵 무작정 따라하기', '민지영, 문수민, 이상호, 앤미디어', '길벗', 34000, 30000, '2018-10-02', 1111, '12122222', 2000,
        '2018-10-17', '포토샵 무작정 따라하기_메인.jpg', 'bestseller',
        '구글코리아에서 소프트웨어 엔지니어로 재직 중이다. 더 좋은 소프트웨어 엔지니어가 되기를 갈망하지만 일과 삶의 균형이 더 중요하다. 겨울에는 주로 스키를 즐긴다.',
        '구글코리아에서 소프트웨어 엔지니어로 재직 중이다. 더 좋은 소프트웨어 엔지니어가 되기를 갈망하지만 일과 삶의 균형이 더 중요하다. 겨울에는 주로 스키를 즐긴다.',
        '구글코리아에서 소프트웨어 엔지니어로 재직 중이다. 더 좋은 소프트웨어 엔지니어가 되기를 갈망하지만 일과 삶의 균형이 더 중요하다. 겨울에는 주로 스키를 즐긴다.',
        '구글코리아에서 소프트웨어 엔지니어로 재직 중이다. 더 좋은 소프트웨어 엔지니어가 되기를 갈망하지만 일과 삶의 균형이 더 중요하다. 겨울에는 주로 스키를 즐긴다.', NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(299, 334, '포토샵 무작정 따라하기_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(300, 334, '포토샵 무작정 따라하기_상세1.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (335, '무작정 따라하기 차트분석', '윤재수', '미래 출판사', 1212, 30000, '2018-10-02', 12, '1212', 2000, '2018-10-24',
        '차트분석 무작정 따라하기_메인.jpg', 'bestseller', '1212', '1212', '1212', '1212', NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(301, 335, '차트분석 무작정 따라하기_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(302, 335, '차트분석 무작정 따라하기_상세1.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (336, '짠테크 가계부', '짠돌이 카페', '길벗', 30000, 30000, '2018-10-02', 1212, '1212', 1212, '2018-10-18', '짠테그 가계부_메인.jpg',
        'bestseller', '1212', '1212', '121', '1212', NULL);
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(303, 336, '짠테그 가계부_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(304, 336, '짠테그 가계부_상세1.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (337, '케라스로 배우는 딥러닝', '프랑소와 숄레', '국민출판사', 30000, 30000, '2018-10-02', 1212, '1212', 1212, '2018-10-19',
        '케라시_메인.jpg', 'bestseller', '1212', '1221', '1212', '1212', NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(305, 337, '케라시_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(306, 337, '케라시_상세1.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (338, '컴퓨터 활용능력 2급 실기', '이병승', '길벗', 25000, 25000, '2018-08-08', 1212, '1212', 1212, '2018-10-26',
        '컴퓨터 활용능력 2급 실기_메인.jpg', 'bestseller', '1212', '1212', '1212', '1212', NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(307, 338, '컴퓨터 활용능력 2급 실기_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(308, 338, '컴퓨터 활용능력 2급 실기_상세1.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (339, '시나공 워드 프로세서 실기', '길벗 알엔디', '국민 출판사', 25000, 25000, '2018-10-29', 1212, '1212', 1212, '2018-10-25',
        '시나공 워드프로세서 실기_메인.jpg', 'bestseller', '1212', '1212', '1212', '121', NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(309, 339, '시나공 워드프로세서 실기_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(310, 339, '시나공 워드프로세서 실기_상세1.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (340, '직장인을 위한 엑셀 실무', '홍길동', '서울출판사', 25000, 25000, '2018-10-17', 1212, '1212', 1212, '2018-10-25',
        '엑셀실무_메인.pg.jpg', 'bestseller', '1212', '1212', '1212', '1212', NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(311, 340, '엑셀실무_메인.pg.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(312, 340, '엑셀실무_상세1.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (341, '자바스크립트 배우기', '2222', '서울 출판사', 25000, 25000, '2018-10-18', 2222, '2222', 2222, '2018-10-18',
        '헬로자바스크립트_메인.jpg', 'bestseller', '5656', '56566', '5656', '5656', NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(313, 341, '헬로자바스크립트_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(314, 341, '모두의 파이선상세이미지1.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (342, '부동산 상식 사전', '백영록', '길벗', 20000, 20000, '2018-10-04', 555, '555', 555, '2018-10-11', '부동상 상식사전_메인.jpg',
        'bestseller', '555', '555', '555', '555', NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(315, 342, '부동상 상식사전_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(316, 342, '부동상 상식사전_상세1.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (343, '기적의 계산법', '이순신', '국민 출판사', 30000, 30000, '2018-10-04', 990, '777', 2000, '2018-11-22', '기적적 계산법_메인.jpg',
        'steadyseller', '777', '7777', '777', '777', NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(317, 343, '기적적 계산법_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(337, 343, '기적적 계산법_상세1.jpg', 'admin', 'uploadFile');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(338, 343, 'good1_detail_image2.jpg', 'admin', 'uploadFile');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(339, 343, 'good1_detail_image3.jpg', 'admin', 'uploadFile');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (344, '초보자를 위한 자바 프로그래밍', '이병승', '인포북', 30000, 27000, '2018-10-02', 996, '2323454566778', 2000, '2018-10-18',
        'image1.jpg', 'newbook', '7777', '77777', '7777', '7777', NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(319, 344, 'image1.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(320, 344, 'react_detail1.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (345, '리액트를 다루는 기술', '이순신', '민국 출판사', 30000, 30000, '2018-10-12', 888, '8888', 888, '2018-10-18',
        'main_react.jpg', 'newbook', '88', '888888', '888', '888', NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(321, 345, 'main_react.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(322, 345, 'detail3.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (346, '여행 일본어', '이길동', '국민 출판사', 30000, 30000, '2018-10-23', 8989, '8989', 8989, '2018-10-18', '여행 일본어_메인.jpg',
        'on_sale', '8989', '8989', '8989', '8989', NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(323, 346, '여행 일본어_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(324, 346, '여행 일본어_상세.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (347, '가장 빨리 만나는 자바9', '카이 호스트만', '길벗', 30000, 32400, '2018-10-17', 1111, '1212121', 2000, '2018-10-22',
        '가장 빨리 만나는 자바_메인.jpg', 'steadyseller', '첫 번째 단계는 프로그래밍 기초 과정이다.
: 객체 지향 프로그래밍을 잘하기 위해서는 우선 기존 프로그래밍 언어의 발전과 프로그래밍의 특징을 잘 알아야 한다. 그리고 자바 또한 기존 언어에서 사용하는 개념이나 기능을 그대로 사용하기 때문에 가장 먼저 프로그래밍의 기본적인 특징이나 기능을 학습할 필요가 있다.',
        NULL, '첫 번째 단계는 프로그래밍 기초 과정이다.
: 객체 지향 프로그래밍을 잘하기 위해서는 우선 기존 프로그래밍 언어의 발전과 프로그래밍의 특징을 잘 알아야 한다. 그리고 자바 또한 기존 언어에서 사용하는 개념이나 기능을 그대로 사용하기 때문에 가장 먼저 프로그래밍의 기본적인 특징이나 기능을 학습할 필요가 있다.', '첫 번째 단계는 프로그래밍 기초 과정이다.
: 객체 지향 프로그래밍을 잘하기 위해서는 우선 기존 프로그래밍 언어의 발전과 프로그래밍의 특징을 잘 알아야 한다. 그리고 자바 또한 기존 언어에서 사용하는 개념이나 기능을 그대로 사용하기 때문에 가장 먼저 프로그래밍의 기본적인 특징이나 기능을 학습할 필요가 있다.',
        NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(325, 347, '가장 빨리 만나는 자바_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(326, 347, '가장 빨리 만나는 자바_상세1.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (348, '자바 EE 디자인 패턴', '무라트예네르, 알렉스 시돔', '길벗', 34000, 30000, '2018-10-18', 1212, '12122222', 2000, '2018-10-24',
        'Java EE 디자이 패턴_메인.jpg', 'on_sale', '첫 번째 단계는 프로그래밍 기초 과정이다.
: 객체 지향 프로그래밍을 잘하기 위해서는 우선 기존 프로그래밍 언어의 발전과 프로그래밍의 특징을 잘 알아야 한다. 그리고 자바 또한 기존 언어에서 사용하는 개념이나 기능을 그대로 사용하기 때문에 가장 먼저 프로그래밍의 기본적인 특징이나 기능을 학습할 필요가 있다.', '첫 번째 단계는 프로그래밍 기초 과정이다.
: 객체 지향 프로그래밍을 잘하기 위해서는 우선 기존 프로그래밍 언어의 발전과 프로그래밍의 특징을 잘 알아야 한다. 그리고 자바 또한 기존 언어에서 사용하는 개념이나 기능을 그대로 사용하기 때문에 가장 먼저 프로그래밍의 기본적인 특징이나 기능을 학습할 필요가 있다.', '첫 번째 단계는 프로그래밍 기초 과정이다.
: 객체 지향 프로그래밍을 잘하기 위해서는 우선 기존 프로그래밍 언어의 발전과 프로그래밍의 특징을 잘 알아야 한다. 그리고 자바 또한 기존 언어에서 사용하는 개념이나 기능을 그대로 사용하기 때문에 가장 먼저 프로그래밍의 기본적인 특징이나 기능을 학습할 필요가 있다.', '첫 번째 단계는 프로그래밍 기초 과정이다.
: 객체 지향 프로그래밍을 잘하기 위해서는 우선 기존 프로그래밍 언어의 발전과 프로그래밍의 특징을 잘 알아야 한다. 그리고 자바 또한 기존 언어에서 사용하는 개념이나 기능을 그대로 사용하기 때문에 가장 먼저 프로그래밍의 기본적인 특징이나 기능을 학습할 필요가 있다.',
        NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(328, 348, 'Java EE 디자이 패턴_상세1.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (349, '자바로 배우는 리팩토링', '유키히로시', '길벗', 34000, 30000, '2018-10-02', 1111, '12122222', 2000, '2018-10-25',
        '자바 리팩토링_메인.jpg', 'on_sale',
        '저자가 오랜 기간 실무에서 습득한 이론 및 평소에 관심이 있던 분야와 학원 강의 중 입문자들이 첫 프로그래밍을 배웠을 때의 낮선 부분과 수업을 진행하면서 어려웠던 여러 가지의 시행착오를 바탕으로 자바를 처음 배우는 입문자가 쉽게 자신의 아이디어를 발휘하여 개발할 수 있게 구성하여 집필했다.',
        '저자가 오랜 기간 실무에서 습득한 이론 및 평소에 관심이 있던 분야와 학원 강의 중 입문자들이 첫 프로그래밍을 배웠을 때의 낮선 부분과 수업을 진행하면서 어려웠던 여러 가지의 시행착오를 바탕으로 자바를 처음 배우는 입문자가 쉽게 자신의 아이디어를 발휘하여 개발할 수 있게 구성하여 집필했다.',
        '저자가 오랜 기간 실무에서 습득한 이론 및 평소에 관심이 있던 분야와 학원 강의 중 입문자들이 첫 프로그래밍을 배웠을 때의 낮선 부분과 수업을 진행하면서 어려웠던 여러 가지의 시행착오를 바탕으로 자바를 처음 배우는 입문자가 쉽게 자신의 아이디어를 발휘하여 개발할 수 있게 구성하여 집필했다.',
        '저자가 오랜 기간 실무에서 습득한 이론 및 평소에 관심이 있던 분야와 학원 강의 중 입문자들이 첫 프로그래밍을 배웠을 때의 낮선 부분과 수업을 진행하면서 어려웠던 여러 가지의 시행착오를 바탕으로 자바를 처음 배우는 입문자가 쉽게 자신의 아이디어를 발휘하여 개발할 수 있게 구성하여 집필했다.',
        NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(330, 349, '자바 리팩토링_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(331, 349, '자바 리팩토링_상세1.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (350, '유지 보수가 가능한 코딩의 기술-자바편', '주스트 뷔서', '한국 출판사', 35000, 32000, '2018-10-20', 1000, '2323222323', 2000,
        '2018-10-22', '유지보수자바_메인.jpg', 'steadyseller',
        '이 책을 읽고 나면 프로그래머는 새로운 객체를 찾아서 만들게 될 것이고, 그것을 프로그래밍화 하는 것이 진정한 객체 지향 프로그래밍이라는 사실을 깨닫게 될 것이다.', '저자가 오랜 기간 실무에서 습득한 이론 및 평소에 관심이 있던 분야와 학원 강의 중 입문자들이 첫 프로그래밍을 배웠을 때의 낮선 부분과 수업을 진행하면서 어려웠던 여러 가지의 시행착오를 바탕으로 자바를 처음 배우는 입문자가 쉽게 자신의 아이디어를 발휘하여 개발할 수 있게 구성하여 집필했다.

- 전자공학과 졸업
- 벤처 기업에서 다양한 소프트웨어 개발 참여
- 대기업의 시스템 통합 작업에 관련된 소프트웨어 개발 참여
- IT프로그래밍 학원에서 강의', '이 책을 읽고 나면 프로그래머는 새로운 객체를 찾아서 만들게 될 것이고, 그것을 프로그래밍화 하는 것이 진정한 객체 지향 프로그래밍이라는 사실을 깨닫게 될 것이다.',
        '이 책을 읽고 나면 프로그래머는 새로운 객체를 찾아서 만들게 될 것이고, 그것을 프로그래밍화 하는 것이 진정한 객체 지향 프로그래밍이라는 사실을 깨닫게 될 것이다.', NULL);

INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(334, 350, '유지보수자바_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
(image_id, goods_id, file_name, reg_id, file_type)
VALUES(341, 350, '유지보수자바_상세1.jpg', 'admin', 'uploadFile');


INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (354, '모두의 딥러닝', '이병승', '인포북', 27000, 21600, '2018-10-02', 996, '2323454566778', 2000, '2018-10-18',
        '모두의 딥러닝_메인.jpg', 'newbook', '7777', '77777', '7777', '7777', NULL);

INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (342, 354, '모두의 딥러닝_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (343, 354, '모두의 딥러닝_상세.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (356, '마인크래프트 무작정 따라하기', '신윤철,이상민', '길벗', 14000, 12000, '2018-10-02', 245, '12122222', 2000, '2018-10-10',
        '마인_메인.jpg', 'bestseller', '마인크래프트를 이용해 코딩을 배울 수 있다는 이야기를 들어 본 적 있나요?
마이크로소프트(Microsoft)에서 만든 블록형 코딩 도구인 메이크코드(MakeCode)를 마인크래프트와 연결해 보세요. 메이크코드에서 만든 코드를 마인크래프트 월드에 적용할 수 있습니다. 또한, 장애물 파괴나 벽돌 쌓기 등 건축물을 지을 때 피할 수 없었던 반복 작업도, 메이크코드의 명령 블록을 이용하면 한번에 뚝딱 자동화할 수 있습니다.
《마인크래프트 게임 제작 무작정 따라하기》는 아이들이 좋아하는 마인크래프트를 활용해 코딩을 쉽고 재미있게 익힐 수 있게 차근차근 도와주는 책입니다. 미래의 게임 프로그래머 또는 공학도를 꿈꾸는 아이라면 《마인크래프트 게임 제작 무작정 따라하기》와 함께 컴퓨팅 사고력, 창의성, 도전 정신을 키워 보세요!', '마인크래프트를 이용해 코딩을 배울 수 있다는 이야기를 들어 본 적 있나요?
마이크로소프트(Microsoft)에서 만든 블록형 코딩 도구인 메이크코드(MakeCode)를 마인크래프트와 연결해 보세요. 메이크코드에서 만든 코드를 마인크래프트 월드에 적용할 수 있습니다. 또한, 장애물 파괴나 벽돌 쌓기 등 건축물을 지을 때 피할 수 없었던 반복 작업도, 메이크코드의 명령 블록을 이용하면 한번에 뚝딱 자동화할 수 있습니다.
《마인크래프트 게임 제작 무작정 따라하기》는 아이들이 좋아하는 마인크래프트를 활용해 코딩을 쉽고 재미있게 익힐 수 있게 차근차근 도와주는 책입니다. 미래의 게임 프로그래머 또는 공학도를 꿈꾸는 아이라면 《마인크래프트 게임 제작 무작정 따라하기》와 함께 컴퓨팅 사고력, 창의성, 도전 정신을 키워 보세요!', '마인크래프트를 이용해 코딩을 배울 수 있다는 이야기를 들어 본 적 있나요?
마이크로소프트(Microsoft)에서 만든 블록형 코딩 도구인 메이크코드(MakeCode)를 마인크래프트와 연결해 보세요. 메이크코드에서 만든 코드를 마인크래프트 월드에 적용할 수 있습니다. 또한, 장애물 파괴나 벽돌 쌓기 등 건축물을 지을 때 피할 수 없었던 반복 작업도, 메이크코드의 명령 블록을 이용하면 한번에 뚝딱 자동화할 수 있습니다.
《마인크래프트 게임 제작 무작정 따라하기》는 아이들이 좋아하는 마인크래프트를 활용해 코딩을 쉽고 재미있게 익힐 수 있게 차근차근 도와주는 책입니다. 미래의 게임 프로그래머 또는 공학도를 꿈꾸는 아이라면 《마인크래프트 게임 제작 무작정 따라하기》와 함께 컴퓨팅 사고력, 창의성, 도전 정신을 키워 보세요!', '마인크래프트를 이용해 코딩을 배울 수 있다는 이야기를 들어 본 적 있나요?
마이크로소프트(Microsoft)에서 만든 블록형 코딩 도구인 메이크코드(MakeCode)를 마인크래프트와 연결해 보세요. 메이크코드에서 만든 코드를 마인크래프트 월드에 적용할 수 있습니다. 또한, 장애물 파괴나 벽돌 쌓기 등 건축물을 지을 때 피할 수 없었던 반복 작업도, 메이크코드의 명령 블록을 이용하면 한번에 뚝딱 자동화할 수 있습니다.
《마인크래프트 게임 제작 무작정 따라하기》는 아이들이 좋아하는 마인크래프트를 활용해 코딩을 쉽고 재미있게 익힐 수 있게 차근차근 도와주는 책입니다. 미래의 게임 프로그래머 또는 공학도를 꿈꾸는 아이라면 《마인크래프트 게임 제작 무작정 따라하기》와 함께 컴퓨팅 사고력, 창의성, 도전 정신을 키워 보세요!',
        NULL);

INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (345, 356, '마인_메인.jpg', 'admin', 'main_image');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (394, '무작정 따라가기 홍콩 마카오', '김수정, 김승남', '인포북스', 30000, 27000, '2015-10-16', 1000, '121212', 2000, '2018-10-18',
        '무작정 따라가기 홍콩 마카오.jpg', 'bestseller', '이 책을 읽고 나면 프로그래머는 새로운 객체를 찾아서 만들게 될 것이고, 그것을 프로그래밍화 하는 것이 진정한 객체 지향 프로그래밍이라는 사실을 깨닫게 될 것이다.

객체 지향 프로그래밍이란 사람을 ‘주체(subject)’라 하고, 주체가 바라본 대상(사람, 사물, 객체)을 ‘객체(object)’라고 한다. 사람이 일상적으로 보고, 느끼고, 생각하는 관점에서 프로그래밍을 하는 방식이다.

자바를 처음 접하는 사람은 다소 생소한 개념이 나오지만 반복해서 학습을 하다 보면 어느새 프로그래밍에 입문할 수 있다는 사실을 깨닫게 될 것이다. 각 장의 끝에는 연습문제를 두어 독학하기에 적합하다. 또한 저자의 카페(http://cafe.naver.com/standardjava)에서는 이 책의 내용이 담긴 동영상 강좌를 무료로 제공한다.', '저자가 오랜 기간 실무에서 습득한 이론 및 평소에 관심이 있던 분야와 학원 강의 중 입문자들이 첫 프로그래밍을 배웠을 때의 낮선 부분과 수업을 진행하면서 어려웠던 여러 가지의 시행착오를 바탕으로 자바를 처음 배우는 입문자가 쉽게 자신의 아이디어를 발휘하여 개발할 수 있게 구성하여 집필했다.

- 전자공학과 졸업
- 벤처 기업에서 다양한 소프트웨어 개발 참여
- 대기업의 시스템 통합 작업에 관련된 소프트웨어 개발 참여
- IT프로그래밍 학원에서 강의

※저자카페 : http://cafe.naver.com/standardjava', '이 책의 삼 단계 학습 방법

첫 번째 단계는 프로그래밍 기초 과정이다.
: 객체 지향 프로그래밍을 잘하기 위해서는 우선 기존 프로그래밍 언어의 발전과 프로그래밍의 특징을 잘 알아야 한다. 그리고 자바 또한 기존 언어에서 사용하는 개념이나 기능을 그대로 사용하기 때문에 가장 먼저 프로그래밍의 기본적인 특징이나 기능을 학습할 필요가 있다.

두 번째 단계는 자바의 객체 지향 개념에 대해 배운다.
: C언어는 컴퓨터의 수행 과정을 흉내 낸 절차적 언어이다. 이러한 절차적 언어를 하는데 있어 여러 가지 단점들이 나타났다. 대표적으로는 소스 코드의 재사용이다. 지금의 응용 프로그램은 초기에 비해 규모도 커지고 개발 기간도 많이 소모된다. 자바는 기존 기능의 재사용성, 설계의 용이성, 관리의 편리성 등의 이유로 많이 찾고 있다. 이 단계의 핵심은 재사용성 및 프로그래밍 설계와 관련된 객체 지향 개념에 대해 학습한다.

세 번째 단계는 API의 기능을 각 장별로 학습한다.
: 자바는 약 20년이 넘었기 때문에 이전에 자바로 프로그래밍을 하면서 다른 프로그램에서 많이 사용하는 기능을 미리 자바에서 클래스로 만들어서 제공한다. 이를 API(Application Program Interface)라고 하며, 이 단계의 과정은 사실 다른 언어에서도 지원한다. 그러나 자바는 앞에서 말한 바와 같이 객체 지향 언어이므로 이 모든 API 기능이 객체 지향 개념을 적용하여 제공되고 있다. 따라서 자바의 API를 잘 사용하려면 앞의 객체 지향 개념을 잘 숙지해야 한다.', '이 책의 삼 단계 학습 방법

첫 번째 단계는 프로그래밍 기초 과정이다.
: 객체 지향 프로그래밍을 잘하기 위해서는 우선 기존 프로그래밍 언어의 발전과 프로그래밍의 특징을 잘 알아야 한다. 그리고 자바 또한 기존 언어에서 사용하는 개념이나 기능을 그대로 사용하기 때문에 가장 먼저 프로그래밍의 기본적인 특징이나 기능을 학습할 필요가 있다.

두 번째 단계는 자바의 객체 지향 개념에 대해 배운다.
: C언어는 컴퓨터의 수행 과정을 흉내 낸 절차적 언어이다. 이러한 절차적 언어를 하는데 있어 여러 가지 단점들이 나타났다. 대표적으로는 소스 코드의 재사용이다. 지금의 응용 프로그램은 초기에 비해 규모도 커지고 개발 기간도 많이 소모된다. 자바는 기존 기능의 재사용성, 설계의 용이성, 관리의 편리성 등의 이유로 많이 찾고 있다. 이 단계의 핵심은 재사용성 및 프로그래밍 설계와 관련된 객체 지향 개념에 대해 학습한다.

세 번째 단계는 API의 기능을 각 장별로 학습한다.
: 자바는 약 20년이 넘었기 때문에 이전에 자바로 프로그래밍을 하면서 다른 프로그램에서 많이 사용하는 기능을 미리 자바에서 클래스로 만들어서 제공한다. 이를 API(Application Program Interface)라고 하며, 이 단계의 과정은 사실 다른 언어에서도 지원한다. 그러나 자바는 앞에서 말한 바와 같이 객체 지향 언어이므로 이 모든 API 기능이 객체 지향 개념을 적용하여 제공되고 있다. 따라서 자바의 API를 잘 사용하려면 앞의 객체 지향 개념을 잘 숙지해야 한다.',
        NULL);

INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (346, 394, '무작정 따라가기 홍콩 마카오.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (347, 394, '무작정 따라가기 홍콩 마카오_상세.jpg', 'admin', 'detail_image1');
INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (348, 394, 'detail2.jpg', 'admin', 'detail_image2');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (395, '모두의 파이썬', '이승찬', '길벗', 12000, 10800, '2016-05-09', 200, '9791186978894', 2000, '2018-10-18', 'image2.jpg',
        'bestseller', '프로그래밍을 한 번도 해본 적이 없어도 괜찮다. 파이썬이 무엇인지 몰라도 상관 없다. 《모두의 파이썬》은 어려운 개념과 복잡한 이론 설명은 최대한 줄이고, 초보자가 프로그래밍을 쉽게 배울 수 있도록 짧고 간단한 예제로 내용을 구성했다. 처음부터 모든 것을 다 이해하지 못해도 괜찮다. 프로그램을 따라서 입력하고, 실행 결과를 확인하며, 책에서 알려주는 대로 에러를 수정해 보자. 어느새 파이썬 프로그램으로 멋진 그림을 그리고, 계산을 하고, 간단한 게임을 만들고, 수학 문제를 푸는 자신을 발견하게 될 것이다. 《모두의 파이썬》으로 남녀노소 누구나 즐겁게 프로그래밍을 시작해 보자!

누구나 20일이면 파이썬 프로그램을 만들 수 있다!

1~13일: 파이썬 언어 기초 배우기

초보자도 배우기 쉬운 언어인 파이썬의 기초 문법을 예제로 배운다. 입력 → 결과 확인 → 에러 해결 → 해설 → 응용, ‘5단계 트레이닝’으로 짧은 프로그램을 직접 입력하고 고쳐 보면서 자연스럽게 프로그램을 작성하는 방법을 익힌다.

14~18일: 간단한 게임 만들기

앞에서 학습한 파이썬 기능을 이용하여 5가지 게임 프로젝트를 실습한다. 계산 맞히기 게임, 타자 게임, 거북이 대포 게임, 터틀런 1, 2를 만들고 실제로 게임을 플레이해 본다.

19~20일: 파이썬으로 수학 문제 풀어 보기

중학교 수준의 간단한 수학 문제를 파이썬 프로그램으로 만들어서 풀어 본다. 수학과 프로그래밍의 연관 관계를 배울 수 있으며 파이썬이 어떻게 활용되는지 알 수 있다.

 만든 이 코멘트',
        '서울대학교에서 컴퓨터공학을 전공하고 게임 개발자로 일하며 메이플스토리 등의 히트 게임을 만들었습니다. 15년간 일한 게임 업계를 떠나 University of Washington에서 경영학 석사 학위를 받았습니다. 현재 로봇 개발/생산 업체 메타로보틱스에서 최신 소프트웨어 기술을 농업 현장에 적용하기 위해 노력하고 있습니다.', '프로그래밍을 한 번도 해본 적이 없어도 괜찮다. 파이썬이 무엇인지 몰라도 상관 없다. 《모두의 파이썬》은 어려운 개념과 복잡한 이론 설명은 최대한 줄이고, 초보자가 프로그래밍을 쉽게 배울 수 있도록 짧고 간단한 예제로 내용을 구성했다. 처음부터 모든 것을 다 이해하지 못해도 괜찮다. 프로그램을 따라서 입력하고, 실행 결과를 확인하며, 책에서 알려주는 대로 에러를 수정해 보자. 어느새 파이썬 프로그램으로 멋진 그림을 그리고, 계산을 하고, 간단한 게임을 만들고, 수학 문제를 푸는 자신을 발견하게 될 것이다. 《모두의 파이썬》으로 남녀노소 누구나 즐겁게 프로그래밍을 시작해 보자!

누구나 20일이면 파이썬 프로그램을 만들 수 있다!

1~13일: 파이썬 언어 기초 배우기

초보자도 배우기 쉬운 언어인 파이썬의 기초 문법을 예제로 배운다. 입력 → 결과 확인 → 에러 해결 → 해설 → 응용, ‘5단계 트레이닝’으로 짧은 프로그램을 직접 입력하고 고쳐 보면서 자연스럽게 프로그램을 작성하는 방법을 익힌다.

14~18일: 간단한 게임 만들기

앞에서 학습한 파이썬 기능을 이용하여 5가지 게임 프로젝트를 실습한다. 계산 맞히기 게임, 타자 게임, 거북이 대포 게임, 터틀런 1, 2를 만들고 실제로 게임을 플레이해 본다.

19~20일: 파이썬으로 수학 문제 풀어 보기

중학교 수준의 간단한 수학 문제를 파이썬 프로그램으로 만들어서 풀어 본다. 수학과 프로그래밍의 연관 관계를 배울 수 있으며 파이썬이 어떻게 활용되는지 알 수 있다.

 만든 이 코멘트', '프로그래밍을 한 번도 해본 적이 없어도 괜찮다. 파이썬이 무엇인지 몰라도 상관 없다. 《모두의 파이썬》은 어려운 개념과 복잡한 이론 설명은 최대한 줄이고, 초보자가 프로그래밍을 쉽게 배울 수 있도록 짧고 간단한 예제로 내용을 구성했다. 처음부터 모든 것을 다 이해하지 못해도 괜찮다. 프로그램을 따라서 입력하고, 실행 결과를 확인하며, 책에서 알려주는 대로 에러를 수정해 보자. 어느새 파이썬 프로그램으로 멋진 그림을 그리고, 계산을 하고, 간단한 게임을 만들고, 수학 문제를 푸는 자신을 발견하게 될 것이다. 《모두의 파이썬》으로 남녀노소 누구나 즐겁게 프로그래밍을 시작해 보자!

누구나 20일이면 파이썬 프로그램을 만들 수 있다!

1~13일: 파이썬 언어 기초 배우기

초보자도 배우기 쉬운 언어인 파이썬의 기초 문법을 예제로 배운다. 입력 → 결과 확인 → 에러 해결 → 해설 → 응용, ‘5단계 트레이닝’으로 짧은 프로그램을 직접 입력하고 고쳐 보면서 자연스럽게 프로그램을 작성하는 방법을 익힌다.

14~18일: 간단한 게임 만들기

앞에서 학습한 파이썬 기능을 이용하여 5가지 게임 프로젝트를 실습한다. 계산 맞히기 게임, 타자 게임, 거북이 대포 게임, 터틀런 1, 2를 만들고 실제로 게임을 플레이해 본다.

19~20일: 파이썬으로 수학 문제 풀어 보기

중학교 수준의 간단한 수학 문제를 파이썬 프로그램으로 만들어서 풀어 본다. 수학과 프로그래밍의 연관 관계를 배울 수 있으며 파이썬이 어떻게 활용되는지 알 수 있다.

 만든 이 코멘트', NULL);

INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (349, 395, 'image2.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (350, 395, '모두의 파이선상세이미지1.jpg', 'admin', 'detail_image1');


INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (397, '리액트를 다루는 기술', '김민준', '길벗', 32000, 32000, '2018-08-01', 688, '9791160505238', 2000, '2018-10-17',
        'main_react.jpg', 'bestseller', '리액트에 대한 기본 지식이 없는 상태에서도 쉽게 이해할 수 있도록 꼼꼼하게 설명되어 있습니다. 또한, 실제 실무에서 어떻게 사용되는지 상세히 알려줍니다.


',
        '애니메이션 스트리밍 서비스를 제공하는 라프텔(laftel.net)에서 프런트엔드 엔지니어로 일하고 있고, 패스트캠퍼스의 리액트로 구현하는 웹 애플리케이션 제작 캠프에서 강의를 하고 있다. 리액트의 빅 팬이고, velopert.com 블로그를 운영하고 있으며, 유튜브에서 매일 밤 라이브 코딩(velopert의 코딩 이야기)을 하고 있다', '리액트에 대한 기본 지식이 없는 상태에서도 쉽게 이해할 수 있도록 꼼꼼하게 설명되어 있습니다. 또한, 실제 실무에서 어떻게 사용되는지 상세히 알려줍니다.
김범준_라프텔(연세대학교) 개발자

리액트뿐만 아니라 다양한 라이브러리를 필요한 곳에 같이 사용하여 쉽게 배울 수 있었습니다.
정지훈_IOS 앱 개발

실무에서 약간 응용하여 사용할 수 있는 좋은 예제가 많다. 참고하지 않은 부분이 없을 정도로 내용이 매우 실무적이다.
조용진_스타트업 모두의 캠퍼스 개발자

문법적인 설명뿐만 아니라 사용하는 개념과 왜 그 개념이 도입될 수밖에 없는지를 이해하는 것이 중요하다고 생각합니다. 이 책은 그 점이 좋았습니다.
신형진_연세대학교 대학원생', '리액트에 대한 기본 지식이 없는 상태에서도 쉽게 이해할 수 있도록 꼼꼼하게 설명되어 있습니다. 또한, 실제 실무에서 어떻게 사용되는지 상세히 알려줍니다.
김범준_라프텔(연세대학교) 개발자

리액트뿐만 아니라 다양한 라이브러리를 필요한 곳에 같이 사용하여 쉽게 배울 수 있었습니다.
정지훈_IOS 앱 개발

실무에서 약간 응용하여 사용할 수 있는 좋은 예제가 많다. 참고하지 않은 부분이 없을 정도로 내용이 매우 실무적이다.
조용진_스타트업 모두의 캠퍼스 개발자

문법적인 설명뿐만 아니라 사용하는 개념과 왜 그 개념이 도입될 수밖에 없는지를 이해하는 것이 중요하다고 생각합니다. 이 책은 그 점이 좋았습니다.
신형진_연세대학교 대학원생', NULL);

INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (351, 397, 'main_react.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (352, 397, 'react_detail1.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (398, 'Try! helloworld 자바스크립트', '김용록', '길벗', 22000, 19800, '2018-05-22', 336, '9791160504736', 2000,
        '2018-10-17', '헬로자바스크립트_메인.jpg', 'bestseller',
        '자바스크립트는 문법이 간결하고 프로그램 설치가 간편하여 첫 프로그래밍 언어로 인기가 높다. 또한, 웹 프로그래밍부터 응용 프로그램 개발까지 활용 범위도 넓다. 이 책은 무료 학습 서비스(동영상+온라인 실습)를 제공하는 프로그래머스(programmers.co.kr) 사이트의 인기 강좌 ‘자바스크립트 기초’와 ‘웹 프런트엔드 기초’를 책으로 엮은 것이다. 책의 설명만으로도 학습하는 데 무리가 없지만, 저자 동영상 강의를 함께 보면 학습 효율이 더욱 높아질 것이다. 또한, 배운 내용을 바로 온라인 사이트에서 실습할 수 있다. 하루 한 강, 매일 15분이면 어느새 자바스크립트 프로그래밍에 익숙해진 자신을 발견하게 될 것이다.',
        '구글코리아에서 소프트웨어 엔지니어로 재직 중이다. 더 좋은 소프트웨어 엔지니어가 되기를 갈망하지만 일과 삶의 균형이 더 중요하다. 겨울에는 주로 스키를 즐긴다.',
        '언어는 말을 하면서 배워야 빠르고 정확하게 배울 수 있습니다. 프로그래밍 언어도 마찬가지입니다. 실습을 하면서 배워야 빠르고 정확하게 배울 수 있고 비로서 자기 것으로 만들 수 있습니다. 프로그래머스 사이트에서 제공하는 강의와 실습 문제는 자바스크립트를 이해하고 자기 것으로 만드는 데 큰 도움을 줄 것입니다. 기회가 된다면 작은 문제나 원하는 프로젝트를 직접 만들면서 해결해 나가길 권합니다. 프로그래머로 더욱 빠르게 성장할 수 있을 것입니다.--- 「머리말」 중에서', '혼자서 공부하는
자바스크립트 + 웹 프런트엔드

# 하루 15분! 자바스크립트 기초부터 웹 프런트엔드까지!
짧은 강의와 실습을 통해 하루 15분이면 누구나 자바스크립트 프로그래밍을 배울 수 있게 구성하였다. 기초 문법을 익힌 후에는 HTML, CSS와 함께 자바스크립트를 활용해 웹 페이지의 다양한 기능을 구현해본다.

# 5분 동영상, 53개 강의
지하철 안에서, 생활 속 자투리 시간에 틈틈이, 짬짬이 볼 수 있는 동영상 강의 53개를 제공한다(본문에 QR 코드 수록). 초보자도 차근차근 학습할 수 있도록 동영상 강의에서 미처 다루지 못한 내용을 책에 보완하고 실전에 필요한 팁을 추가했다.

# 코딩 실습 22개 + 정답 수록
배운 내용을 바로 확인하고 점검할 수 있는 실습 문제와 정답을 수록했다. 프로그래머스 사이트(http://programmers.co.kr)에서 직접 코드를 입력하고 실행해보면서 배운 내용을 훈련할 수 있다.',
        NULL);

INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (353, 398, '헬로자바스크립트_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (354, 398, '헬로자바스크립트_상세1.jpg', 'admin', 'detail_image1');


INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (400, '진짜 쓰는 실무 엑셀', '오빠두(전진권)', '제이펍', 21000, 18900, '2022-02-15', 508, '9791191600704', 0, '2024-01-05',
        '실무엑셀_메인.jpg', 'bestseller', '대기업 직장 생활 10년의 실무 노하우와 엑셀 유튜브 채널을 운영하면서 들은 수많은 직장인의 고민을 해결할 수 있는 다양한 엑셀 비법을 담았다. ‘진짜 쓰는 실무 엑셀’ 한 권이면 빠른 일 처리로 워라밸을 실현하고, 일잘러로 거듭날 수 있다!
오랜 시간 엑셀은 수많은 발전을 거듭하였고, Office 365에서 Microsoft 365로 브랜드명을 변경하기까지 다양한 기능, 특히 동적 배열 함수가 추가되면서 매크로를 사용하지 않고도 많은 부분을 해결할 수 있도록 개선되었다. 이 책에서 소개하는 제대로 된 실무 활용 기능을 익힌다면 방대한 데이터에서 특정 자료를 취합하고 분석하기, 분석된 자료를 한눈에 보기 좋게 시각화하기, 반복되는 작업을 효율적으로 개선하기 등 회사에서 원하는 엑셀 사용 능력을 충분히 뛰어넘을 수 있을 것이다.',
        '대기업에서 직장 생활을 하면서 실무 엑셀을 익혔고, 현재는 구독자 50만의 ‘오빠두엑셀’ 유튜브 채널과 엑셀 전문 홈페이지를 운영한다. 모든 직장인이 일잘러가 되길 바라며, 현업 및 강의 경험을 토대로 쌓은 엑셀 필수 공식과 핵심 기능 등 회사에서 꼭 필요한 엑셀 노하우를 가르치는 데도 힘쓰고 있다. 마이크로소프트에서 최고 전문가로 인정한 엑셀 MVP이며, 삼성전자, 네이버, 서울시 교육청 등 여러 기관 및 기업을 대상으로 강의 및 컨설팅을 진행하고 있다.', '개념 정리는 이제 그만, 실무 활용도 100%, 진짜 쓰는 실전 예제를 활용하여 기초는 빠르게, 실무는 제대로 배울 수 있습니다. 100% 맞춤형 무료 동영상 강의는 서비스!
대상 독자
● 데이터 관리부터 보고서 작성까지 업무 대부분을 엑셀로 처리하는 직장인
● 기본적인 엑셀 사용법은 알지만, 일 처리가 서투른 신입사원
● 데이터 분석 및 시각화를 위해 엑셀을 사용하려는 마케터
● 완벽하게 준비해서 취업하고 싶은 예비 직장인', NULL, 'CHAPTER 01 시작부터 남다른 실무자의 엑셀 활용
CHAPTER 02 실무자라면 반드시 알아야 할 엑셀 활용
CHAPTER 03 보고서가 달라지는 서식 활용법
CHAPTER 04 완성한 엑셀 보고서 공유 및 출력하기
CHAPTER 05 데이터 정리부터 데이터 필터링까지
CHAPTER 06 데이터 자동화 및 분석을 위한 표 & 피벗 테이블
CHAPTER 07 엑셀 활용의 10%를 채워 줄 기본 & 필수 함수 익히기
CHAPTER 08 실무에서 필요한 엑셀 데이터 시각화의 모든 것
APPENDIX 한 걸음 더');

INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (10400, 400, '실무엑셀_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (11400, 400, '실무엑셀_상세1.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (401, '개발자 오늘도 마음 튼튼하게 성장하기', '피오다르 서재나베츠 · 이미령 번역', '길벗', 27500, 24750, '2023-12-13', 380, '9791140707591', 0,
        '2024-01-05', '개발자마음성장_메인.jpg', 'newbook', '당신을 둘러싼 보이지 않는 전쟁이 벌어지고 있다
그리고 이 전쟁은 당신의 경력을 파괴하고 있다
성장하기 위해서는 주변을 바꿔라
내가 성장하기 위해서는 주변을 바꿔야 한다. 나의 몰입을 방해하는 주변 환경을 바꿨다면, 그다음엔 나의 동기를 깎아 먹는 주변 사람을 바꿔야 한다. 부정적인 말로 가득한 사람들, 에너지 뱀파이어를 멀리하고 성장 마인드셋을 가진 사람들로 주변을 채워야 한다. 나 자신을 성장 마인드셋으로 바꾸는 것으로는 부족하다. 소셜 미디어, 오프라인 모임 등을 활용해서 성장 마인드셋을 가진 사람들로 내 주변을 채우자.
성장과 집중에는 멘탈이 전부다
성장을 방해하는 요소를 제거했다면 그다음은 성장과 집중을 위한 건강한 멘탈이 필요하다. 건강한 멘탈은 의지력이나 생각한다고 되는 게 아니다. 작은 행동으로 습관을 형성하는 것부터 시작해야 한다. 습관을 형성하는 기법, 네이비 실에서 배우는 극한의 오너십, 수도자의 정신 수양에서 배우기, 마이크로태스크 기법, 지루한 일을 해치우는 지적확인 환호응답, 뽀모도로와 타이머로 주의력을 효율적으로 관리하고 집중하는 법을 배워보자. 그리하면 몰입의 즐거움마저 느낄 수 있다.
', '(Fiodar Sazanavets)
피오다르는 주로 마이크로소프트 소프트웨어 개발 스택을 다루는 숙련된 풀 스택 리드 소프트웨어 엔지니어다. 그의 주요 전문 분야는 ASP.NET(프레임워크와 코어), SQL 서버, 애저, 도커, 사물인터넷(IoT), 마이크로서비스 아키텍처와 다양한 프런트엔드 기술이다.
피오다르는 물공학, 금융, 소매, 철도, 방산 등 다양한 분야에서 일하며 소프트웨어 엔지니어링 경력을 쌓았다. 그는 다양한 프로젝트에서 주도적인 역할을 했으며 소프트웨어 구축은 물론 아키텍처와 디자인 분야에서도 상당한 경험을 쌓았다. 또한 사내 소프트웨어 개발, 소프트웨어와 IoT 하드웨어 배포 등 고객 사이트에서 다양한 기술 업무를 수행했다.
피오다르는 다른 사람들에게 프로그래밍 기술을 가르치는 데 열정이 있다. 그는 다수의 책과 프로그래밍 강좌를 공개했다.', NULL, NULL, '1 왜 소셜 미디어가 가장 큰 적일까
2 당신의 동맹군 - 딥 워크와 몰입 상태
3 은밀하게 잠입한 스파이 - 내면의 방해꾼을 감지하고 극복하기
4 에코 체임버는 경력에 어떻게 도움이 되는가
5 적을 제압하기 - 소셜 미디어 유리하게 활용하기
6 극한의 오너십 - 프로그래머가 미국 해군 네이비 실에서 배울 수 있는 것
7 수도자 정신은 성공적인 프로그래머가 되는 데 어떤 도움을 주는가
8 마이크로태스크로 미루는 습관 극복하기
9 지적확인 환호응답 - 존에 쉽게 들어가는 일본 기법
10 뽀모도로와 타이머로 더 쉽게 일하기');

INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (10401, 401, '개발자마음성장_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (11401, 401, '개발자마음성장_상세.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (402, 'IT 세계의 괴물들(아무나 이해할 수 있는 IT 이야기)', '아무준수', '생능북스', 19800, 17820, '2024-01-10', 416, '9791192932361', 0,
        '2024-01-03', 'monsters_메인.jpg', 'newbook', '지금까지 이런 책은 없었다!
첫 페이지를 넘기는 순간, 디지털 세상에 빠져드는 완벽한 몰입도를 선사할 것이다!
이 책은 IT 지식을 만화로 풀어낸 것으로, IT의 기초를 확인하고 바로 사용할 수 있는 지식을 제공합니다. 또한 다양한 캐릭터들이 등장하여 각자의 역할에 맞게 웃음 코드를 보여줍니다. 그리고 부연설명이 필요한 생소한 IT 용어는 주석으로 채워 넣었으며, 비전공자도 이해하기 쉽게 한 방에 정리했습니다. 아울러 전공자도 미처 몰랐던 IT의 숨은 이야기도 중간에 쉬어가는 코너로 담았습니다.
디지털 세상이 0과 1만 가득한 무미건조한 세상인 줄 알았다면, 이 책을 통해 코믹한 캐릭터들과 공감해보기를 바라며, 디지털 세대를 키우는 부모님 등을 위한 맞춤형 IT 교양서로도 추천합니다.',
        '현대자동차 그룹사의 R&D 기획팀 출신으로 제어시스템 및 제어 소프트웨어 관련 업무를 담당했다. 퇴사 후 웹 개발 IT 스타트업을 창업하지만 사이버 보안을 등한시 하다 랜섬웨어로 인해 사업을 접게 되었는데, 이 경험은 IT 회사에 사이버 보안 엔지니어로 취업하게 된 계기가 되었다. 현재는 외국계 IT 회사의 엔지니어링 본부 Head를 맡고 있으며, 종종 취미로 인스타그램에 IT 기술을 캐릭터화 시켜 올리던 개그 만화가 책으로 엮어지게 되었다.', '어렵지만 익숙한
낯설지만 친숙한
디지털 세상을 캐릭터로 이해하자!
이 책은 글쓴이가 종종 취미로 IT 기술을 캐릭터화시켜 인스타그램에 올리던 개그 만화를 책으로 엮은 것입니다. 이 책을 통해 글쓴이가 말해주는 디지털 세상의 괴물들(?)은 무엇이 있는지 쉽게 이해할 수 있고, 우리가 모르고 지나쳐서 큰 사고로 유발(예 : 자동차 급발진)되는 것은 없었는지 등을 알 수 있습니다. 꼭 한 번은 편하게 읽으며 공감을 얻었으면 하는 바람입니다.',
        NULL, NULL);

INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (10402, 402, 'monsters_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (11402, 402, 'monsters_상세.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (403, 'AWS 교과서', '김원일 , 서종호 , 김석필 ', '길벗', 38000, 34200, '2023-10-20', 480, '9791140706662', 0, '2024-01-03',
        'AWS 교과서_메인.jpg', 'bestseller', '이론과 실습으로 배우는 AWS!
입문자에게 딱 맞는 구성으로 시작해보자!
AWS는 다양한 퍼블릭 클라우드 서비스를 제공하고 있고, 현재 클라우드 플랫폼 중에서 점유율 1위를 차지하고 있다. 이미 많은 기업이 AWS를 도입했거나 도입을 고려하고 있는 만큼, AWS의 구조와 기능을 잘 알고 있어야 한다. 『AWS 교과서』는 컴퓨팅, 네트워킹, 부하분산, 스토리지, 데이터베이스, IAM, 오토 스케일링 등 주요 서비스를 중심으로 개념을 설명한다. 이론이 끝나면 실습으로 직접 서비스를 다뤄보기 때문에 어떻게 동작하는지 제대로 익힐 수 있다. 마지막 장에서는 AWS 서비스를 활용해 프로젝트 실습까지 해본다. AWS를 어디서부터 어떻게 공부해야 할지 모르겠다면 이 책으로 쉽게 입문해보자!', '김원일
어떠한 이론이나 진리에 대해 눈으로 직접 확인하고, 도식화된 형태로 정리하는 것을 좋아한다. 이러한 즐거움을 바탕으로 현재 클라우드 인프라 스터디 그룹에서 콘텐츠를 제작하며 지식 공유 활동을 하고 있다. 또한, 클라우드 관련 서적을 집필하고 온라인 강의도 업로드하고 있다.
서종호
네트워크 현업에서 10년 넘게 종사하고 있고, 스타트업에서 인프라를 운영하는 데브옵스 엔지니어로 일하고 있다. 클라우드 인프라에 대한 지식을 학습하고, 정보를 공유하는 스터디팀을 만들어 운영하고 있다.', '아는 만큼 최적의 서비스를 선택하고
효율적으로 운영할 수 있다!
AWS는 점유율 1위에 달하는 클라우드 서비스 플랫폼으로, 전 세계에 걸친 광범위한 클라우드 인프라를 형성하고 있다. 현업의 다양한 요구에 맞춰 클라우드 컴퓨팅 서비스는 지속적으로 발전하였고 이로 인해 제공하는 서비스와 기능도 다양해졌다. AWS는 200개 이상의 클라우드 서비스를 제공하며, 이를 잘 활용하기 위해서는 서비스를 잘 이해하고 나에게 필요한 서비스를 적절히 골라 효과적으로 운영하는 스킬이 필요하다.
이 책은 컴퓨팅, 네트워킹, 부하분산, 스토리지, 데이터베이스 등 실제 많이 사용하는 서비스를 중심으로 AWS가 제공하는 서비스를 설명한다. 기본 서비스 외에도 고급 네트워킹 서비스와 실전 프로젝트를 수록해 기본부터 실전까지 모두 익힐 수 있다. 무엇보다 AWS 기본 개념과 핵심 기능을 ‘직접 손으로 따라 하면서’ 공부할 수 있게 매 장마다 실습 코너를 넣었으며, 학습한 뒤에 다시 복기할 수 있게 ‘요약’ 코너도 넣어서 제대로 공부하고 싶은 사람에게 안성맞춤인 책이다. 한 번 읽어보고 내려놓는 게 아닌, 실전형으로 입문하고 싶다면 이 책으로 시작해보길 강력하게 추천한다.',
        NULL, '1장 AWS란
1.1 클라우드 컴퓨팅
1.2 AWS 서비스
1.3 실습 AWS 가입하기 - 프리 티어
2장 AWS 컴퓨팅 서비스
2.1 AWS 컴퓨팅 서비스
2.2 Amazon EC2 소개
2.3 실습 Amazon EC2 인스턴스 배포 및 접근하기
3장 AWS 네트워킹 서비스
3.1 네트워킹이란
3.2 AWS 네트워킹 소개
3.3 Amazon VPC 소개 82
3.4 실습 Amazon VPC로 퍼블릭 및 프라이빗 서브넷 구성하기
4장 AWS 부하분산 서비스
4.1 Amazon ELB 기능 소개
4.2 실습 ALB와 NLB를 이용한 로드 밸런싱 구성하기
5장 AWS 스토리지 서비스
5.1 스토리지 개요
5.2 스토리지 서비스 및 주요 기능
5.3 Amazon EBS
5.4 Amazon S3
5.5 실습 다양한 AWS 스토리지 서비스 구성하기
6장 AWS 데이터베이스 서비스
6.1 데이터베이스와 DBMS
6.2 AWS 데이터베이스 서비스
6.3 실습 웹 서버와 Amazon RDS 연동하기
7장 AWS 고급 네트워킹 서비스
7.1 DNS란
7.2 Amazon Route 53 서비스
7.3 CDN이란
7.4 Amazon CloudFront란
7.5 실습 Amazon CloudFront로 CDN 서비스 구성하기
8장 AWS IAM 서비스
8.1 배경 소개
8.2 AWS IAM
8.3 실습 AWS IAM 사용자 생성 및 정책, 역할 동작 확인하기
9장 AWS 오토 스케일링 서비스
9.1 스케일링
9.2 AWS 오토 스케일링 서비스
9.3 실습 Amazon EC2 오토 스케일링 구성하기
10장 워드프레스
10.1 워드프레스 소개
10.2 실습 워드프레스 구성하기
11장 워드프레스 이중화
11.1 실습 소개
11.2 실습 1 AWS 서비스를 활용한 워드프레스 구성하기
11.3 실습 2 확장성과 안정성을 고려한 워드프레스 구성하기');

INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (10403, 403, 'AWS 교과서_메인.jpg', 'admin', 'main_image');
INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (11403, 403, 'AWS 교과서_상세.jpg', 'admin', 'detail_image1');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (404, 'CODE', '찰스 펫졸드 저자(글) · 김현규 번역', '인사이트', 35000, 31500, '2023-12-22', 624, '9788966264285', 0, '2024-01-03',
        'CODE_메인.jpg', 'newbook', '23년 만에 돌아온 컴퓨터 공학 분야의 필독서!
20년이 넘는 세월 동안 컴퓨터 공학 분야의 필독서로서 많은 독자를 열광하게 만든 《CODE》가 새로운 컴퓨팅 시대에 맞춰 개정되었습니다. 컴퓨터 내부의 비밀스러운 이야기들을 담은 이 책은 잘 짜인 일러스트와 이해하기 쉬운 설명을 통해서 컴퓨터에 대한 수수께끼를 풀어냅니다. 손전등, 검은 고양이, 시소, 폴 리비어의 질주를 통해서 컴퓨팅에 대해 배울 수 있으며, 인간의 독창성과 소통에 대한 충동이 우리가 지금 사용하는 모든 전자 장치에 어떤 영향을 끼쳤는지 확인할 수 있습니다.', '(Charles Petzold)
35년 동안 개인용 컴퓨터와 프로그래밍에 대한 수많은 책을 써왔다. 그가 쓴 책으로는 《Programming Widows》를 포함한 12권 이상의 프로그래밍 책과 《The Annotated Turing: A Guided Tour through Alan Turing’s Historic Paper on Computability and the Turing Machine(주석으로 해설한 튜링: 계산 가능성과 튜링 머신을 다룬 앨런 튜링의 역사적 논문에 대한 해설과 함께하는 여행)》이 있다. 현재 그는 역사학자이자 소설가이자 아내인 데어드레 시놋(Deirdre Sinnott)과 하니, 하이디라는 이름을 가진 두 마리 고양이와 함께 뉴욕에 살고 있다. 개인 웹사이트 www.charlespetzold.com을 운영하고 있다.', '20년이 넘는 세월 동안 컴퓨터 공학 분야의 필독서로서 많은 독자를 열광하게 만든 《CODE》가 새로운 컴퓨팅 시대에 맞춰 새롭게 개정되었습니다. 컴퓨터 내부의 비밀스러운 이야기들을 담은 이 책은 잘 짜인 일러스트와 이해하기 쉬운 설명을 통해서 컴퓨터에 대한 수수께끼를 풀어내는 책입니다. 손전등, 검은 고양이, 시소, 폴 리비어의 질주를 통해서 컴퓨팅에 대해 배울 수 있으며, 인간의 독창성과 소통에 대한 충동이 우리가 지금 사용하는 모든 전자 장치에 어떻게 영향을 끼쳤는지 확인할 수 있습니다.
이번 개정판에서는 모든 스마트 기기의 심장이자 단순한 기본 연산들을 결합시켜 가장 복잡한 작업을 수행할 수 있도록 만들어진 중앙 처리 장치에 대해 비트 단위와 게이트 단위까지 구석구석 깊숙이 탐험하고 있습니다. 또한 저자는 이 책의 내용을 보조하는 웹사이트인 CodeHiddenLanguage.com을 만들어, 이 책에 나오는 주요 회로들의 동작을 그래픽 애니메이션으로 표현함으로써 해당 회로를 더욱 쉽게 이해할 수 있게 하였습니다.
이번 개정판에서는 기존의 내용에서 많은 부분이 수정되었으며, 다음과 같은 새로운 장들이 추가되었습니다.
18장 시계를 만들어 봅시다
21장 산술 논리 장치
22장 레지스터와 버스
23장 CPU의 제어 신호들
24장 점프, 루프, 그리고 호출
28장 월드 브레인', '박재호 (《클린 코드》 역자)
“《CODE》는 추상화 수준을 낮춰서 비트와 바이트의 세계로 여러분들을 안내하는 책입니다. 이렇게 함으로써 매끈한 플라스틱 케이스 뒤에 숨어 있는 컴퓨터의 비밀을 하나씩 캐낼 수 있도록 도와줍니다. 이 책을 통해 재미와 지식이라는 두 마리 토끼를 동시에 잡으면서 소프트웨어 개발과 문제 해결 역량도 한 단계 높여보기 바랍니다."
스콧 한셀만(Scott Hanselman) (마이크로소프트 파트너 프로그램 디렉터이자 Hanselminutes 팟캐스트 진행자)
"저에게 《CODE》는 계시와도 같았습니다. 제게 말을 건네는 첫 번째 프로그래밍 관련 책이었습니다. 이야기로 시작해서 다양한 비유를 한층 한층 쌓아 올려 코드뿐 아니라 시스템까지 이해할 수 있게 해 주었습니다. 이 책은 코드와 프로그래밍에 관한 책인 동시에 시스템적 사고와 추상화에 관한 책이기도 합니다. 우리가 일상적으로 접하는 컴퓨터 시스템과 번개를 주입해서 생각할 수 있도록 만든 마법의 실리콘 바위 사이에 보이지 않은 수많은 계층이 얼마나 많이 존재하는지 알려 줍니다.', 'Chapter 1 친한 친구와의 대화
Chapter 2 부호와 조합
Chapter 3 점자와 이진 부호
Chapter 4 전등을 분해해 봅시다
Chapter 5 가까운 거리에서 이야기하기
Chapter 6 논리와 스위치
Chapter 7 전신과 릴레이
Chapter 8 릴레이와 논리 게이트
Chapter 9 우리가 사용하는 열 개의 숫자들
Chapter 10 십진수 이외의 것
Chapter 11 비트, 비트, 비트
Chapter 12 바이트와 16진수
Chapter 13 ASCII에서 유니코드까지
Chapter 14 논리 게이트로 덧셈하기
Chapter 15 실제로도 그럴까?
Chapter 16 그렇다면 뺄셈은 어떨까요?
Chapter 17 피드백과 플립플롭
Chapter 18 시계를 만들어 봅시다
Chapter 19 메모리를 만들어 봅시다
Chapter 20 연산을 자동화시키기
Chapter 21 산술 논리 장치
Chapter 22 레지스터와 버스
Chapter 23 CPU의 제어 신호들
Chapter 24 루프, 분기, 그리고 호출
Chapter 25 주변 장치들
Chapter 26 운영체제
Chapter 27 코딩
Chapter 28 월드 브레인');

INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (10404, 404, 'CODE_메인.jpg', 'admin', 'main_image');

INSERT INTO bookshop.t_shopping_goods
(goods_id, goods_title, goods_writer, goods_publisher, goods_price, goods_sales_price, goods_published_date,
 goods_total_page, goods_isbn, goods_delivery_price, goods_delivery_date, goods_file_name, goods_status, goods_intro,
 goods_writer_intro, goods_publisher_comment, goods_recommendation, goods_contents_order)
VALUES (409, 'Clean Code(클린 코드)', '로버트 C. 마틴', '인사이트', 33000, 29700, '2013-12-14', 584, '9788966260959', 0,
        '2024-01-03', '클린코드_메인.jpg', 'steadyseller', '프로그래머, 소프트웨어 공학도, 프로젝트 관리자, 팀 리더, 시스템 분석가에게 도움이 될
더 나은 코드를 만드는 책
『Clean Code(클린 코드)』은 오브젝트 멘토(Object Mentor)의 동료들과 힘을 모아 ‘개발하며’ 클린 코드를 만드는 최상의 애자일 기법을 소개하고 있다. 소프트웨어 장인 정신의 가치를 심어 주며 프로그래밍 실력을 높여줄 것이다. 여러분이 노력만 한다면. 어떤 노력이 필요하냐고? 코드를 읽어야 한다. 아주 많은 코드를. 그리고 코드를 읽으면서 그 코드의 무엇이 옳은지, 그른지 생각도 해야 한다. 좀 더 중요하게는 전문가로서 자신이 지니는 가치와 장인으로서 자기 작품에 대한 헌신을 돌아보게 된다.',
        '저자 로버트 C. 마틴 Robert C. Martin은 "밥 아저씨(Uncle Bob)"로 불리기도 한다. 1970년부터 소프트웨어 전문가로 활동했으며, 오브젝트 멘토(Object Mentor) 사의 창립자이며 대표다. 오브젝트 멘토는 C++, 자바, C#, 루비, 객체지향, 디자인 패턴, UML, 애자일 방법론, 익스트림 프로그래밍 분야에서 전 세계의 고객들을 이끄는 경험이 풍부한 컨설턴트로 이루어졌다. 지은 책으로 『Agile Software Development, Principles, Patterns, and Practices』, 『The Clean Coder』, 『UML for Java Programmers』 등이 있다.', '나쁜 코드도 돌아는 간다. 하지만 코드가 깨끗하지 못하면 개발 조직은 기어간다. 매년 지저분한 코드로 수많은 시간과 상당한 자원이 낭비된다. 그래야 할 이유가 없다. 로버트 마틴은 이 책에서 혁명적인 패러다임을 제시한다. 그는 오브젝트 멘토(ObjectMentor)의 동료들과 힘을 모아 ‘개발하며’ 클린 코드를 만드는 최상의 애자일 기법을 정제해 책 한 권에 담았고, 이 책은 소프트웨어 장인 정신의 가치를 심어 주며 프로그래밍 실력을 높여줄 것이다. 여러분이 노력만 한다면. 어떤 노력이 필요하냐고? 코드를 읽어야 한다. 아주 많은 코드를. 그리고 코드를 읽으면서 그 코드의 무엇이 옳은지, 그른지 생각도 해야 한다. 좀 더 중요하게는 전문가로서 자신이 지니는 가치와 장인으로서 자기 작품에 대한 헌신을 돌아보게 된다. 이 책을 읽은 독자는 다음 내용을 알게 된다.
-. 좋은 코드와 나쁜 코드를 구분하는 방법
-. 좋은 코드를 작성하는 방법과 나쁜 코드를 좋은 코드로 바꾸는 방법
-. 좋은 이름, 좋은 함수, 좋은 객체, 좋은 클래스를 작성하는 방법
-. 가독성이 높아지도록 코드 형식을 맞추는 방법
-. 코드 논리를 흩뜨리지 않고서 오류 처리를 완벽하게 구현하는 방법
-. 단위 테스트와 테스트 주도 개발을 적용하는 방법', NULL, NULL);

INSERT INTO bookshop.t_goods_detail_image
    (image_id, goods_id, file_name, reg_id, file_type)
VALUES (10409, 409, '클린코드_메인.jpg', 'admin', 'main_image');

-- t_shopping_order
Insert into t_shopping_order (order_seq_num,order_id,member_id,goods_id,orderer_name,goods_title,order_goods_qty,goods_sales_price,goods_file_name,receiver_name,receiver_hp1,receiver_hp2,receiver_hp3,delivery_address, delivery_method, delivery_message, gift_wrapping, pay_method, card_com_name, card_pay_month, pay_orderer_hp_num, delivery_state, pay_order_time, orderer_hp) values (88,92,'lee',344,'이병승','초보자를 위한 자바프로그래밍',1,30000,'image1.jpg','이병승','010','2222','3333','우편번호:13547 도로명 주소:경기 성남시 분당구 고기로 25 (동원동) [지번 주소:경기 성남시 분당구 동원동 79-1] 럭키빌딩 101호','일반택배',null,'no','신용카드 카드사:삼성, 할부개월수:일시불','삼성','일시불','해당없음','delivery_prepared','2023/12/20','010-2222-3333');
Insert into t_shopping_order (order_seq_num,order_id,member_id,goods_id,orderer_name,goods_title,order_goods_qty,goods_sales_price,goods_file_name,receiver_name,receiver_hp1,receiver_hp2,receiver_hp3,delivery_address, delivery_method, delivery_message, gift_wrapping, pay_method, card_com_name, card_pay_month, pay_orderer_hp_num, delivery_state, pay_order_time, orderer_hp) values (89,93,'lee',354,'이병승','모두의 딥러닝',1,21600,'모두의 딥러닝_메인.jpg','이병승','010','2222','3333','우편번호:13547 도로명 주소:경기 성남시 분당구 고기로 25 (동원동) [지번 주소:경기 성남시 분당구 동원동 79-1] 럭키빌딩 101호','일반택배',null,'no','신용카드 카드사:삼성, 할부개월수:일시불','삼성','일시불','해당없음','delivering','2023/12/20','010-2222-3333');
Insert into t_shopping_order (order_seq_num,order_id,member_id,goods_id,orderer_name,goods_title,order_goods_qty,goods_sales_price,goods_file_name,receiver_name,receiver_hp1,receiver_hp2,receiver_hp3,delivery_address, delivery_method, delivery_message, gift_wrapping, pay_method, card_com_name, card_pay_month, pay_orderer_hp_num, delivery_state, pay_order_time, orderer_hp) values (90,94,'lee',354,'이병승','모두의 딥러닝',1,21600,'모두의 딥러닝_메인.jpg','이병승','010','2222','3333','우편번호:13547 도로명 주소:경기 성남시 분당구 고기로 25 (동원동) [지번 주소:경기 성남시 분당구 동원동 79-1] 럭키빌딩 101호','일반택배',null,'no','신용카드 카드사:삼성, 할부개월수:일시불','삼성','일시불','해당없음','delivery_prepared','2023/12/20','010-2222-3333');

-- 게시판 종류 테이블 데이터
insert into categories(cate, cate_name)
values (1, '공지사항');
insert into categories(cate, cate_name)
values (2, '서비스 문의');
insert into categories(cate, cate_name)
values (31, '환불');
insert into categories(cate, cate_name)
values (32, '배송');
insert into categories(cate, cate_name)
values (33, '기타');
insert into categories(cate, cate_name)
values (4, '상품 후기');


-- 게시판 테이블 더미 데이터
-- cate 1) '공지사항' (관리자 작성)
INSERT INTO board(member_id, title, content, cate)
VALUES ('admin', '무료배송 가능 주문금액 변경 안내', '공지사항입니다.', 1);
INSERT INTO board(member_id, title, content, cate)
VALUES ('admin', '신정 출고 일정 및 고객센터 휴무 안내', '공지사항입니다.', 1);
INSERT INTO board(member_id, title, content, cate)
VALUES ('admin', '내부 점검으로 인한 출고 일정 안내', '공지사항입니다.', 1);
INSERT INTO board(member_id, title, content, cate)
VALUES ('admin', '위탁 배달원 휴무로 인한 배송 지연 안내', '공지사항입니다.', 1);
INSERT INTO board(member_id, title, content, cate)
VALUES ('admin', '개인정보처리방침 개정 사전 안내', '공지사항입니다.', 1);
INSERT INTO board(member_id, title, content, cate)
VALUES ('admin', '판매 종료 도서 안내', '공지사항입니다.', 1);
INSERT INTO board(member_id, title, content, cate)
VALUES ('admin', '품절 도서 재입고 안내', '공지사항입니다.', 1);
INSERT INTO board(member_id, title, content, cate)
VALUES ('admin', '물류 내부 점검으로 인한 출고 지연 안내', '공지사항입니다.', 1);
INSERT INTO board(member_id, title, content, cate)
VALUES ('admin', '신도서 입고 안내', '공지사항입니다.', 1);
INSERT INTO board(member_id, title, content, cate)
VALUES ('admin', '도서 상태 불량에 대한 처리 안내', '공지사항입니다.', 1);
INSERT INTO board(member_id, title, content, cate)
VALUES ('admin', '내부 점검으로 인한 출고 일정 안내', '공지사항입니다.', 1);
INSERT INTO board(member_id, title, content, cate)
VALUES ('admin', '판매 종료 도서 안내', '공지사항입니다.', 1);
INSERT INTO board(member_id, title, content, cate)
VALUES ('admin', '위탁 배달원 휴무로 인한 배송 지연 안내', '공지사항입니다.', 1);
INSERT INTO board(member_id, title, content, cate)
VALUES ('admin', '무료배송 가능 주문금액 변경 안내', '공지사항입니다.', 1);
INSERT INTO board(member_id, title, content, cate)
VALUES ('admin', '신년 이벤트 당첨자 발표', '2024 용의 해, 새해 복 많이 받으세요. 신년 이벤트 당첨자를 발표합니다. 아래의 휴대폰 번호를 확인해주세요.', 1);

-- cate 2) '서비스 문의' (사용자 작성)
INSERT INTO board(member_id, title, content, cate, com_status)
VALUES ('lee', '문의합니다.', '문의합니다.', 2, 'y');
INSERT INTO board(member_id, title, content, cate, com_status)
VALUES ('lee', '문의합니다.', '문의합니다.', 2, 'y');
INSERT INTO board(member_id, title, content, cate, com_status)
VALUES ('lee', '문의합니다.', '문의합니다.', 2, 'y');
INSERT INTO board(member_id, title, content, cate, com_status)
VALUES ('lee', '문의합니다.', '문의합니다.', 2, 'y');
INSERT INTO board(member_id, title, content, cate, com_status)
VALUES ('lee', '문의합니다.', '문의합니다.', 2, 'y');
INSERT INTO board(member_id, title, content, cate)
VALUES ('lee', '문의합니다.', '문의합니다.', 2);
INSERT INTO board(member_id, title, content, cate)
VALUES ('lee', '문의합니다.', '문의합니다.', 2);
INSERT INTO board(member_id, title, content, cate)
VALUES ('lee', '문의합니다.', '문의합니다.', 2);
INSERT INTO board(member_id, title, content, cate)
VALUES ('lee', '문의합니다.', '문의합니다.', 2);
INSERT INTO board(member_id, title, content, cate)
VALUES ('lee', '문의합니다.', '문의합니다.', 2);
INSERT INTO board(member_id, title, content, cate)
VALUES ('lee', '문의합니다.', '문의합니다.', 2);
INSERT INTO board(member_id, title, content, cate)
VALUES ('lee', '문의합니다.', '문의합니다.', 2);
INSERT INTO board(member_id, title, content, cate)
VALUES ('lee', '문의합니다.', '문의합니다.', 2);
INSERT INTO board(member_id, title, content, cate)
VALUES ('lee', '문의합니다.', '문의합니다.', 2);
INSERT INTO board(member_id, title, content, cate)
VALUES ('lee', '문의합니다.', '문의합니다.', 2);

-- cate 31) '환불' (사용자 작성)
INSERT INTO board(goods_id, member_id, title, content, cate, com_status)
VALUES (400, 'lee', '환불 문의입니다.', '환불 문의입니다.', 31, 'y');
INSERT INTO board(goods_id, member_id, title, content, cate, com_status)
VALUES (400, 'lee', '환불 문의입니다.', '환불 문의입니다.', 31, 'y');
INSERT INTO board(goods_id, member_id, title, content, cate, com_status)
VALUES (400, 'lee', '환불 문의입니다.', '환불 문의입니다.', 31, 'y');
INSERT INTO board(goods_id, member_id, title, content, cate, com_status)
VALUES (400, 'lee', '환불 문의입니다.', '환불 문의입니다.', 31, 'y');
INSERT INTO board(goods_id, member_id, title, content, cate, com_status)
VALUES (400, 'lee', '환불 문의입니다.', '환불 문의입니다.', 31, 'y');
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '환불 문의입니다.', '환불 문의입니다.', 31);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '환불 문의입니다.', '환불 문의입니다.', 31);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '환불 문의입니다.', '환불 문의입니다.', 31);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '환불 문의입니다.', '환불 문의입니다.', 31);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '환불 문의입니다.', '환불 문의입니다.', 31);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '환불 문의입니다.', '환불 문의입니다.', 31);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '환불 문의입니다.', '환불 문의입니다.', 31);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '환불 문의입니다.', '환불 문의입니다.', 31);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '환불 문의입니다.', '환불 문의입니다.', 31);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '환불 문의입니다.', '환불 문의입니다.', 31);

-- cate 32) '배송' (사용자 작성)
INSERT INTO board(goods_id, member_id, title, content, cate, com_status)
VALUES (400, 'lee', '배송 문의입니다.', '배송 문의입니다.', 32, 'y');
INSERT INTO board(goods_id, member_id, title, content, cate, com_status)
VALUES (400, 'lee', '배송 문의입니다.', '배송 문의입니다.', 32, 'y');
INSERT INTO board(goods_id, member_id, title, content, cate, com_status)
VALUES (400, 'lee', '배송 문의입니다.', '배송 문의입니다.', 32, 'y');
INSERT INTO board(goods_id, member_id, title, content, cate, com_status)
VALUES (400, 'lee', '배송 문의입니다.', '배송 문의입니다.', 32, 'y');
INSERT INTO board(goods_id, member_id, title, content, cate, com_status)
VALUES (400, 'lee', '배송 문의입니다.', '배송 문의입니다.', 32, 'y');
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '배송 문의입니다.', '배송 문의입니다.', 32);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '배송 문의입니다.', '배송 문의입니다.', 32);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '배송 문의입니다.', '배송 문의입니다.', 32);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '배송 문의입니다.', '배송 문의입니다.', 32);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '배송 문의입니다.', '배송 문의입니다.', 32);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '배송 문의입니다.', '배송 문의입니다.', 32);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '배송 문의입니다.', '배송 문의입니다.', 32);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '배송 문의입니다.', '배송 문의입니다.', 32);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '배송 문의입니다.', '배송 문의입니다.', 32);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '배송 문의입니다.', '배송 문의입니다.', 32);

-- cate 33) '기타' (사용자 작성)
INSERT INTO board(goods_id, member_id, title, content, cate, com_status)
VALUES (400, 'lee', '기타 문의입니다.', '기타 문의입니다.', 33, 'y');
INSERT INTO board(goods_id, member_id, title, content, cate, com_status)
VALUES (400, 'lee', '기타 문의입니다.', '기타 문의입니다.', 33, 'y');
INSERT INTO board(goods_id, member_id, title, content, cate, com_status)
VALUES (400, 'lee', '기타 문의입니다.', '기타 문의입니다.', 33, 'y');
INSERT INTO board(goods_id, member_id, title, content, cate, com_status)
VALUES (400, 'lee', '기타 문의입니다.', '기타 문의입니다.', 33, 'y');
INSERT INTO board(goods_id, member_id, title, content, cate, com_status)
VALUES (400, 'lee', '기타 문의입니다.', '기타 문의입니다.', 33, 'y');
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '기타 문의입니다.', '기타 문의입니다.', 33);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '기타 문의입니다.', '기타 문의입니다.', 33);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '기타 문의입니다.', '기타 문의입니다.', 33);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '기타 문의입니다.', '기타 문의입니다.', 33);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '기타 문의입니다.', '기타 문의입니다.', 33);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '기타 문의입니다.', '기타 문의입니다.', 33);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '기타 문의입니다.', '기타 문의입니다.', 33);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '기타 문의입니다.', '기타 문의입니다.', 33);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '기타 문의입니다.', '기타 문의입니다.', 33);
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '기타 문의입니다.', '기타 문의입니다.', 33);

-- cate 4) '상품 후기' (사용자 작성)
INSERT INTO board(goods_id, member_id, title, content, cate)
VALUES (400, 'lee', '너무 도움 많이 됐어요!', '엑셀 못 해서 늘 고생이었는데 이 도서 덕분에 많이 배웠습니다!', 4);


-- 게시판 댓글 테이블 더미 데이터
-- cate 2) '서비스 문의' (사용자 작성)에 대한 댓글 (관리자 작성)
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (16, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (17, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (18, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (19, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (20, '답변입니다.', 'admin');

-- cate 31) '환불' (사용자 작성)에 대한 댓글 (관리자 작성)
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (31, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (32, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (33, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (34, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (35, '답변입니다.', 'admin');

-- cate 32) '배송' (사용자 작성)에 대한 댓글 (관리자 작성)
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (46, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (47, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (48, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (49, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (50, '답변입니다.', 'admin');

-- cate 33) '기타' (사용자 작성)에 대한 댓글 (관리자 작성)
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (61, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (62, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (63, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (64, '답변입니다.', 'admin');
INSERT INTO board_comment(brd_id, com_content, member_id)
VALUES (65, '답변입니다.', 'admin');


-- 주문테이블 연관관계 설정
--
-- ALTER TABLE t_shopping_order ADD FOREIGN key(member_id) REFERENCES t_shopping_member(member_id) ON DELETE CASCADE;
-- ALTER TABLE t_shopping_order ADD FOREIGN key(goods_id) REFERENCES t_shopping_goods(goods_id) ON DELETE CASCADE;
-- 상품 이미지 정보 테이블 연관관계 설정
-- ALTER TABLE t_goods_detail_image ADD FOREIGN key(goods_id) REFERENCES t_shopping_goods(goods_id) ON DELETE CASCADE;
-- 장바구니 테이블 연관관계 설정
-- ALTER TABLE t_shopping_cart ADD FOREIGN key(member_id) REFERENCES t_shopping_member(member_id) ON DELETE CASCADE;
-- ALTER TABLE t_shopping_cart ADD FOREIGN key(goods_id) REFERENCES t_shopping_goods(goods_id) ON DELETE CASCADE;
-- 게시판 테이블 연관관계 설정
-- ALTER TABLE board ADD FOREIGN key(goods_id) REFERENCES t_shopping_goods(goods_id) ON DELETE CASCADE;
-- ALTER TABLE board ADD FOREIGN key(member_id) REFERENCES t_shopping_member(member_id) ON DELETE CASCADE;
-- ALTER TABLE board ADD FOREIGN key(cate) REFERENCES categories(cate) ON DELETE CASCADE;
--  게시판 댓글 테이블 연관관계
--  ALTER TABLE board_comment ADD FOREIGN key(member_id) REFERENCES t_shopping_member(member_id) ON DELETE CASCADE;
--  ALTER TABLE board_comment ADD FOREIGN key(brd_id) REFERENCES board(brd_id) ON DELETE CASCADE;
--  멤버 권한 연관관계 설정
-- ALTER TABLE member_auth ADD FOREIGN key(member_id) REFERENCES t_shopping_member(member_id) ON DELETE CASCADE;

