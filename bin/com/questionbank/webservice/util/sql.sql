-- TEST
insert into test (test_id, test_nm, created_date, modified_date) values ('9', '방송통신기사', now(), now());
-- VERSION
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('9', '1', '2018-10-06 기출문제', now(), now());
-- QUESTION
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '3', ' 다음 중 궤환회로에서 발진이 일어나는 조건인 바크하우젠 발진조건에 관한 설명으로 틀린 것은? (단, A는 증폭부의 증폭률이고 β는 궤환부의 궤환율이다.)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '3', '1', ' 발진조건은 |Aβ |= 1 이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '3', '2', ' Aβ＜ 1 이면 발진이 일어나지 않는다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '3', '3', ' Aβ ＞1 이면 발진은 되나 이득이 계속 증가하여 클리핑이 일어나면서 불안정하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '3', '4', ' Aβ=1 은 발진조건으로 일정한 진폭의 직류출력이 발생한다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '5', ' 전류 궤환 증폭기의 출력 임피던스는 궤환이 없을 경우에 비해 어떻게 변화하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '5', '1', ' 변화가 없다.		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '5', '2', ' 0이 된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '5', '3', ' 감소한다.		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '5', '4', ' 증가한다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '6', ' 다음 중 부궤환 증폭기의 특성이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '6', '1', ' 잡음이 감소된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '6', '2', ' 주파수 특성이 개선된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '6', '3', ' 비직선 왜곡이 감소된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '6', '4', ' 안정도가 다소 감소된다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '7', ' 발진회로의 궤환루프의 감쇠가 0.5인 경우 발진을 유지하기 위한 증폭 회로의 전압이득은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '7', '1', ' 전압이득은 2.0이어야 한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '7', '2', ' 전압이득은 1.5이어야 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '7', '3', ' 전압이득은 1.0이어야 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '7', '4', ' 전압이득은 0.5보다 적어야 한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '9', ' 다음 중 비동기 검파에 대한 설명으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '9', '1', ' 국부발진 신호와 입력신호를 곱하게 하는 곱셈 검파기이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '9', '2', ' 송신측과 수신측이 동일한 반송파를 이용한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '9', '3', ' 주로 ASK와 FSK에 이용된다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '9', '4', ' 동기검파보다 복조시스템이 복잡하다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '10', ' AM변조에서 100[%] 변조인 경우 그 변조 출력 전력이 6[kW]일 때, 반송파 성분의 전력은 얼마인가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '10', '1', ' 1[kW]		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '10', '2', ' 1.5[kW]', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '10', '3', ' 2[kW]		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '10', '4', ' 4[kW]', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '11', ' 주파수 변조에서 신호주파수가 4[kHz], 최대 주파수 편이가 20[kHz]이면, 변조지수는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '11', '1', ' 0.2		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '11', '2', ' 5', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '11', '3', ' 16		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '11', '4', ' 80', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '12', ' 간접 FM 변조방식(Armstrong 방식)에서의 필수 요소가 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '12', '1', ' 가산기(Adder)', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '12', '2', ' 평형 변조기(Balanced modulation)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '12', '3', ' 위상천이기(90° phase shifter)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '12', '4', ' 진폭제한기(Limiter)', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '13', ' RC 회로의 출력에서 최종치의 10[%]~90[%]까지 얻는데 소요되는 시간을 무엇이라 하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '13', '1', ' 지연 시간		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '13', '2', ' 하강 시간', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '13', '3', ' 상승 시간		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '13', '4', ' 전이 시간', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '16', ' 다음 중 Master-Slave 플립플롭은 어떠한 현상을 해결하기 위한 플립플롭인가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '16', '1', ' 지연 현상		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '16', '2', ' Race 현상', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '16', '3', ' Set 현상		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '16', '4', ' Toggle 현상', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '17', ' 마스터 슬레이브 JK-FF에서 클럭 펄스가 들어올 때마다 출력 상태가 반전되는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '17', '1', ' J=0, K=0		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '17', '2', ' J=1, K=0', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '17', '3', ' J=0, K=1		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '17', '4', ' J=1, K=1', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '18', ' 25진 리플 카운터를 설계할 경우 최소한 몇 개의 플립플롭이 필요한가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '18', '1', ' 4개		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '18', '2', ' 5개', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '18', '3', ' 6개		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '18', '4', ' 7개', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '20', ' 다음 중 전감산기의 입력과 관계없는 것은?<br><br><br><br>', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '20', '1', ' 감수		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '20', '2', ' 상위에서 자리 빌림', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '20', '3', ' 피감수		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '20', '4', ' 하위에서 자리 빌림', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '21', ' 다음 중 방송망을 구성하는 전송설비가 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '21', '1', ' TBC		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '21', '2', ' STL', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '21', '3', ' FPU		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '21', '4', ' SNG', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '22', ' 다음 중 카메라의 위치를 움직이지 않고 카메라 헤드만을 수평방향으로 회전시키면서 촬영하는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '22', '1', ' 패닝(Panning)	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '22', '2', ' 틸팅(Tilting)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '22', '3', ' 달리(Dolly)		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '22', '4', ' 붐(Boom)', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '23', ' 다음 비디오 조명의 조건으로 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '23', '1', ' 밝기가 충분할 것', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '23', '2', ' 플리커(flicker)가 있을 것', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '23', '3', ' 조명의 효율이 좋을 것', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '23', '4', ' 연출의도에 따라 상황이나 분위기를 만들어 낼 것', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '24', ' 다음 중 우리나라 아날로그 라디오방송에 사용하지 않는 주파수대는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '24', '1', ' 중파		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '24', '2', ' 단파', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '24', '3', ' 초단파		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '24', '4', ' 극초단파', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '25', ' 다음 중에서 라디오방송 설비가 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '25', '1', ' 부조정실		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '25', '2', ' 비디오편집실', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '25', '3', ' 송신소		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '25', '4', ' 주조정실', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '26', ' 다음 각종 마이크 종류 중에서 평면적인 고정전극에 상대하여 얇은 진동막의 전극을 배치함으로써 최량의 음질을 실현하는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '26', '1', ' 자기 변화형	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '26', '2', ' 압전형', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '26', '3', ' 다이내믹형		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '26', '4', ' 콘덴서형', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '27', ' 빛의 삼원색에 해당되지 않는 색은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '27', '1', ' 빨강(Red)		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '27', '2', ' 초록(Green)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '27', '3', ' 노랑(Yellow)	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '27', '4', ' 파랑(Blue)', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '28', ' 동축케이블 내에 있어서 파장(λ)은 진공 중 파장(λo)의 2/3(67[%])가 된다. 이 때 색부반송파 3.579545[MHz]를 전송할 때 길이 1[m]당 몇 도[°]의 위상(Phase) 차이가 생기는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '28', '1', ' 3.58		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '28', '2', ' 4.5', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '28', '3', ' 6.44		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '28', '4', ' 7.14', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '29', ' 다음 중 ATSC3.0에서 규정하는 영상 압축방식은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '29', '1', ' AC-3		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '29', '2', ' AC-4', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '29', '3', ' MPEG-H		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '29', '4', ' H.265', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '30', ' 다음 중 카메라의 구성과 관계가 없는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '30', '1', ' 트라이 포드(Tripod)		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '30', '2', ' 뷰파인더(Viewfinder)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '30', '3', ' 렌즈			', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '30', '4', ' 텔레신(Telecine)', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '31', ' 디지털 위성방송에 대한 설명으로 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '31', '1', ' 건물 내부까지 전파가 용이하게 도달된다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '31', '2', ' 디지털변조가 가능하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '31', '3', ' 수신측에서 오류정정이 가능하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '31', '4', ' 부가방송서비스를 제공할 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '32', ' 반송파대 잡음비(C/N)가 10dB 이상이어야 하는 위성방송에서 잡음전력이 1[W]인 경우 반송파 전력은 몇 와트(Watt) 이상이어야 하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '32', '1', ' 1			', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '32', '2', ' 10', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '32', '3', ' 20		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '32', '4', ' 40', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '33', ' CATV에서 헤드엔드로부터 송출된 신호를 서비스 구역 전역에 전송하기 위한 전송로를 무엇이라고 하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '33', '1', ' 간선(Trunk Line)	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '33', '2', ' 분배선(Feeder Line)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '33', '3', ' 인입선(Drop Line)	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '33', '4', ' 가입자선(Subscriber Line)', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '34', ' 다음 중 동축케이블에 대한 광섬유 케이블의 특징으로 적절하지 않은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '34', '1', ' 좁은 대역폭을 가지고 있다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '34', '2', ' 작은 크기와 적은 무게를 가지고 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '34', '3', ' 적은 감쇠도(Attenuation)를 가지고 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '34', '4', ' 전자기적 잡음에 강하여 도청이 어렵다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '35', ' IPTV에서 IGMP(Internet Group Management Protocol)은 멀티캐스트 데이터를 요구하는 수신기가 전송되어 오는 멀티캐스트 데이터를 받기 위해 그룹에 접속하거나 작업을 하기 위한 프로토콜이다. 다음 중 IGMP에서 멀티캐스트 그룹을 사용하는 이유가 될 수 없는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '35', '1', ' 멀티캐스트 그룹에 진입과 탈퇴가 자유롭다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '35', '2', ' 다양한 형태의 정보를 같이 보낼 수 있기 때문에 넓은 범위에서 사용이 가능하다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '35', '3', ' 멀티캐스트 그룹에 접속한 수신기가 없으면 자동으로 네트워크상에서 사라진다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '35', '4', ' 그룹은 그 그룹에 구성된 숫자의 조정이 가능하다. 즉 접속 숫자가 많을 경우 자동으로 인지하여 그 공간을 확보한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '36', ' 국내 지상파 DMB 서비스에 사용되는 주파수 대역은 사업자당 1.536MHz이다. 지상파 한 채널에 최대 몇 개의 DMB 사업자를 허가할 수 있는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '36', '1', ' 2			', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '36', '2', ' 3', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '36', '3', ' 4			', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '36', '4', ' 5', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '37', ' 다음 중 방송제작용 영상스위처(VMU)에 대한 설명으로 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '37', '1', ' 자체 출력 SYNC 레벨은 블랭킹 레벨 이하에서 -40[IRE]가 유지되어야 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '37', '2', ' VMU 입력단에 입력되는 영상신호와 펄스들의 출력 임피던스는 75[Ω]이어야 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '37', '3', ' 영상입력단에 가해진 모든 영상소스는 인코더에서 출력되는 테스트용 컬러바를 이용하여 신호레벨, 위상, 타이밍 등을 확인하고, 정확히 조정하여야 한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '37', '4', ' 스위처(Switcher) 자체의 컬러 블랙과 컬러 백그라운드 신호의 셋업 레벨은 40[IRE]가 되어야 한다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '38', ' 다음 중 NTSC용 웨이브폼 모니터에서 측정된 50[IRE]는 몇 [mV]인가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '38', '1', ' 357[mV]		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '38', '2', ' 350[mV]', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '38', '3', ' 346[mV]		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '38', '4', ' 334[mV]', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '39', ' 다음 중 벡터스코프에 대한 설명으로 맞는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '39', '1', ' 영상신호 중의 색도 성분을 측정하기 위해 색도 신호를 복조하여 그 위상과 진폭을 벡터로 표시하는 장치', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '39', '2', ' TV 전송 신호의 파형을 분석하여 변조된 영상과 음성신호의 신호품질을 측정하는 오실로스코프 장치', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '39', '3', ' RF신호를 측정하는 오실로스코프로 신호의 특성을 2차원 정보로 변환하여 벡터로 표시하는 장치', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '39', '4', ' 피변조파에 포함된 영상신호 레벨 대 진폭 변조된 잡음의 비를 벡터적으로 표시하는 장치', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '40', ' DTV 송신안테나 중 Panel형과 Slot형에 대한 특성을 비교한 것으로 틀린 것은?<br><br><br><br>', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '40', '1', ' Panel형은 바람의 영향을 많이 받으나 Slot형은 평면적이 적어 바람의 영향을 적게 받아 시설유지에 유리하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '40', '2', ' 전파의 수직패턴에 있어 Panel형은 비교적 빔틸트가 일정하나 Slot형은 주파수에 따라 변동된다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '40', '3', ' 전파의 수평패턴 레벨차는 Panel형이 3[dB]정도 나타나지만 Slot형은 0.5[dB]정도다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '40', '4', ' Slot형은 Panel형에 비해 다채널용으로 사용하기에 적합하다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '41', ' 다음 중 아날로그 음성신호의 양옆에 디지털 정보를 배치하여 전송하는 혼성(Hybrid)모드로서, 아날로그 음성신호의 대역폭을 줄이고 기존 할당된 방송주파수 내에서 디지털 방송신호까지 보낼 수 있는 확장성 혼성 디지털라디오방송 방식은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '41', '1', ' DRM		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '41', '2', ' IBOC', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '41', '3', ' DRM+		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '41', '4', ' Eureka-147', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '42', ' 다음 중 FM 부가방송 국제표준으로 권고하고 있는 DARC 방식의 기저대역 주파수는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '42', '1', ' 53[kHz]		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '42', '2', ' 57[kHz]', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '42', '3', ' 67[kHz]		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '42', '4', ' 76[kHz]', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '43', ' 다음 중 연주소 내 부조정실의 역할로 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '43', '1', ' 뉴스센터, 편집실 등 설비에서 넘겨받은 영상, 음성 신호 자료를 송신소로 송출한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '43', '2', ' 카메라, 조명, 영상, 무대를 책임지는 프로듀서, 기술감독 등이 근무하고 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '43', '3', ' 다양한 영상, 조명, 음향 등을 조정하는 장비가 설치되어 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '43', '4', ' 드라마 등 각종 TV프로그램을 녹화한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '44', ' 인간의 가청주파수는 20~20,000[Hz]이다. 가청주파수 3[kHz]의 파장의 길이는 다음 중 어느 것인가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '44', '1', ' 1[km]		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '44', '2', ' 10[km]', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '44', '3', ' 100[km]		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '44', '4', ' 1,000[km]', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '45', ' 아날로그 신호를 디지털 형태의 PCM 신호로 변화시키기 위해서는 세 가지 기본 과정이 필요하다. 다음 중 PCM과정으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '45', '1', ' 표본화(Sampling) 과정 → 양자화(Quantization) 과정 → 부호화(Coding) 과정', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '45', '2', ' 부호화(Coding) 과정 → 표본화(Sampling) 과정 → 양자화(Quantization) 과정', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '45', '3', ' 표본화(Sampling) 과정 → 부호화(Coding) 과정 → 양자화(Quantization) 과정', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '45', '4', ' 양자화(Quantization) 과정 → 표본화(Sampling) 과정 → 부호화(Coding) 과정', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '46', ' 양지향성과 단일지향성의 마이크를 음원에 가까이 대고 사용하면 저음의 출력이 증가되는 현상을 무엇이라고 하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '46', '1', ' 회절		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '46', '2', ' 도플러 효과', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '46', '3', ' 근접효과		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '46', '4', ' 칵테일 파티 효과', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '47', ' 다음 중 TV 주사방식의 설명에서 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '47', '1', ' 순차주사는 하나의 화면을 기수와 우수로 나누어 전송 한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '47', '2', ' 순차주사는 주사 속도가 빨라서 전송 주파수 대역을 넓게 차지한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '47', '3', ' 비월주사는 한 번에 보내는 정보량이 절반으로 되어 전송 주파수 대역을 반(1/2)으로 줄일 수 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '47', '4', ' 비월주사는 하나의 화면을 두 개의 필드로 나눈다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '48', ' 방송 스튜디오 시설 공사 시 컴포지트(Composite) 영상신호용 케이블의 임피던스는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '48', '1', ' 50[Ω]		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '48', '2', ' 60[Ω]', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '48', '3', ' 70[Ω]		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '48', '4', ' 75[Ω]', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '49', ' 색상 스펙트럼에서 마젠타(Magenta)와 싸이안(Cyan)색의 광을 혼합하면 어떤 색이 나오는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '49', '1', ' 청색(Blue)		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '49', '2', ' 노랑(Yellow)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '49', '3', ' 적색(Red)		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '49', '4', ' 녹색(Green)', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '51', ' 데이터 방송 서비스 분류에서 방송 프로그램과 관련된 정보를 시청자에게 제공하는 서비스로 방송 중에 있는 드라마, 음악 프로그램, 스포츠 프로그램 등의 프로그램과 연관된 각종 정보를 데이터로 제공하는 서비스는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '51', '1', ' 독립 정보 서비스', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '51', '2', ' 프로그램 연동 정보 서비스', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '51', '3', ' 양방향 텔레비전 서비스', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '51', '4', ' 전자상거래 서비스', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '52', ' DAB(Audio+Data)에 비디오를 추가한 멀티미디어 서비스로서 고품질의 음성 및 영상서비스를 언제 어디서나 제공할 수 있는 이동 멀티미디어 방송 서비스는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '52', '1', ' DMB		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '52', '2', ' IPT', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '52', '3', ' MMS		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '52', '4', ' 3DTV', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '53', ' 디지털 오디오 파일의 크기를 결정하는 요소가 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '53', '1', ' 양자화 비트수	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '53', '2', ' 시간', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '53', '3', ' 샘플링 레이트	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '53', '4', ' 음색', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '54', ' 영상 신호의 크로마 서브 샘플링 방식에서 4:2:0일 때와 4:2:2일 때 크로마 성분(Cr, Cb) 정보량의 차이는 얼마인가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '54', '1', ' 2배		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '54', '2', ' 4배', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '54', '3', ' 8배		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '54', '4', ' 16배', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '55', ' 다음 중 양방향 대화형 데이터방송 서비스에 대한 설명으로 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '55', '1', ' 수신단말에서 리턴 채널을 통해 데이터를 다시 전송측에 전달되는 서비스를 의미한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '55', '2', ' 오디오/비디오 방송프로그램과는 별개의 전송매체를 이용하여 데이터를 전송한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '55', '3', ' 연동형 데이터방송의 예로는 퀴즈, 홈쇼핑, TV전자상거래 등이 있다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '55', '4', ' 독립형 데이터 방송은 홈뱅킹, 전자우편(e-mail), 채팅 등이 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '56', ' 디지털 텔레비전 방송에서 방송편성표 및 프로그램 내용 등을 안내하는 기능을 무엇이라고 하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '56', '1', ' DLS(Dynamic Label Segment)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '56', '2', ' EPG(Electronic Program Guide)', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '56', '3', ' NPAD(Non-Program Associated Data)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '56', '4', ' FIC(Fast Information Channel)', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '57', ' 다음 중 거실의 TV에서 인터넷포털 및 디지털 방송을 사용자에게 보다 편리한 인터페이스를 통해 제공하는 서비스는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '57', '1', ' 체감형 서비스	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '57', '2', ' TV포털서비스', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '57', '3', ' 멀티모드 서비스	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '57', '4', ' 멀티미디어 서비스', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '58', ' 다음 중 미국식 디지털 TV 표준(ATSC)의 오디오 압축 방식은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '58', '1', ' DAB		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '58', '2', ' SPDIF', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '58', '3', ' AC-3		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '58', '4', ' PCM', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '59', ' 영상신호의 데이터 압축에서 엔트로피(entropy) 개념에 관한 설명 중 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '59', '1', ' 디지털데이터의 부호화는 데이터를 구성하는 각각의 정보가 어떠한 출현확률을 가지는가에 의해서 압축비가 달라진다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '59', '2', ' 엔트로피(entropy)가 높을수록 각각의 정보가 출현할 확률이 높다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '59', '3', ' 각각의 정보가 출현할 확률이 높을수록 효율적인 부호화가 가능하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '59', '4', ' 각각의 정보가 출현할 확률이 모두 같다면 엔트로피(entropy)가 높아져서 압축이 불가능하다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '60', ' MPEG-2의 프레임 구조 중 순방향 프레임간 예측화면은 무엇인가?<br><br><br><br>', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '60', '1', ' I 프레임		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '60', '2', ' S 프레임', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '60', '3', ' P 프레임		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '60', '4', ' B 프레임', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '61', ' 표본화에 의하여 얻어진 PAM 신호를 디지털화하기 위하여 진폭축으로 이산값을 갖도록 처리하는 것을 무엇이라고 하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '61', '1', ' 부호화		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '61', '2', ' 양자화', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '61', '3', ' 이진화		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '61', '4', ' 디지털화', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '62', ' 다음 중 진폭변조(Amplitude Modulation)에서 변조도가 1일 때 반송파 : 상측파대 : 하측파대의 전력 비율은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '62', '1', ' 1 : 1 : 1		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '62', '2', ' 1 : 1/2 : 1/2', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '62', '3', ' 1 : 1/4 : 1/4	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '62', '4', ' 1 : 1/8 : 1/8', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '63', ' 다음 변조방식 중 진폭과 위상을 동시에 사용하고 저역 통과 필터를 사용하는 변조방식은 어느 것인가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '63', '1', ' QAM		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '63', '2', ' MSK', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '63', '3', ' DPSK		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '63', '4', ' FM', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '64', ' 64QAM 변조방식의 전송밀도(bps/Hz)는 얼마인가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '64', '1', ' 3			', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '64', '2', ' 4', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '64', '3', ' 6			', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '64', '4', ' 8', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '65', ' 다음 보기에서 설명하는 것은?<br><br>라디오 송신소 근방은 강력한 저파로 인하여 다른 방송을 수신하기가 곤란한데 이와 같이 강한 전파의 방해를 받는 지역을 의미한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '65', '1', ' 리프프로그(leapfrog) 지역', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '65', '2', ' 블랭킷(blanket) 지역', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '65', '3', ' 커버리지(coverage) 지역', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '65', '4', ' 널(null) 지역', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '66', ' 다음 중 FM송신기의 최고변조주파수가 15[kHz]인 경우 100[%] 변조시 점유주파수의 대역폭은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '66', '1', ' 10[kHz]		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '66', '2', ' 90[kHz]', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '66', '3', ' 180[kHz]		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '66', '4', ' 270[kHz]', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '67', ' 다음 중 스테레오 필드에서 밸런스 유지와 모노 호환성을 위해 두 마이크의 적절한 배열각도는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '67', '1', ' 90도 이내		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '67', '2', ' 100도 이내', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '67', '3', ' 105도 이내		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '67', '4', ' 110도 이내', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '68', ' 다음 중 지상파 Digital TV(DTV) 송신기에서 Mask Filter를 쓰는 주된 목적으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '68', '1', ' S/N 비의 특성 개선', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '68', '2', ' 출력 마진 향상', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '68', '3', ' 타 채널에 대한 간섭 최소화', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '68', '4', ' 영상에 대한 음성지연 보상', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '69', ' 다음 중 디지털 전송시스템의 등화기(Equalizer) 기능을 설명한 것으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '69', '1', ' 디지털 신호의 전송에서 입력의 잡음을 제거하여 신호의 출력 레벨을 높게 하는 장치', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '69', '2', ' 디지털 신호의 전송에서 신호의 왜곡을 줄여 비트오류를 줄이는 장치', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '69', '3', ' 디지털 신호의 전송에서 신호의 비선형성을 줄여 비트오류를 증가시키는 장치', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '69', '4', ' 디지털 신호의 전송에서 신호의 대역폭 효율을 최대화하는 장치', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '70', ' 다음 중 ATSC 방식의 디지털TV 방송의 특징이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '70', '1', ' 넓은 지역 서비스가 가능하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '70', '2', ' HD급 영상에 SD급 영상을 추가하여 구성이 가능하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '70', '3', ' 통신네트워크와 연동하여 홈쇼핑, 홈뱅킹 등 양방향 데이터서비스 제공이 가능하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '70', '4', ' 이동수신 성능이 우수하고 SFN(Single Frequency Network) 구성에 용이하다.', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '72', ' 유선방송국용 전원설비에서 최대로 사용되는 전력을 안정적으로 공급할 수 있도록 하기 위한 전압·전류의 변동허용범위로 맞는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '72', '1', ' ±5[%] 이내	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '72', '2', ' ±10[%] 이내', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '72', '3', ' ±15[%] 이내	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '72', '4', ' ±20[%] 이내', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '73', ' 다음 중 국내디지털유선방송의 상·하향 대역 분리 방식으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '73', '1', ' Sub split 방식	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '73', '2', ' Mid split 방식', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '73', '3', ' High Split 방식	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '73', '4', ' Extended Mid Split 방식', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '74', ' 다음 중 위성방송에서 전파손실의 가장 큰 부분을 차지하는 손실은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '74', '1', ' 자유공간 손실	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '74', '2', ' 감쇠와 흡수', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '74', '3', ' 산란과 회절	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '74', '4', ' 다중경로 손실', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '75', ' 다음 중 위성방송의 특징과 가장 거리가 먼 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '75', '1', ' 다채널성		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '75', '2', ' 고품질성', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '75', '3', ' 대용량성		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '75', '4', ' 국지성', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '76', ' 다음 설명으로 맞는 안테나는 무엇인가?<br><br>지향성이 있는 수평 다이폴안테나를 공간적으로 직각이 되게 놓아 90도의 위상 차로 급전함으로써 수평면에서 원형에 가까운 전 방향성을 가지는 안테나', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '76', '1', ' 무지향성 안테나	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '76', '2', ' 파라볼라 안테나', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '76', '3', ' 혼 안테나		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '76', '4', ' 빔 안테나', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '77', ' 전송방식이 OFDM인 국내 지상파 DMB의 변조방식은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '77', '1', ' DQPSK		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '77', '2', ' FM', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '77', '3', ' DSK		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '77', '4', ' ASK', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '78', ' 화상통신회의의 특징이라고 할 수 없는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '78', '1', ' 시간과 경비의 절약, 신속하고 정확한 정보전달이 가능하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '78', '2', ' 적임자의 회의참석이 용이하다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '78', '3', ' 기업 활용의 극대화 및 효율화를 기대할 수 없다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '78', '4', ' TV회의를 실현하려면 고속, 광대역 네트워크가 필요하다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '79', ' 다음은 CATV시스템의 기본 구성으로 케이블의 손실을 보상해주는 증폭기에 대한 설명이다. 다음에 해당되는 증폭기는?<br><br>"헤드엔드로부터 나온 신호가 들어가는 간선의 일정 간격마다 설치되는 것으로, 간선 케이블의 손실을 보상하여 단말에 충분한 강도의 신호를 보내기 위해 사용된 증폭기"', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '79', '1', ' 간선 증폭기 [TA : Trunk Amplifier]', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '79', '2', ' 간선 분기증폭기 [TBA : Trunk Bridger Amplifier]', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '79', '3', ' 분기증폭기 [BA : Bridger Amplifier]', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '79', '4', ' 쌍방향 중계증폭기', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '80', ' 접지 시공 시방서에 의한 한국산업규격(KS)의 표준이 잘못된 것은?<br><br><br><br>', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '80', '1', ' KS C 2621 동선용 나압착 슬라브', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '80', '2', ' KS C 3103 전기용 연동연선(AS)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '80', '3', ' KS C 3301 600V 비닐 절연전선(IV)', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '80', '4', ' KS C 0804 접지선 및 접지측 전선의 색별 통칙', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '81', ' 전자계산기 소프트웨어는 시스템 소프트웨어와 응용 소프트웨어의 두 가지 종류로 구분될 수 있다. 다음 중 시스템 소프트웨어가 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '81', '1', ' 과학용 프로그램', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '81', '2', ' 운영 시스템', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '81', '3', ' 데이터베이스 관리 시스템', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '81', '4', ' 통신 제어 프로그램', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '82', ' 디스크 오류가 발생하였을 때, 디스크를 재구성하지 않고 복사된 것을 대체함으로써 데이터를 복구할 수 있는 RAID 레벨(Level)은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '82', '1', ' RAID 0		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '82', '2', ' RAID 1', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '82', '3', ' RAID 3		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '82', '4', ' RAID 5', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '83', ' 10진수 (38)10을 2진수로 올바르게 변환한 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '83', '1', ' (100100)2	Ā		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '83', '2', ' (100101)2', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '83', '3', ' (100110)2	Ā		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '83', '4', ' (100111)2', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '84', ' 다음 중 자료의 병렬전송을 직렬전송으로 변경하는 레지스터는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '84', '1', ' 명령 레지스터(IR)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '84', '2', ' 메모리 주소 레지스터(MAR)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '84', '3', ' 메모리 버퍼 레지스터(MBR)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '84', '4', ' 쉬프트 레지스터(Shift Register)', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '85', ' 파일 관리자는 파일 구조에 따라 각기 다른 접근 방법으로 관리한다. 다음 중 저장공간의 효율성이 가장 높은 파일 구조는 어느 것인가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '85', '1', ' 직접 파일(Direct File)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '85', '2', ' 순차 파일(Sequential File)', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '85', '3', ' 색인 순차 파일(Indexed Sequential File)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '85', '4', ' 분할 파일(Partitioned File)', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '86', ' 다음 중 컴퓨터의 운영체제에서 로더(Loader)의 주요 기능이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '86', '1', ' 프로그램과 프로그램 간의 연결(linking)을 수행한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '86', '2', ' 출력 데이터에 대해 일시 저장(spooling) 기능을 수행한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '86', '3', ' 프로그램이 실행될 수 있도록 번지수를 재배치(relocation)한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '86', '4', ' 프로그램 또는 데이터가 저장될 번지수를 계산하고 할당(allocation)한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '87', ' 몇 개의 관련 있는 데이터 파일을 조직적으로 작성하여 중복된 데이터 항목을 제거한 구조를 무엇이라 하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '87', '1', ' Data File		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '87', '2', ' Data Base', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '87', '3', ' Data Program	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '87', '4', ' Data Link', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '88', ' 다음 중 운영체제가 제공하는 소프트웨어 프로그램이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '88', '1', ' 스택(Stack)', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '88', '2', ' 컴파일러(Compiler)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '88', '3', ' 로더(Loader)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '88', '4', ' 응용 패키지(Application Package)', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '89', ' 접근시간(Access Time)과 사이클시간(Cycle Time)에 관한 설명으로 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '89', '1', ' 사이클시간이 접근시간보다 대개 시간이 더 걸린다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '89', '2', ' 접근시간은 메모리로부터 정보를 거쳐오는 데 걸리는 시간이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '89', '3', ' 접근시간은 주기억장치에만 관계되며 보조기억장치와는 상관이 없다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '89', '4', ' 접근시간은 메모리로부터 정보를 가지고 나와서 다시 재 기억시키는데 걸리는 시간이다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '90', ' 16비트 명령어 형식에서 연산코드 5비트, 오퍼랜드1은 3비트, 오퍼랜드2는 8비트일 경우, ⓐ 연산종류와 사용할 수 있는 ⓑ 레지스터의 수를 바르게 나열한 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '90', '1', ' ⓐ 32가지, ⓑ 512		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '90', '2', ' ⓐ 31가지, ⓑ 8', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '90', '3', ' ⓐ 32가지, ⓑ 8		', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '90', '4', ' ⓐ 8가지, ⓑ 511', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '91', ' 다음 중 유선방송국 설비 등에 관한 기술기준에서 사용하는 증폭기의 설명으로 가장 적합한 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '91', '1', ' 입력신호 에너지를 2개 이상으로 균등하게 증폭하는 장치', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '91', '2', ' 텔레비전 방송신호를 수신하기 위한 증폭장치', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '91', '3', ' 낙뢰 등에 의한 이상 전류 또는 이상전압의 유입을 제한하거나 차단하는 장치', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '91', '4', ' 동축케이블·분배기 및 분기기 등에 의한 상·하향 신호의 전송손실을 보상하기 위하여 사용하는 장치', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '92', ' 다음 중 입력신호 에너지를 간선에서 지선으로 불균등하게 분리시키는 장치는?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '92', '1', ' 분배기		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '92', '2', ' 분기기', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '92', '3', ' 분사기		', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '92', '4', ' 분파기', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '93', ' 다음 중 방송법에서 정한 방송사업의 종류가 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '93', '1', ' 지상파방송사업	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '93', '2', ' 위성방송사업', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '93', '3', ' 방송채널사용사업	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '93', '4', ' 중계유선사업', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '94', ' 방송법 및 방송법시행령의 내용으로 맞지 않는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '94', '1', ' 한국방송공사 이사회는 이사장을 포함한 이사 11인으로 구성한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '94', '2', ' 한국방송공사의 자본금은 300억원으로 하고 50%는 정부가 출자한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '94', '3', ' 시청자위원회는 10인 이상 15인 이내의 위원으로 구성한다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '94', '4', ' 방송시설의 효율적 이용을 위하여 방송시설과 그에 부속된 토지·건물 등을 공동으로 구축·이용하도록 할 수 있다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '95', ' 지상파 디지털 텔레비전 방송용 무선설비의 기술기준 중 변조 및 송신에 대한 설명으로 옳은 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '95', '1', ' 펄스 정형 필터는 제곱근 레이즈드 여현 필터(root-raised cosine filter)를 사용할 것', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '95', '2', ' 변조방식은 12-VSB 방식으로 할 것', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '95', '3', ' 전송 속도는 16.762 Msymbols/sec로 할 것', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '95', '4', ' 변조된 신호의 채널 당 주파수 대역폭은 8 ㎒로 할 것', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '96', ' 다음은 방송법상의 방송의 정의를 설명한 것이다. 괄호 안에 가장 적합한 것은?<br><br>방송프로그램을 기획, 편성 또는 제작하여 이를 공중(시청자)에게 (   )에 의하여 송신하는 것이다. ', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '96', '1', ' 정보통신설비	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '96', '2', ' 방송통신설비', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '96', '3', ' 이동통신설비	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '96', '4', ' 전기통신설비', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '97', ' 과학기술정보통신부장관은 전파자원의 공평하고 효율적인 이용을 촉진하기 위하여 시행해야 할 사항이 아닌 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '97', '1', ' 주파수분배의 변경', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '97', '2', ' 주파수 회수 또는 주파수 재배치', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '97', '3', ' 새로운 기술방식으로의 전환', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '97', '4', ' 무선국 공동 운영', 'Y', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '98', ' 종합유선방송국 설비의 기술적 조건에 대한 사항 중 틀린 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '98', '1', ' 종합유선방송국이 사용할 수 있는 대역내 주파수 대역은 5.75㎒부터 1,002㎒까지이다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '98', '2', ' 영상신호의 휘도신호와 색차신호의 표본당 비트수는 4비트로 한다.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '98', '3', ' 디지털채널의 변조방식 및 전송조건 등은 「디지털 유선방송 송수신 정합」표준을 따른다.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '98', '4', ' 아날로그 종합유선방송국의 주 전송장치의 전송방식은 진폭변조 방식으로 한다.', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '99', ' 종합 유선방송신호를 전송하기 위한 전송선로시설의 질적 수준 측정항목에 포함되지 않는 것은?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '99', '1', ' 영상반송파의 신호레벨', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '99', '2', ' 음성반송파의 주파수편차', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '99', '3', ' 혼변조도', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '99', '4', ' 채널간 영상반송파의 레벨차', 'N', now(), now());

insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('9', '1', '100', ' 다음 중 중계유선방송의 영상반송파의 신호레벨은 수신자설비의 분계점에서 몇 [dBμV]이라야 하는가?', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '100', '1', ' 45~65[dBμV]	', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '100', '2', ' 55~75[dBμV]', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '100', '3', ' 65~85[dBμV]	', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('9', '1', '100', '4', ' 75~95[dBμV]', 'N', now(), now());

