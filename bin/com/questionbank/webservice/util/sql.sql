
-- VERSION
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('15', '1', '2019-08-31 기출문제', now(), now());
-- QUESTION
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '1', ' 다음 중 워드프로세서의 특징에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '1', '1', ' 작성한 문서를 다른 응용 프로그램에서 불러와 편집할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '1', '2', ' 작성 중인 문서를 포토샵 파일(*.PDS)이나 동영상 파일(*.WMV)로 저장할 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '1', '3', ' 작성한 문서에 암호를 부여하여 저장할 수 있어 보안 유지가 가능하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '1', '4', ' 작성한 문서를 메일, 팩시밀리, 모바일 등을 이용하여 쉽게 전송할 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '2', ' 다음 중 워드프로세서에서 문서를 작성할 때 금칙 처리에 관한 설명으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '2', '1', ' 특정한 기호가 행의 마지막 또는 행의 처음에 나타나지 않도록 하는 것이다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '2', '2', ' 입력되는 단어가 길어서 동일한 줄에 입력되지 않을 경우 다음 줄로 이동하여 나타나도록 하는 것이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '2', '3', ' 문서 인쇄 시 특정한 글자나 기호가 인쇄되지 않도록 하는 것이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '2', '4', ' 특정한 서체를 작성 중인 문서에서 사용할 수 없도록 하는 것이다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '3', ' 다음 중 워드프로세서에서 인쇄 기능에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '3', '1', ' 인쇄 전 미리보기 기능을 이용하여 여백 보기 등을 통해 문서의 윤곽을 미리 확인할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '3', '2', ' 모아 찍기 기능을 이용하여 문서 한 장에 여러 페이지를 인쇄할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '3', '3', ' 그림 워터마크와 글씨 워터마크를 설정하여 인쇄할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '3', '4', ' 파일로 인쇄하면 확장자가 .hwp 또는 .doc인 파일로 저장된다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '4', ' 다음 중 워드프로세서의 메일 머지(Mail Merge) 기능에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '4', '1', ' 메일 머지를 수행하기 위해서는 데이터 파일과 서식파일이 필요하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '4', '2', ' 데이터 파일은 서식 파일에 대입될 개인별 이름이나 주소 등을 담고 있는 파일이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '4', '3', ' 서식 파일은 메일 머지 되어 나올 내용에서 공통적으로 들어갈 본문 내용을 기재한 파일이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '4', '4', ' 메일 머지에 쓸 수 있는 서식 파일에는 윈도우의 주소록과 Outlook 주소록, 한글 파일, 엑셀 파일 등이 있다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '5', ' 다음 중 맞춤법 검사(Spelling Check)에 대한 설명으로 올바른 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '5', '1', ' 수식과 화학식도 맞춤법 검사를 할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '5', '2', ' 자주 틀리는 단어는 자동으로 수정되도록 지정할 수있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '5', '3', ' 문서의 특정부분만 검사할 수는 없다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '5', '4', ' 맞춤법 외에 문법적인 오류는 고칠 수 없다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '6', ' 다음 중 워드프로세서의 용어에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '6', '1', ' 옵션(Option) : 어떤 기능에 대한 지시를 부여하거나 지시할 때 선택할 수 있는 항목을 말한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '6', '2', ' 마진(Margin) : 문서의 균형을 위해 비워두는 페이지의 상 • 하 • 좌 • 우 공백을 말한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '6', '3', ' 센터링(Centering) : 문서의 중심을 비우고 문서의 내용을 정렬하는 기능이다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '6', '4', ' 캡션(Caption) : 문서에 포함된 표나 그림에 붙이는 제목 또는 설명이다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '7', ' 다음 중 워드프로세서의 정렬(Align) 기능에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '7', '1', ' 문서의 내용을 가, 나, 다 … 혹은 1, 2, 3 … 형태로 크기 순서에 따라 나열하는 것이다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '7', '2', ' 하나의 문단은 영역 지정이 없어도 정렬이 가능하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '7', '3', ' 영역 지정 기능을 사용하면 문서 전체에 대해서 한꺼번에 정렬할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '7', '4', ' 정렬 방식으로는 왼쪽 정렬, 오른쪽 정렬, 가운데 정렬, 양쪽 정렬 등이 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '8', ' 다음 중 워드프로세서의 화면 표시 기능과 관련된설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '8', '1', ' 눈금자를 사용하면 왼쪽과 오른쪽 여백, 들여쓰기, 내어쓰기, 탭 설정 여부 등을 표시할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '8', '2', ' 상태 표시줄에는 커서가 있는 쪽 번호, 커서 위치, 삽입 또는 수정 상태, 자판의 종류 등의 정보를 표시한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '8', '3', ' 문서를 작성할 때 화면을 상 • 하 • 좌 • 우로 이동하는 기능을 스크롤(Scroll)이라고 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '8', '4', ' 작업 화면의 표준 도구 모음에는 제어 상자, 제목, 창 조절 단추 등이 표시된다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '9', ' 다음 중 전자출판에 사용되는 용어에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '9', '1', ' 오버 프린트(Over Print) : 대상체의 컬러가 배경색의 컬러보다 짙을 때에 겹쳐서 인쇄하는 방법이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '9', '2', ' 필터링(Filtering) : 그림의 제한된 색상을 조합하여 복잡한 색이나 새로운 색을 만드는 작업이다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '9', '3', ' 워터마크(Watermark) : 그림을 명암 대비가 작은 그림으로 바꾸는 것으로 기관의 로고 등을 작성하여 배경을 희미하게 나타낼 때 사용한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '9', '4', ' 초크(Choke) : 이미지 변형 작업으로 채도, 조명도, 명암 등을 조절해 주는 기능이다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '10', ' 다음 중 문서의 수정을 위한 교정 부호의 표기법으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '10', '1', ' 문서의 내용과 혼돈되지 않도록 글자 색과 동일한 색으로 표기하도록 한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '10', '2', ' 한번 교정된 부분도 다시 교정할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '10', '3', ' 교정하고자 하는 글자를 명확하게 지적해야 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '10', '4', ' 여러 교정부호를 동일한 행에 사용할 때 교정부호가 겹치지 않도록 한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '12', ' 다음 중 문서의 폐기에 관한 설명으로 가장 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '12', '1', ' 보존기간이 경과한 문서는 즉시 폐기처분한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '12', '2', ' 비밀문서는 반드시 문서세단기를 이용하거나 폐기전문업체를 이용한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '12', '3', ' 문서를 폐기할 때는 보존문서 기록대장에 폐기사실을 기입하고 폐기인을 날인한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '12', '4', ' 폐기할 문서가 다시 필요할 지에 대한 검토를 할 필요는 없다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '13', ' 다음 중 문서관리 시 확보해야 할 원칙에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '13', '1', ' 문서관리를 담당하는 전문 인력을 배치하여 전문성을 높인다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '13', '2', ' 문서 처리 절차나 방법 중에서 반복되는 것이나 불필요한 것은 없애고 간결하게 처리한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '13', '3', ' 가능한 한 문서를 옮겨 적거나 세밀하게 기재하고 문서의 경유처는 최대한 모두 경유하게 한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '13', '4', ' 문서 관리 시 발생하는 여러 가지 수단이나 방법중에서 가장 합리적인 것을 선정하여 적용한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '14', ' 다음에 설명하는 문서정리방법을 나타내는 용어로 가장 적절한 것은?<br><br>    - 같은 카테고리의 문서를 한 곳에 모을 수 있다.<br><br>	- 문서 내용의 분류가 여러개인 경우 상호참조표시가 필요하다.<br><br>	- 문서가 소분류로 구분되어 취급되는 경우에 많이 활용된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '14', '1', ' 번호식 분류법	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '14', '2', ' 지역별 분류법', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '14', '3', ' 주제별 분류법	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '14', '4', ' 수평적 분류법', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '15', ' 다음 설명에 해당하는 용어는 무엇인가?<br><br>	주문서, 납품서, 청구서 등 무역에 필요한 각종 서류를 표준화된 양식을 통해 전자적 신호로 바꿔 컴퓨터통신망을 이용, 거래처에 전송하는 시스템이다. 기존의 서류를 통한 업무 처리와는 달리 컴퓨터를 이용하여 사무실에서 빠르고 간편하게 업무를 처리할 수 있다. 기업 간의 거래 데이터를 교환하기 위한 표준 포맷이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '15', '1', ' ERP		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '15', '2', ' EDI', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '15', '3', ' EDMS		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '15', '4', ' CALS', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '16', ' 다음 중 공문서의 기안에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '16', '1', ' 기안 문서는 전자 문서로 하는 것을 원칙으로 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '16', '2', ' 각종 증명 발급이나, 회의록 등은 발의자와 보고자의 표시를 생략할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '16', '3', ' 행정기관명을 표시할 때 다른 행정기관명과 동일한 경우 바로 아래 하급기관명을 함께 표시할 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '16', '4', ' 수신자가 없는 내부결재문서인 경우 수신란에 '내부결재'로 표시한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '17', ' 다음 중 글자 모양에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '17', '1', ' 아웃라인 글꼴에는 비트맵, 트루타입, 벡터, 포스트 스크립트, 오픈 타입 등이 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '17', '2', ' 일반적인 워드프로세서에서의 글자 크기 단위는 보통 포인트(point)로 표시한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '17', '3', ' 첨자 문자는 전각문자의 1/4 크기의 문자이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '17', '4', ' 장평은 글자의 가로 폭을 늘리거나 줄여서 글자에 변화를 주는 것이다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '18', ' 다음 사외문서의 구성에 대한 설명 중 두문에 해당하지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '18', '1', ' 제목은 문서 내용을 파악할 수 있도록 본문 내용을 간추려 표시한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '18', '2', ' 수신자명은 직위와 성명을 표시한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '18', '3', ' 발신연월일은 숫자 뒤에 년, 월, 일을 붙여 표시할 수있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '18', '4', ' 발신자명은 문서 발신자의 성명을 표시한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '19', ' 용지규격 A4의 사이즈는 210*297(mm)이다. 그렇다면 A3와 A5사이즈의 가로*세로 크기(mm)로 바르게 나열된 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '19', '1', ' A3: 297*420, A5: 148*210', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '19', '2', ' A3: 148*210, A5: 105*148', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '19', '3', ' A3: 257*364, A5: 182*128', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '19', '4', ' A3: 728*515, A5: 594*420', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '20', ' 다음 중 공문서의 효력 발생 시기에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '20', '1', ' 효력 발생 시기란 문서를 실질적으로 영향을 미치는 시기를 의미한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '20', '2', ' 우리나라는 문서가 수신된 시기 효력이 발생하는 도달주의를 채택하고 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '20', '3', ' 공고문서의 경우에는 고시나 공고 즉시 효력이 발생한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '20', '4', ' 전자문서의 경우에는 수신자의 컴퓨터 파일로 기록된 시기에 효력이 발생한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '21', ' 다음 중 한글 Windows 7의 시작 메뉴에 있는 [시스템종료] 단추의 펼침 메뉴에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '21', '1', ' 사용자 전환: 현재 로그온 한 사용자 계정 작업 상태를 그대로 두고 다른 사용자의 계정으로 전환하여 컴퓨터에 손쉽게 로그온할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '21', '2', ' 로그오프: 사용하던 프로그램은 모두 닫히지만 컴퓨터는 꺼지지 않는다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '21', '3', ' 잠금: 사용 중인 사용자 계정에 암호가 설정되어 있는 경우 컴퓨터를 켜놓은 상태로 잠그면 사용자 암호를 입력해야만 잠금을 해제할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '21', '4', ' 다시 시작: 변경된 Windows 설정을 저장하고 메모리에 있는 모든 정보를 이동식 디스크에 저장한 후에 시스템을 다시 시작한다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '22', ' 다음 중 한글 Windows 7에서 사용되는 [Windows 도움말 및 지원] 창에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '22', '1', ' 도움말은 하이퍼텍스트 방식으로 제공되어 관련 항목의 도움말로 이동이 용이하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '22', '2', ' 제목별로 검색할 수 있으며, 도움말의 내용을 사용자가 수정할 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '22', '3', ' 도움말을 보다가 표시된 응용 프로그램을 실행하거나 인터넷 페이지로 이동할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '22', '4', ' 원격 지원이나 온라인 기술지원을 통하여 도움을 요청할 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '23', ' 다음 중 한글 Windows 7의 바탕 화면에 있는 폴더 아이콘의 바로 가기 메뉴를 사용하여 할 수 있는 작업으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '23', '1', ' 바탕 화면에 해당 폴더의 새로운 바로 가기 아이콘을 만들 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '23', '2', ' 바로 이전에 삭제한 폴더를 복원할 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '23', '3', ' 공유 대상 폴더를 설정할 수 있으며, 동기화할 수있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '23', '4', ' 해당 폴더의 속성을 재설정할 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '24', ' 다음 중 한글 Windows 7에서 바로 가기 아이콘에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '24', '1', ' 바로 가기 아이콘은 하나의 프로그램 아이콘에 대해 한 개만 만들 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '24', '2', ' 바로 가기 아이콘에는 왼쪽 아래에 꺾인 화살표가 표시된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '24', '3', ' 바로 가기 아이콘은 프로그램을 빠르게 실행하기 위해 만들어 사용하는 것이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '24', '4', ' 폴더, 프린터, 디스크 드라이브 등에 대해 바로 가기 아이콘을 만들 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '25', ' 다음 중 한글 Windows 7의 화면 보호기에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '25', '1', ' 사용자 계정에 암호가 설정되어 있지 않아도 화면보호기의 암호를 사용할 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '25', '2', ' 일정 시간 모니터에 전달되는 정보에 변화가 없을 때 화면보호기가 작동되게 설정한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '25', '3', ' 화면보호기는 마우스를 움직이거나 키보드에서 임의의 키를 누르면 해제된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '25', '4', ' 대기 시간, 다시 시작할 때 로그온 화면표시를 지정할 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '26', ' 다음 중 한글 Windows 7에서 파일이나 폴더의 복사 또는 이동에 사용되는 클립보드에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '26', '1', ' 클립보드를 사용하면 서로 다른 응용 프로그램 간에 데이터를 쉽게 전달할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '26', '2', ' 클립보드에 저장된 내용은 시스템을 다시 시작하더라도 재사용이 가능하다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '26', '3', ' 클립보드의 내용은 여러 번 사용이 가능하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '26', '4', ' 클립보드에는 가장 최근에 저장한 것 하나만 저장된다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '27', ' 다음 중 한글 Windows 7의 보조프로그램에 있는 그림판에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '27', '1', ' 스마트폰으로 촬영한 jpg 파일을 불러와 편집한 후 png 파일 형식으로 저장할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '27', '2', ' 편집 중인 이미지의 일부분을 선택한 후 삭제하면 삭제된 빈 공간은 '색 1'(전경색)로 채워진다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '27', '3', ' 그림판에서 편집한 그림은 Windows 바탕화면의 배경으로 사용할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '27', '4', ' 오른쪽 버튼으로 그림을 그릴 경우에는 모두 '색 2' (배경색)로 그려진다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '28', ' 다음 중 한글 Windows 7의 Windows Media Player에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '28', '1', ' 비디오 목록을 자녀 보호 등급별로 분류하여 표시할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '28', '2', ' xlsx, hwp, doc 등과 같은 파일 형식의 문서 파일을 열 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '28', '3', ' mp3 파일을 재생할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '28', '4', ' 재생 목록에 있는 파일을 비어 있는 CD 또는 DVD로 복사할 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '29', ' 다음 중 한글 Windows 7에서 프린터 설치에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '29', '1', ' 10대 이상의 프린터도 설치할 수 있으며 기본프린터는 하나의 프린터에 대해서만 설정할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '29', '2', ' 공유된 프린터를 네트워크 프린터로 설정하여 설치할수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '29', '3', ' LAN 카드가 설치되어 IP 주소가 부여된 프린터를 로컬 프린터로 설치할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '29', '4', ' 공유된 프린터는 기본 프린터로 설정할 수 없다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '30', ' 다음 중 한글 Windows 7에서 하드웨어 추가 또는 제거에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '30', '1', ' 설치된 하드웨어는 [제어판]의 [장치 관리자]에서 확인할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '30', '2', ' 플러그 앤 플레이를 지원하는 장치를 설치하고 Windows 7을 재시작하면 자동으로 인식하여 설치된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '30', '3', ' 플러그 앤 플레이를 지원하지 않는 장치를 설치할 때는 [장치 관리자] 창의 [동작]-[레거시 하드웨어 추가] 메뉴를 선택하여 나타나는 [하드웨어 추가]마법사를 사용한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '30', '4', ' 설치된 하드웨어의 제거는 [프로그램 및 기능]창에서 해당 하드웨어의 드라이버를 제거하면 된다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '31', ' 다음 중 한글 Windows 7의 [Windows 작업 관리자]창에서 확인할 수 있는 사항으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '31', '1', ' 실행 중인 응용 프로그램 목록', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '31', '2', ' CPU와 메모리의 사용 현황', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '31', '3', ' 네트워크 이용률과 연결 속도', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '31', '4', ' 프린터 등의 주변 기기 사용 목록', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '32', ' 다음 중 한글 Windows 7에서 폴더와 프린터의 공유에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '32', '1', ' 다른 사람이 공유 여부를 모르게 하려면 폴더의 공유 이름 뒤에 '#' 기호를 표시한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '32', '2', ' 공유 자원의 아이콘을 클릭하면 Windows 탐색기 하단의 세부 정보 창에 공유 여부가 표시된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '32', '3', ' 프린터를 공유할 경우 공유할 프린터의 이름을 변경할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '32', '4', ' 문서, 비디오, 소리, 그림 등의 데이터 파일을 공유하려면 해당 파일을 공용 폴더로 이동시키면 된다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '33', ' 다음 중 한글 Windows 7에서 네트워크 연결을 위한 [로컬 영역 연결 속성] 창에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '33', '1', ' 네트워크 연결에 사용할 네트워크 어댑터의 유형과 장치가 장착된 위치 등을 알 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '33', '2', ' 네트워크 기능의 유형에는 라우터, 게이트웨이, 리피터 등이 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '33', '3', ' 네트워크가 IP 자동 설정 기능을 지원하지 않는 경우에는 해당 IP 주소, 서브넷 마스크, 기본게이트웨이, DNS 서버 주소를 수동으로 설정하여야 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '33', '4', ' 기본 게이트웨이와 DNS 서버 주소는 2개 이상 여러 개를 설정할 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '34', ' 다음 중 한글 Windows 7의 Internet Explorer에서 [보기] 메뉴의 하위 항목을 선택하여 할 수 있는 작업으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '34', '1', ' 메뉴 모음, 즐겨찾기 모음, 상태표시줄 등을 표시하도록 도구모음을 설정할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '34', '2', ' 이전이나 앞으로 화면 또는 기본 홈페이지로 이동을 실행할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '34', '3', ' 표시되는 텍스트의 크기를 설정할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '34', '4', ' 즐겨 찾는 웹페이지의 목록을 표시하여 볼 수 있다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '35', ' 다음 중 한글 Windows 7의 시스템 도구 프로그램에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '35', '1', ' [시스템 정보]를 수행하면 DMA, IRQ, I/O 주소 및 메모리 주소를 확인할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '35', '2', ' [디스크 조각 모음]을 수행하면 디스크 공간의 최적화를 이루어 접근 속도가 향상된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '35', '3', ' [디스크 검사]를 수행하면 불필요한 파일을 검색하여 삭제한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '35', '4', ' [시스템 복원]을 수행하면 복원에 사용할 디스크 공간의 비율을 조절할 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '36', ' 다음 중 한글 Windows 7의 제어판에 있는 기본 프로그램을 이용하여 설정할 수 있는 내용으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '36', '1', ' 같은 유형의 파일 형식 또는 프로토콜별로 연결된 프로그램을 설정할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '36', '2', ' 파일 형식 또는 프로토콜이 항상 특정 프로그램에서 열리도록 설정할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '36', '3', ' 컴퓨터에 삽입된 CD 또는 미디어 유형에 따라 각각에 맞게 자동으로 수행할 작업을 지정할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '36', '4', ' 컴퓨터에 설치된 특정 프로그램에 대한 추가나 제거를 할 수 있다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '37', ' 한글 Windows 7에서 '시스템 이미지 만들기'에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '37', '1', ' 시스템 이미지는 파일 시스템이 NTFS인 경우에만 가능하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '37', '2', ' 시스템 이미지는 현재 사용 중인 드라이브 전체를 그대로 복사하는 것이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '37', '3', ' 시스템 이미지는 개별적인 폴더나 파일을 선택하여 만들 수 없다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '37', '4', ' [제어판]-[복구]의 왼쪽 창에서 '시스템 이미지 만들기'를 클릭한다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '38', ' 다음 중 한글 Windows 7의 보조프로그램 중에서 메모장에 관한 설명으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '38', '1', ' 그림이나 차트 등의 OLE 개체를 삽입할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '38', '2', ' 편집하는 문서의 특정 영역(블록)에 대한 글꼴의 종류나 속성, 크기를 변경할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '38', '3', ' 자동 맞춤법과 같은 고급기능을 제공한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '38', '4', ' 서식이 없는 텍스트 형식의 문서만 열거나 저장할 수있다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '39', ' 다음 중 한글 Windows 7의 작업 표시줄에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '39', '1', ' 작업 표시줄은 현재 실행되고 있는 프로그램 단추와 프로그램을 빠르게 실행하기 위해 등록한 고정 프로그램 단추 등이 표시되는 곳이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '39', '2', ' 작업 표시줄은 위치를 변경하거나 크기를 조절할 수 있으며, 크기는 화면의 1/4까지만 늘릴 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '39', '3', ' '작업 표시줄 잠금'이 지정된 상태에서는 작업 표시줄의 크기나 위치 등을 변경할 수 없다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '39', '4', ' 작업 표시줄은 기본적으로 바탕화면의 맨 아래쪽에 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '40', ' 다음 중 한글 Windows 7에서 네트워크에 이상이 있어 발생하는 문제라고 볼 수 없는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '40', '1', ' 네트워크를 통해 다른 컴퓨터와 연결되지 않는 경우', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '40', '2', ' 네트워크에 로그온 할 수 없는 경우', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '40', '3', ' 다른 컴퓨터에 연결된 프린터를 공유할 수 없는 경우', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '40', '4', ' 현재 실행 중인 이미지 뷰어 프로그램이 응답하지 않는 경우', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '41', ' 다음 중 컴퓨터의 발전에 대한 세대별 특징을 연결한 것으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '41', '1', ' 1세대 - 일괄처리 시스템, 분산 처리', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '41', '2', ' 2세대 – 운영체제 도입, 고급언어 개발', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '41', '3', ' 3세대 – 시분할 처리, MIS 도입', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '41', '4', ' 4세대 – 개인용 컴퓨터 개발, 마이크로프로세서 개발', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '42', ' 다음 중 데이터의 표현 방식에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '42', '1', ' 숫자를 표현하는 부동 소수점 표현은 고정 소수점 표현에 비해 큰 수나 작은 수를 표현하기 때문에 컴퓨터 내부에서 처리하는 시간이 많이 걸린다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '42', '2', ' 문자 표현 방법 중 확장된 2진화 10진 코드(EBCDIC)는 8비트로 표현하며, ASCII 코드는 7비트로 표현한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '42', '3', ' 그레이(Gray)코드는 각 자리 수에 고유한 값을 부여한 코드로, 가중치 코드에 속하며 보수를 간단히 얻을 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '42', '4', ' 고정 소수점 표현은 정수 표현 형식으로 구조가 단순하고 표현 범위가 좁다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '44', ' 다음 중 아날로그 컴퓨터와 비교하여 디지털 컴퓨터의 특징으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '44', '1', ' 입력 형태로 전류, 전압, 온도, 속도 등이 가능하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '44', '2', ' 논리 회로를 사용하며, 프로그래밍이 필요하다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '44', '3', ' 미분이나 적분에 관한 연산 속도가 빠르다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '44', '4', ' 특수 목적용으로 기억기능이 적다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '45', ' 다음 중 컴퓨터의 CPU에 있는 레지스터(Register)에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '45', '1', ' CPU 내부에서 처리할 명령어나 연산의 중간 값을 일시적으로 기억한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '45', '2', ' 메모리 중에서 가장 속도가 빠르다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '45', '3', ' 플립플롭(Flip-Flop)이나 래치(Latch)들을 연결하여 구성된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '45', '4', ' 운영체제의 실행 정보를 기억하고 관리한다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '47', ' 다음 중 객체지향 프로그래밍 언어로만 짝지어진 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '47', '1', ' C++, C#, JAVA		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '47', '2', ' C, COBOL, BASIC', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '47', '3', ' FORTRAN, C++, XML	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '47', '4', ' JAVA, C, XML', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '48', ' 다음 중 응용 소프트웨어에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '48', '1', ' 스프레드시트 소프트웨어로는 엑셀, 로터스, 훈민시트 등이 있다', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '48', '2', ' 셰어웨어(Shareware)는 무료로 사용할 수 있으며 누구나 자유롭게 사용하고 수정 및 배포할 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '48', '3', ' 전자출판(DTP) 소프트웨어로는 페이지 메이커, Quark Xpress 등이 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '48', '4', ' 데이터베이스 관리 시스템을 사용하면 데이터의 중복성을 최소화 할 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '49', ' 다음 중 압축 프로그램에 대한 설명으로 가장 거리가 먼것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '49', '1', ' 디스크 저장 공간을 효율적으로 사용할 수 있게 해준다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '49', '2', ' 데이터의 이동과 전송 시에 시간과 비용을 절감할 수있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '49', '3', ' 이미 압축된 파일을 다시 압축하면 압축률을 더욱 증가시킬 수 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '49', '4', ' 한글 Windows 7에는 Zip 파일로의 압축 기능을 기본으로 제공하고 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '51', ' 다음 중 웹브라우저와 검색엔진 및 검색방법에 관한설명으로 옳지 않은 것은 ?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '51', '1', ' 웹 브라우저는 하이퍼미디어 형태의 월드 와이드 웹을 이용하기 위한 프로그램이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '51', '2', ' 인터넷 정보검색을 위한 검색 엔진은 동작방식에 따라 주제별, 키워드, 메타 검색엔진 등으로 구분된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '51', '3', ' 웹 브라우저는 플러그인 프로그램을 이용해 다양한 멀티미디어 데이터를 처리할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '51', '4', ' 검색 연산자(NEAR, AND, OR, NOT)는 우선순위 없이 검색한다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '52', ' 다음 중 OSI 7 계층 구조에서 각 계층에 해당하는 프로토콜로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '52', '1', ' 데이터링크 계층 : HDLC, SDLC', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '52', '2', ' 네트워크 계층 : IP, ICMP', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '52', '3', ' 세션 계층 : TCP, UDP', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '52', '4', ' 응용 계층 : FTP, HTTP', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '54', ' 다음 중 제작자가 의도적으로 사용자에게 피해를 주고자 만든 모든 악의적 목적을 가진 프로그램 및 매크로, 스크립트 등 컴퓨터상에서 작동하는 모든 실행 가능한 형태의 악성 코드가 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '54', '1', ' 웜(Worm)		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '54', '2', ' 트로이 목마(Trojan House)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '54', '3', ' 혹스(Hoax)		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '54', '4', ' V3', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '55', ' 다음 중 스마트 폰의 보안 위협에 대처하는 방법에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '55', '1', ' 와이파이(Wi-Fi) 망에서 양자간 통신 내용을 가로채는 중간자 공격을 방지하기 위해 VPN 서비스를 강화 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '55', '2', ' 악성 코드나 바이러스 감염으로부터 예방하고자 운영체제와 백신 프로그램을 항상 최신 버전으로 업데이트 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '55', '3', ' 악성 코드 유포를 막기 위해 가급적 멀티미디어메시지(MMS)를 사용하고 블루투스 기능은 항상 켜 놓는 다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '55', '4', ' 분실한 기기에 저장된 개인 정보를 원격으로 삭제하여 불법 사용을 방지하기 위해 킬 스위치(Kill Switch) 기능을 사용한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '56', ' 다음 중 정보 보안 기법으로 사용되는 방화벽(Firewall)에 관한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '56', '1', ' 외부 침입자의 흔적을 찾는 역추적 기능이 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '56', '2', ' 외부에서 내부로 들어오는 인증된 패킷만 통과시키는 구조이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '56', '3', ' 내부로부터의 불법적인 해킹에 대비한 보안 기법으로도 사용된다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '56', '4', ' 해킹 등 외부로의 정보 유출을 막기 위하여 사용되는 보안 기법이다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '57', ' 다음 중 정보통신기술(ICT)에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '57', '1', ' 증강현실(Augmented Reality) : 현실 세계의 배경에 3D의 가상 이미지를 중첩하여 영상으로 보여 주는 기술이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '57', '2', ' RFID(Radio Frequency IDentification) : 전자태그가 부착된 IC칩과 무선 통신 기술을 이용하여 다양한 개체들의 정보를 관리할 수 있는 센서 기술이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '57', '3', ' 매시업(Mashup) : 웹상에서 제공되는 다양한 콘텐츠와 서비스를 혼합하여 새로운 서비스를 개발하는 기술이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '57', '4', ' 텔레메틱스(Telematics) : 유선 전화망, 무선망, 패킷 데이터 망 등과 같은 기존의 통신망을 하나의 IP기반 망으로 통합하여 각종 데이터를 전송하는 기술이다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '58', ' 다음 중 모바일 기기의 기능에서 테더링(Tethering)에 관한 설명으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '58', '1', ' 기기에 내장된 카메라를 이용해 실제 사물이나 환경에 부가 정보를 표시하는 기술이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '58', '2', ' 인터넷에 연결된 기기를 활용해 다른 기기에서 인터넷 접속을 가능하도록 하는 기술이다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '58', '3', ' 인공위성 위치정보 신호를 수신하는 기술이다', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '58', '4', ' 근거리에서 데이터의 무선 통신을 가능하도록 해주는 기술이다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '59', ' 다음 중 전자우편에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '59', '1', ' 전자우편의 송신을 담당하고 다른 사람의 계정이 있는 곳으로 전송하는 프로토콜은 IMAP 이다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '59', '2', ' 메일 서버에 도착한 전자우편을 사용자 컴퓨터로 가져오는 프로토콜은 POP3 이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '59', '3', ' 전자우편 주소 sang123@nara.co.kr에서 도메인네임은 nara.co.kr 이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '59', '4', ' 회신은 받은 메일에 대해 답장을 작성하여 발송자에게 보내는 기능이다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('15', '1', '60', ' 다음 중 아웃룩(Outlook) 2007에서 전자 메일에 대한 규칙 및 알림 설정에 대한 설명으로 옳지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '60', '1', ' 제목에 특정 단어가 들어 있는 메시지를 특정 폴더로 이동시킬 수 있게 지정할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '60', '2', ' 특정인으로부터 메일을 받으면 특정 소리를 재생할 수 있게 지정할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '60', '3', ' 제목에 특정 단어가 있는 메시지가 삭제되도록 지정할 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('15', '1', '60', '4', ' 받은 사람 란에 내 이름이 없을 경우 메시지를 삭제할 수 있게 지정할 수 있다.', 'Y', now(), now());

