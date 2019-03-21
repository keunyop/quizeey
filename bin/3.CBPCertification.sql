-- TEST
insert into test (test_nm, created_date, modified_date) values ('CBP Certification – 개발자', now(), now());

-- VERSION
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('3', '1', '아키텍처', now(), now());
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('3', '2', '공통', now(), now());
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('3', '3', '상품', now(), now());
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('3', '4', '액터', now(), now());
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('3', '5', '계약', now(), now());
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('3', '6', '정산', now(), now());

-- Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '1', '1', 'BXM 프레임워크는 채널에 대한 다양한 요구를 수용하면서, 표준화된 개발 환경을 제공한다. 제공하는 기능이 아닌것은?', 'BXM 프레임워크는 채널에 대한 다양한 요구를 수용하면서, 표준화된 개발 환경을 제공한다. 또한 센터컷, 배치, 후행, 스케줄러 등을 제공한다.', 'https://drive.google.com/file/d/1P3Ga8sYvExyHnj4LvhtlhJdnKLGHY62u/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '1', '1', '센터컷', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '1', '2', '배치', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '1', '3', '후행', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '1', '4', '블록체인', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '1', '5', '스케줄러', 'false', now(), now());

-- Q2
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '1', '2', 'BwG 코어뱅킹 솔로션의 주요 기능이 아닌것은?', '주요 기능은 다음과 같다. 1. BXM 프레임워크는 채널에 대한 다양한 요구를 수용하면서, 죠준화된 개발 환경을 제공한다. 또한 센터컷, 배치, 후행, 스케줄러 등을 제공한다. 2. 다양한 상품 요구를 수용하는 BX PF는 상품을 설계, 개발한 후 BX CBP의 상품으로 배포한다. 3. BX CBP는 업무 기능 컴포넌트인 BX CBB를 제공하여, 고객이 요구하는 서비스를 유연하고 빠르게 개발 할 수 있다.', 'https://drive.google.com/file/d/1P3Ga8sYvExyHnj4LvhtlhJdnKLGHY62u/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '2', '1', '고객사의 부가가치를 높여준다.', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '2', '2', 'CBB를 활용하여 고객이 요구하는 서비스를 유연하고 빠르게 개발한다.', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '2', '3', '다양한 상품 요구를 수용한다.', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '2', '4', 'BXM 프레임워크는 채널에 대한 다양한 요구를 수용하면서, 표준화된 개발 환경을 제공한다.', 'false', now(), now());

-- Q3
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '1', '3', 'PF의 특/장점이 아닌것은?', 'PF의 특/장점은 다음과 같다. 1. 독립적인 상품정보 관리, 2. 제약 없는 상품(조건) 확장, 3. 신속한 상품 출시, 4. 검증된 국내/외 사례', 'https://drive.google.com/file/d/1P3Ga8sYvExyHnj4LvhtlhJdnKLGHY62u/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '3', '1', '머신러닝을 통한 상품 추천', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '3', '2', '독립적인 상품정보 관리', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '3', '3', '제약 없는 상품(조건) 확장', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '3', '4', '신속한 상품 출시', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '3', '5', '검증된 국내/외 사례', 'false', now(), now());

-- Q4
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '1', '4', 'CBP의 특/장점이 아닌것은?', 'CBP의 특/장점은 다음과 같다. 1. 조립식 서비스 신규(Assemblable), 2. 데이터 정의에 의한 용건 대응(Configurable), 3. Plug-In 방식의 신규요건 대응 (Pluggable), 4. 표준화된 개발/운영 방식(Standardized)', 'https://drive.google.com/file/d/1P3Ga8sYvExyHnj4LvhtlhJdnKLGHY62u/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '4', '1', 'Standardized', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '4', '2', 'Comments', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '4', '3', 'Assemblable', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '4', '4', 'Configurable', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '4', '5', 'Pluggable', 'false', now(), now());

