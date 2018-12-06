package pack_JDBC;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pack_Bean.Ad_QnABean;
import pack_Bean.PostBean;
import pack_DBCP.DBConnectionMgr;
import pack_Util.UtilMgr;

public class Ad_QnaMgr {

	private DBConnectionMgr pool;

	public Ad_QnaMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게시판 리스트
	public Vector<Ad_QnABean> getQnAList(String keyField, String keyWord, int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Ad_QnABean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select * from tblQnA where del= 0 order by ref desc, pos limit ?, ?";

				//////////// 페이징연습용 쿼리 시작 ////////////
				// sql = "select * from tblPost order by num desc limit 40, 50";
				//////////// 페이징연습용 쿼리 끝 ////////////
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			} else {
				sql = "select * from  tblQnA where " + keyField + " like ? and del=0 ";
				sql += " order by ref desc, pos limit ? , ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");

				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Ad_QnABean bean = new Ad_QnABean();
				bean.setNum(rs.getInt("num"));
				bean.setProductName(rs.getString("productName"));
				bean.setId(rs.getString("id"));
				bean.setSubject(rs.getString("subject"));
				bean.setIp(rs.getString("ip"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setAnswer(rs.getString("answer"));
				bean.setDel(rs.getString("del"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 총 게시물수
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(*) from tblQnA where del=0 ";
				pstmt = con.prepareStatement(sql);
			} else {

				sql = "select count(*) from  tblQnA where " + keyField + " like ? and del=0 ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");

			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	// 게시물 입력
	public void insertQnA(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		try {
			con = pool.getConnection();
			sql = "select max(num)  from tblQnA";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int ref = 1;
			if (rs.next())
				ref = rs.getInt(1) + 1;

			sql = "insert into tblQnA(productName, id, content, subject, ref, pos, depth, regdate, pass, ip, answer, del) ";
			sql += " values(?, ?, ?, ?, ?, 0, 0, now(), ?, ?, 1, 0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, req.getParameter("productName"));
			pstmt.setString(2, req.getParameter("id"));
			pstmt.setString(3, req.getParameter("content"));
			pstmt.setString(4, req.getParameter("subject"));
			pstmt.setInt(5, ref);
			pstmt.setString(6, req.getParameter("pass"));
			pstmt.setString(7, req.getParameter("ip"));
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}

	// 게시물 리턴
	public Ad_QnABean getQnA(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Ad_QnABean bean = new Ad_QnABean();

		try {
			con = pool.getConnection();
			sql = "select * from tblQnA where num=? and del=0";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setProductName(rs.getString("productName"));
				bean.setId(rs.getString("id"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setPass(rs.getString("pass"));
				bean.setIp(rs.getString("ip"));
				bean.setAnswer(rs.getString("answer"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	// 게시물 삭제 - 답변과 삭제처리된 게시물만 다이렉트 삭제 가능//
	public boolean directDeleteQnA(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		boolean flag = false;
		try {
			con = pool.getConnection();

			sql = "select ref, depth from tblQnA where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			rs.next();
			int ref = rs.getInt(1);
			int depth = rs.getInt(2);

			if (depth == 0) {
				sql = "delete from tblQnA where ref=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.executeUpdate();
			} else {
				sql = "delete from tblQnA where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.executeUpdate();

				sql = "update tblQnA set depth=depth-1, pos=pos-1 where ref=? and pos>0";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.executeUpdate();

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	// 일반회원 게시물 삭제처리//
	public boolean deleteQnA(int num, String del) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if (!del.equals("1")) {
				return flag;
			}
			sql = "update tblQnA set del=1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			if (pstmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	// 삭제처리된 게시물 복원
	public boolean recoverQnA(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		boolean flag = false;
		try {
			con = pool.getConnection();

			sql = "update tblQnA set del=0 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			if (pstmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	// 삭제처리된 질문 목록 반환
	public Vector<Ad_QnABean> getDeletedQnAList(String keyField, String keyWord, int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Ad_QnABean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select * from tblQnA where del= 1 order by ref desc, pos limit ?, ?";

				//////////// 페이징연습용 쿼리 시작 ////////////
				// sql = "select * from tblPost order by num desc limit 40, 50";
				//////////// 페이징연습용 쿼리 끝 ////////////
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			} else {
				sql = "select * from  tblQnA where " + keyField + " like ? and del=1 ";
				sql += " order by ref desc, pos limit ? , ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Ad_QnABean bean = new Ad_QnABean();
				bean.setNum(rs.getInt("num"));
				bean.setProductName(rs.getString("productName"));
				bean.setId(rs.getString("id"));
				bean.setIp(rs.getString("ip"));
				bean.setSubject(rs.getString("subject"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setAnswer(rs.getString("answer"));
				bean.setDel(rs.getString("del"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	public int getDelTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(*) from tblQnA where del=1";
				pstmt = con.prepareStatement(sql);
			} else {
				if (keyField.equals("answer")) {
					sql = "select count(*) from  tblQnA where answer=? and del=1 ";
					sql += " order by ref desc, pos limit ? , ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, keyWord);
				} else {
					sql = "select count(*) from  tblQnA where " + keyField + " like ? and del=1";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%");
				}
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	// 게시물 수정
	public boolean updateQnA(Ad_QnABean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblQnA set id=?,subject=?,content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getSubject());
			pstmt.setString(3, bean.getContent());
			pstmt.setInt(4, bean.getNum());

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

	// 게시물 답변 (답변글 빈, 원본글 num)
	public void replyQnA(Ad_QnABean bean, int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into tblQnA (productName, id, content, subject, ref, pos, depth, regdate, pass, ip, answer, del) ";
			sql += " values(?, ?, ?, ?, ?, ?, ?, now(), ?, ?, 3, 0)";
			int depth = bean.getDepth() + 1;
			int pos = bean.getPos() + 1;
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getProductName());
			pstmt.setString(2, bean.getId());
			pstmt.setString(3, bean.getContent());
			pstmt.setString(4, bean.getSubject());
			pstmt.setInt(5, bean.getRef());
			pstmt.setInt(6, pos);
			pstmt.setInt(7, depth);
			pstmt.setString(8, bean.getPass());
			pstmt.setString(9, bean.getIp());
			pstmt.executeUpdate();

			sql = "update tblQnA set answer=2 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}

	// 답변에 위치값 증가
	public void replyUpQnA(int ref, int pos) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblQnA set pos = pos + 1 where ref=? and pos > ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, pos);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}

	public Vector<Ad_QnABean> getReplyList(String keyField, String keyWord, int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Ad_QnABean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select * from tblQnA where answer>1 and del=0 order by ref desc, pos limit ?, ?";

				//////////// 페이징연습용 쿼리 시작 ////////////
				// sql = "select * from tblPost order by num desc limit 40, 50";
				//////////// 페이징연습용 쿼리 끝 ////////////
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			} else {
				sql = "select * from  tblQnA where " + keyField + " like ? and answer>1 and del=0 ";
				sql += " order by ref desc, pos limit ? , ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Ad_QnABean bean = new Ad_QnABean();
				bean.setNum(rs.getInt("num"));
				bean.setProductName(rs.getString("productName"));
				bean.setId(rs.getString("id"));
				bean.setIp(rs.getString("ip"));
				bean.setSubject(rs.getString("subject"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setAnswer(rs.getString("answer"));
				bean.setDel(rs.getString("del"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	public int getRepTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(*) from tblQnA where answer>1 and del=0 ";
				pstmt = con.prepareStatement(sql);
			} else {
				if (keyField.equals("answer")) {
					sql = "select count(*) from  tblQnA where answer=? and answer>1 ";
					sql += " order by ref desc, pos limit ? , ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, keyWord);
				} else {
					sql = "select count(*) from  tblQnA where " + keyField + " like ? and answer>1";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%");
				}
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	// 게시판 리스트
	public Vector<Ad_QnABean> getProductQnAList(String productName, int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Ad_QnABean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from tblQnA where productName=? and del= 0 order by ref desc, pos limit ?, ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, productName);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				Ad_QnABean bean = new Ad_QnABean();
				bean.setNum(rs.getInt("num"));
				bean.setProductName(rs.getString("productName"));
				bean.setId(rs.getString("id"));
				bean.setSubject(rs.getString("subject"));
				bean.setIp(rs.getString("ip"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setAnswer(rs.getString("answer"));
				bean.setDel(rs.getString("del"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

}
