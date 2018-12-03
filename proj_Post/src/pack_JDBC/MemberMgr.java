package pack_JDBC;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import pack_Bean.MemberBean;
import pack_Bean.PostBean;
import pack_Bean.ZipcodeBean;
import pack_DBCP.DBConnectionMgr;
import pack_Util.UtilMgr;

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
		PreparedStatement objPstmt = null;
		// Statememt : 일반적인 쿼리문
		// PreparedStatement : 매개변수(기호 : ?)가
		// 들어있는 쿼리문
		ResultSet objRs = null;

		String sql = null;
		boolean flag = false;

		try {
			objConn = pool.getConnection();
			sql = "select id from tblMember where id=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, id);
			flag = objPstmt.executeQuery().next();

		} catch (Exception e) {
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
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;

		String sql = null;
		Vector<ZipcodeBean> vlist = new Vector<>();

		try {
			objConn = pool.getConnection();
			sql = "select * from tblZipcode where area3 like ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, "%" + area3 + "%");
			objRs = objPstmt.executeQuery();

			while (objRs.next()) {
				ZipcodeBean bean = new ZipcodeBean();
				bean.setZipcode(objRs.getString(1));
				bean.setArea1(objRs.getString(2));
				bean.setArea2(objRs.getString(3));
				bean.setArea3(objRs.getString(4));
				bean.setArea4(objRs.getString(5));
				vlist.add(bean);
			}

		} catch (Exception e) {
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
		PreparedStatement objPstmt = null;
		String sql = null;
		boolean flag = false;

		if (bean.getId().equals("admin")) {
			return flag;
		}

		try {

			objConn = pool.getConnection();
			sql = "insert into tblMember " + "(id, pass, name, gender, email, "
					+ "birthday, zipcode, address, phoneNum, level) " + " values " + "(?, ?, ?, ?, ?, "
					+ "?, ?, ?, ?, ?)";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, bean.getId());
			objPstmt.setString(2, bean.getPass());
			objPstmt.setString(3, bean.getName());
			objPstmt.setString(4, bean.getGender());
			objPstmt.setString(5, bean.getEmail());
			objPstmt.setString(6, bean.getBirthday());
			objPstmt.setString(7, bean.getZipcode());
			objPstmt.setString(8, bean.getAddress());

			String phoneNum = bean.getPhone1() + "-" + bean.getPhone2() + "-" + bean.getPhone3();
			objPstmt.setString(9, phoneNum);
			objPstmt.setInt(10, 1);

			if (objPstmt.executeUpdate() == 1) {
				flag = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(objConn, objPstmt);
		}

		return flag;

	}
////////////////////회원가입 끝 ////////////////////

////////////////////회원수정 시작 ////////////////////
	public void updateMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblMember set pass=?, name=?, gender=?, "
					+ "birthday=?, email=?, zipcode=?, address=?, phoneNum=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getPass());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getGender());
			pstmt.setString(4, bean.getBirthday());
			pstmt.setString(5, bean.getEmail());
			pstmt.setString(6, bean.getZipcode());
			pstmt.setString(7, bean.getAddress());

			String phoneNum = bean.getPhone1() + "-" + bean.getPhone2() + "-" + bean.getPhone3();
			pstmt.setString(8, phoneNum);

			pstmt.setString(9, bean.getId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
////////////////////회원 수정 끝 ////////////////////

////////////////////회원 삭제 시작 ////////////////////
	public boolean deleteMember(String id, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from tblMember where id=? and pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);

			if (pstmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}

		return flag;
	}
////////////////////회원 삭제 끝 ////////////////////

////////////////////일반 회원 로그인 시작 ////////////////////
	public boolean loginMember(String id, String pass) {

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;

		String sql = null;
		boolean flag = false;

		if (id.equals("admin")) {
			return flag;
		}

		try {
			objConn = pool.getConnection();
			sql = "select id from tblMember where id=? and pass=?";
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
////////////////////일반 회원 로그인 끝 ////////////////////

////////////////////로그인 기록 정보 추가 ////////////////////
	public void insertARecord(String id, String ip) {

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		String sql = null;

		try {

			objConn = pool.getConnection();
			sql = "insert into accessRecord " + " (id, loginTime, ip) " + " values (?, now(), ?)";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, id);
			objPstmt.setString(2, ip);

			objPstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(objConn, objPstmt);
		}
	}
////////////////////로그인 기록 정보 추가 끝 ////////////////////

////////////////////회원 정보 반환 시작 ////////////////////
	public MemberBean getMember(String id, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblMember where id=? and pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setId(rs.getString(1));
				bean.setPass(rs.getString(2));
				bean.setName(rs.getString(3));
				bean.setGender(rs.getString(4));
				bean.setEmail(rs.getString(5));
				bean.setBirthday(rs.getString(6));
				bean.setZipcode(rs.getString(7));
				bean.setAddress(rs.getString(8));

				String phoneNum = rs.getString(9);
				bean.setPhone1(phoneNum.substring(0, 3));
				bean.setPhone2(phoneNum.substring(4, 8));
				bean.setPhone3(phoneNum.substring(9, 13));

				bean.setLevel(rs.getInt(10));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

////////////////////회원 정보 반환 끝 ////////////////////
}