-- Q5
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '1', '5', 'CBP(Core Banking Package)는 서비스 및 기본 구성 요소 및 구성 센터가 표함 된 핵심 뱅킹 패키지 응용 프로그램이다.', 'CBP(Core Banking Package)는 서비스 및 기본 구성 요소 및 구성 센터가 표함 된 핵심 뱅킹 패키지 응용 프로그램이다.', 'https://drive.google.com/file/d/1P3Ga8sYvExyHnj4LvhtlhJdnKLGHY62u/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '5', '1', 'True', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '5', '2', 'False', 'false', now(), now());

-- Q6
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '1', '6', '다음은 CBP 특/장점 중 무엇을 뜻하는가? "느슨한 구조를 가진 잘 구조화된 컴포넌트의 기능을 조합 하는 것 만으로 새로운 업무 서비스를 작성 할 수 있다."', 'Assemblable - 느슨한 구조를 가진 잘 구조화된 컴포넌트의 기능을 조합 하는 것 만으로 새로운 업무 서비스를 작성 할 수 있다.', 'https://drive.google.com/file/d/1P3Ga8sYvExyHnj4LvhtlhJdnKLGHY62u/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '6', '1', 'Assemblable', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '6', '2', 'Configurable', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '6', '3', 'Pluggable', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '6', '4', 'Standardized', 'false', now(), now());

-- Q7
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '1', '7', '다음은 CBP 특/장점 중 무엇을 뜻하는가? "이미 만들어진 기능을 수정하지 않고 원하는 새로운 기능으로 대체 하거나 수정 할 수 있다."', 'Pluggable - 이미 만들어진 기능을 수정하지 않고 원하는 새로운 기능으로 대체 하거나 수정 할 수 있다.', 'https://drive.google.com/file/d/1P3Ga8sYvExyHnj4LvhtlhJdnKLGHY62u/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '7', '1', 'Assemblable', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '7', '2', 'Configurable', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '7', '3', 'Pluggable', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '7', '4', 'Standardized', 'false', now(), now());

-- Q8
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '1', '8', '프레임워크의 영역 중 Pre Service의 역할이 아닌것은?', 'Pre service의 역할 - 입력항목 DTO 변환, 서비스 권한 검증, 입력항목 검증(기본+확장), 서비스 제한/제어 검증', 'https://drive.google.com/file/d/1P3Ga8sYvExyHnj4LvhtlhJdnKLGHY62u/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '8', '1', '입력항목 검증 (기본 + 확장)', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '8', '2', '서비스 제한/제어 검증', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '8', '3', '서비스 유효성 검증', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '8', '4', '입력항목 DTO 변환', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '8', '5', '서비스 권한 검증', 'false', now(), now());

-- Q9
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '1', '9', '프레임워크의 영역 중 Main Service의 역할이 아닌것은?', 'Main service의 역할 - 서비스 유효성 검증, 서비스 처리 흐름 제어 로직, 베이스 기능을 이용만 함, DB접근이 불가능', 'https://drive.google.com/file/d/1P3Ga8sYvExyHnj4LvhtlhJdnKLGHY62u/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '9', '1', '서비스 처리 흐름 제어 로직', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '9', '2', '베이스 기능을 이용만 함', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '9', '3', 'DB접근이 가능', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '9', '4', '서비스 유효성 검증', 'false', now(), now());

-- Q10
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '1', '10', '프레임워크의 영역 중 Post Service의 역할이 아닌것은?', 'Post service의 역할 - 분개 및 분개검증, 포지션 처리, 텔러 거래내역, 시제 갱신, 거래로그 생성, Transactional Logic(commit, role back)', 'https://drive.google.com/file/d/1P3Ga8sYvExyHnj4LvhtlhJdnKLGHY62u/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '10', '1', '포지션 처리', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '10', '2', '텔러 거래내역, 시제 갱신', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '10', '3', '거래로그 생성', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '10', '4', 'Transactional Logic (commit, role back)', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '10', '5', '서비스 처리 흐름 제어 로직', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '10', '6', '분개 및 분개검증', 'false', now(), now());

