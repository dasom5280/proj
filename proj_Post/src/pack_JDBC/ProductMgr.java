package pack_JDBC;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import pack_Bean.AccessRecordBean;
import pack_Bean.Ad_QnABean;
import pack_Bean.MemberBean;
import pack_Bean.ProductBean;
import pack_DBCP.DBConnectionMgr;

public class ProductMgr {

	private DBConnectionMgr pool;

	public ProductMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

////////////////////상품추가 시작 ////////////////////
	public boolean insertProduct(HttpServletRequest request) {

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			objConn = pool.getConnection();
			request.setCharacterEncoding("utf-8");
			sql = "insert into tblProduct " + " (productName, productType, explanation, price, inventory) " + " values "
					+ " (?, ?, ?, ?, ?)";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, request.getParameter("productName"));
			objPstmt.setString(2, request.getParameter("productType"));
			objPstmt.setString(3, request.getParameter("explanation"));
			objPstmt.setString(4, request.getParameter("price"));
			objPstmt.setString(5, request.getParameter("inventory"));

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
////////////////////상품추가 끝 ////////////////////

////////////////////상품수정 시작 ////////////////////
	public boolean updateProduct(ProductBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblProduct set productName=?, productType=?, explanation=?, price=?, inventory=? "
					+ " where productNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getProductName());
			pstmt.setString(2, bean.getProductType());
			pstmt.setString(3, bean.getExplanation());
			pstmt.setString(4, bean.getPrice());
			pstmt.setString(5, bean.getInventory());
			pstmt.setInt(6, bean.getProductNum());

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
////////////////////상품수정 끝 ////////////////////

////////////////////상품 삭제 시작 ////////////////////
	public void deleteProduct(int productNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblProduct where productNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNum);
			pstmt.executeUpdate();

// foreign key 설정된 모든 자료를 지워야 함

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}

	}
////////////////////상품 삭제 끝 ////////////////////

////////////////////상품 목록 반환 ////////////////////
	public Vector<ProductBean> getProductList() {

		Connection objConn = null;
		Statement objStmt = null;
		ResultSet objRs = null;
		String sql = null;
		Vector<ProductBean> vlist = new Vector<>();

		try {

			objConn = pool.getConnection();
			sql = "select * from tblProduct";
			objStmt = objConn.createStatement();
			objRs = objStmt.executeQuery(sql);

			while (objRs.next()) {
				ProductBean bean = new ProductBean();
				bean.setProductNum(objRs.getInt("productNum"));
				bean.setProductName(objRs.getString("productName"));
				bean.setProductType(objRs.getString("productType"));
				bean.setExplanation(objRs.getString("explanation"));
				bean.setPrice(objRs.getString("price"));
				bean.setInventory(objRs.getString("inventory"));
				vlist.add(bean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(objConn, objStmt, objRs);
		}
		return vlist;
	}

////////////////////상품 목록 반환 끝 ////////////////////
	
	// 게시판 리스트
		public Vector<ProductBean> getProductList(String keyField, String keyWord, int start, int end) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<ProductBean> vlist = new Vector<>();
			try {
				con = pool.getConnection();
				if (keyWord.equals("null") || keyWord.equals("")) {
					sql = "select * from tblProduct order by productNum desc limit ?, ?";

					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, end);
				} else {
					sql = "select * from  tblProduct where " + keyField + " like ? ";
					sql += " order by productNum desc limit ? , ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%");
					pstmt.setInt(2, start);
					pstmt.setInt(3, end);
				}
				rs = pstmt.executeQuery();
				while (rs.next()) {
					ProductBean bean = new ProductBean();
					bean.setProductNum(rs.getInt("productNum"));
					bean.setProductName(rs.getString("productName"));
					bean.setProductType(rs.getString("productType"));
					bean.setExplanation(rs.getString("explanation"));
					bean.setPrice(rs.getString("price"));
					bean.setInventory(rs.getString("inventory"));
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
					sql = "select count(*) from tblProduct";
					pstmt = con.prepareStatement(sql);
				} else {

					sql = "select count(*) from  tblProduct where " + keyField + " like ?";
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

////////////////////상품 정보 반환 시작 ////////////////////
	public ProductBean getProduct(int productNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ProductBean bean = new ProductBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblProduct where productNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setProductNum(rs.getInt("productNum"));
				bean.setProductName(rs.getString("productName"));
				bean.setProductType(rs.getString("productType"));
				bean.setExplanation(rs.getString("explanation"));
				bean.setPrice(rs.getString("price"));
				bean.setInventory(rs.getString("inventory"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
////////////////////상품 정보 반환 끝 ////////////////////

}
