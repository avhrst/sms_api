create or replace PACKAGE BODY  "SMS_API"  
AS 
	PROCEDURE send( 
			v_number     VARCHAR2, 
			v_msg        VARCHAR2, 
			v_desc       VARCHAR2, 
			v_lifetime   INT DEFAULT 1, 
			v_start_time DATE DEFAULT NULL, 
			v_end_time   DATE DEFAULT NULL) 
	AS 
		------------------------- 
		content1 clob  ;
        v_clob clob := null;
	    v_blob blob := null;
        v_length    integer;
		req utl_http.req; 
		res utl_http.resp; 
	BEGIN 
		content1 := '<?xml version="1.0" encoding="utf-8"?>'; 
		content1 := concat(content1, '<request>') ; 
		content1 := concat(content1,'<operation>SENDSMS</operation>') ; 
		content1 := concat(content1, 
		'<message start_time=" AUTO " end_time=" AUTO " lifetime="'||v_lifetime|| 
		'" rate="120" desc="'||v_desc||'" source="' ||v_alfaname||'">') ; 
		content1 := concat(content1,'<body>'||v_msg||'</body>') ; 
		content1 := concat(content1,'<recipient>'||v_number||'</recipient>') ; 
		content1 := concat(content1,'</message>') ; 
		content1 := concat(content1,'</request>') ; 
       v_length := dbms_lob.getlength(content1);
        req := utl_http.begin_request(v_host, 'POST',' HTTP/1.1') ; 
		utl_http.set_header(req, 'content-type', 'text/xml; charset=utf-8') ; 
		utl_http.set_header(req, 'Accept', 'text/xml; charset=utf-8') ; 
		utl_http.set_header(req, 'Content-Length', v_length) ; 
		utl_http.set_header(req, 'charset', 'utf-8') ; 
        
		-- HTTP basic authentication -- 
		utl_http.set_authentication(req,v_user,v_pass) ; 
		utl_http.write_text(req, content1) ; 
		res := utl_http.get_response(req) ; 
		utl_http.end_response(res) ; 
     EXCEPTION
  WHEN OTHERS THEN
    UTL_HTTP.end_response(res);
    RAISE;  
	END send;	
   
END SMS_API;