-- Q11
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '1', '11', '다음은 CBP 특/장점 중 무엇을 뜻하는가? "파라미터나 처리규칙을 설정 하는 것 만으로 이미 만들어진 기능을 수정하지 않고 원하는 새로운 기능으로 대체 하거나 변경 할 수 있다."', 'Configurable - 파라미터나 처리규칙을 설정 하는 것 만으로 이미 만들어진 기능을 수정하지 않고 원하는 새로운 기능으로 대체 하거나 변경 할 수 있다.', 'https://drive.google.com/file/d/1P3Ga8sYvExyHnj4LvhtlhJdnKLGHY62u/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '11', '1', 'Assemblable', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '11', '2', 'Configurable', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '11', '3', 'Pluggable', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '11', '4', 'Standardized', 'false', now(), now());

-- Q12
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '1', '12', '어플리케이션은 크게 2개의 컴포넌트, Service와 Base로 구분되어 진다.', '어플리케이션은 크게 2개의 컴포넌트(Service, Base)로 구분되며, 5개의 레이어(Service, BizProc, BO, DSO, DAO) 구조를 가지고 있다.', 'https://drive.google.com/file/d/1P3Ga8sYvExyHnj4LvhtlhJdnKLGHY62u/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '12', '1', 'True', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '12', '2', 'False', 'false', now(), now());

-- Q13
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '1', '13', '어플리케이션을 이루고 있는 레이어가 아닌것은?', '어플리케이션은 크게 2개의 컴포넌트(Service, Base)로 구분되며, 5개의 레이어(Service, BizProc, BO, DSO, DAO) 구조를 가지고 있다.', 'https://drive.google.com/file/d/1P3Ga8sYvExyHnj4LvhtlhJdnKLGHY62u/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '13', '1', 'Service', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '13', '2', 'BizProc', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '13', '3', 'BO', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '13', '4', 'DSO', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '13', '5', 'DAO', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '13', '6', 'DB', 'true', now(), now());

-- Q14
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '1', '14', '다음중 설명이 잘못 짝지어진 레이어는?', 'Service Layer - 독립적인 단위의 기능 제공, BizProc Layer - 공통 또는 복잡한 로직(필수 아님), Domain Layer - 핵심 업무 기능 제공(Base API), DS Layer - BO와 DAO 사이에서 다중 DBMS의 지원, DA Layer - Java Interface와 SQL을 포함하는 Mapper로 구성', 'https://drive.google.com/file/d/1P3Ga8sYvExyHnj4LvhtlhJdnKLGHY62u/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '14', '1', 'Service Layer - 독립적인 단위의 기능 제공', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '14', '2', 'BizProc Layer - 공통 또는 복잡한 포직 (필수 아님)', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '14', '3', 'Domain Layer - 핵심 업무 기능 제공. Base API', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '1', '14', '4', 'DS Layer - Java Interface와 SQL을 포함하는 Mapper로 구성', 'true', now(), now());

-- Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '2', '1', '채번을 하기 위한 방법으로 잘못된 것은?', '채번을 하기 위해 방법으로 시퀀스 사용, 테이블 사용, 별도 트랜잭션 사용 중에 한가지를 선택할 수 있다.<br>또한 복잡한 규칙을 적용하여 채번을 하기 위하여, 별도의 채번클래스를 plug-in 할 수 있는 기반이 마련되어있다.', 'https://drive.google.com/file/d/149H3O_OvTgrOpn5bOhdJMfs8eE7qhJRD/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '2', '1', '1', '시퀀스 사용', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '2', '1', '2', 'Timestamp 사용', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '2', '1', '3', '별도 트랜잭션 사용', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '2', '1', '4', '별도의 채번 클래스 plug-in', 'false', now(), now());

-- Q2
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '2', '2', '사전에서 관리하지 않는 항목은?', '사전으로 관리하는 항목은?<br>- 단어, 복합단어, 도메인 등의 메타정보를 관리함<br>- 각 유형별 다국어 정보도 사전의 항목으로 관리함', 'https://drive.google.com/file/d/149H3O_OvTgrOpn5bOhdJMfs8eE7qhJRD/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '2', '2', '1', '테이블명', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '2', '2', '2', '복합단어', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '2', '2', '3', '도메인', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '2', '2', '4', '다국어', 'false', now(), now());

