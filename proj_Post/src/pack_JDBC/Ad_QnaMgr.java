package pack_JDBC;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import pack_Bean.Ad_QnABean;
import pack_DBCP.DBConnectionMgr;

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
				sql = "select * from tblQnA order by ref desc, pos limit ?, ?";

				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			} else {
				sql = "select * from  tblQnA where " + keyField + " like ? ";
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
				sql = "select count(*) from tblQnA";
				pstmt = con.prepareStatement(sql);
			} else {

				sql = "select count(*) from  tblQnA where " + keyField + " like ?";
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

			sql = "insert into tblQnA(productName, id, content, subject, ref, pos, depth, regdate, pass, ip, answer) ";
			sql += " values(?, ?, ?, ?, ?, 0, 0, now(), ?, ?, 1)";
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
			sql = "select * from tblQnA where num=?";
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

	// 게시물 삭제//
	public boolean deleteQnA(int num, int level) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		boolean flag = false;
		try {
			con = pool.getConnection();

			sql = "select ref, pos from tblQnA where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			rs.next();
			int ref = rs.getInt(1);
			int pos = rs.getInt(2);

			if (pos == 0 && level == 2) {
				// 원본글이 삭제된경우 답변 글도 한꺼번에 삭제
				sql = "delete from tblQnA where ref=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.executeUpdate();
			} else {
				// 그 글만 삭제 <- 답변만 삭제할 때나 일반회원이 사용
				sql = "delete from tblQnA where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				// 사용자가 원본글을 지우면 첫 번째 답변에 달린 ㄴ이 사라지도록. 답변이 여러 개 달려 있는 경우 답변 글의 위치를 1씩 당긴다
				sql = "update tblQnA set depth=depth-1 where ref=? and pos>0";
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

	// 게시물 수정
	public boolean updateQnA(Ad_QnABean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblQnA set id=?, subject=?, content=?, productName=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getSubject());
			pstmt.setString(3, bean.getContent());
			pstmt.setString(4, bean.getProductName());
			pstmt.setInt(5, bean.getNum());

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
			sql = "insert into tblQnA (productName, id, content, subject, ref, pos, depth, regdate, pass, ip, answer) ";
			sql += " values(?, ?, ?, ?, ?, ?, ?, now(), ?, ?, 3)";
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
				sql = "select * from tblQnA where answer>1 order by ref desc, pos limit ?, ?";

				//////////// 페이징연습용 쿼리 시작 ////////////
				// sql = "select * from tblPost order by num desc limit 40, 50";
				//////////// 페이징연습용 쿼리 끝 ////////////
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			} else {
				sql = "select * from  tblQnA where " + keyField + " like ? and answer>1 ";
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
				sql = "select count(*) from tblQnA where answer>1 ";
				pstmt = con.prepareStatement(sql);
			} else {

				sql = "select count(*) from  tblQnA where " + keyField + " like ? and answer>1";
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

	// 게시판 리스트
	public Vector<Ad_QnABean> getProductQnAList(String productName, int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Ad_QnABean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from tblQnA where productName=? order by ref desc, pos limit ?, ?";

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
