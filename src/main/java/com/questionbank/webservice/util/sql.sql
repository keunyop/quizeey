
-- VERSION
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('11', '1', '2019-08-31 기출문제', now(), now());
-- QUESTION
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '1', ' 다음 중 멀티미디어 기법에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '1', '1', ' 안티앨리어싱(Anti-Aliasing)은 2차원 그래픽에서 개체색상과 배경 색상을 혼합하여 경계면 픽셀을 표현함으로써 경계면을 부드럽게 보이도록 하는 기법이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '1', '2', ' 모델링(Modeling)은 컴퓨터 그래픽에서 명암, 색상, 농도의 변화 등과 같은 3차원 질감을 넣음으로써 사실 감을 더하는 기법을 말한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '1', '3', ' 디더링(Dithering)은 제한된 색을 조합하여 음영이나 색을 나타내는 것으로 여러 컬러의 색을 최대한 나타내는 기법을 말한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '1', '4', ' 모핑(Morphing)은 한 이미지가 다른 이미지로 서서히 변화하는 과정을 나타내는 기법이다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '2', ' 다음 중 초고속 인터넷을 이용하여 동영상 콘텐츠, 정보서비스 등 기본 텔레비전 기능에 인터넷 검색이 가능하게 한 서비스는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '2', '1', ' VoIP		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '2', '2', ' IPTV', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '2', '3', ' IPv6		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '2', '4', ' TCP/IP', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '3', ' 다음 중 컴퓨터 보안과 관련된 기술에 해당하지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '3', '1', ' 인증(Authentication)		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '3', '2', ' 암호화(Encryption)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '3', '3', ' 방화벽(Firewall)		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '3', '4', ' 브리지(Bridge)', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '4', ' 다음 중 정보 사회의 특징으로 적절하지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '4', '1', ' 처리하고자 하는 정보의 종류와 양이 증가하였다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '4', '2', ' 정보처리 기술의 발달로 사회의 변화 속도가 빨라졌다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '4', '3', ' 사이버 공간 상에 새로운 인간관계와 문화가 형성되었다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '4', '4', ' 대중화 현상이 강화되고 개성과 자유를 경시하게 되었다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '5', ' 다음 중 네트워크 구성 형태에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '5', '1', ' 망(Mesh)형은 응답 시간이 빠르고 노드의 연결성이 우수하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '5', '2', ' 성형(중앙 집중형)은 통신망의 처리 능력 및 신뢰성이 중앙 노드의 제어장치에 좌우된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '5', '3', ' 버스(Bus)형은 기밀 보장이 우수하고 회선 길이의 제한이 없다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '5', '4', ' 링(Ring)형은 통신회선 중 어느 하나라도 고장 나면 전체 통신망에 영향을 미친다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '6', ' 다음 중 컴퓨터와 같은 정보기기를 사용하기 위해서 반드시 설치되어야 하는 프로그램으로 가장 대표적인 시스템 소프트웨어는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '6', '1', ' 컴파일러		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '6', '2', ' 운영체제', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '6', '3', ' 유틸리티		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '6', '4', ' 라이브러리', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '7', ' 다음 중 웹 브라우저의 기능에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '7', '1', ' 인터넷 옵션에서 멀티미디어 편집기를 선택할 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '7', '2', ' 전자 우편을 보내거나 FTP 서버에 접속할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '7', '3', ' 웹 페이지를 사용자 컴퓨터에 저장하거나 인쇄할 수있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '7', '4', ' 자주 방문하는 웹 사이트 주소를 관리할 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '8', ' 다음 중 정보통신 시스템의 구성요소에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '8', '1', ' 데이터 전송 방식에는 클라이언트/서버 방식과 동배간 처리 방식이 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '8', '2', ' 데이터 전송계는 데이터의 이동을 담당하는 여러 장치들을 포함한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '8', '3', ' 데이터 처리계는 데이터 처리에 사용하는 하드웨어와 통신 소프트웨어가 해당된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '8', '4', ' 단말장치는 원격지에서 발생한 데이터의 송수신을 위한 장치로 에러 제어 기능이 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '9', ' 다음 중 컴퓨터 운영체제 운영방식에서 임베디드 시스템에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '9', '1', ' 제어가 필요한 시스템의 두뇌 역할을 하는 전자 시스템으로 TV, 냉장고 등의 가전제품에 많이 사용된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '9', '2', ' 처리할 데이터를 일정량 또는 일정시간 동안 모아서 한꺼번에 처리한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '9', '3', ' 마이크로프로세서에 특정 기능을 수행하는 응용프로그램을 탑재하여 컴퓨터 기능을 수행한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '9', '4', ' 하드웨어와 소프트웨어가 하나로 결합된 제어 시스템이다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '10', ' 다음 중 컴퓨터에서 사용하는 유니코드(Unicode)에 관한 설명으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '10', '1', ' 표현 가능한 문자수는 최대 256자이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '10', '2', ' 에러 검출이나 교정이 가능한 코드이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '10', '3', ' 연산을 빠르게 수행하기 위하여 Zone 비트와 Digit 비트로 구성한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '10', '4', ' 데이터의 처리나 교환을 위하여 1개 문자를 16비트로 표현한다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '11', ' 다음 중 자료의 구성 단위에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '11', '1', ' 데이터베이스(Database)는 관련된 데이터 파일들의 집합을 말한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '11', '2', ' 워드(Word)는 컴퓨터에서 한번에 처리할 수 있는 명령 단위를 나타낸다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '11', '3', ' 니블(Nibble)은 4개의 비트가 모여 1개의 니블을 구성한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '11', '4', ' 비트(Bit)는 정보의 최소 단위이며, 5비트가 모여 1바이트(Byte)가 된다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '12', ' 다음 중 컴퓨터 하드 디스크의 연결 방식인 SATA(Serial ATA)에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '12', '1', ' 병렬 인터페이스 방식이다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '12', '2', ' 핫 플러그인 기능을 지원한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '12', '3', ' CMOS에서 지정하면 자동으로 Master와 Slave가 지정 된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '12', '4', ' 데이터 전송 속도가 빠르다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '13', ' 다음 중 컴퓨터의 하드웨어를 업그레이드할 때 수치가 작을수록 좋은 항목은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '13', '1', ' CPU 클럭 속도	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '13', '2', ' 하드디스크 용량', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '13', '3', ' RAM 접근 속도	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '13', '4', ' 모뎀 전송 속도', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '14', ' 다음 중 플래시 메모리(Flash Memory)에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '14', '1', ' 정보의 입출력이 자유롭고, 전송속도가 빠르다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '14', '2', ' 비휘발성 기억장치이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '14', '3', ' 트랙 단위로 저장된다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '14', '4', ' 전력 소모가 적다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '15', ' 다음 중 Windows에서 사용되는 휴지통에 관한 설명으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '15', '1', ' 휴지통은 하드 디스크 드라이브마다 한 개씩 만들 수있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '15', '2', ' 지정된 휴지통의 용량이 초과되면 새로 삭제된 파일이나 폴더는 보관되지 않는다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '15', '3', ' 휴지통에 보관된 파일이나 폴더의 이름을 변경할 수있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '15', '4', ' 휴지통에서 원하는 파일이나 폴더를 선택하여 실행할 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '16', ' 다음 중 Windows 작업 표시줄의 점프 목록 사용에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '16', '1', ' 프로그램의 점프 목록을 보려면 작업 표시줄의 프로그램 아이콘을 마우스 오른쪽 단추로 클릭한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '16', '2', ' 점프 목록에서 항목을 열려면 프로그램의 점프 목록에서 해당 항목을 클릭한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '16', '3', ' 점프 목록에 항목을 고정하려면 프로그램의 점프 목록에서 항목을 가리킨 다음 압정 아이콘을 클릭한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '16', '4', ' 점프 목록에서 항목을 제거하려면 프로그램의 점프목록에서 항목을 가리킨 다음 ＜Delete＞ 키를 누른다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '17', ' 다음 중 Windows의 시스템 복원 기능에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '17', '1', ' 컴퓨터 시스템에 문제가 생겼을 경우 복원 지점을 이용하여 정상적인 상태로 만드는 기능이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '17', '2', ' 복원 지점은 시스템에 의해 자동으로 설정되지만 사용자가 임의로 복원 지점을 설정할 수도 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '17', '3', ' 시스템 복원은 개인 파일을 백업하지 않으므로 삭제되었거나 손상된 개인 파일은 복구할 수 없다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '17', '4', ' 시스템 복원 시 Windows Update에 의한 변경 사항은 복원되지 않는다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '18', ' 다음 중 유틸리티 프로그램에 대한 설명으로 적절하지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '18', '1', ' 다수의 작업이나 목적에 대하여 적용되는 편리한 서비스 프로그램이나 루틴을 말한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '18', '2', ' 컴퓨터의 동작에 필수적이고, 컴퓨터를 이용하는 주 목적에 대한 일부 특정 작업을 수행하는 소프트웨어들을 가리킨다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '18', '3', ' 컴퓨터 하드웨어, 운영 체제, 응용 소프트웨어를 관리하는 데 도움을 주도록 설계된 프로그램을 의미한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '18', '4', ' Windows에서 제공하는 유틸리티 프로그램으로는 메모장, 그림판, 계산기 등을 예로 들 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '19', ' 다음 중 Window에서 유해한 프로그램이나 불법 사용자가 컴퓨터 설정을 임의로 변경하려는 경우 이를 사용자에게 알려 컴퓨터를 제어할 수 있도록 도와주는 기능은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '19', '1', ' 사용자 계정 컨트롤		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '19', '2', ' Windows Defender', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '19', '3', ' BitLocker			', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '19', '4', ' 시스템 복원', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '20', ' 다음 중 Windows의 드라이브 최적화(디스크 조각모음) 기능에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '20', '1', ' 하드 디스크에 단편화되어 조각난 파일들을 모아준다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '20', '2', ' USB 플래시 드라이브와 같은 이동식 저장 장치도 조각화 될 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '20', '3', ' 수행 후에는 디스크 공간의 최적화가 이루어져 디스크의 용량이 증가한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '20', '4', ' 일정을 구성하여 드라이브 최적화(디스크 조각 모음)를 예약 실행할 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '23', ' 다음 중 정렬에 대한 설명으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '23', '1', ' 최대 24개의 열을 기준으로 정렬할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '23', '2', ' 글꼴 색을 기준으로 정렬할 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '23', '3', ' 정렬 대상 범위에 병합된 셀이 포함되어 있어도 정렬할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '23', '4', ' 숨겨진 행은 정렬 결과에 포함되나 숨겨진 열은 정렬결과에 포함되지 않는다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '25', ' 다음 중 채우기 핸들을 이용하여 데이터를 입력하는 방법으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '25', '1', ' 인접한 셀의 내용으로 현재 셀을 빠르게 입력할 때 위쪽 셀의 내용은 단축키 ＜Ctrl＞+＜D＞, 왼쪽 셀의 내용은 단축키 ＜Ctrl＞+＜R＞을 누른다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '25', '2', ' 숫자와 문자가 혼합된 문자열이 입력된 셀의 채우기 핸들을 아래쪽으로 끌면 문자는 복사되고 마지막 숫자는 1씩 증가한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '25', '3', ' 숫자가 입력된 셀의 채우기 핸들을 ＜Ctrl＞키를 누른 채 아래쪽으로 끌면 똑같은 내용이 복사되어 입력된다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '25', '4', ' 날짜가 입력된 셀의 채우기 핸들을 아래쪽으로 끌면 기본적으로 1일 단위로 증가하여 입력된다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '27', ' 다음 중 [찾기 및 바꾸기] 대화 창에서 찾을 내용에 만능 문자(와일드카드)인 '?' 나 '*' 문자 자체를 찾는 방법은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '27', '1', ' 찾으려는 만능 문자 앞·뒤에 큰따옴표(“”) 기호를 입력한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '27', '2', ' 찾으려는 만능 문자 앞에 퍼센트(%) 기호를 입력한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '27', '3', ' 찾으려는 만능 문자 앞에 느낌표(!) 기호를 입력한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '27', '4', ' 찾으려는 만능 문자 앞에 물결표(~) 기호를 입력한다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '29', ' 다음 중 매크로에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '29', '1', ' 같은 통합 문서 내에서 시트가 다르면 동일한 매크로 이름으로 기록할 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '29', '2', ' [매크로 기록] 대화상자에서 바로 가기 키 지정 시 영문 대문자를 사용하면 ＜Shift＞키가 자동으로 덧붙는다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '29', '3', ' 엑셀을 실행할 때마다 매크로를 사용할 수 있게 하려면 [매크로 기록] 대화상자에서 매크로 저장 위치를 '개인용 매크로 통합 문서'로 선택한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '29', '4', ' 통합 문서를 열 때 어떤 상황에서 어떤 매크로를 실행할지 매크로 보안 설정을 변경하여 제어할 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '34', ' 다음 중 찾기/참조 함수에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '34', '1', ' VLOOKUP 함수의 네 번째 인수를 'FALSE'로 사용하는 경우 참조 표의 첫 열의 값은 반드시 오름차순 정렬되어 있어야 한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '34', '2', ' HLOOKUP 함수는 참조 표의 첫 행에서 값을 찾을 때 대/소문자를 구분하지 않는다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '34', '3', ' INDEX 함수는 표나 범위에서 값 또는 값에 대한 참조를 반환한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '34', '4', ' CHOOSE 함수의 첫 번째 인수는 1에서 254 사이의 숫자를 나타내는 숫자나 수식, 셀 참조 등을 사용한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '35', ' 다음 중 셀 또는 셀 범위에 대한 이름 정의 시 구문규칙에 대한 설명으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '35', '1', ' 이름은 최대 255자까지 지정할 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '35', '2', ' 이름의 첫 자는 반드시 문자나 밑줄(_) 또는 슬래시(/)로 시작해야 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '35', '3', ' 이름의 일부로 공백을 사용할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '35', '4', ' Excel에서는 이름의 대문자와 소문자를 구별한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '36', ' 다음 중 워크시트의 화면 작업에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '36', '1', ' 범위를 선택한 후 값을 입력하고 ＜Alt＞+＜Enter＞ 키를 누르면 선택된 범위에 같은 값이 입력된다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '36', '2', ' ＜Ctrl＞ 키를 누른 상태에서 마우스 휠을 돌리면 화면이 확대/축소된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '36', '3', ' ＜Enter＞ 방향키가 아래쪽일 때 ＜Shift＞+＜Enter＞ 키를 누르면 셀 포인터가 위쪽 셀로 이동된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '36', '4', ' ＜ScrollLock＞ 키를 누른 후 방향키를 누르면 셀 포인터는 고정된 상태로 화면만 이동된다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '37', ' 다음 중 각 차트에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '37', '1', ' 꺾은선형 차트: 일정 간격에 따라 데이터의 추세를 나타내기에 적합하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '37', '2', ' 원형 차트: 전체에 대한 각 부분의 관계를 보여주며, 여러 데이터 계열이 각각의 고리로 표시된다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '37', '3', ' 방사형 차트: 각 데이터 요소의 중간 지점에 대한 값의 변화를 보여주며, 여러 데이터 계열의 집계 값을 비교하기에도 용이하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '37', '4', ' 분산형 차트: 여러 데이터 계열에 있는 숫자 값 사이의 관계를 보여주거나 두 개의 숫자 그룹을 xy 좌표로 이루어진 하나의 계열로 표시한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('11', '1', '39', ' 다음 중 [인쇄 미리 보기 및 인쇄] 상태에서의 [페이지설정] 대화상자에 대한 설명으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '39', '1', ' 눈금선이나 행/열 머리글의 인쇄 여부를 설정할 수 없다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '39', '2', ' 인쇄 영역이나 인쇄 제목으로 반복할 행 또는 반복할 열을 설정할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '39', '3', ' 인쇄 배율을 수동으로 설정할 수 있고, 배율은 워크시트 표준 크기의 '10%'에서 '200%'까지 가능하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('11', '1', '39', '4', ' 배율을 '자동 맞춤'으로 선택하고 용지 너비와 용지높이를 '1'로 지정하는 경우 여러 페이지가 한 페이지에 출력되도록 확대/축소 배율이 자동으로 조정 된다.', 'Y', now(), now());