-- Q3
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '2', '3', '중요 증서가 아닌 것은?', '중요증서란 은행에서 특별히 관리가 필요할 만큼 중요한 증서를 의미하며, 통상적으로 현금은 아니지만 현금과 밀접한 관련이 있는 통장, 수표, 예금증서, 수입인지 등을 의미한다.', 'https://drive.google.com/file/d/149H3O_OvTgrOpn5bOhdJMfs8eE7qhJRD/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '2', '3', '1', '통장', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '2', '3', '2', '현금', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '2', '3', '3', '예금증서', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '2', '3', '4', '수입인지', 'false', now(), now());

-- Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '3', '1', '상품 조건의 유형이 아닌것은?', '조건은 상품을 구성하는 가장 작은 단위로 목록형, 범위형, 금리형, 수수료형 4가지 유형으로 구성된다. ', 'https://drive.google.com/file/d/1lFWNmya5EPF6KaW8n4Fv1LipW400WEQK/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '3', '1', '1', '목록형', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '3', '1', '2', '세금형', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '3', '1', '3', '금리형', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '3', '1', '4', '수수료형', 'false', now(), now());

-- Q2
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '3', '2', '상품팩토리 솔루션의 주요 특징 중 맞는 것을 모두 고르시오.', '유연한 데이터 구조, 상품템플릿기반 상품개발체계, 상품정의 용이, 상품정보 일관성 보장, 표준 API 제공', 'https://drive.google.com/file/d/1lFWNmya5EPF6KaW8n4Fv1LipW400WEQK/view', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '3', '2', '1', '유연한 데이터 구조', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '3', '2', '2', '배포 후 롤백 기능', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '3', '2', '3', '상품템플릿기반 상품개발체계', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '3', '2', '4', '상품 맞춤 추천 제공', 'false', now(), now());

-- Q3
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '3', '3', '상품별 해쉬태그를 정의할 수 있다.', '', 'https://drive.google.com/file/d/1lFWNmya5EPF6KaW8n4Fv1LipW400WEQK/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '3', '3', '1', 'True', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '3', '3', '2', 'False', 'false', now(), now());

-- Q4
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '3', '4', '상품 정의 화면에서 검은색 조건은 값이 정의 되어 있고 회색은 값이 정의되어 있지 않다.', '', 'https://drive.google.com/file/d/1lFWNmya5EPF6KaW8n4Fv1LipW400WEQK/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '3', '4', '1', 'True', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '3', '4', '2', 'False', 'false', now(), now());

-- Q5
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '3', '5', '상품코드의 자릿수는 변경할 수 없다.', '', 'https://drive.google.com/file/d/1lFWNmya5EPF6KaW8n4Fv1LipW400WEQK/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '3', '5', '1', 'True', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '3', '5', '2', 'False', 'true', now(), now());

-- Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '4', '1', '액터 베이스 컴포넌트가 관리하는 정보가 아닌 것은?', '액터 베이스 컴포넌트는 고객, 스태프, 파트너, 부서, 통지 관련 정보 및 기능 관리를 담당', 'https://drive.google.com/file/d/1w6dpbH4jiT_h3NRsQnTQCpnLdjnK_5wS/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '4', '1', '1', '부동산', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '4', '1', '2', '스태프', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '4', '1', '3', '파트너', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '4', '1', '4', '부서', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '4', '1', '5', '통지', 'false', now(), now());

-- Q2
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '4', '2', '개인은 고객도 될 수 있고, 스태프도 될 수 있고, 파트너도 될 수 있다.', '개인은 고객도 될 수 있고, 스태프도 될 수 있고, 파트너도 될 수 있음', 'https://drive.google.com/file/d/1w6dpbH4jiT_h3NRsQnTQCpnLdjnK_5wS/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '4', '2', '1', 'True', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '4', '2', '2', 'False', 'false', now(), now());

