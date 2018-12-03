package pack_JDBC;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import pack_DBCP.DBConnectionMgr;

public class adminMgr {
	private DBConnectionMgr pool;

	public adminMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

////////////////////일반 회원 로그인 시작 ////////////////////
	public boolean loginAdmin(String id, String pass) {

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;

		String sql = null;
		boolean flag = false;
		if (!id.equals("admin") || !pass.equals("1234")) {
			return flag;
		}
		try {
			objConn = pool.getConnection();
			sql = "select id from tblMember where id=? and pass=? and level=2";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, id);
			objPstmt.setString(2, pass);
			flag = objPstmt.executeQuery().next();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}

		return flag;

	}

}
