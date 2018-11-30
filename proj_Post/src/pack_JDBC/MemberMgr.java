package pack_JDBC;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import pack_Bean.MemberBean;
import pack_Bean.ZipcodeBean;
import pack_DBCP.DBConnectionMgr;

public class MemberMgr {
	
	private DBConnectionMgr pool;

	public MemberMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

//////////////////// ID 중복확인 시작 ////////////////////
public boolean checkId(String id) {
	Connection objConn = null;
	PreparedStatement	objPstmt = null;
	// Statememt : 일반적인 쿼리문
	// PreparedStatement : 매개변수(기호 : ?)가
	//                     들어있는 쿼리문
	ResultSet		objRs = null;
	
	String sql = null;
	boolean flag = false;
	
	try {
		objConn = pool.getConnection();
		sql = "select id from member where id=?";
		objPstmt = objConn.prepareStatement(sql);
		objPstmt.setString(1, id);		
		flag = objPstmt.executeQuery().next();
				
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(objConn, objPstmt, objRs);
	}
		
	return flag;
}	
//////////////////// ID 중복확인 끝 ////////////////////	
	

////////////////////우편번호 검색 시작 ////////////////////
public Vector<ZipcodeBean> zipcodeRead(String area3) {

	Connection objConn = null;
	PreparedStatement	objPstmt = null;
	ResultSet		objRs = null;
	
	String sql = null;
	Vector<ZipcodeBean> vlist
		= new Vector<>();
	
	try {
		objConn = pool.getConnection();
		sql = "select * from tblZipcode where area3 like ?";
		objPstmt = objConn.prepareStatement(sql);
		objPstmt.setString(1, "%" + area3 + "%");		
		objRs = objPstmt.executeQuery();
				
		while(objRs.next()) {
			ZipcodeBean bean = new ZipcodeBean();
			bean.setZipcode(objRs.getString(1));
			bean.setArea1(objRs.getString(2));
			bean.setArea2(objRs.getString(3));
			bean.setArea3(objRs.getString(4));
			bean.setArea4(objRs.getString(5));
			vlist.add(bean);
		}
		
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(objConn, objPstmt, objRs);
	}
		
	return vlist;
}
////////////////////우편번호 검색 끝 ////////////////////


////////////////////회원가입 시작 ////////////////////
public boolean insertMember(MemberBean bean) {
	Connection objConn = null;
	PreparedStatement	objPstmt = null;
	String sql = null;
	boolean flag = false;
	
	try {
		objConn = pool.getConnection();
		sql = "insert into member "
				+ "(id, pass, name, sex, email, "
				+ "birthday, zipcode, address, hobby, job) "
				+ "values "
				+ "(?, ?, ?, ?, ?, "
				+ "?, ?, ?, ?, ?)";
		objPstmt = objConn.prepareStatement(sql);
		objPstmt.setString(1, bean.getId());	
		objPstmt.setString(2, bean.getPass());	
		objPstmt.setString(3, bean.getName());	
		objPstmt.setString(4, bean.getSex());	
		objPstmt.setString(5, bean.getEmail());	
		objPstmt.setString(6, bean.getBirthday());	
		objPstmt.setString(7, bean.getZipcode());	
		objPstmt.setString(8, bean.getAddress());	
		String[] hobby = bean.getHobby();
		char[] hb = { '0', '0', '0', '0', '0' };
		String[] lists = { "인터넷", "여행",
				"게임", "영화", "운동", };
		for(int i=0; i<hobby.length; i++) {
			for (int j=0; j<lists.length; j++) {
				if(hobby[i].equals(lists[j])) {
					hb[j] = '1';
				}
			}
		}
		
		
		objPstmt.setString(9, new String(hb));	
		objPstmt.setString(10, bean.getJob());
		
		if(objPstmt.executeUpdate() == 1) {
			flag = true;
		}
		
		
				
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(objConn, objPstmt);
	}
		
	return flag;
			
}
////////////////////회원가입 끝 ////////////////////


////////////////////로그인 시작 ////////////////////
public boolean loginMember(String id, String pass) {

	Connection objConn = null;
	PreparedStatement	objPstmt = null;
	ResultSet		objRs = null;
	
	String sql = null;
	boolean flag = false;
	
	try {
		objConn = pool.getConnection();
		sql = "select id from member where id=? and pass=?";
		objPstmt = objConn.prepareStatement(sql);
		objPstmt.setString(1, id);
		objPstmt.setString(2, pass);		
		flag = objPstmt.executeQuery().next();
				
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(objConn, objPstmt, objRs);
	}
		
	return flag;
	
}
////////////////////로그인 끝 ////////////////////

}
