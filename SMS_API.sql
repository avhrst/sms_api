create or replace package SMS_API as

/******** sms-fly API *********/ 
	v_host VARCHAR2(199) := 'http://sms-fly.com/api/api.php';	
    v_user VARCHAR2(50)  := '380630000000';	v_pass VARCHAR2(50)  := 'pppppp';	
    v_alfaname varchar2(50) := 'InfoCentr';	-- отправка сообщения -- 
	PROCEDURE send( 
			v_number VARCHAR2, 
			v_msg    VARCHAR2, 
			v_desc varchar2, 
			v_lifetime int default 1, 
			v_start_time date default null, 
			v_end_time date default null 
			) ; 
END SMS_API;