-- Q3
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '4', '3', '액터의 유형이 아닌것은?', '액터의 유형<br>	개인: 자영인(내/외국인, 제외동포)<br>	개인사업자: 국세청에서 사업자등록증을 발급받은 개인<br>	법인: 법적으로 법인격을 부여받은 사단과 재단<br>	법인사업자: 사업자등록증을 발급받은 법인(영리, 비영리, 국가, 지자체)<br>	임의단체: 법인이 아닌 임의 단체(동창회, 납세번호 유/무 단체로 구분)<br>', 'https://drive.google.com/file/d/1w6dpbH4jiT_h3NRsQnTQCpnLdjnK_5wS/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '4', '3', '1', '개인', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '4', '3', '2', '개인사업자', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '4', '3', '3', '법인', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '4', '3', '4', '법인차량', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '4', '3', '5', '임의단체', 'false', now(), now());

-- Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '5', '1', '계약 베이스 컴포넌트에서 관리하는 계약의 종류가 아닌것은?', '계약 베이스 컴포넌트에서 관리하는 계약의 종류는 수신/여신등 상품 계약, 회원 계약, 거래성 계약, 포인트 계약, 가맹점 계약, 결제 계약, 심사 계약, 내부 계약 이다.', 'https://drive.google.com/file/d/1AVsJ2n_v9cgFLmnfdG5XcJtnsEVnlRDI/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '5', '1', '1', '상품 계약', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '5', '1', '2', '회원 계약', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '5', '1', '3', '거래성 계약', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '5', '1', '4', '외부 계약', 'true', now(), now());

-- Q2
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '5', '2', '계약에서 관리하는 정보가 아닌것은?', '계약에서 관리하는 정보는 계약기본정보, 계약조건정보, 계약관계정보, 계약확장정보 이다.', 'https://drive.google.com/file/d/1AVsJ2n_v9cgFLmnfdG5XcJtnsEVnlRDI/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '5', '2', '1', '계약배포정보', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '5', '2', '2', '계약조건정보', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '5', '2', '3', '계약관계정보', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '5', '2', '4', '계약확장정보', 'false', now(), now());

-- Q3
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '5', '3', '다음 계약의 생명주기 중 계좌번호가 채번되는 시점은 언제인가?', '계좌번호, 신규일, 만기일은 계좌가 활동되는 시점에 그 값이 결정된다.', 'https://drive.google.com/file/d/1AVsJ2n_v9cgFLmnfdG5XcJtnsEVnlRDI/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '5', '3', '1', '여신 신청', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '5', '3', '2', '여신 승인', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '5', '3', '3', '여신 실행', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '5', '3', '4', '여신 해지', 'false', now(), now());

-- Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '6', '1', '정산 베이스 컴포넌트가 담당하지 않는 기능은?', '정산 베이스 컴포넌트는 계약관련 거래의 거래내역관리, 손익내역관리, 잔액관리, 이자계산, 세금계산, 회계처리용 일계조립 기능을 담당한다.', 'https://drive.google.com/file/d/1e4zHfdCc1m6mh-_yEjdw2V2lh76TRWVm/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '6', '1', '1', '거래내역관리', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '6', '1', '2', '일계조립', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '6', '1', '3', '잔액관리', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '6', '1', '4', '수수료계산', 'true', now(), now());

-- Q2
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '6', '2', '정산에서 관리하는 잔액이 아닌것은?', '금액뿐만 아니라 건수도 잔액형태로 제공한다.', 'https://drive.google.com/file/d/1e4zHfdCc1m6mh-_yEjdw2V2lh76TRWVm/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '6', '2', '1', '계좌의 현재 잔액', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '6', '2', '2', '인출가능 금액', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '6', '2', '3', '계좌의 총 이자지급 횟수', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '6', '2', '4', '상품 판매 한도금액', 'true', now(), now());

-- Q3
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('3', '6', '3', '잔액유형이 관리하지 않는 정보는?', '', 'https://drive.google.com/file/d/1e4zHfdCc1m6mh-_yEjdw2V2lh76TRWVm/view', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '6', '3', '1', '잔액 상품코드', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '6', '3', '2', '잔액 갱신 방법', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '6', '3', '3', '잔액 갱신 여부 판단 프로그램', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('3', '6', '3', '4', '잔액 초기화 주기', 'false', now(), now());


